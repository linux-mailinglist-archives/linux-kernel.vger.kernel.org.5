Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4BE784AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjHVTog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjHVTof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:44:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F421CD7;
        Tue, 22 Aug 2023 12:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1692733458; x=1693338258; i=wahrenst@gmx.net;
 bh=KWypl0sV+vq2D9w0DB00mSAgszVx/o3GfZmGIVi/pSs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=HBvLOvQRdE81aDlIbS0qZoKAytoC8YFRu3HgGAl7hbIhiQPUJS2BSpU1CcUS3KtDFYr4LhF
 sw8fjJrfwjUv9dS6gZHiwaQ/AbR7YiXEdMyrpA4ViWzvpWP2RGUVWvupFnYJQtTuXC03BEq3R
 zpObpe1ONR7514s/ui1FaqMv/c+pSGChqrnby8iFygdcoHUKDoxu87n7t3VdZfZ6FdYMS3oPx
 WRIICsTRjtOOWdouIBtYy1ZKTawRWpw86SmTeMsjvY03LYnJbmK+yn7O95xr74JL/RsfZAsEd
 duLrN+/0sxAJePagDeOByMWlOF1K26qFgcOJVgDxAHZCfT/jiDkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.128] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCfJ-1qCLkh1gO1-00V76e; Tue, 22
 Aug 2023 21:44:18 +0200
Message-ID: <2b0ee6c9-7b10-971e-2aaa-e9c83618f424@gmx.net>
Date:   Tue, 22 Aug 2023 21:44:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm: dts: bcm2711: Describe Ethernet LEDs
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     andrew@lunn.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230821192714.3104006-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20230821192714.3104006-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PUDVymnLuIFPGOzkFwmJlQzD1kHIzBv7VV+8cl0l5SZPdMbvNyU
 EIMoiT0cMG+RsXoerA4Hm2t/erPgrBz5IsPhzc/YcLwnmj96EcqOAk6XNbS3kBmPdKlgKWi
 cPfLMu/4WpZJfbZevlPtLFl8rej8LqQznljKe8K/zkLRHQHFkcA0IgBwv3CTzUYGowVFr9e
 dcFspmp/MwY7iXIoy+9kw==
UI-OutboundReport: notjunk:1;M01:P0:0LkyVTqIQYw=;x+XqYm2YcCIr/LR+GKZH2Of2ve9
 0q24MI9RHrMcxCUgg68G3shjYsoHn2BaFTShszxCU0LDcwCuh/skiM1uBA4qb5XLBPdFvWYbF
 BfZxtBi/CqZcVfWVqchOTnO+S4lh13vweXxln+9xJ9Gac7KgSzXeu8RN9yHsqKNsDDg/JUKag
 BpYTkZtMjPWwRc6LE3Ka+5cOXDwUZ9/afziRrofu6WIhuYqCPlo8f7irrTk7ckuRJOcK8Sc2F
 +9dhpwLffRI5MVgIjZYYN4Yedn8F4KTvgNf03uW7g1KfJtMn0mYGUQG0TDWLp8JcLx/FndbmX
 b+VDhi8w1ZWcJoYQtMQHAnPMoXfePv7I77bzNmWvURh/eJqruoLt5zlUTHwO0E1/bc3NRgPEV
 /LHpkRhTSpAKxQPvPVER5/DhjiuqFd2uS0hiV68s7N1CqVu2O8rWa7cF48M27hCSvlSijxQEf
 pwSeGE0m29N9B2dZSvwIPQess5t7sQXdjhuHO2Ri7f2DfqObLq5PjXSbPRi45w3Zlnxyht3vL
 OnAi9bMVEFs9DVc3AWBrPmgobGtF3z3OqW9JaqDMewpLeOerxc3ZteGruKn9CH2DjLdWPE6jH
 Ae0fBGoGleQBPpZ0OuoZGyhiT0lkswpM0J9eSqCrADfLipw+636/OFifueX8NWXQQ3f7uiy6i
 YXYLXSC7Rykmg+Ee3RdE6K+v4EyrGSF1QIcBXKU6We0iLRfYu8PlMj+0KLzV9zN5NphQ9SXnJ
 uNcZl3bplB7q6Xb2FtLm/57Z1sNv23lLnFOliPHA0uZlAInwcriv6QEdGGyn1FBZyEnjyPf62
 wF8+SWBQYmV9bUiohwgwvYXUPxEfeDB0wAsHH1cBJTZmaNgAJTXqF+NhFX2qfJJheoP8Q7Tmx
 279S0lK9CZmuv8VNCZEDrXueuk0AZHGH7ySX1D7GVYPd/csvylHU02QXJ3QeZT1a7Z0+6QL3Z
 bK9RVusMWY7yVzt4w9xynESprnk=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Am 21.08.23 um 21:27 schrieb Florian Fainelli:
> Describe the Ethernet LEDs for the Raspberry Pi 4 model B board as well
> as the Raspberry Pi 4 CM board.
>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>   arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts | 18 ++++++++++++++++++
>   .../arm/boot/dts/broadcom/bcm2711-rpi-cm4.dtsi | 18 ++++++++++++++++++
>   2 files changed, 36 insertions(+)
>
> diff --git a/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts b/arch/arm/b=
oot/dts/broadcom/bcm2711-rpi-4-b.dts
> index d5f8823230db..41db78cb0836 100644
> --- a/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
> @@ -5,6 +5,7 @@
>   #include "bcm283x-rpi-led-deprecated.dtsi"
>   #include "bcm283x-rpi-usb-peripheral.dtsi"
>   #include "bcm283x-rpi-wifi-bt.dtsi"
> +#include <dt-bindings/leds/common.h>
>
>   / {
>   	compatible =3D "raspberrypi,4-model-b", "brcm,bcm2711";
> @@ -197,6 +198,23 @@ &genet_mdio {
>   	phy1: ethernet-phy@1 {
>   		/* No PHY interrupt */
>   		reg =3D <0x1>;
> +
> +		leds {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			leds@0 {
> +				color =3D <LED_COLOR_ID_GREEN>;
> +				default-state =3D "keep";
> +				reg =3D <0>;
> +			};
> +
> +			leds@1 {
> +				color =3D <LED_COLOR_ID_AMBER>;
> +				default-state =3D "keep";
> +				reg =3D <1>;
> +			};
> +		};

the Raspberry Pi 400 Ethernet Jack doesn't have LEDs, but the
bcm2711-rpi-400.dts does include bcm2711-rpi-4.dtb. So this complete new
node must be deleted there.

Best regards

>   	};
>   };
