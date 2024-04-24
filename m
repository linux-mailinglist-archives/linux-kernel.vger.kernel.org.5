Return-Path: <linux-kernel+bounces-157351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBEE8B1040
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90F8B27B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4119E16C856;
	Wed, 24 Apr 2024 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NxO5Hle7"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889AC16C69A;
	Wed, 24 Apr 2024 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977405; cv=none; b=rkzqaDojULuLmLw2IN/NY8fkU4fWP29raar5Ttw3pGjq4wMciKpGJgd6UGFyhHfZFNyGb0Wb2tp1uQnN46qeRaBGWSAffPgj9FrgFTwjNFIkJ18fQXpXk6ieFONp5if8V0JGqqHN4CTGTIcjsPaI1E2SakS87jqRQFlc4Z8+i8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977405; c=relaxed/simple;
	bh=FYbgZexAN+JVXgR151DKTlIcy0OCgRStQLwb0bRmgqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cEXw55HM1RQAccw41HOftPuhHwMJ8wQBx+eri4V5JLbaZy/DX27irN9+YqYQ9233arNjKwmU0ebqqpO2K4YMinz0lP9+exrFJneecDRvVz47gZ/FnA07IHwjDuLGz0a+3v8cKkmPXy8g3Zj5adMHd6+1t9VAMjWLM0d+wuNd+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NxO5Hle7; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OCUpmG021448;
	Wed, 24 Apr 2024 18:49:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=jKGwl773XJvGqWbO7cS33YH5zC02Gq0vxXa7aIjjZg0=; b=Nx
	O5Hle7Duy2r7yZ2J9zuke2EASIg6tcihFGidX6M/Gu6dDAAkjNoT1a0nfnhqwF0z
	g45EHqfA/2Y/1GiQggnhHw+eU90w5S1OQnCdm9nRfye/OD+zX4NYnTMi4pzKl1Mt
	xHn33R8rwbOT3U+IfY8A4SbBle0UaNrRh9dVgyzNm9yR7mvKqNpzxpzovMA2sJEv
	Kyg6aNnHx04BT8gqMIo0N5XSg0BykyUY9S1TLOATwthWmbVx6n7PbKzl1n7t+sDe
	q6HZRGzdhuQBAk2bC61YILbunQFijsTAaUyGk7RwYZtHU9GiW3KU1aKgbQ0BXNGh
	llwj9Z5xxiPd9nJEHDJA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm51w9e7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 18:49:36 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9BCD44002D;
	Wed, 24 Apr 2024 18:49:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8EF23222C9A;
	Wed, 24 Apr 2024 18:48:14 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 18:48:13 +0200
Message-ID: <89f4a518-cad2-4913-a532-1f38c5b85ded@foss.st.com>
Date: Wed, 24 Apr 2024 18:48:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Add display support for stm32mp135f-dk board
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam
 Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>
References: <20240223-ltdc_mp13-v3-0-7f92a59ca11f@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240223-ltdc_mp13-v3-0-7f92a59ca11f@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_14,2024-04-24_01,2023-05-22_02

Hi Raphael

On 2/23/24 13:36, Raphael Gallais-Pou wrote:
> This serie aims to enable display support for the stm32mp135f-dk board
> 
> Those are only patches of the device-tree since the driver support has
> already been added [1].
> 
> It respectivelly:
> 	- adds support for the display controller on stm32mp135
> 	- adds pinctrl for the display controller
> 	- enables panel, backlight and display controller on
> 	  stm32mp135f-dk
> 
> Finally it fixes the flags on the panel default mode in the
> 'panel-simple' driver, allowing to override the default mode by one
> described in the device tree, and push further the blanking limit on the
> panel.
> 
> [1] commit 1726cee3d053 ("drm/stm: ltdc: support of new hardware version")
> 
> Changes in v3:
>    - [4/4] Allow every properties from panel-common in panel-simple.yaml
>    - [4/4] Rewrite commit description to match changes
> 
> Changes in v2:
>    - Removed already merged patches
> https://lore.kernel.org/lkml/170729755552.1647630.4818786052103823648.b4-ty@linaro.org/
> https://lore.kernel.org/lkml/170729755662.1647630.425379349649657352.b4-ty@linaro.org/
>    - Fixed CHECK_DTBS warnings
>    - Added missing properties in panel-simple.yaml
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
> Raphael Gallais-Pou (4):
>        ARM: dts: stm32: add LTDC support for STM32MP13x SoC family
>        ARM: dts: stm32: add LTDC pinctrl on STM32MP13x SoC family
>        ARM: dts: stm32: enable display support on stm32mp135f-dk board
>        dt-bindings: display: simple: allow panel-common properties
> 
>   .../bindings/display/panel/panel-simple.yaml       | 11 +----
>   arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi        | 57 ++++++++++++++++++++++
>   arch/arm/boot/dts/st/stm32mp135.dtsi               | 11 +++++
>   arch/arm/boot/dts/st/stm32mp135f-dk.dts            | 53 ++++++++++++++++++++
>   4 files changed, 122 insertions(+), 10 deletions(-)
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240124-ltdc_mp13-2f86a782424c
> 
> Best regards,

Series applied on stm32-next.

Thanks!!

Alex

