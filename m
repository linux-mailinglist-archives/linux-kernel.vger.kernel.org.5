Return-Path: <linux-kernel+bounces-6450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5178198F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098561C22182
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C4B15AFF;
	Wed, 20 Dec 2023 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgBkAR6B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCA6134BE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5d3758fdd2eso43469447b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703055991; x=1703660791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PDWrKqsTiKF62ylXC5/B7bhK2bQor5BoNL0HPFCdigI=;
        b=PgBkAR6BCSG8V8Qouyg1TGXdzlFpj2BpN9rCwTnJEjia06lrU1MrBL9ULOh36cQgO4
         ATZTtGCJ3cLeb8Yj3AKaGUJNDOKhv7gH5wB6DY84a1wWqmtE0ZIDBD2vH07odubKsIRz
         kEILYq6XnGQK8wijky6Ca1b7Za4tyzR/niFJ4pNPcu8ap3PcmMBnA+SGDfYdZWJPGjvE
         w5ZaKNM9GFMQeXhZofAzybLbuBcTTNHhuwOuClK4wJb+SqkB4bJM04DBY27mHbNQhkJf
         BvEGo47hFuWVYcN2idhW9SfjgYOm/8CfM4AUyBexWyvTUnkUOZZf5/4g4GyCxHe1dyWZ
         3w1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703055991; x=1703660791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PDWrKqsTiKF62ylXC5/B7bhK2bQor5BoNL0HPFCdigI=;
        b=Y7dz908v818uWVIEs/zaYECTHf52jMvAdybD2ejW452k7ztislM9Doxcj+PFmjDlWy
         Wmukn14RbQm4JZO6V1JGu8mT+q+aafw3h/6EZUUgTWtO24Oo2riJkX62+QoASXxxO9pK
         U1MAxqSpyQEH6YJ6Rdm+HmIprjEjVEq8qoJQzBBxmxJcSGv0gEfNAtuMxacerR4t59nv
         xsXArqqoErU+zqjvR+Rbl98h1BNPCzxtI47FxySd0+xI+hy2/Wz+n3uJlF1jihP3OJXM
         ACqoFTxSA0ZS7yW4vvAxeGgiUVyJS+vc7WH0vL5jhNHx+blTkQuzKWL4jnLkX2zyTnK2
         iSlQ==
X-Gm-Message-State: AOJu0YxgxTg9zuJQEh3vLU0sJuBB5SdXQIkrXAshZgmPC94aHdLBpudT
	Yikv73w+cusIQd8oPXHg+1AyA/P9GD8Yk2sWe7JU7g==
X-Google-Smtp-Source: AGHT+IEcFbcbnmj03utajyA2pEmfcmpjmCIOSVshHqD10gIE95RFefIkqz/0Orl4DYbbQYaTb6iSqQKcL09KnFp1APU=
X-Received: by 2002:a0d:dac3:0:b0:5d7:90da:ce13 with SMTP id
 c186-20020a0ddac3000000b005d790dace13mr14576836ywe.18.1703055991470; Tue, 19
 Dec 2023 23:06:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
 <20231219003106.8663-2-quic_tengfan@quicinc.com> <457e336e-004c-4721-b58d-e9ada16dc04b@linaro.org>
 <a8f168da-14f7-4377-8dea-f282a3eac0a4@quicinc.com> <13b61d41-6045-499e-864b-51c6cb6eacf9@linaro.org>
 <38604415-b410-4995-9c4f-525536435699@quicinc.com> <CAA8EJpo07gE7ZeNP6wSGTLtmF_3PKQAKFyMRZ8dk1K+f7PAxrg@mail.gmail.com>
 <ad1547cf-0520-422d-a105-ec426f526d71@quicinc.com>
In-Reply-To: <ad1547cf-0520-422d-a105-ec426f526d71@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 20 Dec 2023 09:06:20 +0200
Message-ID: <CAA8EJppwsezPV21Uw8xTn=ra8L2jfnkHoRghDPN96O5tJsOD7A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: sm8550: remove
 address/size-cells from mdss_dsi1
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tengfei Fan <quic_tengfan@quicinc.com>, 
	andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 02:54, Aiqun Yu (Maria) <quic_aiquny@quicinc.com> wrote:
>
>
>
> On 12/19/2023 6:21 PM, Dmitry Baryshkov wrote:
> > On Tue, 19 Dec 2023 at 12:09, Aiqun Yu (Maria) <quic_aiquny@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 12/19/2023 5:41 PM, Krzysztof Kozlowski wrote:
> >>> On 19/12/2023 10:36, Aiqun Yu (Maria) wrote:
> >>>>
> >>>>
> >>>> On 12/19/2023 3:17 PM, Krzysztof Kozlowski wrote:
> >>>>> On 19/12/2023 01:31, Tengfei Fan wrote:
> >>>>>> The address/size-cells in mdss_dsi1 node have not ranges and child also
> >>>>>> have not reg, then this leads to dtc W=1 warnings:
> >>>>>
> >>>> Comments can be more readable:
> >>>> "mdss_dsi1" node don't have "ranges" or child "reg" property, while it
> >>>> have address/size-cells properties. This caused
> >>>> "avoid_unnecessary_addr_size" warning from dtb check.
> >>>> Remove address/size-cells properties for "mdss_dsi1" node.
> >>>>
> >>>>> I cannot parse it. Address/size cells never have ranges or children.
> >>>>> They cannot have. These are uint32 properties.
> >>>> Pls help to comment on the revised commit message. Every time I write a
> >>>> commit message, also takes a while for me to double confirm whether
> >>>> others can understand me correctly as well. Feel free to let us know if
> >>>> it is not readable to you. It will help us as non-English native developers.
> >>>>>
> >>>>>>
> >>>>>>      sm8550.dtsi:2937.27-2992.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
> >>>>>>        unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> >>>>>>
> >>>>>>
> >>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> >>>>>> ---
> >>>>>
> >>>>> I disagreed with the patch before. You resubmit it without really
> >>>>> addressing my concerns.
> >>>>>
> >>>>> I am not sure if this is correct fix and I want to fix all of such
> >>>>> errors (there are multiple of them) in the same way. Feel free to
> >>>>> propose common solution based on arguments.
> >>>> Per my understanding, "qcom,mdss-dsi-ctrl" driver node like "mdss_dsi1"
> >>>> don't need to have address/size-cells properties.
> >>>
> >>> Just because dtc says so? And what about bindings?
> >> I don't find any reason why "qcom,mdss-dsi-ctrl" driver node need to
> >> have address/size-cells properties. Document Bindings should also be fixed.
> >>>
> >>>> Feel free to let us know whether there is different idea of
> >>>> "address/size-cells" needed for the "qcom,mdss-dsi-ctrl" driver node.
> >>>
> >>> The bindings expressed that idea. If the binding is incorrect, fix the
> >>> binding and the DTS. If the binding is correct, provide rationale why it
> >>> somehow does not apply here etc.
> >> Our plan is to fix the bindings as well.
> >>
> >> In case you have missed the question, I just re-place it here:
> >> While there are about 22 different soc dtsi and it's document binding
> >> files needed to be fixed. Shall we fix it for all qcom related soc usage
> >> in one patch, or we'd better to split into different patches according
> >> to soc specifically?
> >
> > Don't touch the bindings unless you understand what you are doing.
> > Your patch will be NAKed. There can be a DSI panel attached to the DSI
> > host, which means there is a need for #address-cells / #size-cells.
> >
> Could you please help to elaborate more on details? Like what's the
> right example here for the "qcom,mdss-dsi-ctrl" driver node needed to
> have "#address-cells"/"#size-cells".

As I wrote, the attached DSI panels make use of #address-cells / #size-cells.

Please take a look at the sdm845-mtp.dts, which provides a complex
enough example (a panel which is attached to both DSI0 and DSI1
hosts).

> Thx to chime in that we have put a good amount of time here.

Can't quite catch you here.

> > Please stop wasting the time on dtc warning. The bindings (and the
> > file) are correct.
> I don't agree here.
> Either it is a wrong usage of "#address-cells"/"#size-cells", or dtc
> warning should be fixed with this usage take into account.
> "dtb check" will be a good guideline for developers to follow, I don't
> think it is wasting time here.

It is a guideline, but not a rule. No warnings by default is more of
the rule. W=1 enables warnings that developers have to classify and
cope with.

E.g. I don't think dtc correctly handles the case when there are both
with-address and no-address nodes (e.g. 'panel@0' and 'ports'). Note,
I might be mistaken there.

> >
>
> --
> Thx and BRs,
> Aiqun(Maria) Yu



-- 
With best wishes
Dmitry

