Return-Path: <linux-kernel+bounces-91201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48630870B24
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C8A1F25548
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0969D7A15C;
	Mon,  4 Mar 2024 20:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Lu++QQ+o"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D462160;
	Mon,  4 Mar 2024 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709582719; cv=none; b=q7oSmVAszFoQzXIAlTDls6DFu20guNM9zrV8W6xvewFRkF4TXGGJq4l7ovXk4nI7PJNfuJgfOS8wcHvLbLFCHZzOTHh0fWuOfqq8ap1epGfqe3ymbr1DX5mTCTtH5Lr5dKTIpOzmss4YO0DTJF21jdxNXgcZ2V6Cpq+fuBR1DTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709582719; c=relaxed/simple;
	bh=vUfjqtH1hTFvjNaj//d38OmrgQ4pGzlsbIhvVjEE4oU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IR1n0RdbwZ8WwlvWxBAT8zP0RTC8ilFBo8asAJEzPzHz/vfbjrJ/GaRd7bN70Ty/yBwCN6iDAEA/8AcUtfbjvvNCPBkFT7zxYF4flClSFP5hv2cRIMzduqmmCw0BPqkuXpJ+JAqFB4yw6hACZpyGpwRA7IA//7OZ1XP50uKY9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Lu++QQ+o; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 93147418C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709582710; bh=vUfjqtH1hTFvjNaj//d38OmrgQ4pGzlsbIhvVjEE4oU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Lu++QQ+oSFSwD+Ydi+fLhZ7/dQlSifoQNvA92XP6yLnrpGP0O9dQG8NicpRpltAgi
	 9uGA9CldikKeKnORMZtYUfngCIX1qzauJVY+WC/aMHZF3pgT6rQZv7avJCEF3D+hqA
	 seadK9nixXSGMcOOmy+sbibUC9NhiV/Fs0VsFdRp58+20RTVXsKKnifOaBOMVMOv9K
	 Xx6I2BlspGIllJduV+mTBndlTYxMej9x4e1a1JW01jtrlWqXH/unfuGF1kYNQM4U+v
	 BWaZlVL/kKHAs0TJOmgsCyr2qJNjKNLwwj//or4HcHaVIJK7n5I51UCaQe3Zt9sHCe
	 EjZXZO9C8/O3g==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 93147418C3;
	Mon,  4 Mar 2024 20:05:10 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Ben Hutchings <ben@decadent.org.uk>, Kees
 Cook <keescook@chromium.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aditya Srivastava <yashsri421@gmail.com>,
 1064035@bugs.debian.org
Subject: Re: [regression 5.10.y] linux-doc builds: Global symbol "$args"
 requires explicit package name (did you forget to declare "my $args"?) at
 ./scripts/kernel-doc line 1236.
In-Reply-To: <ZeYoZNJaZ4ejONTZ@eldamar.lan>
References: <ZeHKjjPGoyv_b2Tg@eldamar.lan> <877ciiw1yp.fsf@meer.lwn.net>
 <ZeYoZNJaZ4ejONTZ@eldamar.lan>
Date: Mon, 04 Mar 2024 13:05:09 -0700
Message-ID: <874jdlsqyy.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Salvatore Bonaccorso <carnil@debian.org> writes:

> Ok. In the sprit of the stable series rules we might try the later and
> if it's not feasible pick the first variant?

Well, "the spirit of the stable series" is one of Greg's titles, and he
said either was good...:)

jon

