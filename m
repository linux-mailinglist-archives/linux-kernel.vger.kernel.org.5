Return-Path: <linux-kernel+bounces-76241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0333485F4AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEA81F21F39
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8193A1C6;
	Thu, 22 Feb 2024 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B5zhm8MY"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4847E3B2B6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594852; cv=none; b=P/h4Oybntx7YRu9pdnhBlpb1ID9haowQdjr+KPsSsYDVScDLHyOOeXiRXj7mKgb7hSfW/x9gT8COwPwG1KuI4n0F/nJBPoAnDAAKNWIFauzWpDBodlV4C4g9AhT2TWsXLiH+lNA6RehXDxLDvxRxaVHoAigDpXUdyTAZIwjVCJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594852; c=relaxed/simple;
	bh=U5A3cMOJuT9FC8OcV7iHHe6jSA8P8czbVBAGeCesJBQ=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ufCWYcSLWtlCvMjks8MUUAfd30mXgQKzyHwAOBgvrOGnPyW+Y/08Du9pb/kiDXfd3TllWIlBt/3oy4cyekCyoFBsMKPK1e1+2mTeRh23doBpXmp9FplTDNT9tUcbDt1Nkuv5NmZkV3wUPdSVp5WIQsE1I1Cy+fzcqkRyv2+nJZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B5zhm8MY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d2b354c72so3672824f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708594846; x=1709199646; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=eDfk374ak2aj4U9CiiV0QysDtfpirDyDxvL4BxqbaqM=;
        b=B5zhm8MYoBAp/zYDtkOcy24LUVGREDYQrybwvlvBfOPOZZzQGP2pR2gDzfAHmdTzcI
         nMyB/v6bx8Cq/7ET4TPotLa/QaEVwBB5YMgwv+szO65jVe89qtK19LHYmFA29THKsKFy
         x8xCgLKemNErPKUtfP8EKASz1J6FU9lPrtanW2rfkQZpzohginanjwv1r7/3kx902a7L
         yQJl/5mIIVAOsksfet48EpRopJBda/OkmORJExeuNRRAQn71GUolQkDs03EZ2oVGqnTN
         +93gfQJ86e41+Aqb3wKLsIiZzK7zSfXYRR/g5eV/ExcO1ZJJH7P5gGHyPhtCjTcqMcKJ
         2TlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594846; x=1709199646;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDfk374ak2aj4U9CiiV0QysDtfpirDyDxvL4BxqbaqM=;
        b=FpUXd4Lnp0HcK0bxxTpE5r0sdzylqsmHuKaNRlYz1n74TQ2F6FCrxw+xMw4Au3wrZS
         LFh0yFxDq4iYA/iVAaP7dSgsdW8R3owvaWARhMhlTT13J+aCHZfrBgJC1jUsOl3TwBHj
         AA8FUbl6He5rgEQ4d3nUGzHq5+L6eT4PthpZ2hJPnDPQjR7zIeMRyAK82Jf0vhJ+wooM
         gCEeYwqx/jDWT8FvH29bcZmFBbLEt81ne9JbWI7w29gunB1SNsIq2BZkQLNjSFVKRmMm
         nigUvMggihP5B+hC8b3OdO2S6m99kxjJaWtw/khh/gR2CLNRugbMV1YfUXDkmNIy047V
         PW4w==
X-Forwarded-Encrypted: i=1; AJvYcCX2gXb0GsObNxG663jWCHBuJ+0m4FvUljEx9Ip+caC7L2qtrCb7GE6l4zq0u0M2Y2eKwU08XblopE8/C0XaB9XD9mFh5vwI1fH1N1gx
X-Gm-Message-State: AOJu0Yy0OsA2SRsEMb3sERhTdzlVhT9M2su6My/81OOmrzVX88PaKea6
	xzrZmbmW/BCIwfZRUuRJo4Q8jU+Ze7rSJtlItpSLz2codXP3MFHt+QHl5GGSHOg=
X-Google-Smtp-Source: AGHT+IG5rkzGOGgFCat5JaFS4ufYwwZ9KH5dC97ai2bBbn/Ybhk9OGrUNxlKouDoMUdjhRCttgQ9Lg==
X-Received: by 2002:adf:fec7:0:b0:33d:6cc0:b884 with SMTP id q7-20020adffec7000000b0033d6cc0b884mr5221035wrs.10.1708594846378;
        Thu, 22 Feb 2024 01:40:46 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:e0f9:f458:9920:7af9])
        by smtp.gmail.com with ESMTPSA id bk30-20020a0560001d9e00b0033cddadde6esm20291902wrb.80.2024.02.22.01.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:40:45 -0800 (PST)
References: <20240222082523.1812-1-greena88@gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Jerome Brunet <jbrunet@baylibre.com>
To: Adam Green <greena88@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-g12b-odroid-n2*: Add support for
 overclocking Hardkernel ODROID-N2 boards.
Date: Thu, 22 Feb 2024 10:37:28 +0100
In-reply-to: <20240222082523.1812-1-greena88@gmail.com>
Message-ID: <1j8r3cet0i.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Thu 22 Feb 2024 at 08:25, Adam Green <greena88@gmail.com> wrote:

> Hardkernel actively supports overclocking these boards in their own
> documentation. (https://wiki.odroid.com/odroid-n2/hardware/overclocking)
>
> This aligns the SoC opps with those in the board vendors bsp source.

Patch title is too long - checkpatch.pl should have given a you warning
for this.

Not sure it is wise support overclocking directly in mainline, not by
default at least. Maybe as an overlay ? even this I'm not too sure.

>
> Signed-off-by: Adam Green <greena88@gmail.com>
> ---
>  .../dts/amlogic/meson-g12b-odroid-n2-plus.dts | 25 +++++++++++++++++++
>  .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 17 +++++++++++++
>  .../dts/amlogic/meson-g12b-odroid-n2l.dts     | 25 +++++++++++++++++++
>  3 files changed, 67 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
> index ce1198ad34e4..1731d542a00c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
> @@ -15,6 +15,31 @@ / {
>  	model = "Hardkernel ODROID-N2Plus";
>  };
>  
> +&cpu_opp_table_0 {
> +	opp-1908000000 {
> +		opp-hz = /bits/ 64 <1908000000>;
> +		opp-microvolt = <1030000>;
> +	};
> +	opp-2016000000 {
> +		opp-hz = /bits/ 64 <2016000000>;
> +		opp-microvolt = <1040000>;
> +		turbo-mode;
> +	};
> +};
> +
> +&cpub_opp_table_1 {
> +	opp-2304000000 {
> +		opp-hz = /bits/ 64 <2304000000>;
> +		opp-microvolt = <1030000>;
> +		turbo-mode;
> +	};
> +	opp-2400000000 {
> +		opp-hz = /bits/ 64 <2400000000>;
> +		opp-microvolt = <1040000>;
> +		turbo-mode;
> +	};
> +};
> +
>  &vddcpu_a {
>  	regulator-min-microvolt = <680000>;
>  	regulator-max-microvolt = <1040000>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> index a198a91259ec..0c71e8bc0124 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> @@ -13,3 +13,20 @@ / {
>  	compatible = "hardkernel,odroid-n2", "amlogic,s922x", "amlogic,g12b";
>  	model = "Hardkernel ODROID-N2";
>  };
> +
> +&cpu_opp_table_0 {
> +	opp-1992000000 {
> +		turbo-mode;
> +	};
> +};
> +
> +&cpub_opp_table_1 {
> +	opp-1908000000 {
> +		turbo-mode;
> +	};
> +	opp-2004000000 {
> +		opp-hz = /bits/ 64 <2004000000>;
> +		opp-microvolt = <1022000>;
> +		turbo-mode;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
> index e26f3e3258e1..b16a69d0cad6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
> @@ -97,6 +97,31 @@ codec {
>  	};
>  };
>  
> +&cpu_opp_table_0 {
> +	opp-1908000000 {
> +		opp-hz = /bits/ 64 <1908000000>;
> +		opp-microvolt = <1030000>;
> +	};
> +	opp-2016000000 {
> +		opp-hz = /bits/ 64 <2016000000>;
> +		opp-microvolt = <1040000>;
> +		turbo-mode;
> +	};
> +};
> +
> +&cpub_opp_table_1 {
> +	opp-2304000000 {
> +		opp-hz = /bits/ 64 <2304000000>;
> +		opp-microvolt = <1030000>;
> +		turbo-mode;
> +	};
> +	opp-2400000000 {
> +		opp-hz = /bits/ 64 <2400000000>;
> +		opp-microvolt = <1040000>;
> +		turbo-mode;
> +	};
> +};
> +
>  &eth_phy {
>  	status = "disabled";
>  };


-- 
Jerome

