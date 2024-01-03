Return-Path: <linux-kernel+bounces-15030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D30822661
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D16D285651
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A899A1848;
	Wed,  3 Jan 2024 01:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+rNw5Hw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8392EA6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 01:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ebca94cf74so58041527b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 17:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704244117; x=1704848917; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p8fPDfzL2N3tcHcZiXtbT0PFXQblAxBsLoG48+1LxxE=;
        b=U+rNw5HwUnSLY4WP0pZEVFbKEJp+u3ltXqpuYcbMQve0ZB/pDNSXv7Nf6PViR8LPFO
         QxxsDHfsyNiqvpOWIw++Onj6IfHLeJ3e9Fv1707Dp2mfe+0XeAX9aeA9WVreU1xz5QWq
         AlKTptRJVNdAHqh6yJJpvtfQpS7N2sOIzycHXvJxXF17Xbvd6xRtimabUj3F0O7nDW9D
         w9nZ/R/4hbDA3S8DyyDEMk0l9bjji3XMyAytRYN5aOmylQf8kDiG6Kt10LCn8asT++6D
         dC2YxZI6GrYKdnXjGKjZXpO338EFX/Byz2bX2FXtDXZX2GxDfeTXqW4BMy4mP6XNu2Nb
         qxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704244117; x=1704848917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8fPDfzL2N3tcHcZiXtbT0PFXQblAxBsLoG48+1LxxE=;
        b=VfxUglVZp2a4L34xuG8AKMoLBBdYjH3z5EagmF2cIBePRAkI7tCpM681E18Frui9lJ
         StncfVgYkoik8WQwNy39Tp0XIHBeBnXjjStHnrIOzz7tvS18OIGc5MXi81wyYJbepuM5
         fIvoKyofQMhX5Eity7ZOgLt7AbAx80focLi80xntRYCB1hpTYAAXR89FgzTbil2s4NI8
         0AP76pSbOCqd9vrtl5u8pPkegBRqvNGalSA3imQpQHx+iyMf1YsefmMl6RPoJQQ3NHYX
         UvaMK9WlZOgnSrRYvQcyZycrI/KgT1SYS7dDQ1RlTcYE9z2KiCajoay6grGWvMwozUot
         Kihg==
X-Gm-Message-State: AOJu0YyhLkL+CbF0GV0HhBYlUlmYty3eCBlBDaY2e2u4Af1PXEG8ESuN
	8waRXxQquQE6lT/Oh/D4qxOpquHSk+INIhXlkkVVzlntXOW0pQ==
X-Google-Smtp-Source: AGHT+IESRnzFActZ4nCEdcS2Hd80g6/QMeRxBsKvrVu/YOu9jw+UX733JJtP+MA9aE4bapxcuCWGYqU5G6iZtgRfM0U=
X-Received: by 2002:a81:5454:0:b0:5e8:8c2c:32ac with SMTP id
 i81-20020a815454000000b005e88c2c32acmr14014156ywb.41.1704244116831; Tue, 02
 Jan 2024 17:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-topic-gpu_cooling-v1-0-fda30c57e353@linaro.org> <20240102-topic-gpu_cooling-v1-12-fda30c57e353@linaro.org>
In-Reply-To: <20240102-topic-gpu_cooling-v1-12-fda30c57e353@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Jan 2024 03:08:26 +0200
Message-ID: <CAA8EJpr+gV-+8tBCgnN-113uoq-G1wN6iRhApHMtavzs1Ec1tQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] arm64: dts: qcom: sdm630: Hook up GPU cooling device
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jan 2024 at 15:38, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> In order to allow for throttling the GPU, hook up the cooling device
> to the respective thermal zones.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

