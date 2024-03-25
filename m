Return-Path: <linux-kernel+bounces-117367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0277E88AA7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD461F66C75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DE713A3E0;
	Mon, 25 Mar 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="zn/PDYW9"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A2139CF7;
	Mon, 25 Mar 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380500; cv=none; b=BKkliYx2N5m5/fZNllz24h6VgGk272n2Z+PJ+CmK13lvmZkuVDGjDt5895RqB1/czz3fB5AxG/Kxtd83UK6LyCBymzZtcWyJN7ND1BnX1+VrN03PSsY+r4fdbdZDhd8lqYo2VwC5Z5ceNPtKH5C9G+DIkhyGcq3aYryT+REa3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380500; c=relaxed/simple;
	bh=l7Iq42t4OAqPVcaUphs8qOzZizq2Dfx1SufCIbfsbEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nO//MaZ9/zZNacMwmSCrgQi9JtRIjMZq4jfPGsiQVJHSVG5AQXablJyVC4BSH8N/c/XZdxltOAHib5aGqg1IDQbL2Jp7wkX9E2QzKWNp+j35pgo7Pt+t9+Nu+z1JIir4xZpDQ1r2CLAPoRG9gz7qZ9B1+9b1iDt4OnAL5BkEMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=zn/PDYW9; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roltB-003KDz-1Q;
	Mon, 25 Mar 2024 16:05:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a9zvtfL5+zzdZaDVQ7s7ROa8rd+QCuJZiFyI2UwPWgI=; b=zn/PDYW9I2AYu+Ff5oOniCVSPe
	7awjFoLWzNrlxAU4tlQglV0nOUv2RFpWqQIk+9JP6cojXfxPXQGBpJyk7iIba8wz9Jc3xuCfHSWtl
	5tofDJqG2ZmLwxPO4wYNt8yYAAc+w15fv5s51sTRcQsqHF8n2T2RL11VuF8NDOXXTglwgihB1WU9Q
	RDlHXSKEyUeZ8qAJN6z9s1iO9h7mMQ6Kq6iuhATVrq7GuxZpvDGoVV5MxhEVenSMbx04t3gXBOyaM
	DEkSrwW2PgzHBLdSkx5EkuJgAtkDgHhQYiAQUYK/cxh7FpkfYb9cb3PQUMdha3NAObVHtHodkGrGU
	KEEVSQWA==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1rokNR-000Zp7-4z; Mon, 25 Mar 2024 14:28:36 +0100
Date: Mon, 25 Mar 2024 14:28:33 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [RFC PATCH 2/2] mfd: rohm-bd71828: Add power off functionality
Message-ID: <20240325142833.538993c2@aktux>
In-Reply-To: <81bf6604-9160-4bae-8da6-7034f8aa3f92@gmail.com>
References: <20240324201210.232301-1-andreas@kemnade.info>
	<20240324201210.232301-3-andreas@kemnade.info>
	<472c6eaf-6cbc-484c-bc94-571d115176aa@gmail.com>
	<20240325131605.6607b778@aktux>
	<81bf6604-9160-4bae-8da6-7034f8aa3f92@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Matti,

On Mon, 25 Mar 2024 14:44:43 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Andreas,
> 
> On 3/25/24 14:16, Andreas Kemnade wrote:
> > On Mon, 25 Mar 2024 13:31:15 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> On 3/24/24 22:12, Andreas Kemnade wrote:  
> >>> Since the chip can power off the system, add the corresponding
> >>> functionality.
> >>> Based on https://github.com/kobolabs/Kobo-Reader/raw/master/hw/imx6sll-clara2e/kernel.tar.bz2
> >>> No information source about the magic numbers found.  
> >>
> >> Oh, interesting repository :) Thanks for linking to it! I didn't know
> >> someone had reworked this driver...
> >>  
> > which btw: contains this interesting snippet (output from fdtdump)
> >    bd71828-i2c@4b {
> >                      reg = <0x0000004b>;
> >                      compatible = "rohm,bd71828";
> >                      gpio_int = <0x00000008 0x00000013 0x00000001>;
> >                      gpio_wdogb = <0x00000039 0x00000018 0x00000001>;
> >                      #address-cells = <0x00000001>;
> >                      #size-cells = <0x00000000>;
> >                      pmic@4b {
> >                          compatible = "rohm,bd71828";
> >               	        regulators {
> >                          	BUCK1 {
> >                              		regulator-name = "buck1";
> > 
> > 
> > and to make it work since basically no regulators are registered
> > instead just some regmap_write()s are done to configure something
> > in probe(). It is a pitfall to think that the information below pmic@4b
> > is used, especially since it is not that obvious in the source.  
> 
> Just to ensure there will be no misunderstanding - I have not authored 
> the modifications seen in "Kobo-Reader" repository. Upstream driver does 
> register the regulators - and it does not use the oddly named gpio_int 
> or the gpio_wdogb:

yes, I know it is not from you and I know the general quality in those repos.
But I feel not well pointing to those repositories without issuing the warning
that regulator information in dtb is not an authoritative source for required
regulator settings. Not that someone enables the smoke-generator
functionality...

But lets not go too much offtopic.

Regards,
Andreas


