Return-Path: <linux-kernel+bounces-84156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AE786A336
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983D01F25A34
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5696C55E44;
	Tue, 27 Feb 2024 23:02:22 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F0A1E86C;
	Tue, 27 Feb 2024 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074941; cv=none; b=TgpjoD7vpfqrGIzE7snW8vBdM+AzFDgnc7gsyeh+kA5QEy1JDIcn4WmscghUSLGMNogHo1jQmOC9/oqlEjFywDjQaaoDppHwSt0aYhCSpt71BMhKDfbllseXi8v41XjF5QAVdEO63npNA/45dVMBUwJixTog3oZsf2IFJqhKatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074941; c=relaxed/simple;
	bh=S49evQSkI7rIhtVTwtSlf93JIi9GPebbgKntcqdpleU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j+6qRqAz38EIOqCWXgrHnEbtKRxjCzuXO/4Yu8ypUxVHRoHKGkjy28B7yHhEOVZrpn6CzXMjJ0w9zs8jjOdHE8hcR8/3QFBol9SDIIsrUDry23ng6QVWNZlm/jjvKK/fTiexGXrwKrn5x5W+LGF7tEtfeqzagjI9tXSBZK9Bnos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4TktBw1pGYz1qsPL;
	Tue, 27 Feb 2024 23:56:24 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4TktBw0r48z1qqlY;
	Tue, 27 Feb 2024 23:56:24 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id rI9AB2bmZDcy; Tue, 27 Feb 2024 23:56:23 +0100 (CET)
X-Auth-Info: Tx5lBDEGMLRTUQyblCbuJ3bg9NFXYwmbhPEjTzRsWqwGSw/+vO1HE4cryHgGnaif
Received: from igel.home (aftr-62-216-202-59.dynamic.mnet-online.de [62.216.202.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Tue, 27 Feb 2024 23:56:23 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 2E0572C1A60; Tue, 27 Feb 2024 23:56:23 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Kees Cook <keescook@chromium.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,  Guenter Roeck
 <linux@roeck-us.net>,  linux-kernel@vger.kernel.org,
  linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib: stackinit: Adjust target string to 8 bytes for m68k
In-Reply-To: <20240227224653.work.603-kees@kernel.org> (Kees Cook's message of
	"Tue, 27 Feb 2024 14:46:56 -0800")
References: <20240227224653.work.603-kees@kernel.org>
X-Yow: Yow!  Are we in the perfect mood?
Date: Tue, 27 Feb 2024 23:56:23 +0100
Message-ID: <87ttltzfc8.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Feb 27 2024, Kees Cook wrote:

> For reasons I cannot understand, m68k moves the start of the stack frame
> for consecutive calls to the same function

It's called optimisation.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

