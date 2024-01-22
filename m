Return-Path: <linux-kernel+bounces-33330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E08836874
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5DA1F20B67
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80A7612D1;
	Mon, 22 Jan 2024 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C7NokoDs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KB++GBe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C3060EDB;
	Mon, 22 Jan 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935906; cv=none; b=QZSdotcSettGxpDt8Q6e+VxMPaY8vQkA6ya1KJSg1juNfH7VwMQFU5jaRMYnCCM0DX8Ck7m8LOW3OtsEO5E6qMw8NSIbtK5m47Jm2iL+pHgCeS4Ei6+vGVWpBiINhmQlIfeup/MLWwIPU9XCYgKxQ7xbR3SopJDCwagGYALsEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935906; c=relaxed/simple;
	bh=O2ymWPku5NfSvCY6cxMFSE4QNpkEPBlZ/ZY2nCddZrc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5lLulxmJESLbEr0eTs3hLLT3wI6Sq42MSFxH2k5eNxFRSybQp6e2GhXmT3FgBdrzvpqWuy4X9XrBwTkVaiawiGWipuRbbmrrn5VXxDeZaMqnLyFLO/KRhuGZu2HcJLsn4t+XQwieU9X+SfQutTcirgArKoo+lkZXDrkPCy4eWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C7NokoDs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0KB++GBe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Jan 2024 16:05:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705935902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbDHLmWEZUt1XATg4KN9+ebNsHN0XH+rmUPOoAgDRaA=;
	b=C7NokoDsbokdQ2iINmvwvKm3aLyK3jiQiM8DR1/r0YW6KM07+u3t0iJvmXMAYTd8//74Fy
	0ML2QpU0lfgwRZf671rE8DvYSMMm7TWvB7DJOg+n0P4z8dD4zp76EQVehQ//507dDuDlwQ
	il5I2McNQaHehdYXkwiQ5GbAIQX1AwPHK93Ere9mQ32EY6OgFrS95mbCKt+wVDpwfSQ2bt
	KJ3ls5mlaoUMDRbBUto8NKHwS9WW8Lel2QglHNJM4PmcdDgZYCceQHBVlKAOidHzi1dmm2
	4oAZj8KnvHk3jwAshSFWn4WN2Qjik+Wz8Ei2V/rpqkmGSwQiNKtIoTCvn9BdSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705935902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbDHLmWEZUt1XATg4KN9+ebNsHN0XH+rmUPOoAgDRaA=;
	b=0KB++GBeFHR4JGvd1OeLwqSDL82F5aiQmwtfJpunj7F+NJ2AXVNJ1R9TxIXT9DY7+iGkAb
	BC5qOPWjp1x/hZDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: resolve symlinks for O= properly
Message-ID: <20240122150501.qCO5PPG6@linutronix.de>
References: <20231215160637.842748-1-masahiroy@kernel.org>
 <20240122141203.CWe3n5rG@linutronix.de>
 <Za6C2w0QIZDayA48@buildd.core.avm.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Za6C2w0QIZDayA48@buildd.core.avm.de>

On 2024-01-22 15:59:37 [+0100], Nicolas Schier wrote:
> Expanding tilde expandos is traditionally a shell feature, as you
> already mentioned; and bash supports also expandos like '~+' and '~-'.
> I think, we should leave the shell things in shells.
> 
> Thus, please update your shell scripts to be compliant to their
> interpreting shell (e.g. use '$HOME' or switch the shell).

I reported that this change silently broke dash users. If you accept
this then you could acknowledge it instead of suggesting workarounds.

> Kind regards,
> Nicolas

Sebastian

