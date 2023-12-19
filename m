Return-Path: <linux-kernel+bounces-5010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B010881853D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A85283ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C307C14F78;
	Tue, 19 Dec 2023 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1SQyXTb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9A14AA8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5d7a47d06eeso35498857b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702981295; x=1703586095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lJHN/nZH55N6VvaZaAZtpZMkjKp9jds0WE3B6lm/6ss=;
        b=P1SQyXTbWlOFgZw+Ggkmm8R/mL1T6tjdUZTW7OLMBc+wqnJVM0AqA3vzffn8/AyGNu
         yqE8ZeEX+NJ4Z5Ux5Hm6kPEXjaEa6zfC1iwuQ3eCeahZIwvwKLpFoPWH5OhBJ1qZ2U0d
         4JYXhm6TVIq6PBna/KUW3okfqxFLneJ8mfA8ScXgH2mANonmH6InpxSyAt5r73Na4Cb1
         cUkx5Wwi5tDOIXOR4/GBlV7yD2oZ5xzuTLyFS1TvKJtmDZjfra10IhnSDWe1ApmrK2yL
         /8kmKxbf/v22DWUps33n+dna0MExA/9hbk7LXkzmi/5IgmhWGtcl3WhfBPqKhV85j79Z
         tZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702981295; x=1703586095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJHN/nZH55N6VvaZaAZtpZMkjKp9jds0WE3B6lm/6ss=;
        b=qI990M/XaapEjuoo3fQ1pNFq3QUfwmeSo79dHgQ+Dz0R+M9fFJi/XuDX0VPs6BUzao
         4vskYvAdzh3O7Ft2MASixkpolVWD4nDxDnykbLxyq85Bxj//UWpWmQYUN0tUhfU9GmkF
         FdvkwSf9UsqF88xrXCReBUhH/chVOT7MPsJBTY/+QdIQgB+mB0kb4OV3BU5ir9sN+utN
         gRYN21oWbxbCGS9Jime1X3YObp1OU8Z2w6JG4veVYSXlpCxlhSh+TbiJs8jbdV5g9lIZ
         4UQYgUQjmXa+J2d3UlHQWjnN5wOeoWCMs9hmB1ZblewDmJ65ifvnuEwF6lkeG98g6scs
         MU1g==
X-Gm-Message-State: AOJu0YwOiOaAd+Apw1117Grds4D5k79HiU36cgW5YfgHcG0TGGAW8IIr
	MG7efVbLfk+n8vt4PRZC4z5wy+IJvVRBAVXUI+Gicw==
X-Google-Smtp-Source: AGHT+IHrLBxPUVOjm7wRbo7M4HpbDoyVyMEnUeRnGXyuxCDlcYiAMMTRmJux1fR16ItYG7qtIKxbHVEiezj/4KDbM+0=
X-Received: by 2002:a81:494f:0:b0:5e4:f18c:9956 with SMTP id
 w76-20020a81494f000000b005e4f18c9956mr4378425ywa.24.1702981295343; Tue, 19
 Dec 2023 02:21:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
 <20231219003106.8663-2-quic_tengfan@quicinc.com> <457e336e-004c-4721-b58d-e9ada16dc04b@linaro.org>
 <a8f168da-14f7-4377-8dea-f282a3eac0a4@quicinc.com> <13b61d41-6045-499e-864b-51c6cb6eacf9@linaro.org>
 <38604415-b410-4995-9c4f-525536435699@quicinc.com>
In-Reply-To: <38604415-b410-4995-9c4f-525536435699@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Dec 2023 12:21:23 +0200
Message-ID: <CAA8EJpo07gE7ZeNP6wSGTLtmF_3PKQAKFyMRZ8dk1K+f7PAxrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] arm64: dts: qcom: sm8550: remove
 address/size-cells from mdss_dsi1
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Tengfei Fan <quic_tengfan@quicinc.com>, 
	andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Dec 2023 at 12:09, Aiqun Yu (Maria) <quic_aiquny@quicinc.com> wrote:
>
>
>
> On 12/19/2023 5:41 PM, Krzysztof Kozlowski wrote:
> > On 19/12/2023 10:36, Aiqun Yu (Maria) wrote:
> >>
> >>
> >> On 12/19/2023 3:17 PM, Krzysztof Kozlowski wrote:
> >>> On 19/12/2023 01:31, Tengfei Fan wrote:
> >>>> The address/size-cells in mdss_dsi1 node have not ranges and child also
> >>>> have not reg, then this leads to dtc W=1 warnings:
> >>>
> >> Comments can be more readable:
> >> "mdss_dsi1" node don't have "ranges" or child "reg" property, while it
> >> have address/size-cells properties. This caused
> >> "avoid_unnecessary_addr_size" warning from dtb check.
> >> Remove address/size-cells properties for "mdss_dsi1" node.
> >>
> >>> I cannot parse it. Address/size cells never have ranges or children.
> >>> They cannot have. These are uint32 properties.
> >> Pls help to comment on the revised commit message. Every time I write a
> >> commit message, also takes a while for me to double confirm whether
> >> others can understand me correctly as well. Feel free to let us know if
> >> it is not readable to you. It will help us as non-English native developers.
> >>>
> >>>>
> >>>>     sm8550.dtsi:2937.27-2992.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
> >>>>       unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> >>>>
> >>>>
> >>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> >>>> ---
> >>>
> >>> I disagreed with the patch before. You resubmit it without really
> >>> addressing my concerns.
> >>>
> >>> I am not sure if this is correct fix and I want to fix all of such
> >>> errors (there are multiple of them) in the same way. Feel free to
> >>> propose common solution based on arguments.
> >> Per my understanding, "qcom,mdss-dsi-ctrl" driver node like "mdss_dsi1"
> >> don't need to have address/size-cells properties.
> >
> > Just because dtc says so? And what about bindings?
> I don't find any reason why "qcom,mdss-dsi-ctrl" driver node need to
> have address/size-cells properties. Document Bindings should also be fixed.
> >
> >> Feel free to let us know whether there is different idea of
> >> "address/size-cells" needed for the "qcom,mdss-dsi-ctrl" driver node.
> >
> > The bindings expressed that idea. If the binding is incorrect, fix the
> > binding and the DTS. If the binding is correct, provide rationale why it
> > somehow does not apply here etc.
> Our plan is to fix the bindings as well.
>
> In case you have missed the question, I just re-place it here:
> While there are about 22 different soc dtsi and it's document binding
> files needed to be fixed. Shall we fix it for all qcom related soc usage
> in one patch, or we'd better to split into different patches according
> to soc specifically?

Don't touch the bindings unless you understand what you are doing.
Your patch will be NAKed. There can be a DSI panel attached to the DSI
host, which means there is a need for #address-cells / #size-cells.

Please stop wasting the time on dtc warning. The bindings (and the
file) are correct.

-- 
With best wishes
Dmitry

