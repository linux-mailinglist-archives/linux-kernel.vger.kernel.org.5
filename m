Return-Path: <linux-kernel+bounces-23252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7CC82A9C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DBFBB248F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49509FC19;
	Thu, 11 Jan 2024 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="hyWHgQPf"
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA102FBFA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-55569b59f81so6285538a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1704963334; x=1705568134; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+urHVCxXYj39IE1pxye+SFmnhznkKtnAt7Qr2ngkeI=;
        b=hyWHgQPfOCt59gKs95hRuIAfcQjgJoRv/jS+nrBuh7bVX3BEAGbf31AsYf46ZJG/z0
         K2pnpVocK8miiZ611d21CB5wzF/pr7zd9fp1s9DG5HQs8E2OygkfopLBvKFHxvqzBelX
         o6fC7B+tcD2d+Sw+yyz3RHcANPOWuhLYQGe1Zc4CujyTL06U6bNas11k26iez4Se31mt
         cXa8WwSOnQ/nPb/F0yye6z6mk+eBRDVDvD9LPGy9jlZcONXGPPmPQY1Cb21Fl3kGYqZ8
         rING12D1uNxf61XQntoxcYlKcHNXqaGfYwGw8ItUJ5edI7mkP/HT/x5qWJ7iRg7Hcpdb
         1sQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963334; x=1705568134;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+urHVCxXYj39IE1pxye+SFmnhznkKtnAt7Qr2ngkeI=;
        b=mhmvILkRG61JDQGdniUcxXjlse2y6OOdAgkO9FNki4L5rB6kAxW0dAWSevEKVinzhO
         9aiKRtuj4hjtGaAQhKZfAdCzng9/mE7Kjgrs2Liwvdr+jERmNeHZWMnU3pNZuTEfOwJa
         iV8LoXuBGNmWbNJK141GJAPi6MQg559iBOOLkCiD+YwTYz68I8toR85cAcXBFPbI8jge
         7Q9KHmm9tBGOomWAv7XUtjLcingIah50hwIPm0zJ0HXRjHPW1AfWnIae0sZMi5pI2XK7
         KWGCqsQ18css1TeSQi/JNZEjzx41pvGrWeSf5REaTi6VZkEgL+daGvUXfOuQEFj58bKE
         izMg==
X-Gm-Message-State: AOJu0YwlW/u9RaMN0kzw8Pd2D6Qakk5nXk+TcAiXt9ell3IrU01gPdfO
	ccEdfvXf5m71KMgwXFZupkDYdwgQCR/LiA==
X-Google-Smtp-Source: AGHT+IFkOaiX1Qj7iGZDGLUwqNZiH0n8d9X2CJnd6YUgczb+xRKH3UmnXd4YgHnjN2v+RKH3pQQJPg==
X-Received: by 2002:aa7:c69a:0:b0:558:80c7:5e8f with SMTP id n26-20020aa7c69a000000b0055880c75e8fmr372546edq.9.1704963334132;
        Thu, 11 Jan 2024 00:55:34 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id c10-20020a0564021f8a00b00557d29be289sm362971edc.11.2024.01.11.00.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 00:55:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jan 2024 09:55:33 +0100
Message-Id: <CYBR26JQ2SD4.33ELRAVYZW1PY@fairphone.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm7225-fairphone-fp4: Add PM6150L
 thermals
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@linaro.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley"
 <conor+dt@kernel.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>
X-Mailer: aerc 0.15.2
References: <20240105-fp4-thermals-v1-0-f95875a536b7@fairphone.com>
 <20240105-fp4-thermals-v1-2-f95875a536b7@fairphone.com>
 <18dc5f88-6590-4e2d-948f-fd77f4713f8b@linaro.org>
 <CYA4ZGOQOJXY.2RO98RBCDKK5J@fairphone.com>
 <f78ce9e6-0a25-4e08-b972-db055b7afd71@linaro.org>
In-Reply-To: <f78ce9e6-0a25-4e08-b972-db055b7afd71@linaro.org>

On Wed Jan 10, 2024 at 8:16 PM CET, Konrad Dybcio wrote:
>
>
> On 1/9/24 12:24, Luca Weiss wrote:
> > On Tue Jan 9, 2024 at 11:09 AM CET, Konrad Dybcio wrote:
> >>
> >>
> >> On 1/5/24 15:54, Luca Weiss wrote:
> >>> Configure the thermals for the PA_THERM1, MSM_THERM, PA_THERM0,
> >>> RFC_CAM_THERM, CAM_FLASH_THERM and QUIET_THERM thermistors connected =
to
> >>> PM6150L.
> >>>
> >>> Due to hardware constraints we can only register 4 zones with
> >>> pm6150l_adc_tm, the other 2 we can register via generic-adc-thermal.
> >>
> >> Ugh.. so the ADC can support more inputs than the ADC_TM that was
> >> designed to ship alongside it can?
> >>
> >> And that's why the "generic-adc-thermal"-provided zones need to
> >> be polled?
> >=20
> > This part of the code from qcom-spmi-adc-tm5.c was trigerring if I
> > define more than 4 channels, and looking at downstream I can also see
> > that only 4 zones are registered properly with adc_tm, the rest is
> > registered with "qcom,adc-tm5-iio" which skips from what I could tell
> > basically all the HW bits and only registering the thermal zone.
> >=20
> >=20
> > 	ret =3D adc_tm5_read(chip, ADC_TM5_NUM_BTM,
> > 			   &channels_available, sizeof(channels_available));
> > 	if (ret) {
> > 		dev_err(chip->dev, "read failed for BTM channels\n");
> > 		return ret;
> > 	}
> >=20
> > 	for (i =3D 0; i < chip->nchannels; i++) {
> > 		if (chip->channels[i].channel >=3D channels_available) {
> > 			dev_err(chip->dev, "Invalid channel %d\n", chip->channels[i].channel=
);
> > 			return -EINVAL;
> > 		}
> > 	}
> >=20
> >=20
> >>
> >>>
> >>> The trip points can really only be considered as placeholders, more
> >>> configuration with cooling etc. can be added later.
> >>>
> >>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> >>> ---
> >> [...]
> >>
> >> I've read the sentence above, but..
> >>> +		sdm-skin-thermal {
> >>> +			polling-delay-passive =3D <1000>;
> >>> +			polling-delay =3D <5000>;
> >>> +			thermal-sensors =3D <&msm_therm_sensor>;
> >>> +
> >>> +			trips {
> >>> +				active-config0 {
> >>> +					temperature =3D <125000>;
> >>> +					hysteresis =3D <1000>;
> >>> +					type =3D "passive";
> >>
> >> I don't fancy burnt fingers for dinner!
> >=20
> > With passive trip point it wouldn't even do anything now, but at what
> > temp do you think it should do what? I'd definitely need more time to
> > understand more of how the thermal setup works in downstream Android,
> > and then replicate a sane configuration for mainline with proper
> > temperatures, cooling, etc.
> If "skin therm" means "the temperature of some part of the phone's
> body that can be felt with a human hand", then definitely some
> throttling should happen at 40ish with heavy throttling at 50
> and crit at 55 or so..
>
> We should probably make this a broader topic and keep a single
> policy for all supported phones.

I agree that this shouldn't be implemented differently per device since
it's really more a question "what should Linux do" that's quite a
general question and not device-specific. Of course some device-specific
tweaks could be here and there, like if the phone has metal back or
plastic back but it's only minor.

Based on the config here
https://gerrit-public.fairphone.software/plugins/gitiles/platform/hardware/=
qcom/thermal/+/refs/heads/odm/dev/target/13/fp5/thermalConfig.cpp#946
it looks like throtteling starts for internal components at 95degC with
a shutdown threshold of 115degC.
The skin sensor here has a throttling threshold of 40degC and shutdown
threshold of 95degC.

But actually I'm not even sure this config gets active for QCM6490 with
socid=3D497. So yeah I need more time digging into the thermal code to see
what it's actually doing.. Not that it would/should be much different
for socid=3D497 I guess though.

There's also plenty of thermal code in qcom proprietary.

Regards
Luca

>
> + CC AGdR, may be interested in where this leads
>
> Konrad


