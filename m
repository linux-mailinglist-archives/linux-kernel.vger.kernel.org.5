Return-Path: <linux-kernel+bounces-15023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B424E82264D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41711C21BC0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC2F10F1;
	Wed,  3 Jan 2024 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQn6IGhw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92390A4C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 01:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5e7409797a1so84065257b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 17:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704244023; x=1704848823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xl/hmmhK6zc+yGDB0wn93QSTd4cePCvfCqLWBamZSPw=;
        b=PQn6IGhwXSN4zjCejuk3mk5xkz4YQTfFQ9EcyEhkXzvg0QKSsur3/DKdAkMW2+jo31
         oZQnbtn8F4k9bUWC6mihMQYYSooUIAq8ImdRjf+a/0T3J9E/J/bkfyAm7wFFjIl8V+y8
         Cqc/5wUObYwI7EQLYDldHanQi4RLgDmNx83/E1ml8TCGnQLi01gEpcU2qJ6vyfZaNINP
         GqHYDfGO0g/WZ035ltd9kcHqxHhXGTs8OoaJXt9p3yufjzzpFXTNc5lPfadREOGgdegO
         0VmfTCuVQKVUqyft4Hc+YSX81V4T/We2aHpghGdFYrpGtigVGoRhmnJTeXJk3cbhQM0N
         RCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704244023; x=1704848823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xl/hmmhK6zc+yGDB0wn93QSTd4cePCvfCqLWBamZSPw=;
        b=s436fNcW6XjHIbUtE0atQdcUnLCAviLp87c34oKVBS3xGi68l0b0hT8l7sHhdQsSmy
         kkGiYKnj8MCJk5rRd8KpxkfLuA0qefvuWpxLA5lrbgkU9xSgWKnuABntfzf7dDSOWm21
         hxee5idA0DNGlFWqGEEud8Q7Mu1L618O0gFJ2lxiGgdvh7o12n7jrJlbAx7KIYePp4bY
         GFx2xwOtyIkvDebFYBtfaguT39b0QQUVBXygOuaK70UxrxeWQOnPMAQ38QvUXTAEo7/G
         GERulQqF0Rjjz1JhVqJfcgpe9i9AqzZ89JVim6wmb9rs3ToY9DHjY8PAgl3D7WpR0j0r
         J23Q==
X-Gm-Message-State: AOJu0Yz/DnmpKoGCdS55aDN+WgTOQyhd8SP0ivRe6OdrznEJVrhh2vrq
	ddlzwjCKa7v3/Zs4L3e9bKLXOSKaOJXr3xk1HxIw2gvZRhgrig==
X-Google-Smtp-Source: AGHT+IFfxHqbsKBYmeZKaMuyhFdWd2IGAVo8dC2ioxb07yMgSL9PMZPmpybg0UqJykGsPruSNWXJmMAM++RnlZbAP+o=
X-Received: by 2002:a05:690c:3745:b0:5ea:e8d:df85 with SMTP id
 fw5-20020a05690c374500b005ea0e8ddf85mr10806988ywb.35.1704244023567; Tue, 02
 Jan 2024 17:07:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-topic-gpu_cooling-v1-0-fda30c57e353@linaro.org> <20240102-topic-gpu_cooling-v1-6-fda30c57e353@linaro.org>
In-Reply-To: <20240102-topic-gpu_cooling-v1-6-fda30c57e353@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Jan 2024 03:06:52 +0200
Message-ID: <CAA8EJpprtV8v4md_MVgNcHivM+hB9=ZV5kk9htVkrHfpOB8vxA@mail.gmail.com>
Subject: Re: [PATCH 06/12] arm64: dts: qcom: sm6115: Mark GPU @ 125C critical
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jan 2024 at 15:36, Konrad Dybcio <konrad.dybcio@linaro.org> wrote=
:
>
> If the GPU ever reaches this temperature, the "critical" signal shuold
> definitely be propagated. Fix the wrong type.

I hope it will be shut down before reaching 125=C2=B0C

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/q=
com/sm6115.dtsi
> index a8c819d53104..be51cbaeeb7e 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -3313,7 +3313,7 @@ gpu_alert0: trip-point0 {
>                                 trip-point1 {
>                                         temperature =3D <125000>;
>                                         hysteresis =3D <1000>;
> -                                       type =3D "passive";
> +                                       type =3D "critical";
>                                 };
>                         };
>                 };
>
> --
> 2.43.0
>
>


--=20
With best wishes
Dmitry

