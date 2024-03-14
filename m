Return-Path: <linux-kernel+bounces-103269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C62D87BD40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13DEFB217DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232A85A7B4;
	Thu, 14 Mar 2024 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXLxoAhX"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FE15A0ED
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421541; cv=none; b=EEvx9Iqi/x8hnChiZ75r4bRkpUkqORhbr7sEl/hhmaqRNyRn9Vr48VkXnO5Hx/F3xO0FQq7wLXJS4hGrhSmv4vmqbgm34A3LeimcUyUbZvG5Y+EFrvvxsAWT+S6tFIXk/SJmLxkjhuIWMYzmEGMrXRi0VbebOnGnRx8MclHlofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421541; c=relaxed/simple;
	bh=QBhs2rdEI9Ta2Qm5lV/m1p6meuBuhC/dnIjl3YYKYI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyNX+cl+Bb1XNh5ztLbbBzoYvMazM8qrD2cqNoA2tQYU3A5PSUK2VAw7X+VbaXz6Npyrg4Jf1Ag2aPjkWnSPSeiU1g7GQ2CpPsXCSIW9dFWtmCSd/ns7O73ymGHmdUDjt6FfXg4bi3S9uuZXf4meW9Jyp5VY2RaYGVOiQMBRfP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gXLxoAhX; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6099703e530so9049227b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710421537; x=1711026337; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=II2UsaIZAzw07RsAVvrS+6gd+EObsid7jBvJIs0WBzw=;
        b=gXLxoAhXqsvS3fzWN/U9aHRYz4lemCrCX+CKcD0Q7RYLy2VBqhmE5LgmumFQ4hBVOO
         K2EaqXgOPD8jhf5n2YtTKoFdYG1/pCG66yNA4vZVq4syEIgAY92WfEoLDWPbv/pOXNTP
         H3vA7uegPZCyl8GbpN6WyPh/0pGhbFjWGf2ZhDrJ/YKYBmIakta2GIlfSk8y8pXg46b6
         ZIUUDSGGiNlpMgN+biy0N9E8KAdb0CBv1gSY0MSvaZJCMn22J0ha/KHzYIwkg8iDakmg
         er5f2Js7oPX0jaTWeas/7lkk7cf0EeN526XMxt74PifdLCB/EEBir507/mFAJ+Drsvvv
         sfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710421537; x=1711026337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=II2UsaIZAzw07RsAVvrS+6gd+EObsid7jBvJIs0WBzw=;
        b=LMIgW7i7SAM9ttgIZXq/wG6Hz1ZxiUf3NrYm3bbZI9gqwdVrMWm1bRpKY9N0kngbuZ
         JB9WB1Sr5v+qMVGEpcmpdVwd2M5idfzNt1zkwZN9O5n288I3dvcW4clxel5Ga7T4sF2G
         ecqehggqhQ2bRg/U6u1qgNtRKZKa05jrM6R5ClfuMEmozHhmgjEESJog2FbTQeqmMntx
         IlLKhcrwl167dUVRpUjqJb4Xfkcb0Xbl+zLHOEnJ61TaaMygqZm05aXD/frSnBUDMh/S
         ZO0lclC0iukeRhmqiBmzQU2InwrnREgCPnOzke9lFX6rsTSCn3IkPNtJkzPDbf2RptsD
         UJFA==
X-Forwarded-Encrypted: i=1; AJvYcCX6ICNcfeoujZ/vO6LEqj6D1HUSnIrBftBeck6L+i4y+s4qbug5FmYsY+ZZKPjrNWPU0f8fOw6XqUDf8z+3f8T/88xIxTQ57P3K2tK9
X-Gm-Message-State: AOJu0YyZ+U65TuaeYnUDo4fKyQBuE7jY8or5JpOYE6Qsb5bM2IKaP/mP
	KWrdP8jNrSFih/558rHBXGt8Qk5ywC/+aNNPyggjEFmFJOzz6XqiuRv3ATztjeUgguI/+Nw0nrR
	Kk3fGOvVbEdHfDdWu/lKCnf8WzOkjf6CFc1L7EA==
X-Google-Smtp-Source: AGHT+IFXC5RLGM5+/OQzl0VN7/sYRocbZIrLl+pCS9V1R3inRBR/pXXbajydYegK5aeCFV33pHqokJMy1KmLSL3ltB4=
X-Received: by 2002:a0d:e4c4:0:b0:60c:ced3:8e26 with SMTP id
 n187-20020a0de4c4000000b0060cced38e26mr901393ywe.13.1710421537330; Thu, 14
 Mar 2024 06:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com>
 <20240313-videocc-sm8150-dt-node-v1-1-ae8ec3c822c2@quicinc.com>
 <CAA8EJpo63oRA07QNCdzJdHW_hJJWK6aj-LCpp-XwmPJYf0twZw@mail.gmail.com> <a09941ff-7b43-a964-1bd1-5321913be1a3@quicinc.com>
In-Reply-To: <a09941ff-7b43-a964-1bd1-5321913be1a3@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 14 Mar 2024 15:05:26 +0200
Message-ID: <CAA8EJpo=ACtqbaPQN--p_28Cf6DLsKMFKh-A0crMZq4hmhPdyA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom: Update SM8150 videocc bindings
To: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 11:19, Satya Priya Kakitapalli (Temp)
<quic_skakitap@quicinc.com> wrote:
>
>
> On 3/14/2024 12:50 AM, Dmitry Baryshkov wrote:
> > On Wed, 13 Mar 2024 at 13:11, Satya Priya Kakitapalli
> > <quic_skakitap@quicinc.com> wrote:
> >> Update the videocc device tree bindings for sm8150 to align with the
> >> latest convention.
> > But why? Bindings already exist. There is nothing wrong with them. And
> > sm8150 platform in general uses name-based lookup.
>
>
> With the new index based lookup introduced we cannot use this bindings,
> hence I moved to the sm8450-videocc bindings.

This is true for _new_ drivers. However you have a driver already. And
the driver has bindings. If you check, existing drivers were updated
from parent_names to fw_name / parent_hw lookups. However none of the
drivers was _updated_ to use index-based lookups.

> >> Fixes: 35d26e9292e2 ("dt-bindings: clock: Add YAML schemas for the QCOM VIDEOCC clock bindings")
> > It is not a fix, there is no bug that this commit is fixing.
>
>
> The clocks list needs to be fixed to add both XO and AHB clocks, and we
> are adding required-opps property.

Oh, so you have mixed two unrelated changes without telling anybody.
Please don't do this.

>
>
> >> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> >> ---
> >>   Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml | 1 +
> >>   Documentation/devicetree/bindings/clock/qcom,videocc.yaml        | 3 ---
> >>   2 files changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> >> index bad8f019a8d3..e00fdc8ceaa4 100644
> >> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> >> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> >> @@ -20,6 +20,7 @@ properties:
> >>       enum:
> >>         - qcom,sm8450-videocc
> >>         - qcom,sm8550-videocc
> >> +      - qcom,sm8150-videocc
> >>
> >>     reg:
> >>       maxItems: 1
> >> diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> >> index 6999e36ace1b..28d134ad9517 100644
> >> --- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> >> +++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
> >> @@ -17,7 +17,6 @@ description: |
> >>       include/dt-bindings/clock/qcom,videocc-sc7180.h
> >>       include/dt-bindings/clock/qcom,videocc-sc7280.h
> >>       include/dt-bindings/clock/qcom,videocc-sdm845.h
> >> -    include/dt-bindings/clock/qcom,videocc-sm8150.h
> >>       include/dt-bindings/clock/qcom,videocc-sm8250.h
> >>
> >>   properties:
> >> @@ -26,7 +25,6 @@ properties:
> >>         - qcom,sc7180-videocc
> >>         - qcom,sc7280-videocc
> >>         - qcom,sdm845-videocc
> >> -      - qcom,sm8150-videocc
> >>         - qcom,sm8250-videocc
> >>
> >>     clocks:
> >> @@ -75,7 +73,6 @@ allOf:
> >>             enum:
> >>               - qcom,sc7180-videocc
> >>               - qcom,sdm845-videocc
> >> -            - qcom,sm8150-videocc
> >>       then:
> >>         properties:
> >>           clocks:
> >>
> >> --
> >> 2.25.1
> >>
> >>
> >



-- 
With best wishes
Dmitry

