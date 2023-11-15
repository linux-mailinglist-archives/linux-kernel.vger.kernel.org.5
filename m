Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2B67EC762
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjKOPeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOPeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:34:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B171A3;
        Wed, 15 Nov 2023 07:34:18 -0800 (PST)
Received: from [100.92.221.145] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4BB826603149;
        Wed, 15 Nov 2023 15:34:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700062457;
        bh=66db6GfHHnR8m3eMrA6GUpWG/wGdHrrqIWkULFznoU4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gdUd4UjgojBkEzoZ71USXnRnsvgTC9OhzQukBZuC40JAj1Ba4c5BAMIG+8S5H0s2J
         UhGQN47wwzZyMwPK/4rPGQQucphfAUY61G3Kjdy0WpPjQqeWK2K82zbwAgvAZc5zJb
         7wPg+PCnVhrV0Tqyst01KQ6hWPcdYsgtUp7mtHVk9YWF326+HM9eLYOq8bAnjyw8VA
         nGAlTgetgZ/Joy9aWxjD9y6TJWh8W3NJaEHAm0oSHlYsH1oa4UuU9KJMUDzwqFjuUZ
         KXAcu3842enDQUQCYuiJwQENGrPczh16HkO6HHv6ZmMsR7yACP/H5D8IKBTLF8aIVd
         yYBO0RkYPR1ng==
Message-ID: <8b09aaf1-fb36-49e0-b36f-7daecbffdba4@collabora.com>
Date:   Wed, 15 Nov 2023 15:34:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] arm64: dts: ti: Enable CSI cameras for AM62 family
Content-Language: en-US
To:     Jai Luthra <j-luthra@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Julien Massot <julien.massot@collabora.com>
References: <20231115-csi_dts-v1-0-99fc535b2bde@ti.com>
From:   Martyn Welch <martyn.welch@collabora.com>
In-Reply-To: <20231115-csi_dts-v1-0-99fc535b2bde@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2023 09:51, Jai Luthra wrote:
> This series enables CSI camera support on BeaglePlay, SK-AM62 and
> SK-AM62A, now that the dt-bindings and driver support for CSI-RX related
> IPs is merged in v6.7-rc1.
>
> Along with the device tree nodes for CSI-RX, add new DT overlays for
> different camera modules like RPiv2 (IMX219) or PCam5C (OV5640).
>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>


Tested applied to master on AM625-SK with OV5640:

Tested-by: Martyn Welch <martyn.welch@collabora.com>


> ---
> Jai Luthra (8):
>        arm64: defconfig: Enable AM62 CSI2RX
>        arm64: dts: ti: Enable CSI-RX on AM62
>        arm64: dts: ti: Enable CSI-RX on AM62A
>        arm64: dts: ti: k3-am625-beagleplay: Add overlays for OV5640
>        arm64: dts: ti: k3-am62x-sk: Enable camera peripherals
>        arm64: dts: ti: k3-am62x: Add overlays for OV5640
>        arm64: dts: ti: k3-am62a7-sk: Enable camera peripherals
>        arm64: dts: ti: k3-am62x: Add overlay for IMX219
>
>   arch/arm64/boot/dts/ti/Makefile                    | 17 ++++
>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi           | 62 ++++++++++++++
>   .../dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso    | 77 +++++++++++++++++
>   .../ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso   | 77 +++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi          | 99 ++++++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            | 35 ++++++++
>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi     | 15 ++++
>   .../arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso | 76 +++++++++++++++++
>   .../arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso | 74 ++++++++++++++++
>   .../boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso  | 74 ++++++++++++++++
>   arch/arm64/configs/defconfig                       |  3 +
>   11 files changed, 609 insertions(+)
> ---
> base-commit: a93441cc391f1923d031dcd463e3444c7c21bffe
> change-id: 20231114-csi_dts-5f433aca3665
>
> Best regards,
