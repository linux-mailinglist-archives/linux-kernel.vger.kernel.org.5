Return-Path: <linux-kernel+bounces-27262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1F482ECE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D0B1F2407D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C06C1755D;
	Tue, 16 Jan 2024 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0JNJz9t"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7528B13FE3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso97728157b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 02:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705401872; x=1706006672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xfr8ekJ3/kF67ykOkBtf3gUlwOGhZeagdlr6ytlyxGQ=;
        b=D0JNJz9tdBfYflFvVMZbxy7m3PsTtAvotZqMmh+CQekZcUhU5uqYJ2G0mIcX0Yt/Qv
         fKz5AeloQlgv8b9wI9C6HHXPN13rO67iE6BFqBi5gEKpN9yQ9SCvUEKgW0sFjJbtJNb0
         Aqlt3l7mLunknMKe3Bkrwzr7uT4GIrIIwVz6Lb+oY3fRg42Gu5es+1pKk4gDL3qd7yEk
         W30bSb7OFpySSH7emgq/X1gSJZY9eLzWJa3681NdupU5WMvWHSluPxRUbm2PMzxpk+Ge
         SJTachma4TMKMwHOgPccdpwlT19Ihe/0Tf4QrTXanc4ODKSoTArGeeJ4Nl0Ham1EloSw
         5N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705401872; x=1706006672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfr8ekJ3/kF67ykOkBtf3gUlwOGhZeagdlr6ytlyxGQ=;
        b=HkoQhQfKTUYqrPoiK0Ubo3kfK5ahtoskO6xev/MaiWcIKEEt7eATNAghdhlwNHeRYC
         dapae46DnZQxdHtf/O8lufMu30HdcDun0n08ots0TmOl9EOE2ujS63viBxe6FSUtXeRj
         mXZCkiqZGYIZkiRbH71Rn5JDKTpll2etYZVPt/2wyFRdpMtX2FP6nqYi9ELj+Q/v0GV0
         gtdq/3Y2IecOvWB9gaen0eI1TEvklD9OXlIoHbH7+BXqlN5BBOD/yec1qm/mGvG/uttW
         uQOe9APC5Wfz8j6LmoPT7KoxHd3Rby6pwCDZiWj0Y1MWmvajn6gS7a8kPbApiGKaXHgc
         GcZw==
X-Gm-Message-State: AOJu0YxqlNfV4AA4M1/IqrCy7tCOAmDsbjL180Oc+OMcvCxcwfrXGUak
	4wi7il6LJe90TjHuhLd1kKYbXqq1SDKhxiE4gRpptbIHCIuGHw==
X-Google-Smtp-Source: AGHT+IG+pjXF8PAggTuUX8KKrF6NwOBF5GFi3hYjC/JuFDOGwfzK7X5hEG8iavIiEV1pP/58gypnnpC/LjrAO+dgnws=
X-Received: by 2002:a81:de4d:0:b0:5d7:1940:f3e0 with SMTP id
 o13-20020a81de4d000000b005d71940f3e0mr5302858ywl.72.1705401871966; Tue, 16
 Jan 2024 02:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116094935.9988-1-quic_riteshk@quicinc.com>
 <20240116094935.9988-2-quic_riteshk@quicinc.com> <CAA8EJpo3YS4EzfsLtovYKbLSGYX=RwUn9dpmCW=j257LnvPrgw@mail.gmail.com>
 <1d68485fd1574ff88047cef0d2d5e6f1@quicinc.com>
In-Reply-To: <1d68485fd1574ff88047cef0d2d5e6f1@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Jan 2024 12:44:21 +0200
Message-ID: <CAA8EJpqV_jTm1gNy5RsgRWZBC3j0nTPsUPRkv6KivvRbw8TucA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: defconfig: enable Novatek NT36672E DSI Panel driver
To: "Ritesh Kumar (QUIC)" <quic_riteshk@quicinc.com>
Cc: "andersson@kernel.org" <andersson@kernel.org>, 
	"konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "Bjorn Andersson (QUIC)" <quic_bjorande@quicinc.com>, 
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "arnd@arndb.de" <arnd@arndb.de>, 
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, 
	"nfraprado@collabora.com" <nfraprado@collabora.com>, 
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>, 
	"Rajeev Nandan (QUIC)" <quic_rajeevny@quicinc.com>, 
	"Vishnuvardhan Prodduturi (QUIC)" <quic_vproddut@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jan 2024 at 12:25, Ritesh Kumar (QUIC)
<quic_riteshk@quicinc.com> wrote:
>
>
> >-----Original Message-----
> >From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >Sent: Tuesday, January 16, 2024 3:30 PM
> >To: Ritesh Kumar (QUIC) <quic_riteshk@quicinc.com>
> >Cc: andersson@kernel.org; konrad.dybcio@linaro.org; robh+dt@kernel.org;
> >krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> >catalin.marinas@arm.com; will@kernel.org; Bjorn Andersson (QUIC)
> ><quic_bjorande@quicinc.com>; geert+renesas@glider.be; arnd@arndb.de;
> >neil.armstrong@linaro.org; nfraprado@collabora.com;
> >m.szyprowski@samsung.com; linux-arm-msm@vger.kernel.org;
> >devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> >kernel@lists.infradead.org; Abhinav Kumar (QUIC)
> ><quic_abhinavk@quicinc.com>; Rajeev Nandan (QUIC)
> ><quic_rajeevny@quicinc.com>; Vishnuvardhan Prodduturi (QUIC)
> ><quic_vproddut@quicinc.com>
> >Subject: Re: [PATCH 1/2] arm64: defconfig: enable Novatek NT36672E DSI
> >Panel driver

This is ugly. Please fix your email setup.

> >
> >On Tue, 16 Jan 2024 at 11:49, Ritesh Kumar <quic_riteshk@quicinc.com>
> >wrote:
> >>
> >> Build the Novatek NT36672E DSI Panel driver as module.
> >
> >... because it is used on ....
> >
>
> Thanks, will update in next version.
>
> >>
> >> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> >> ---
> >>  arch/arm64/configs/defconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm64/configs/defconfig
> >> b/arch/arm64/configs/defconfig index 361c31b5d064..028d80be95f6
> >100644
> >> --- a/arch/arm64/configs/defconfig
> >> +++ b/arch/arm64/configs/defconfig
> >> @@ -859,6 +859,7 @@ CONFIG_DRM_PANEL_LVDS=m
> >CONFIG_DRM_PANEL_SIMPLE=m
> >> CONFIG_DRM_PANEL_EDP=m  CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
> >> +CONFIG_DRM_PANEL_NOVATEK_NT36672E=m
> >>  CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
> >>  CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
> >>  CONFIG_DRM_PANEL_SITRONIX_ST7703=m
> >> --
> >> 2.17.1
> >>
>
> Thanks,
> Ritesh



-- 
With best wishes
Dmitry

