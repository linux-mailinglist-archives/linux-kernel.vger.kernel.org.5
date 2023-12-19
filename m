Return-Path: <linux-kernel+bounces-5037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70618185BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6F4283BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B2814F79;
	Tue, 19 Dec 2023 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlnnZaX1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EFB1872
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbcfd61bd0fso3010429276.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702983257; x=1703588057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=anBAHVOVvM4j+dShGvK/3C4/G3dScYLizOG8GPTA2U8=;
        b=RlnnZaX1cZh32yt9vdi51YrrubUlkDHEkeGYN+h1D5Hw5isy+bpYk7a+bkS2F8wauk
         yQ6Ul4pwCliIub703X9XF8T8/UOG99ndjkfT0Js9EKfksljKR0TikDO+DWsKQCxBkabn
         iS6AsJzSRjt1nuGoBN2xAsOZZ/doEyG7rUVPe87Q4frc+HLfM+1odzicdwYdy1rcOMZH
         nQx5Q4W1vJpl4n8sNGoj8esyiBoMlMoADAN7HKfNDxugVnHhP5AuwxggU8OW8FX/mGjL
         6KiKoFZMRoh8l0JDfPB//83YMJGWueCsgd759/wEviyDYq2Rw62EvsSNnSJ7xnCSGYef
         x/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702983257; x=1703588057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anBAHVOVvM4j+dShGvK/3C4/G3dScYLizOG8GPTA2U8=;
        b=fYPX+O2Le8T6wjCxy5FvUwwLwl69EZFs8qGyYlt/EUEzvFgKLqlhskESz76N70KHt2
         LCwAhuBjvBmwYiuMvypHymz2ZM6maGIMlc+md0Qd1n+lQ6fy8VANsSuDDsFGJNyB8pe3
         zS7YDxotcYTWnzdK8RyjLUyP9vUX3z3bPlG0+pHPLae7VD2/nIx6mMXqlnyilBPzTJdE
         Hbv+gLXzwkA+8m4k9s62rIyi1OcHw9ifd4C8eV6h5suP1dpFRJ94SE7eYeKEkVGHPkqF
         PmWdDFEaDaUbkmkxktMr5PSHpwXFCkbrbEm1Dfo7BunRYiWchVfR0AR5vIQ3xoYWE6bB
         HPvg==
X-Gm-Message-State: AOJu0Yx9tJ/tDz/pqqWmxz5F+f6jsNAjH5bgpT5sKm/Dwb6oYabZBQrK
	88ls0ZR+XgZDN12NhBQIlvOjncJ2IOiDWbo7FrmAnoZeAA6ypw==
X-Google-Smtp-Source: AGHT+IGhEzGlCWq1rL4qGXwqd4YgBr4sH7tRvCT6SHVQRBa1xR5Wj9Q5ZKq/NSBF7Ket2OSBTP2miMI1NRXQhn1lFrM=
X-Received: by 2002:a25:4294:0:b0:dbc:fbba:2e6c with SMTP id
 p142-20020a254294000000b00dbcfbba2e6cmr487272yba.45.1702983256719; Tue, 19
 Dec 2023 02:54:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219005007.11644-1-quic_tengfan@quicinc.com>
 <20231219005007.11644-5-quic_tengfan@quicinc.com> <ec730ce7-2021-4cad-97e6-0a86c6063533@linaro.org>
 <cd5a0140-295a-4f48-a378-3c2b8be0f499@quicinc.com> <f0f707c0-dd96-4409-bfc5-118d885933e8@linaro.org>
 <d955f3bb-c73e-4777-b268-a8abc70788ef@quicinc.com>
In-Reply-To: <d955f3bb-c73e-4777-b268-a8abc70788ef@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Dec 2023 12:54:05 +0200
Message-ID: <CAA8EJpqjJe49xmRyb40_ypdZCn0njBLuF7vsah5Gm1b=9trn5A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] arm64: dts: qcom: qcs8550: introduce qcs8550 dtsi
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tengfei Fan <quic_tengfan@quicinc.com>, 
	andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 12:20, Aiqun Yu (Maria) <quic_aiquny@quicinc.com> wrote:
>
>
>
> On 12/19/2023 6:01 PM, Krzysztof Kozlowski wrote:
> > On 19/12/2023 10:57, Aiqun Yu (Maria) wrote:
> >>
> >>
> >> On 12/19/2023 3:02 PM, Krzysztof Kozlowski wrote:
> >>> On 19/12/2023 01:50, Tengfei Fan wrote:
> >>>> QCS8550 is derived from SM8550, it is mainly used in IoT scenarios.
> >>>
> >>> What are the differences? You need to describe the hardware, you have
> >>> entire commit msg for something useful which will avoid such comments
> >>> from reviewers.
> >>>
> >>>>
> >>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> >>>> ---
> >>>>    arch/arm64/boot/dts/qcom/qcs8550.dtsi | 6 ++++++
> >>>>    1 file changed, 6 insertions(+)
> >>>>    create mode 100644 arch/arm64/boot/dts/qcom/qcs8550.dtsi
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/qcom/qcs8550.dtsi b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
> >>>> new file mode 100644
> >>>> index 000000000000..254657f46c5e
> >>>> --- /dev/null
> >>>> +++ b/arch/arm64/boot/dts/qcom/qcs8550.dtsi
> >>>> @@ -0,0 +1,6 @@
> >>>> +// SPDX-License-Identifier: BSD-3-Clause
> >>>> +/*
> >>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> >>>> + */
> >>>> +
> >>>> +#include "sm8550.dtsi"
> >>>
> >>> This is a weird file. I thought qcs8550 has differences from sm8550,
> >>> e.g. lack of modem, so why do you claim you have here MPSS?
> >> MPSS here in qcs8550 is a GPS only MPSS.
> >
> > Is it different or the same? Is the interface the same? So many
> > questions and so little information. You have entire commit msg to
> > explain this.
> we can add all current email information into the commit message in next
> patchset.
> >
> >>
> >> QCS8550 will have a different firmware release with sm8550, and it will
> >> have different memory reserved for the firmware to be used.
> >> While firmware release along with memory map was not settled down yet.
> >> That's why currently qcs8550.dtsi is an "empty file" and only include
> >> sm8550.dtsi. As long as the firmware release is settled down, we will
> >> have more detailed different node here.
> >
> > So the DTS is not really usable now?
> curent qcs8550.dtsi is an "empty file" which is identical to "sm8550.dtsi".
> While qcs8550-aim300-itot.dts is currently used with a "temporary
> reserved memory" for those engineer qcs8550 firmware for boot up and
> limited function verify.

You know, this doesn't work this way. Once the board dts file lands
into the kernel, it _must_ be supported for quite a while. So if you
land your 'temporary' memory map, you will be forced to stick to it
forever.

If you want to share the interim state, you _MUST_ state that in the
cover letter and you _MUST_ mark your patches in a sufficient way so
that they can not be merged by accident.

> So the idea here is to postpone only the firmware related reserved
> memory part. And open an "empty file" qcs8550.dtsi for common which can
> be used for other board like qcs8550-rb5-gen2.

Unfortunately, this means NAK for this patch and for the whole series.
Please finish the memory map first. You can not change that after the
patches have been landed in the kernel.

And BTW, as we have landed the qcm6490-rb3gen2, could you please drop
the second dash for the sake of uniformity?

> >>
> >> By the way, RB5 gen2 will also relies on the current qcs8550.dtsi, since
> >> it is using the same qcs8550 soc, and will use the same firmware release.
> >>
> >> We have patch version2 remove the qcs8550.dtsi, and have SOM dtsi
> >> qcs8550-aim300.dtsi include the sm8550.dtsi. While after discussion, our
> >> understanding is that we can have an qcs8550.dtsi like this. Feel free
> >> to let us know if it is not right understanding.
> >>
> >>>
> >>> It's really confusing now.
> >>
> >> We can have a syncup to clear the confusing point if needed. :)
> >>>
> >
> > The code and commit msg are confusing. I need to keep asking you to get
> > any information.


-- 
With best wishes
Dmitry

