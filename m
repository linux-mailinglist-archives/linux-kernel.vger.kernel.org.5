Return-Path: <linux-kernel+bounces-8843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C8781BD13
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67ABE1C25E59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB830627F8;
	Thu, 21 Dec 2023 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="syIxHXQa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A88627E5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33666fb9318so912455f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703179337; x=1703784137; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Js4hNAR6cMsgc+pWjfLy+VC1mhzmUfo3McJWjVqOMn8=;
        b=syIxHXQauPq9XtVy+TbwqfECpuv1z+C6rHVow0Gq/U6OZMWss25zMA+TcN2Vfeogil
         mRvQ5A097od2xpJpuWDVyZYKuXYxOKMK9SKnMwLfllqW/EE1bKShVDn9jGoNLLTgUE1F
         xdiWjVUvxUIZD3PQKdPJoeVpUM3tmaPItSzPCVg1wUSpbhUPM2fVcZI7XT6vbNH1VB/y
         DD2EpLeH5/OOLNl2cyjxJJ7PxziXXvffFHFfj4JUpQE1h197XCw9hIJHwRAkV03yHuRH
         4h18kwgv48G8qW4vNXA/v1MxrJdcng9nGYGVfv8tvKjPQ5VJTG5k7t7WOPHn4gLurWH9
         3aXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703179337; x=1703784137;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Js4hNAR6cMsgc+pWjfLy+VC1mhzmUfo3McJWjVqOMn8=;
        b=BVbxOMe+1lo0Sp4J/c3Ip07oKr+Ya0Z6WjhesOt+oX7+Kv83UEFy4sIHgm3yH3mMhe
         B9cHSjszaqwMRImkwt4SGRMbtrxug+LzCpA0HWfbvfbxRe23DmJYkPR8t1NnbGsdcrzw
         ffa9hOpC2xgXnY+7MIuj+Q8LRz31N6wUBjAL6JzVnnj+sT6+fs9gMiFnRbVGIFGuRUjN
         sFQJ3Xq2jcEA4s982no3Fzu6S7PNEkGMpw7oq3SMqZup7RraOEF812G7+0xrmr4SXeZw
         fgZmh5yE4nBj0Du6fsIY+qqep8boP7ZogsCk/PF++1jOLVUvlggQOSpHohCbtm5AKh7T
         +brQ==
X-Gm-Message-State: AOJu0YyBW/AAnBJ9qZ6M/GrRFZYEfkPJGMxJHWlqLwupEHe4B3xb64Qr
	iMENO4JVA6pfUvSCA7jyCsnFjmG4uRZnLQ==
X-Google-Smtp-Source: AGHT+IHcAJGfPeb0yQ0Y+EJs+D5vtPiabTLnkLz7qcj6pT5g6RrUmtCIamT/YwSJe3jpwXJvTq+1Dg==
X-Received: by 2002:a5d:674a:0:b0:333:3c06:b431 with SMTP id l10-20020a5d674a000000b003333c06b431mr63490wrw.35.1703179336691;
        Thu, 21 Dec 2023 09:22:16 -0800 (PST)
Received: from [10.1.1.118] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id q17-20020adfcd91000000b003362d0eefd3sm2451227wrj.20.2023.12.21.09.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:22:16 -0800 (PST)
Message-ID: <aa2991470dfb8fb2e80892d62538d0c75444e6c9.camel@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: exynos: gs101: comply with the new
 cmu_misc clock names
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: tudor.ambarus@linaro.org
Cc: alim.akhtar@samsung.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org,  kernel-team@android.com,
 krzysztof.kozlowski+dt@linaro.org,  linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org,  mturquette@baylibre.com,
 peter.griffin@linaro.org, robh+dt@kernel.org,  robh@kernel.org,
 semen.protsenko@linaro.org
Date: Thu, 21 Dec 2023 17:22:15 +0000
In-Reply-To: <20231221090046.1486195-2-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.49.2-3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tudor,

> diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/bo=
ot/dts/exynos/google/gs101.dtsi
> index 9747cb3fa03a..d838e3a7af6e 100644
> --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> @@ -289,7 +289,7 @@ cmu_misc: clock-controller@10010000 {
>  			#clock-cells =3D <1>;
>  			clocks =3D <&cmu_top CLK_DOUT_CMU_MISC_BUS>,
>  				 <&cmu_top CLK_DOUT_CMU_MISC_SSS>;
> -			clock-names =3D "dout_cmu_misc_bus", "dout_cmu_misc_sss";
> +			clock-names =3D "bus", "sss";
>  		};
>=20

With this change, parent clock enablement fails, and we get:
    exynos_arm64_register_cmu: could not enable bus clock dout_cmu_misc_bus=
; err =3D -2
during boot.


Cheers,
Andre'



