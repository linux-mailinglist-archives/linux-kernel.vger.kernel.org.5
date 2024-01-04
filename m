Return-Path: <linux-kernel+bounces-16538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC99A823FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D991F21F98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24F2210FC;
	Thu,  4 Jan 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFmprMCX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648E20DDD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5f0629e67f4so3822787b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 02:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704365396; x=1704970196; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZroRwris0DtDaQFjQ/kdJIj4CeYX8OZcE1rnvSqF2A=;
        b=qFmprMCXdNYa1fKbHMLW0Zq+zjeJScBjC54viefwD1FtW4HpaJ73M5Di24y3AcOJYA
         zINRck9cj/sEZMWv7ge+oPgHc46oHdRStkQXevXXVMn6nNIzTbbeQveJ71k8maTZFWHP
         xPN6G7SzT1rSSuNUFQIPzy4+Sc+C/F4giA/r1eTXyi4zOLpInvdO5yQ8HSPAMbOSGfPS
         G+qKeALpXIfUIFXsU2izw15aQ1VGFluK/4EkR8BbKP492sGlStGqmkGBktoKc0xWTjQx
         T5xwyBLK00u/6vcLAidyTaYX+SLH/kITeStzo4KiaSlBGCZj0giVh/PXFnVU+ygFTNcB
         tKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704365396; x=1704970196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZroRwris0DtDaQFjQ/kdJIj4CeYX8OZcE1rnvSqF2A=;
        b=eHbX3m7psghSfcb+yHfeo5nYYe5Wi5gryqjEqMgy6U0eACzDhzsINfyKX5MFPsq3VJ
         ptMxsC3TASSBr6NAyu+2rw9DXAWB8vYO6u1GVf3r3f0v+p0kFpAX4DMd+5k6UwVwppAc
         Cwfb2SshNQdTsxlLkDoStmQrfvAU07s5N58M740Xqg9d7KOusrMI3CLC3axlp+z91UbU
         Es0yj2fkXbnJeUs7Ct/5iQusrUOX/ldRO3AbNaWX6Ia/9i3Cj/5sYX3nSn8wFf+hhOan
         +6rL5s95eV6zOtAV8VSaA8aq0/I67c+Oc9FfqQoRLfeoXiVi0nejIozl4whv028Xlw68
         qKxQ==
X-Gm-Message-State: AOJu0YwPr7t517AMJU5THSRqntlYjXlDU5b5Vu1t10ggrvcNm8P2VKJs
	uWa5jZiAEOOayFr6zM73kCOY0+Q9D07ephe5KVOwD53hCWK+3A==
X-Google-Smtp-Source: AGHT+IH04HHUjq2y5n7wKNiHMxZHKJ+rgve9k0eKq+IvK90xHCicvSOSUIFEJxkhZbiJYPTs32AcjR0lBpzZYVN44CQ=
X-Received: by 2002:a25:2d03:0:b0:db9:82b9:28b5 with SMTP id
 t3-20020a252d03000000b00db982b928b5mr335890ybt.35.1704365395795; Thu, 04 Jan
 2024 02:49:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104-gcc-docs-update-v1-1-127e4816b798@quicinc.com>
 <CAA8EJprsGke9zZBy_x=YSxz7R1aSpx8r3ndjjXVVKhjKBxd=QQ@mail.gmail.com>
 <724f608a-cbfe-48f6-a1f7-59b961a7d724@quicinc.com> <56ee556d-ec31-4553-bce3-0c1e12c111ed@linaro.org>
 <685f45d9-48e8-49c6-9de0-6771777ba62e@gmail.com> <a8012b92-6072-406d-8aab-ecb167ea44d2@quicinc.com>
In-Reply-To: <a8012b92-6072-406d-8aab-ecb167ea44d2@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 4 Jan 2024 12:49:44 +0200
Message-ID: <CAA8EJpoAA7RyD=9JZ9aYLMhyvCMWLVr1yhe7NSryRe=VjfmZPw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: ipq6018: add #power-domain-cells for
 gcc node
To: Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: Robert Marko <robimarko@gmail.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, quic_tdas@quicinc.com, 
	quic_aiquny@quicinc.com, kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 12:41, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
>
>
>
> On 1/4/2024 6:32 PM, Robert Marko wrote:
> >
> > On 04. 01. 2024. 11:16, Konrad Dybcio wrote:
> >> On 4.01.2024 11:13, Fenglin Wu wrote:
> >>>
> >>> On 1/4/2024 5:53 PM, Dmitry Baryshkov wrote:
> >>>> On Thu, 4 Jan 2024 at 10:06, Fenglin Wu via B4 Relay
> >>>> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
> >>>>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> >>>>>
> >>>>> Property '#power-domain-cells' is required as per defined in
> >>>>> qcom,gcc.yaml
> >>>>> so add it for ipq6018 gcc device node to eliminate following
> >>>>> warning in
> >>>>> dtbs_check:
> >>>>>
> >>>>> arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dtb: gcc@1800000:
> >>>>>           '#power-domain-cells' is a required property
> >>>>> from schema $id:
> >>>>> http://devicetree.org/schemas/clock/qcom,gcc-ipq6018.yaml#
> >>>> But ipq6018 doesn't implement GDSC support. So for the sake of fixing
> >>>> the warning you are adding a bogus property.
> >>>>
> >>> I agree. However, there are also some gcc drivers not implementing
> >>> GDSC support but the bindings are adding '#power-domain-cells' in the
> >>> DT example, such as: qcom,gcc-apq8064.yaml, qcom,gcc-ipq4019.yaml,
> >>> qcom,gcc-ipq6018.yaml, qcom,gcc-ipq8064.yaml, qcom,gcc-msm8660.yaml.
> >>>
> >>> Actually I thought that maybe we should do a clean up by removing
> >>> '#power-domain-cells' out of the qcom,gcc.yaml binding and only
> >>> adding it into individual qcom,gcc-xxx.yaml for the driver which has
> >>> implemented GDSC support. I checked this with Taniya offline, but she
> >>> prefers only fixing it in ipq6018.dtsi as it doesn't hurt anything by
> >>> adding the property, and she expects the GDSC support should be
> >>> existing in most of qcom,gcc drivers especially the newer Qcom chipsets.
> >> Before we start changing anything, we should assess whether these
> >> platforms actually have GDSCs within this clock controller block,
> >> even if they are (currently) not described in the clk driver.
> > Hi,
> > IPQ6018 has GDSC-s, at least for the USB-s.
> > I tried configuring them a while ago, but the USB2.0 GDSC seems to
> > either have a HW bug or
> > it uses some special configuration as its status bits never show that
> > its ON [1].
> >
> > [1]
> > https://patchwork.kernel.org/project/linux-arm-msm/patch/20231025104457.628109-2-robimarko@gmail.com/
> >
> Thanks for the link! I checked the spec internal, and I did see GDSC
> device for USB0/USB1 controller is present in GCC clock controller.
> So considering there is a patch ongoing to add GDSC device for ipq6018
> gcc driver, can the DT commit which adds '#power-domain-cells' be accepted?

What for?

-- 
With best wishes
Dmitry

