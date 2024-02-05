Return-Path: <linux-kernel+bounces-52200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0D3849546
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C35B2396B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC8911709;
	Mon,  5 Feb 2024 08:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Owi8gK9h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d6vYOyw/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108FF11197;
	Mon,  5 Feb 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121309; cv=none; b=hPcKK8P351DrowPOEghh+gt8dKaB2EJPCVlm+GB+xTGIeApWnAuyMCz9+IlIyA6WxO/id3w5G/1tOnI7Pm0FkMKPn7xE7Pl8oWITn5qX+g/AO/C1Z0zXLRoodGzTsm+RsYznXmu+dpW0t+LXM+hkrUn322zPLSEt9Ir4JwRHMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121309; c=relaxed/simple;
	bh=jWoYKNOaJZkQXUjbgKMKgXdgzbUGl0YlxWmC3h9cIEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKAnrkucGOKG2nwwlHfwMEEZE+PjXcB58kebtWg06524gtpHgQ823CGX6LUcSNs00UiAGUsTmt+dcLu+sBtRT+4BnNbn/AZaACfmiaI09jG1kjfqnUOCUgaS3bZDYUqzuKXF7eF1nTxE5ctH0Z4y2hFHNPpFdVAfjntusFLIvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Owi8gK9h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d6vYOyw/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 5 Feb 2024 09:21:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707121299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWoYKNOaJZkQXUjbgKMKgXdgzbUGl0YlxWmC3h9cIEo=;
	b=Owi8gK9hxlNii8V3eWJUhqWBOTxiRLx5KBn2BL8bjZ5ScFJVAxkHWu+OX5Or1ZdkXvPcJc
	geBiq9G0LGSB2B7a9txtW05+SXTff8YLVoQ4MPdAA9S1kjFsHjOf7bA5+Jbj3eDjr2g5Ws
	y31sbMg4E2rB82cilHwUGc8vRTMSOxFRmIVHVftc5rxent4mxcD46jSccAzhvRj6SbBJ5E
	5qyMgHAXVS2Rh+v/ywP3lXJVj5hzNM+zjl5dKFo/ckn3vxNuEGP0HIl1U5H9b0Md1fwwUq
	Mw80JHszWuB5f3ss6x1SGDnfPRc7hyBcrlW4tvoiN1pfqwN7Kd9txBrPbl7Ktg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707121299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWoYKNOaJZkQXUjbgKMKgXdgzbUGl0YlxWmC3h9cIEo=;
	b=d6vYOyw/DvOqugkKocJ/FqMnMxxg6NMhwO2gFQGyWcnWYDDhrU5pRQQOeBMiM0oP5MKPjE
	9AE/vIE6psVmudDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT 0/1] Linux v4.19.306-rt132-rc1
Message-ID: <20240205082138.HtHvUfp9@linutronix.de>
References: <20240202170457.29516-1-wagi@monom.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240202170457.29516-1-wagi@monom.org>

On 2024-02-02 18:04:56 [+0100], Daniel Wagner wrote:
> Dear RT Folks,
Hi,

> This is the RT stable review cycle of patch 4.19.306-rt132-rc1.
=E2=80=A6
> Please scream at me if I messed something up. Please test the patches
> too.

Good.

> Enjoy!
> Daniel

Sebastian

