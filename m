Return-Path: <linux-kernel+bounces-117908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8403288B124
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F515301310
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CBA524B1;
	Mon, 25 Mar 2024 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="UmB2QdPw"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7E482EB;
	Mon, 25 Mar 2024 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397694; cv=none; b=Llk49h6RelJKKh10xhqayFWHRTqv5wd7TLg19Das+24wcTnlRIzTNKRUZ1lieMzZC2ua9ypRhp4tL5/8ZLab6CJmX3yg5DDF97p7Vk+NTNgLKw3SwyUp3n3ll3tNWwdEg1jXg+PgK8fjgT877NGUIsTOGYFI3Tm2+N+RGpw3NNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397694; c=relaxed/simple;
	bh=zMdjhVydUjoxY/xzQk2i+kEu+0c1uqePaXKIVxSJJ4M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwHwyM+zq5YxHH3DpI0fQYFCdT9NSwY6rEMVqq+IKSrXIByOlP4ANo8KWzlUCoSOGWm6DPb7OtRW1ODzlPZKjkubXwbbuR6vpl9zSzjoq4sbLujL3JWLtOxJAeqQsHOHTqO0fsOxbBmmsntRlIaYhGyGUPcVYFkXlUNlOmJ00wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=UmB2QdPw; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roqiY-003Nxp-2I;
	Mon, 25 Mar 2024 21:14:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kloWOYc1TsPkAcQwP8j3eY+xjDjed/pTSmC/qaW2750=; b=UmB2QdPwmyNX2Rt+hYRFiUfyY3
	jLldrBLci2o1K8tcOWlXjtBvqUEjC9CmJzuhAXSWphxrPpt/xenmWWQJxC2XU7l59p/Nn/Y4fqCCI
	dIgKVrLYxCUKK1qXWJGwt2hYDkILqm/lSROr+HWw1bh1kPd43HBxVUST9MY31XYzDH2per2sPOg5u
	0i0/Wv0sUX34dnNEmt/kwbgJfHDjr7v009hFi8JGp7JBubiTl4Dxf7bZue9jK5zZSAIoDTaFBdQMh
	CpYOdojD459sZj8m7ubDJLPejYvYR/Lxc8mBUQzXLHYcYLtxovPlLqtFlR1tlHdW6UPziQ6gmuPWV
	yGGA+xBQ==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roqiW-0000gv-33;
	Mon, 25 Mar 2024 21:14:49 +0100
Date: Mon, 25 Mar 2024 21:14:46 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Lee Jones <lee@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev
Subject: Re: [RFC PATCH 2/2] mfd: rohm-bd71828: Add power off functionality
Message-ID: <20240325211446.26fb3bad@aktux>
In-Reply-To: <20240325165134.GP13211@google.com>
References: <20240324201210.232301-1-andreas@kemnade.info>
	<20240324201210.232301-3-andreas@kemnade.info>
	<472c6eaf-6cbc-484c-bc94-571d115176aa@gmail.com>
	<20240325131605.6607b778@aktux>
	<81bf6604-9160-4bae-8da6-7034f8aa3f92@gmail.com>
	<20240325141032.GO13211@google.com>
	<20240325165134.GP13211@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 16:51:34 +0000
Lee Jones <lee@kernel.org> wrote:

> On Mon, 25 Mar 2024, Lee Jones wrote:
> 
> > On Mon, 25 Mar 2024, Matti Vaittinen wrote:
> >   
> > > Hi Andreas,
> > > 
> > > On 3/25/24 14:16, Andreas Kemnade wrote:  
> > > > On Mon, 25 Mar 2024 13:31:15 +0200
> > > > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > > >   
> > > > > On 3/24/24 22:12, Andreas Kemnade wrote:  
> > > > > > Since the chip can power off the system, add the corresponding
> > > > > > functionality.
> > > > > > Based on https://github.com/kobolabs/Kobo-Reader/raw/master/hw/imx6sll-clara2e/kernel.tar.bz2
> > > > > > No information source about the magic numbers found.  
> > > > > 
> > > > > Oh, interesting repository :) Thanks for linking to it! I didn't know
> > > > > someone had reworked this driver...
> > > > >   
> > > > which btw: contains this interesting snippet (output from fdtdump)
> > > >    bd71828-i2c@4b {
> > > >                      reg = <0x0000004b>;
> > > >                      compatible = "rohm,bd71828";
> > > >                      gpio_int = <0x00000008 0x00000013 0x00000001>;
> > > >                      gpio_wdogb = <0x00000039 0x00000018 0x00000001>;
> > > >                      #address-cells = <0x00000001>;
> > > >                      #size-cells = <0x00000000>;
> > > >                      pmic@4b {
> > > >                          compatible = "rohm,bd71828";
> > > >               	        regulators {
> > > >                          	BUCK1 {
> > > >                              		regulator-name = "buck1";
> > > > 
> > > > 
> > > > and to make it work since basically no regulators are registered
> > > > instead just some regmap_write()s are done to configure something
> > > > in probe(). It is a pitfall to think that the information below pmic@4b
> > > > is used, especially since it is not that obvious in the source.  
> > 
> > Odd!  Not only did I not receive the original patch, I also did not
> > receive your response Andreas.  Spam is empty too.
> > 
> > LORE too: https://lore.kernel.org/all/?q=%22mfd:%20rohm-bd71828:%20Add%20power%20off%20functionality%22  
> 
> Super weird!  They just all came through.
> 
> The LORE link above is now working too.
> 
> I suspect an issue with kernel.org.
> 
Well, no, emails from me to everyone sitting behind a mail server without IPv6
address were affected. TCP ACK (3rd part of the handshake) was eaten up by
something. Whatever... So nothing to blame kernel.org besides not having IPv6.

Regards,
Andreas


