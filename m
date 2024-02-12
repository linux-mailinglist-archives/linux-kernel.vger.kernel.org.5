Return-Path: <linux-kernel+bounces-62371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C19F851F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442F61F22D94
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE024C601;
	Mon, 12 Feb 2024 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3D8xA3g"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5F4C61C;
	Mon, 12 Feb 2024 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772331; cv=none; b=npNObaPtvNVBb/s9wkv++3hTDmkKmGn7WY5qlJ5BXf9tugqol0Pas+AWgdl/LECAiT7Gwoht73iQHMMndXm8P9NEbjlhmreXUBMAnLrXx/RAAiuQYayOveGJ8XROFSY1BL0scYryVM9AAL46gmJghSC8eqDeL69gpqC2hF4+Z3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772331; c=relaxed/simple;
	bh=h2MtV/MK2Odk0xUTraQ/KlPfHPspWCPAQzwp7rljY2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XcTTRLu28WbXxOVH4ihyRf9ARs3K2J+jWzFHIrPheW6Flv05dVT2FWd0oI3nCkfkn9ts9qPo/ajDzfaSp2NXryTfJnkiY0VfHGy8+q7syrIpemkX3mtgAleAgrDKOeRhKWWaSWftoqDitEUz5eu0b4iHnEUm8oiA5SdPr487jGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3D8xA3g; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3641ab281cbso214505ab.1;
        Mon, 12 Feb 2024 13:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707772329; x=1708377129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crkWvWwMlvDdItEx33Ai/IPFs930CB0fo5NxvXMgpxs=;
        b=N3D8xA3gcrzWvDZb6fO6xKZV/j+AbSO9qEP0h5EesFV5Q10ru56DgCNpKW3hQhl1dN
         0fktc7AxuXBQ6BU4wpqlW0tbBeL/h/bOES7nuo591uQUmBuGt1eST1pRcWU8Cl9HantZ
         VmpQBBdWzeW4Z1pwS+mZYzikXMcgDcILWcM7afRSZicAqcaeFVOOi2k1+7bvTuqATIuI
         9hwWrT5t+W+Iig1Tz7t6Opd90zY9L56WzCnoeVzbjQkK3KzXB9cDGTgnVVnhvErxcVm6
         Pdi/Y6YfL1lFk/j+eV7bSR7cbkQsydAu8VXSGSZZl0jsbhFdFJxYsysVTFFXfR1LZA53
         wbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707772329; x=1708377129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crkWvWwMlvDdItEx33Ai/IPFs930CB0fo5NxvXMgpxs=;
        b=f4PsFPZ4pK36QUFshpOfAUEyNfS9gJyb8c847nfZ9K2478qZNEL3myksajfz/MZcUO
         bIv7+oxE3fa9N6SOMAV8vwoVfm7oGT+EAcmVurswlC4pygZxkBloXQYDKnPrXppTv6vu
         gEP2lX6bfPNw3okZI8y8OYBEMvWb/kys3L+nrAyaBTrXDfbTlI6pggvJQSnT1H9VMuBA
         y2hoS/c31fYefXSLVPdUGZsV1WTvn55rulZsjH/smhP20ybK6QBqky0sPLKlfhKNyOHO
         2HCrZ6AzqTdK1hXG0p1+BAAQLi3SBywrOKyKwKLQmmBvW+K7jx6FCX3HaD7aOMCaPr+8
         w8Xg==
X-Gm-Message-State: AOJu0Yy2Ahj7Z5l6jte3qm1AP2p7EwQMoShOcCxsN1q6rqdX2QW6y17v
	0T+EG/i4Goad/ATRbyDEZRu+X+Yvrpg93AXBsVNeeHMgg98PZaEn
X-Google-Smtp-Source: AGHT+IEsFxP2wf+CqyRsyHIhdyhg6SpWiZQ2tz1EtmrrYtkThu5pFY+Z/6qwEZdwy8WVxZujb8uIIQ==
X-Received: by 2002:a92:c8c8:0:b0:363:a61b:52ba with SMTP id c8-20020a92c8c8000000b00363a61b52bamr9094902ilq.9.1707772329458;
        Mon, 12 Feb 2024 13:12:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZUJyMD3BIlUtvrM3sjdysoX1iZhYCUYCdDIih1hsVuMH0lXwQxABBNHke5UPD7IJTlw8aY9uzWC3lsfcC4qyLJmS7Qx4T4N8lDpuhjo177D0ZJ5Haf/j8KSpxEkU9zhAecvKzPrjZ4DmYP05ghRLShI042R/c3e5ZXD9/iC0irsJi2VHMSfH7iAw/I8yYi3eYqtHxkLx+O42xtDXIHhDVNbv/H5faUNNOoOzepT9ocug9aUtze2sd1jQKkzNqSeYL6znPw5S8QL8mlhajZRexueu9TTn5J1dxk2AXx39riZzU0Utt3xvE8s3kkh0zflLTfwxKft/4Vsl9Ir/WCYwkT+yHON86o7/3uWGHpSRC9IN32hJLBSQ=
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id a5-20020a056e02120500b00363c2249c51sm2050733ilq.87.2024.02.12.13.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 13:12:08 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>, Jisheng Zhang <jszhang@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3 0/2] arm64: dts: allwinner: h618: Add Sipeed Longan SoM 3H and
 Pi 3H board
Date: Mon, 12 Feb 2024 22:12:04 +0100
Message-ID: <2183605.Mh6RI2rZIc@jernej-laptop>
In-Reply-To: <20240211081739.395-1-jszhang@kernel.org>
References: <20240211081739.395-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne nedelja, 11. februar 2024 ob 09:17:37 CET je Jisheng Zhang napisal(a):
> Add Sipeed Longan SoM 3H and Longan Pi 3H board support.
> 
> The Sipeed Longan SoM 3H is a system on module based on the Allwinner
> H618 SoC. The SoM features:
> 
> - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
> - 2/4 GiB LPDDR4 DRAM SoMs
> - AXP313a PMIC
> - eMMC
> 
> The Sipeed Longan PI 3H is a development board based on the above SoM.
> The board features:
> - Longan SoM 3H
> - Raspberry-Pi-1 compatible GPIO header
> - 2 USB 2.0 host port
> - 1 USB 2.0 type C port (power supply + OTG)
> - MicroSD slot
> - 1Gbps Ethernet port (via RTL8211 PHY)
> - HDMI port
> - WiFi/BT chip

Merged, thanks!

Best regards,
Jernej

> 
> Since v2:
>   - collect Reviewed-by tag
>   - add vin-supply property to reg_vcc3v3
>   - fix reg_vcc3v3 voltage value
>   - remove "interrupt-parent" and "interrupts" properties from axp313
>     node
> 
> Since v1:
>   - Use const rather than enum for "sipeed,longan-pi-3h" dt-binding
>   - remove dts-v1, model and compatible from SoM dtsi
>   - add interrupt related properties to axp313 dt node
>   - use "vcc-1v8-pll" and "vcc-3v3-io" as regulator name
>   - add dt node for board's discrete 5V->3.3V regulator and use it for
>     eth\tfcard 3.3v supply
>   - add usb2_vbus-supply property
> 
> 
> Jisheng Zhang (2):
>   dt-bindings: arm: sunxi: Add Sipeed Longan Module 3H and Longan Pi 3H
>   arm64: dts: allwinner: h616: Add Sipeed Longan SoM 3H and Pi 3H board
>     support
> 
>  .../devicetree/bindings/arm/sunxi.yaml        |   6 +
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../sun50i-h618-longan-module-3h.dtsi         |  75 +++++++++
>  .../dts/allwinner/sun50i-h618-longanpi-3h.dts | 144 ++++++++++++++++++
>  4 files changed, 226 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longan-module-3h.dtsi
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-longanpi-3h.dts
> 
> 





