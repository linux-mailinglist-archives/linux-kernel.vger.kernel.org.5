Return-Path: <linux-kernel+bounces-68660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E87857DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675A21F25E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B5C12BF36;
	Fri, 16 Feb 2024 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpmTDcqj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D092CCB4;
	Fri, 16 Feb 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091149; cv=none; b=g+7hPuQTuS5JiyI3jQLxD4FyBVCG/nVMzuO6uPP2ogAAucP+2vSKttLNGqhcZW6nWXZb11Vuq7DE7WYBA+gBfjDeDT0de/5t9Hr+duIjA98yPhpPb98kj7ozCeB0zxdcknhoFTOGi+zA2P2aWHyAadazAdrohlh3O0efeFj3a58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091149; c=relaxed/simple;
	bh=d9Bzh9P8NxtPjWqITn8rHulkcUgjn4uOxVfVyQ3u3AY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtqcYEqQ//g7fuoW/nK9K+vEHK3xeUg6DMS9ErVqk/mmGQ2ezHBcnGNwBaYTm0uhkdDgVjGZGe5EEehNHAl6xqr2On34suUT7c9DYtOG59Grd55j5eYjmZsprgHVhCG/Oap2o2nVVE2+ANTMAqY3gQrE6332vGhZfHFYQLQ/zSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpmTDcqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B38DC433F1;
	Fri, 16 Feb 2024 13:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708091149;
	bh=d9Bzh9P8NxtPjWqITn8rHulkcUgjn4uOxVfVyQ3u3AY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GpmTDcqj9c688tqKUSBEtMODmHp9u6pSgYAtlEIIZenR2XmqUY6kmwaVNdHa1+2e7
	 daxDIDgnocfN0ZioFNSCnS30P18ZjAw5ffmdWSJcCJjOptRyfC8pac2ZW3Dv8/2RfQ
	 Owe0hQ2B/wuNXzAC2ZzGUYZZP82bDa3RXQwrEkyDxqgdaVC4HO3rl4mdZ4/o+MTwE3
	 qb4tlHqzDISQULefI8l96W7tUZedr/USj6WkenUnqmt7vzUHsxt/e5j720zqAZaIBQ
	 qCQkCHgPMMR9HI54D5+J2dCssKrsEl6ty3oLO/5ZASiu8l2HeoT16O+ZsG3fyvtRXW
	 yympsZqOAa95w==
Date: Fri, 16 Feb 2024 13:45:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <quic_jprakash@quicinc.com>
Cc: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
 <lee@kernel.org>, <andriy.shevchenko@linux.intel.com>,
 <daniel.lezcano@linaro.org>, <dmitry.baryshkov@linaro.org>,
 <lars@metafoo.de>, <luca@z3ntu.xyz>, <marijn.suijten@somainline.org>,
 <agross@kernel.org>, <sboyd@kernel.org>, <rafael@kernel.org>,
 <rui.zhang@intel.com>, <lukasz.luba@arm.com>, <linus.walleij@linaro.org>,
 <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
 <quic_amelende@quicinc.com>, <quic_kamalw@quicinc.com>,
 <kernel@quicinc.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <cros-qcom-dts-watchers@chromium.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: adc: Add support for QCOM
 PMIC5 Gen3 ADC
Message-ID: <20240216134531.159a9da8@jic23-huawei>
In-Reply-To: <12723477-aee2-40bc-80f0-a86c16c98988@quicinc.com>
References: <20231231171237.3322376-1-quic_jprakash@quicinc.com>
	<20231231171237.3322376-3-quic_jprakash@quicinc.com>
	<20240101180209.56e04267@jic23-huawei>
	<12723477-aee2-40bc-80f0-a86c16c98988@quicinc.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 16:09:38 +0530
Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> Hi Jonathan,
> 
> On 1/1/2024 11:32 PM, Jonathan Cameron wrote:
> > On Sun, 31 Dec 2023 22:42:36 +0530
> > Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
> >  
> >> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the  
> 
> >> +
> >> +      label:
> >> +        $ref: /schemas/types.yaml#/definitions/string
> >> +        description: |
> >> +            ADC input of the platform as seen in the schematics.
> >> +            For thermistor inputs connected to generic AMUX or GPIO inputs
> >> +            these can vary across platform for the same pins. Hence select
> >> +            the platform schematics name for this channel.  
> > defined in adc.yaml, so should just have a reference to that here.
> >  
> >> +
> >> +      qcom,decimation:
> >> +        $ref: /schemas/types.yaml#/definitions/uint32
> >> +        description: |
> >> +            This parameter is used to decrease ADC sampling rate.
> >> +            Quicker measurements can be made by reducing decimation ratio.  
> > Why is this in DT rather than as a userspace control?  
> 
> 
> We don't intend this property to be something that can be controlled 
> from userspace - if a client wants to read an ADC channel from 
> userspace, we only intend to provide them the processed value, 
> calculated with a fixed set of ADC properties mentioned in the 
> corresponding channel node in DT.

Why?  This is a way to control precision of an ADC channel read out.
That's policy rather than dependent on the hardware.
To be in DT we (mostly) need it to be related to the hardware configuration
(i.e. what it is wired to etc).


> 
> 
> >> +        enum: [ 85, 340, 1360 ]
> >> +        default: 1360
> >> +  
> 
> >> +
> >> +      qcom,hw-settle-time:
> >> +        $ref: /schemas/types.yaml#/definitions/uint32
> >> +        description: |
> >> +            Time between AMUX getting configured and the ADC starting
> >> +            conversion. The 'hw_settle_time' is an index used from valid values
> >> +            and programmed in hardware to achieve the hardware settling delay.
> >> +        enum: [ 15, 100, 200, 300, 400, 500, 600, 700, 1000, 2000, 4000,
> >> +                8000, 16000, 32000, 64000, 128000 ]
> >> +        default: 15  
> > only currently defined for muxes but we have settle-time-us which has benefit of
> > providing the units (which are missing here from the description as well)
> >  
> >> +
> >> +      qcom,avg-samples:
> >> +        $ref: /schemas/types.yaml#/definitions/uint32
> >> +        description: |
> >> +            Number of samples to be used for measurement.
> >> +            Averaging provides the option to obtain a single measurement
> >> +            from the ADC that is an average of multiple samples. The value
> >> +            selected is 2^(value).  
> > Why is this in dt?  Why not just userspace control (in_voltageX_oversampling_ratio
> >
> > If it needs to be, we do have standard DT bindings for it in adc.yaml  
> 
> 
> avg-samples is also something we don't want the client to modify from 
> userspace. As for using adc.yaml, I think I could use settling-time-us 
> and oversampling-ratio from it for the above two properties.

Same as for above.  This is policy. If you want to control it that belongs
in a udev script or similar, not the DT bindings.
We tend to resist defining such policy in DT because it isn't a characteristic
of the hardware and depending on the usecase userspace may have good reason
to tweak the settings (or consumer drivers if you have those as sometimes
these numbers are about getting a particular precision needed for what
we are measuring to be useful for another driver).

There is some legacy for this though as you point out. So that may be a
strong enough argument for why we should make an exception this time.
If so make that clear in the patch description.

> 
> However, Krzysztof has mentioned in another comment that I should put 
> properties common to ADC5 Gen3 and older QCOM VADC devices in a common 
> schema. If I now try replacing the existing qcom,hw-settle-time and 
> qcom,avg-samples properties with settling-time-us and oversampling-ratio 
> for older devices too, I would have to make several DT changes for 
> existing devices...are you fine with this? Or should I just replace 
> these two properties for ADC5 Gen3?

If you change DT binding for older devices, you will need to maintain
backwards compatibility.  It's fine to deprecate them in the binding
docs etc, but not the driver (as there may be old DT on devices that
can't be easily updated).

> 
> 
> I'll address your other comments in the next patchset.
> 
> 
> Thanks,
> 
> Jishnu
> 


