Return-Path: <linux-kernel+bounces-60942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBAE850B6B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12FD1C21783
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067445EE6B;
	Sun, 11 Feb 2024 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3IBfip7"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822FA5E22B;
	Sun, 11 Feb 2024 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682729; cv=none; b=tB9yvFyJX07WwcPk3ih7UZeYDPxhEVQJyJfNcF/p2K+ds56cgYExlAmab/tIaoDKlB5k07tH1JOrPspYqpe+7fkS57keSqfz0CtIE2cLjJTxh4B3q7VkojowOaqwrT0adNAwsgAn0Lf0woqwCCvuifSPcheg/a0W6MQp/sGQ1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682729; c=relaxed/simple;
	bh=dKCtnqQrdPiAcB5tU3OAGqv2wvew/q0hoFczpMUZQuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyPufK+Sey/jVIOC7D23fKcRFjckf0UCgSD0XY6YRTNXS1pqCIiwN3/fTN8WHIcDirQ95XiaiWGat/CxpBDj5je5604OcNjY2vgxdzPuBdQ/6ezMwLOMkJjZjxRpL8e0cR8KqhZ5GgXSUSlFtzUZ55Z9vdU2MbgPhibSrO7M+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3IBfip7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41090edfeb3so9253925e9.2;
        Sun, 11 Feb 2024 12:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707682726; x=1708287526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+YiYsQBrTTOvviGUFRUVFiil2HbbY6cTsvycoefVBE=;
        b=K3IBfip7ku6ZOSi0tHqmsJUMFh2LF90W/lYGLFF4IKN73TFQEnBahcocldTLZLZjVo
         IqPyAcn1T8ERQzEcFbvWI6VwJ7v5R2BpepUy2mP+K6PJKzT7QI4dQtdJLKCheWF2t57m
         4wDnlwdiVDtG5ssMExdM0RDk6Us9pNBlokCpjz1L7CGNwtDNHAubYxRWHIWFnhV47SUM
         +MjGR4o+N5jdLddlmeDFs95NwyovZn5NzKZfh/pHLLl7W8f6vzpzpYRbLoVijjsyO1P2
         JS1ydS4PrVqKVFcGRSLfOaa8z2Pr6Td21TBd/t3FW8fVagZLmctf0Kg6x7DQlvpwftQ+
         7k8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707682726; x=1708287526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+YiYsQBrTTOvviGUFRUVFiil2HbbY6cTsvycoefVBE=;
        b=JMZDuC3pvqo+WF9XXBCNYm9Ikw9Pxe0aabreAu1Pmzaed+jI/V/srUULmXGf0w8ZNp
         4z1gVIsgLvg0wplbS2/cB/rbfOHo0fwhbj9bpPIbGbxqwyKM3JkpwOfde84Eyw8CzE2D
         E/XpC+Zk5uS2HBOigrTbEabayEfHMGJ3+ES+d6Cn6GIUEVjrsr6g/xh9RLNCWxyDHVxQ
         916kuGbU2QX5lZG8GbFfMS+CNK1f3j+xpgPMXXG33ZTLHHir8SnF0jabsA5MK/5uFJ0U
         /RmAr6+dazc7Y81hmGwKw9+jJxH0oQADNvw7ikTiMcwEBSe+oUQOj6uU1JAsrVTspSYl
         DZNA==
X-Forwarded-Encrypted: i=1; AJvYcCWhQ9R+lk5o984HjT8I7tc3Cel75Lao28UW/ifBda3ub+qtpfsxATMyYAd1eg3TRHxsBxuwcHBkHzb+uBmWbbRwstEXHzzUuNKNYzH+Aaxn49Xnq/c0MunBhCXrTWqHWbjsNnQNtDfiKg==
X-Gm-Message-State: AOJu0YyNW3oNLbOioSaS75Tdl/vD2+oBSKxoNB2qr52XKBmqL5WI+H1+
	l/GqmEl+DRqCPVYLPFeIWpdJe7KU0hb5fmSdMYBuAa4HaSOet9q8
X-Google-Smtp-Source: AGHT+IG/07bMwCShxjkLi2N6MPnqgrqRM4NBXbflM3tKfwK+14p/k/CnwbsQvu10AaXMiynZX0TXZw==
X-Received: by 2002:a05:600c:46c9:b0:40f:ddb6:a63b with SMTP id q9-20020a05600c46c900b0040fddb6a63bmr4345296wmo.24.1707682725574;
        Sun, 11 Feb 2024 12:18:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkm7WeMzZocmE3nk64qrBJmiwW4HTrGgXGwgNE+N6FdmH5kVUsxznMLAMhXaGcAomSUOhkQtxc9ePhJNTHhbjiejXoj8Eg3jyA354G5YjBLKJ67+MKso/KEdyn/BMnvEOei5ZD9BQjJuRCoGbC2ySYRSZa2LfTr/JKKk2TG3TAtSYDn0+Ag6pZyFpoJ/rUeWIhzGJ7RHZOOIhqgkAr/glEWqpheiTntE3bm6/GWXn5mdAX5XABoLASYUViB0lFoAUW4IRrhIJ/lfImnh/qd8M0uYiOr8vbRTKZ0FyuHCFOodpQv94=
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b0040fd2f3dc0esm6609776wms.45.2024.02.11.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 12:18:45 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject:
 Re: [PATCH 1/2] arm64: dts: allwinner: use capital "OR" for multiple licenses
 in SPDX
Date: Sun, 11 Feb 2024 21:18:44 +0100
Message-ID: <1959194.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <20240208105301.129005-1-krzysztof.kozlowski@linaro.org>
References: <20240208105301.129005-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne =C4=8Detrtek, 08. februar 2024 ob 11:53:00 CET je Krzysztof Kozlowski n=
apisal(a):
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!

Best regards,
Jernej

> ---
>  .../boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts    | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi  | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-ma=
nta.dts b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.d=
ts
> index dbce61b355d6..4bfb52609c94 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1-manta.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
>   */
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dt=
si b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> index 1fed2b46cfe8..b2988f500231 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-cb1.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * Copyright (C) 2023 Martin Botka <martin.botka@somainline.org>.
>   */
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts=
 b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> index 832f08b2b260..ff84a3794470 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-bigtreetech-pi.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>  /*
>   * Copyright (C) 2023 Martin Botka <martin@biqu3d.com>.
>   */
>=20





