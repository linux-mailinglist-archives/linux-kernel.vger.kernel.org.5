Return-Path: <linux-kernel+bounces-126803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48960893CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0200B283040
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67C446558;
	Mon,  1 Apr 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b="kZLywtKU"
Received: from mail.wantyapps.xyz (mail.wantyapps.xyz [66.135.5.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E805B42057
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.135.5.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985793; cv=none; b=S7X4wW/EfQxEw0BTQsuhG4rtT+vlll6aCIwUItGaVlc8Ftu9dm3vcWi+vQ9ohhbIater2tr3WnuNo6wxADyiPXVSPeicloiTWuv/uBawgDUh4MVh7eCW9iKQigj8UMkY/jpy4AjIzgHw0D6AsAesnnFd7IOf35S9kjPuWIFLQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985793; c=relaxed/simple;
	bh=Wr12XCmFt3h6/dABXnkeyRdNJg9he5UE/O/4EKcEDcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgZjT/vac7qQ2XFpldxmDAIZCgHpxK5XNP8fYFaspMizl1eAMnfSUUP7deyVHYUnYBEdpCjKalAKHghFBO77xxs5pIDgaGFl74uH58jaAD3zkws0EC7oxPjaUYNsYpIW3ys+4PHtpPx1He3aFdHklwtLgRvu0PuylH+QkTxAsdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz; spf=pass smtp.mailfrom=wantyapps.xyz; dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b=kZLywtKU; arc=none smtp.client-ip=66.135.5.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantyapps.xyz
Received: from multivac (unknown [147.235.194.23])
	by mail.wantyapps.xyz (Postfix) with ESMTPSA id 64F76933D9;
	Mon,  1 Apr 2024 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
	s=mail; t=1711985783;
	bh=Wr12XCmFt3h6/dABXnkeyRdNJg9he5UE/O/4EKcEDcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZLywtKULKf0dyFNOxD5MRw50L11Ij9/Ph05YhERq6iZRj44YcFrOtuz8FPgv5HAr
	 IBIxhYE/Dt43aWamgCiohTmmI5tBFr6AlxuNg6tXMCCPx8cZZnCRHUVPWf2IrM7VFf
	 sj130QNMm7R4mQCvDsln4xHs+XjSgaodMdIU2BzVcgQjhf6O6rrOynLk/cXJeo95hd
	 WaUO1syYwyUH8bnz3DljIX7aJDla8eMi+YQ7ODHbtVAx3pRyx2HBzzM13I2Zj0ZC38
	 /8yuFFUsGBSrIPP+QfKyXmhFT1ORJjOYVWSfWkpIqW3Usn3tWrCIukaLtqkL/st/hq
	 V5cEn3P9Vi5fQ==
Date: Mon, 1 Apr 2024 18:36:19 +0300
From: Uri Arev <me@wantyapps.xyz>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Prathu Baronia <prathubaronia2011@gmail.com>, Rob Herring <robh@kernel.org>, Yangtao Li <frank.li@vivo.com>, 
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: Fix indentation
Message-ID: <ezp7lmxhd3ouzh3uwhxxvv7p2ek6y3xcf3rbkczvv76ljsmxoq@65gbnxprrlsi>
References: <20240305211416.755911-1-me@wantyapps.xyz>
 <Zgqn8izgsMI7rQNA@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zgqn8izgsMI7rQNA@archie.me>

On Mon, Apr 01, 2024 at 07:26:26PM +0700, Bagas Sanjaya wrote:
> LGTM, thanks!
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Thank you so much for the review! Have a great day

                 Uri Arev

