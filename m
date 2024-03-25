Return-Path: <linux-kernel+bounces-117510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F7788AC1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B5C2E62B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1998F6B;
	Mon, 25 Mar 2024 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+1Z1mz5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3963DABE6;
	Mon, 25 Mar 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385500; cv=none; b=Kq9QH+OFUGkfeu+5Gd3IqzokcHv59vZ55wSrGKU0Q1fp0V2C6j5bPxZ58z4bVNmVyLCBAZm/uRBAQoNYerHoKivBuNDVCBqIwYihebk9SPfHP1Gzxj1W5EYxVsluzeD8wWQtjEo6w+2hbsdPTY+7I7DyG/heLNFvjZmDim+g+Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385500; c=relaxed/simple;
	bh=Iu8KBH2J8gwOqs7CFvo2VClDZQn6xBSmERMdX7llFo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GM2czId06c0OLTVA2RLWVhxNVin5C16vMr0+Mm+aTE1MV3n1kDKMIezXaOXe0naXvZJncsfXqcAVlGDnWAubajLLyCfSosHfrip+trja6bp7/HQpXKTp1KTIljc2TuxVRmuQCM6ZoD72UpHMGuSdWjJIJO+3a2rOnwFXN3sevho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+1Z1mz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C34C433F1;
	Mon, 25 Mar 2024 16:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711385499;
	bh=Iu8KBH2J8gwOqs7CFvo2VClDZQn6xBSmERMdX7llFo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+1Z1mz5ihW5gtjTmBfXU5UZzmTBjUNp01p6oqQq/GUwWiPlxi93qpigozpyMTMdN
	 Z/RYEiSHUpzkN8D3UW4ZwuFRlwHPXMqLDkSbDU+gJ8FFfyUQyxioYcVF/rCCAp1F85
	 9I/JK9X/c3o4/4EiuImJaIPNd1yCZCXKY6+fMEtiPjGeClxpLuIw1JhpxpYvLY1RbO
	 juXjB9bSH0cMkzqpqfIxk/37qFpNvpYVN5p778mv5OjQv4X90GMRNY9hXKnyODne4U
	 6p3OccFTTYq5TUbKg3NrI0/vR+uMQ5k8domUKwN80L9w3S0FFsRJ06pI/L0LoIYN/d
	 G3Hu2FiM65sFg==
Date: Mon, 25 Mar 2024 16:51:34 +0000
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [RFC PATCH 2/2] mfd: rohm-bd71828: Add power off functionality
Message-ID: <20240325165134.GP13211@google.com>
References: <20240324201210.232301-1-andreas@kemnade.info>
 <20240324201210.232301-3-andreas@kemnade.info>
 <472c6eaf-6cbc-484c-bc94-571d115176aa@gmail.com>
 <20240325131605.6607b778@aktux>
 <81bf6604-9160-4bae-8da6-7034f8aa3f92@gmail.com>
 <20240325141032.GO13211@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325141032.GO13211@google.com>

On Mon, 25 Mar 2024, Lee Jones wrote:

> On Mon, 25 Mar 2024, Matti Vaittinen wrote:
> 
> > Hi Andreas,
> > 
> > On 3/25/24 14:16, Andreas Kemnade wrote:
> > > On Mon, 25 Mar 2024 13:31:15 +0200
> > > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > > 
> > > > On 3/24/24 22:12, Andreas Kemnade wrote:
> > > > > Since the chip can power off the system, add the corresponding
> > > > > functionality.
> > > > > Based on https://github.com/kobolabs/Kobo-Reader/raw/master/hw/imx6sll-clara2e/kernel.tar.bz2
> > > > > No information source about the magic numbers found.
> > > > 
> > > > Oh, interesting repository :) Thanks for linking to it! I didn't know
> > > > someone had reworked this driver...
> > > > 
> > > which btw: contains this interesting snippet (output from fdtdump)
> > >    bd71828-i2c@4b {
> > >                      reg = <0x0000004b>;
> > >                      compatible = "rohm,bd71828";
> > >                      gpio_int = <0x00000008 0x00000013 0x00000001>;
> > >                      gpio_wdogb = <0x00000039 0x00000018 0x00000001>;
> > >                      #address-cells = <0x00000001>;
> > >                      #size-cells = <0x00000000>;
> > >                      pmic@4b {
> > >                          compatible = "rohm,bd71828";
> > >               	        regulators {
> > >                          	BUCK1 {
> > >                              		regulator-name = "buck1";
> > > 
> > > 
> > > and to make it work since basically no regulators are registered
> > > instead just some regmap_write()s are done to configure something
> > > in probe(). It is a pitfall to think that the information below pmic@4b
> > > is used, especially since it is not that obvious in the source.
> 
> Odd!  Not only did I not receive the original patch, I also did not
> receive your response Andreas.  Spam is empty too.
> 
> LORE too: https://lore.kernel.org/all/?q=%22mfd:%20rohm-bd71828:%20Add%20power%20off%20functionality%22

Super weird!  They just all came through.

The LORE link above is now working too.

I suspect an issue with kernel.org.

-- 
Lee Jones [李琼斯]

