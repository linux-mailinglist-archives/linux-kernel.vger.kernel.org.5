Return-Path: <linux-kernel+bounces-103438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248D787BF56
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A441F1F22F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D107172B;
	Thu, 14 Mar 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yeawrzyK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FE6FE10
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427984; cv=none; b=W5ItyNe55omsHOB9QJeSIghScS179t2fbaogWVI2mlc3BiZomFH6f47EGEw81I5CugvGpdh1OdlegA1QdG1qdDehab/Fc9ABykweH2HV5Yayr+K8V3suTrXwAiQqVApuy4r2okNZTw/TsDMAV2Eq8M+N0VOarsM95Zi9TWepuDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427984; c=relaxed/simple;
	bh=Z4Ix1Oz24qrsjV1vmGqdhWdEKSxI4Rx28UJCxDH4Sx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUowygLaogz+jVmLxUyvPvgmtKyiP31qbUah8J+Ugbn1BKaVZApsBV2/+cLvl2NvSRiBQMlBCnwuSCYqrwEXlf46Og6DnirufpVx1xWU0OPAI7MN5i92HbJgCXNZb1q772Lpn2++SoZp1pSlK56+b6qnB/6l7eBerzBUYCKxMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yeawrzyK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6b5831bc8so1033080b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710427983; x=1711032783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQdGRCc8CvufO8pJrzg/EbeDXgOQDIEiNqPLlOCuoyM=;
        b=yeawrzyK12AlYySnBbLvlrY1hiqyxCZSY1Rim5dOnqUe13MaKTSR9H03Cx2n3ZAZxI
         UR7h+ffqhVUKMSLkcycaRCSVaBu+0kLoXQzrbtouG4YI0MtPMeRrIKvceunrfAJRCGQP
         0Rrluu34ssIuS5bgS/0+hdMZXSI4GRPxGCCGt4NH0yXnAykDFzSEvXu05OGlEfisr5K6
         Km3sVE+a6EB27U1hJZ9d2ncYaF2E1qgdw8yLtq1MyT4Uy9RI93zMoy8s01FHNe1XOQrb
         2+sIajZSHGn6SqKKG0s4UXoTO0GVnBIn0DdMk2C8Uyi3q8H9a/m6MiGwuIjPxK3SFdc5
         d+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710427983; x=1711032783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQdGRCc8CvufO8pJrzg/EbeDXgOQDIEiNqPLlOCuoyM=;
        b=oyrug3DnM7h/dfUOOL83oV8WpAYLguyB9g863i2YLaWGyGIspetB3yEWy6lDcdyYR+
         B0fAgDBB+Z3pkZWj7mHJbK7cVC3isGgTsWCa77oUsuL63vRIU2zD/DHoLPG007rf6m6v
         PycMZ+nxzB48X8dbBhwqEi3Gmq/y8WLzveVZgaAfGlCyni3/4582Rb2cXH3k8fqF574D
         jQpbNG6Gx0Wns0A4oUWeomhPOcTwmjRGpHnCe5oqlYF6ehl5fFenN0D22WYwOdhksPab
         XbgBUG2dR1Fblwey4t59HiYvgRCK84i0Xu5JqCCu4yIYWIM8346BOgyp7OpBrprDRjif
         pTDA==
X-Forwarded-Encrypted: i=1; AJvYcCUoA4KCGKzuQcBPvCNACChpCx9sdHGI+AgPbQFb9vaA6lH889RgcIPiK0uwaEJdd+2egsIz52PLdfVh+voQDL7ZZEH6CfIBCcdyZjmL
X-Gm-Message-State: AOJu0YydlNGUtiDkH6O3oX5K54j+Skt8aIyP+/znqdwGv22Nl7EGo7Cq
	y2GUs2uRatDxYyfkd6ADw04GSag1osuKCLensk9jR2mc50+TIRwDUozpndZimO4=
X-Google-Smtp-Source: AGHT+IHEMN+NstoSXqaYuO+a0b+IClYsaLbJ/T+IJD4cV0xAleMVWkTv6lKGty1MmRGzfPlPcDv1+Q==
X-Received: by 2002:a05:6a00:39a1:b0:6e6:7af6:2201 with SMTP id fi33-20020a056a0039a100b006e67af62201mr1888318pfb.8.1710427982718;
        Thu, 14 Mar 2024 07:53:02 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:7983:888b:1e31:65e6])
        by smtp.gmail.com with ESMTPSA id fb12-20020a056a002d8c00b006e6b73eb992sm1543850pfb.118.2024.03.14.07.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 07:53:02 -0700 (PDT)
Date: Thu, 14 Mar 2024 08:52:59 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: Add Arm remoteproc driver
Message-ID: <ZfMPS+qn0lh5IrS7@p14s>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-2-abdellatif.elkhlifi@arm.com>
 <ZeYWKVpeFm1+4mlT@p14s>
 <20240307194026.GA355455@e130802.arm.com>
 <CANLsYkzA20rQdTM6AOvFK=3o28GvcoRbckL=ri8RegHqyHaiCw@mail.gmail.com>
 <20240311114442.GA82865@e130802.arm.com>
 <CANLsYkwReJvB1UWvR5TwtSs-w_VqU45kDSUzuQ0k+waetEn6Yw@mail.gmail.com>
 <20240312173252.GA38992@e130802.arm.com>
 <ZfHTfNx4um8koTlY@p14s>
 <20240313171756.GA82165@e130802.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313171756.GA82165@e130802.arm.com>

On Wed, Mar 13, 2024 at 05:17:56PM +0000, Abdellatif El Khlifi wrote:
> Hi Mathieu,
> 
> On Wed, Mar 13, 2024 at 10:25:32AM -0600, Mathieu Poirier wrote:
> > On Tue, Mar 12, 2024 at 05:32:52PM +0000, Abdellatif El Khlifi wrote:
> > > Hi Mathieu,
> > > 
> > > On Tue, Mar 12, 2024 at 10:29:52AM -0600, Mathieu Poirier wrote:
> > > > > This is an initial patchset for allowing to turn on and off the remote processor.
> > > > > The FW is already loaded before the Corstone-1000 SoC is powered on and this
> > > > > is done through the FPGA board bootloader in case of the FPGA target. Or by the Corstone-1000 FVP model
> > > > > (emulator).
> > > > >
> > > > >From the above I take it that booting with a preloaded firmware is a
> > > > scenario that needs to be supported and not just a temporary stage.
> > > 
> > > The current status of the Corstone-1000 SoC requires that there is
> > > a preloaded firmware for the external core. Preloading is done externally
> > > either through the FPGA bootloader or the emulator (FVP) before powering
> > > on the SoC.
> > > 
> > 
> > Ok
> > 
> > > Corstone-1000 will be upgraded in a way that the A core running Linux is able
> > > to share memory with the remote core and also being able to access the remote
> > > core memory so Linux can copy the firmware to. This HW changes are still
> > > This is why this patchset is relying on a preloaded firmware. And it's the step 1
> > > of adding remoteproc support for Corstone.
> > >
> > 
> > Ok, so there is a HW problem where A core and M core can't see each other's
> > memory, preventing the A core from copying the firmware image to the proper
> > location.
> > 
> > When the HW is fixed, will there be a need to support scenarios where the
> > firmware image has been preloaded into memory?
> 
> No, this scenario won't apply when we get the HW upgrade. No need for an
> external entity anymore. The firmware(s) will all be files in the linux filesystem.
>

Very well.  I am willing to continue with this driver but it does so little that
I wonder if it wouldn't simply be better to move forward with upstreaming when
the HW is fixed.  The choice is yours. 

Thanks,
Mathieu

