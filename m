Return-Path: <linux-kernel+bounces-15020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA7A822643
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C951E1C21BEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B7C111B;
	Wed,  3 Jan 2024 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KYlZoSrY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2A4A17
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ebca94cf74so58023207b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 17:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704243939; x=1704848739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=98A/8V20IKILvDpScKjsN750Bhxoj2OxNg7x93EEq7c=;
        b=KYlZoSrYu3OUzRnxawU4bSey6BsDLszXL9HUn7ZJwdmQZ9eRjGvTQsS1SBp5T+rvq+
         ugpPk0JAUcbEH1Jc2btauWsGJ1YXSU4rw3qHI9NOuchrh+n9hyrsYAPe7s7COxcfKusd
         cLYJVEOz+lZ9eUjW9VLkspzcu1lmY1jfTpuoBiv1HCeVvb/u/tWsDqqv/xhp++7hzl1G
         2t1I5D8NVf1K/mfOWgUWBK2LtX6O0KyhwZo4yCY+mAtDk6EM8JlgCGcCzq+0kH+q7tk3
         bnFGYT8jco6JMvLHGLE354gsOkYPL6uLwj/kdVQaD5iFeJ+mCqHdOJBZCkug8bJ/dpPw
         KsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704243939; x=1704848739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98A/8V20IKILvDpScKjsN750Bhxoj2OxNg7x93EEq7c=;
        b=WdUytC6Qg2JMpt0YCSsPKzuOCedJ9hmv5QKDT5RETNrsWts+kaUGqAeL5obtaVL0kq
         pSEuXX1bOVEmshXFw9wTW4Cpo2T4YC+Xq3IgKH+lUwtRTXVHSnEweSB9Cnn1iO0IvOTQ
         9mXpHMOhhmVz2E+n6twaozO23dnGXnyIOXaDoVBMwxhDBBz7NmbMsQ5GqMvn1M9u1xym
         NqkrT5oe3iptr8aG5Z+jk5hxdFxGs87pnwm2meE4/oY09Z+WEWcIQuHDo8k4lH2rfqxV
         QUhuKpX+IZfz2x3+ICONE592XaV3EmdAiaauv4UCtLH8K1gI3dfCU7aj5dMAdpEr1RKT
         AmBg==
X-Gm-Message-State: AOJu0Ywzo6XowxD2r9H9qD1Brwq1iu2/OXeK8yPS3lbVgVVsks1BU/bQ
	piMu1+MY7yVL6FpQ/jnv+2nayFfwx8KFGq1UOmsDW67vNAZzjg==
X-Google-Smtp-Source: AGHT+IFcKL9veH0L/w0ddt0luEQ/sh0DLIROaWihyParawpIzWGa6wctaGZ2/KRdqcFnYwnA6JHABBgj49z3GfEWanc=
X-Received: by 2002:a0d:c8c7:0:b0:5e3:320b:7c with SMTP id k190-20020a0dc8c7000000b005e3320b007cmr12412275ywd.37.1704243939239;
 Tue, 02 Jan 2024 17:05:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-topic-gpu_cooling-v1-0-fda30c57e353@linaro.org> <20240102-topic-gpu_cooling-v1-3-fda30c57e353@linaro.org>
In-Reply-To: <20240102-topic-gpu_cooling-v1-3-fda30c57e353@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Jan 2024 03:05:28 +0200
Message-ID: <CAA8EJpqjaaC8UeAxBnxsqa7Q7RysUbAVnix+5tc4Ed-OXjvR_g@mail.gmail.com>
Subject: Re: [PATCH 03/12] arm64: dts: qcom: sc8180x: Hook up GPU cooling device
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jan 2024 at 15:35, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> In order to allow for throttling the GPU, hook up the cooling device
> to the respective thermal zones.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

