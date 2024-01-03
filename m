Return-Path: <linux-kernel+bounces-15022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A8822649
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCEF283A5C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE54A26;
	Wed,  3 Jan 2024 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eDE1c2qv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98091469F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 01:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5f0c0ca5ef1so26685197b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 17:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704243981; x=1704848781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W6cI8723ahaH5ElyBXblN/4IB61vCE8DgpJGxzSRdhk=;
        b=eDE1c2qvtHt56Gdvik4WQBPepgDGagPVp43MN6v87Yc2GtY8gu7c6jMlVET+r1ZGD2
         sl/oUO+KBer8XyW8GIW0O5yQYz0FKrCzOjIJvs00piWKTcx06W2t5n3PgdLQlRDUqyKq
         z5srkxaO8UVCdgEtC+ko1LBpk1I1E62IcJJBhBnaYtMzBHpYTqkhaF1RGDlLYiD1OSnt
         xd7m2Fmml241XHFw+yurJ00C/nzEf3XiltyF2Bln5zD778+A96GB3SQb97m/3vPP/xW5
         xty2YboT4qyfhzyI1nWXPFdNGimTKFqINss8j1HX2AgbWGMqMPv/Y1DJFHgldg/Z+eEv
         LlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704243981; x=1704848781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6cI8723ahaH5ElyBXblN/4IB61vCE8DgpJGxzSRdhk=;
        b=xJMdHWJU/T/R9jc4U762ab9l5CeOzUm9p8mbd5Ksjww3dgidJNLiz2bD69T5+9TmZ6
         eYduJJri+ALNAyOzN4VGDThbsm05RF/o/RkanblwbwstRk9oHa/sY9qcw2QRoocRjQ0U
         p2ovGxejxzp1A8wrG+WFOeduLbwiZPg6yAkg1whKdyudMn6usHJtiUmpA6WQi5kYP5pS
         7GxQObEC17NBzGRSmGcHtK2oeWViTqLHYtsoCRAfr5NgBl0yluWXhqGcxLmmLt8kjh04
         eodjwDPYZPeaLMvzJhS7lZksRJCxefpbZ6n6UKZKjv5x2hLsF4J4E7CfX8kC4AVKz7Lj
         TeaA==
X-Gm-Message-State: AOJu0Yzffke2vfHKCWiheqr2dYxcEqWqwGBPIfNQdQfVPAZqD4b7qddo
	Vbc1IsKpRu67r9O0uRTBJzUI5IupI8UlpJf/4pYd+VzSy074Kg==
X-Google-Smtp-Source: AGHT+IFiiVpO2F7K3LjhLzi+FA9HTTct8NS0IrYAdu2NKhkuYAA+Mzn8eTpxq6f2HM4k8EZOec+WbjSB8ARnpVxOPTU=
X-Received: by 2002:a0d:f084:0:b0:5e9:f386:dd63 with SMTP id
 z126-20020a0df084000000b005e9f386dd63mr13166451ywe.39.1704243981584; Tue, 02
 Jan 2024 17:06:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-topic-gpu_cooling-v1-0-fda30c57e353@linaro.org> <20240102-topic-gpu_cooling-v1-5-fda30c57e353@linaro.org>
In-Reply-To: <20240102-topic-gpu_cooling-v1-5-fda30c57e353@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Jan 2024 03:06:10 +0200
Message-ID: <CAA8EJppJeWObQapP1zxwt3gigF5bAUdxm=2YFDw63=TSYDdKEA@mail.gmail.com>
Subject: Re: [PATCH 05/12] arm64: dts: qcom: sm6115: Hook up GPU cooling device
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jan 2024 at 15:36, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> In order to allow for throttling the GPU, hook up the cooling device
> to the respective thermal zones.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

