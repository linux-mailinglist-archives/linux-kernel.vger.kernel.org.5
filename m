Return-Path: <linux-kernel+bounces-52755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D103C849C52
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CDE5B24E82
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4E324B35;
	Mon,  5 Feb 2024 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h9KzbfW7"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F921373
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141280; cv=none; b=LFewSeQ/Hyvf+dtGMHxx6DwXakTx5xWtdo+Puw5KC8W/6NZ6r4jCqtq+gHfR2HLYOnbCLxGR+YJ/ppSqGPRoBqH+EWxftKS8QzbV3SC5NKLkv7VOitVedmuJz0n088c9LSCqs3TocFUNX3q34jyBfKifOuFVrp32vwhVn+aMHpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141280; c=relaxed/simple;
	bh=JOKHiC6XDnMvCFB+2urHL6ouF/Z2o4GIp6viWvkNhSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4giLNx+ETa2c8C6RAMhsPn5iwzLkb7fjP64/4WgwXBY8PmCnPe6Zgf+4AHVokM3UUbuV2lIuyocvJrluaWWLcIJEJOjxrXvtkStFstSMf2lMLRyvD2K7RC+69mV+bzPKB4sD2T6zNojM6bEL294XNHmsKUZZO+QMwPy/j3bMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h9KzbfW7; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6040d9e52b9so41281487b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707141276; x=1707746076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JtBlYOtJ0skwp1KJO8a8C9zsixZtlwcwqIpjM6PlYiA=;
        b=h9KzbfW7qoLb5hf3wQ3d5oH7YofrK+B97T664pc2di3yzcZBAYmHgMFmdrug82WEXo
         1XZDvkTcHXS+RNuxwNeGhTlvLhWGc/XLOlf3BtDR0q+diJm++igKejzBoKKSK62pnoFK
         Gl/WWh5rBuWoDa056ugOy/L/ENdEUTxsX182lwL6SJe5GShP+Y6cq1FUOfYGPKWNcjtO
         9WVBpnwyKGKj/8fAtpY0Gw4m1cPaY5eKSumfwk4LUoiebMNqSeiRV/QoOy47cc/0RhaO
         9jGdqNQcgCPWuF9uXt1evt2NfVchMjzKnYsCW+rKVnJ+aLzKcEVAcyo8aR0WesndseZA
         hn9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707141276; x=1707746076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtBlYOtJ0skwp1KJO8a8C9zsixZtlwcwqIpjM6PlYiA=;
        b=t7RwF48h7V6NirHN5kkUM5z4+RYq5b+gWQrtAu8AlGBv0MCkbAivP0D1OtIOe3UHap
         eOYncvbzkuTy0Sz2pJCWPwZCxp5vNpIrNNQfLENihx2f6RZWMxaBJPG7N6WvBnA3AU3a
         g8jX07qg4rlQs7cMLk1VxRuCPH+IixgIqFyWgmG1uS30yDOv9jQNWpP5KWrUksrlHbun
         /1OF/Z6ECfmzlVJG/UJVH/xiIOWSCWxGlfjTp529aSy1cORPf/D2ee/EpiaT8vzFR1M4
         YmwOy3KFXUYcYqaFkUoROAG2aU8Q0hlwlAfX9wSDqskSm1Emq/+TLcS75J484OP3QMW1
         mu1w==
X-Gm-Message-State: AOJu0YwSAt0w43PTbPZ9qT7UVpL/icJOz830amMt6Ckfo/b4kssLcGsa
	aVr/8PV6nnU21Bdom1XIshk2Icd4tTItPX2WF0qAcMJxb5MRMbIj8gp7iCj7m5XnbHs3ATU5FuK
	HYaoJ1r0eV1qeMnudLyhAk/mykiafyj1goeQ0Wg==
X-Google-Smtp-Source: AGHT+IGpSzTyt8vbbIqitI5GoUk9JT4XUNcvQrbvqDpIn3MhWnis9GRwj8SDab9bFdb0JISqVskwSvWUEcLPq8Pt5Zo=
X-Received: by 2002:a81:a18a:0:b0:5fb:c044:f087 with SMTP id
 y132-20020a81a18a000000b005fbc044f087mr9614980ywg.35.1707141275864; Mon, 05
 Feb 2024 05:54:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-2-quic_tengfan@quicinc.com> <CAA8EJprpMjK03rKPK6wgfVuDvBikYsKZjMc0Wusa1BxFOBnXhQ@mail.gmail.com>
 <86672501-206a-49ed-8af7-2b6c332c1697@quicinc.com>
In-Reply-To: <86672501-206a-49ed-8af7-2b6c332c1697@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 5 Feb 2024 15:48:36 +0200
Message-ID: <CAA8EJppkDDACV_sLxFW4EqKQLHfo4ivSLwa_jCde8JpeH4YfzA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: arm: qcom: Document QCM8550, QCS8550
 SoC and board
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 12:21, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>
>
>
> On 2/5/2024 12:29 AM, Dmitry Baryshkov wrote:
> > On Fri, 19 Jan 2024 at 11:07, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
> >>
> >> Document QCM8550, QCS8550 SoC and the AIM300 AIoT board bindings.
> >> QCS8550 and QCM8550 processor combines powerful computing, extreme edge
> >> AI processing, Wi-Fi 7, and robust video and graphics for a wide range
> >> of use cases for the Internet of Things (IoT). QCS8550 is a QCS version
> >> for QCM8550. Modem RF only in QCM8550 but not in QCS8550.
> >> AIM300 Series is a highly optimized family of modules designed to
> >> support AIoT applications. The module is mounted onto Qualcomm AIoT
> >> carrier board to support verification, evaluation and development. It
> >> integrates QCS8550 SoC, UFS and PMIC chip etc.
> >> AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.
> >>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> >> ---
> >>   Documentation/devicetree/bindings/arm/qcom.yaml | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> index 1a5fb889a444..9cee874a8eae 100644
> >> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> >> @@ -49,8 +49,10 @@ description: |
> >>           msm8996
> >>           msm8998
> >>           qcs404
> >> +        qcs8550
> >>           qcm2290
> >>           qcm6490
> >> +        qcm8550
> >
> > Drop
>
> we want to introduce qcm8550 here.

What for. It either had to be introduced beforehand, or it should be
introduced when one adds support for an actual qcm8550 device.

> qcm8550.dtsi has been introduced and qcs8550-aim300.dtsi include
> qcm8550.dtsi directly.
>
> qcs8550 is a QCS version for qcm8550. qcs8550 is a sub-series of
> qcm8550. qcm8550 will be a firmware release series from qualcomm.

All three names refer to the different kinds of the same platform. The
base chip name is sm8550, so it is the last one. Other than that,
there is no need to include any SoC compatibles other than the actual
SoC name. See existing qrb devices for an inspiration.

>
> here is the qcm8550/qcs8550 detailed spec:
> https://docs.qualcomm.com/bundle/publicresource/87-61717-1_REV_A_Qualcomm_QCS8550_QCM8550_Processors_Product_Brief.pdf
>
> here is the sm8550 detailed spec:
> https://docs.qualcomm.com/bundle/publicresource/87-71408-1_REV_C_Snapdragon_8_gen_3_Mobile_Platform_Product_Brief.pdf

Can you please summarise the _actual_ difference between qcm8550,
qcs8550 and sm8550? Are they fully soft compatible? Soft compatible
except the modem? Pin compatible?

>
> >
> >>           qdu1000
> >>           qrb2210
> >>           qrb4210
> >> @@ -93,6 +95,7 @@ description: |
> >>     The 'board' element must be one of the following strings:
> >>
> >>           adp
> >> +        aim300-aiot
> >
> > We probably need to drop this list, it doesn't surve its purposes.
>
> I am a little confused, do you expect to just remove this "aim300-aiot"
> or do you want to introduce a new patch and remove the whole list?

If you were following the list, you would have seen the patch
reworking the bindings.

>
> >
> >>           cdp
> >>           dragonboard
> >>           idp
> >> @@ -904,6 +907,14 @@ properties:
> >>             - const: qcom,qcs404-evb
> >>             - const: qcom,qcs404
> >>
> >> +      - items:
> >> +          - enum:
> >> +              - qcom,qcs8550-aim300-aiot
> >> +          - const: qcom,qcs8550-aim300
> >> +          - const: qcom,qcs8550
> >> +          - const: qcom,qcm8550
> >
> > In the review comments for v3 you have been asked to add qcom,sm8550.
> > But not the qcom,qcm8550. I don't think that there is any need to
> > mention qcm8550 here.
>
> qcm8550 and sm8550 are different, they have different firmware release.
>
> AIM300 AIoT board depend on qcs8550, qcs8550 is a QCS version for
> qcm8550. Modem RF only in qcm8550 but not in qcs8550.

There are no 'dependecies' here. The thing is about declaring compatibility.
In my opinion, the qcm8550 is an unnecesary part of the equation. You
declare compatibility with the board itself,  with the SoM, with the
actual SoC and with the base of the series. Anybody caring for the
difference between QCM, QCS and SM will have to check for both
qcom,qcs8550 and qcom,qcm8550 anyway, as there are differences on the
modem side.

> >> +          - const: qcom,sm8550
> >> +
> >>         - items:
> >>             - enum:
> >>                 - qcom,sa8155p-adp
> >> --

-- 
With best wishes
Dmitry

