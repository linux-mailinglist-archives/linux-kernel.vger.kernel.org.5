Return-Path: <linux-kernel+bounces-137983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004C689EACF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C92283B75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A2129CF2;
	Wed, 10 Apr 2024 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rOjXRMfT"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4026AFB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730272; cv=none; b=eFELZQv9WgHtqxB2BEr/zxe5DtFJwUWPZBALl1RUxbLyyY1xvdSkQV5x2++PwmwBqhHI0yOvNG22dZsjx8TpEw1JV1r+rRY6JUZ8g6gQyySbzGaVz4zkz5uCy3U2jdyIWd4mMDbgrqj1QN9aWjIYEGpyGvRkK57F6hoS/3Y2VWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730272; c=relaxed/simple;
	bh=pc0e0tUYq/37j2gR6Sy35PRQEWq3EaSwIwd2WS6bZc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwyetXkRevda1ZaBlm1Ipdv+dd4XtWgjfeB+Mx9WlVnSdgrBt2DLVMXm5TxS+84Vqkxw8DhhwUQxrla6nNvLlu2WR0A5q6kBD9z1/bbVUTwkUWzVM5NFi4vpDL5N3yuIBzBG728Fh/g7uCKObWbpDzfjZXJIkozP7+8n8aMxNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rOjXRMfT; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7e6e0693df5so977331241.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 23:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712730270; x=1713335070; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KylCJZxBa8y+V5kkjzaXZYU26+SVqQvuISRPkxq1ES8=;
        b=rOjXRMfTrDH81XavwCN5z2wqUqcZmNJ6PCd6zlUM6wrMCfg+0KVfWsHSmBrrPTg0dE
         eMFUKzpxEOr3CvZZRJMvBVbPA5/jVOimpM2ra973YIwO7R3bEIzW9pqcvpPbN0I4utuC
         AVjOlKDkQMCCk42B2lkA5J9u4qhs+uIhCNW1Ihz61EGcLFVJISiceY6B5k1vgZskXwzK
         YLoYu7ykKg26af+LUyGBCbypwV/3ARI192sA0uVoLic1GubqfYIzw3tpz9rAia/zzdrn
         wR/CB2Ej0RBnnvawqMMJxKn46D7k+itPD5aHpChAyThD74em81cwJyRKy+uf4fF6lcIF
         M1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712730270; x=1713335070;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KylCJZxBa8y+V5kkjzaXZYU26+SVqQvuISRPkxq1ES8=;
        b=acID7ndcR7QGKcK5X3+SwzWYvol/1NN3JyToxuKE1MBHT0WsEL8awv3Tz5DXyFs2Zf
         DZ2ug59oOEKshqk4ishxDN3SolfgQzoExIhiV4u1Mw4zFIVt+d+zycQFAJWK0hw0Yxuo
         4u7h5VLIMlQqetlKvbHcwlFsqGynR7ulozVZOWfNu6qZ/ZEak/7IS0bN2JhvBy8wR5S6
         WfLgr84jq6wVhk/hbFlNl9iELyERG51NmVESuLQzmONCmKV9D1az3gBchem2qz2oeZTj
         p4nn+a1dcQtB7Yqso+KU2nzq1CO3abqKYsZRyBs8oBRjglJqxHsx7fXGVS9MQnXyDcVi
         f37g==
X-Forwarded-Encrypted: i=1; AJvYcCVYGtHKyEe3TnEPnVjRj47mKdD1MfxZIthuwVKQFoWqXji3npropnubV8Tok4lgfMt79pStnsYPqTMr1bThCc7uM7DzR7Sl/l8dOvnE
X-Gm-Message-State: AOJu0YwYN622Aqq67s3dUI+oIlDndBBcuagNTP9YMwq8mSW52uLKRbPH
	zl1jF87hxjGaleNms8utrsD7o1vGyKvODGHocziMVM9SIEmzhPM8+lvVoooNJiOYkg+DY0uSriF
	6WWB3jB3qzpiVqitEUq1mVC4lXjfCiHpYuxET7g==
X-Google-Smtp-Source: AGHT+IGlTd7dOZZaKnAoGYupWxI68TBNvSGJ1J4DUch9kc6qjSab2ayma+a+Z7jlMCtcIWMOCFW6ScvfbuN+kv32QFA=
X-Received: by 2002:a05:6102:32d0:b0:47a:2968:a9d2 with SMTP id
 o16-20020a05610232d000b0047a2968a9d2mr305454vss.10.1712730269944; Tue, 09 Apr
 2024 23:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403043416.3800259-1-sumit.garg@linaro.org>
In-Reply-To: <20240403043416.3800259-1-sumit.garg@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 10 Apr 2024 11:54:18 +0530
Message-ID: <CAFA6WYNxTPgiq6WLQaKGMTenuKe51SXXhgGYkdyRibghXAMfnA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
To: andersson@kernel.org, konrad.dybcio@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	stephan@gerhold.net, caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
	dmitry.baryshkov@linaro.org, laetitia.mariottini@se.com, 
	pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com, 
	benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn, Konrad,

On Wed, 3 Apr 2024 at 10:04, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add Schneider Electric HMIBSC board DTS. The HMIBSC board is an IIoT Edge
> Box Core board based on the Qualcomm APQ8016E SoC. For more information
> refer to the product page [1].
>
> One of the major difference from db410c is serial port where HMIBSC board
> uses UART1 as the debug console with a default RS232 mode (UART1 mode mux
> configured via gpio99 and gpio100).
>
> Support for Schneider Electric HMIBSC. Features:
> - Qualcomm Snapdragon 410C SoC - APQ8016 (4xCortex A53, Adreno 306)
> - 1GiB RAM
> - 8GiB eMMC, SD slot
> - WiFi and Bluetooth
> - 2x Host, 1x Device USB port
> - HDMI
> - Discrete TPM2 chip over SPI
> - USB ethernet adaptors (soldered)
>
> This series is a v2 since v1 of this DTS file has been reviewed on the
> U-Boot mailing list [2].
>
> Changes in v5:
> - Addressed another nitpick from Stephen.
> - Collected Stephen's review tag.
> - Warnings reported by Rob's DT check bot aren't related to HMIBSC
>   board DTS but rather they are due to msm8916.dtsi or extcon-usb-gpio.txt
>   still not converted to YAML format.
>

I haven't seen any further comments on this series, can you help to pick it up?

-Sumit

> Changes in v4:
> - Dropped IRQ_TYPE_EDGE_FALLING for pm8916_resin given the expectations
>   of Linux kernel driver. Instead depend on systemd workaround suggested
>   by Caleb to get expected HMIBSC reset behaviour.
> - Incorporated further DT coding style comments from Stephen.
> - Warnings reported by Rob's DT check bot aren't related to HMIBSC
>   board DTS but rather they are due to msm8916.dtsi or extcon-usb-gpio.txt
>   still not converted to YAML format.
>
> Changes in v3:
> - Picked up tags.
> - Fixed further DT schema warnings.
> - Configure resin/power button interrupt as falling edge.
> - Incorporate DTS coding style comments from Krzysztof and Konrad.
>
> Changes in v2:
> - Fix DT schema warnings.
> - Incorporate suggestions from Stephan.
> - Document UART1 mode GPIOs based mux.
>
> [1] https://www.se.com/us/en/product/HMIBSCEA53D1L0T/iiot-edge-box-core-harmony-ipc-emmc-dc-linux-tpm/
> [2] https://patchwork.ozlabs.org/project/uboot/patch/20240311111027.44577-6-sumit.garg@linaro.org/
>
> Sumit Garg (3):
>   dt-bindings: vendor-prefixes: Add Schneider Electric
>   dt-bindings: arm: qcom: Add Schneider Electric HMIBSC board
>   arm64: dts: qcom: apq8016: Add Schneider HMIBSC board DTS
>
>  .../devicetree/bindings/arm/qcom.yaml         |   1 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/apq8016-schneider-hmibsc.dts     | 491 ++++++++++++++++++
>  4 files changed, 495 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
>
> --
> 2.34.1
>

