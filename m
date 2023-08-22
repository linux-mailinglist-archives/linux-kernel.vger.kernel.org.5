Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224CC7847E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbjHVQpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbjHVQpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:45:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB6D184;
        Tue, 22 Aug 2023 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1692722694; x=1693327494; i=wahrenst@gmx.net;
 bh=j6gYjZW5ImhXrLVx/PcB/4cVtHICOrfn9HM0d3IgFlA=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=J6cMXgqt5tbxWaJysY7V2oKi6rxlbCyRIUbyed8JuPPVxhYKJY0uStHdRf0mxwG1NJN+a4v
 APG6A4Qgk+j0Ir7HQ35wfUSXkwxFkn+65yjNvcf0XxZmWIxGeJtLHmPECl0isQ3LbS5ghsiKR
 Y0Fy0goCv9abewU3yv9Lnc0mOEgcjyOEf1+VsqQFnXEoaqZjCAzYbOBK4EI0bMehG8GEQOU2k
 h7zfLZD6OgYQEc0JJeD0SOk6hGmVqBQYdnS+cBl5oBxhvAb5Q3UArqCI/dc2SnqD2wpaW7vci
 M9JD+avnjoWeUrkBaLwG3jRBShTSUlWQ9SuYbzu5oPLY3tw9coAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.128] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBm1U-1qQlGz3nlU-00CDbh; Tue, 22
 Aug 2023 18:44:54 +0200
Message-ID: <0f79710c-c64f-1f17-4374-f73999065235@gmx.net>
Date:   Tue, 22 Aug 2023 18:44:52 +0200
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
X-Provags-ID: V03:K1:yyEd6H3sDZDhJTVM9OE4jP2MkdzvbWGBRnEvuGNSVGArHHlODJW
 GF7C6Yi426Txd6Ed0YB7jAbWFnJ8fdiGBbRHpHJYR9nokGC69s15PqHkWmmSaxPHNlLzr7U
 PKsevhoPOVvV8BSts0dkKPXGgCFePKiAid+L0mOrMZI8C+gOxWu8igBdXFDqw9Rdbyud6GE
 60WeZrSzUI9lRyc3sLoMw==
UI-OutboundReport: notjunk:1;M01:P0:qghDuVSWBe8=;CilJ5N76e5TKItywkTT7TBoT/M9
 S1Epe1CdHMnWRgb6PmsQhmGt86DIkCeorZO+pK5srrOz65umhQa6FA7bLrdm39oBBs+nkOHAQ
 iwDxq4dupTGC78H4H+7GzMJUmjUEVPLBfjhWgl/wF0ek6nkRxmg1iRxnp7gmHlUIGZGa86RBH
 My2Y4OXUQZ4dmKAtQOu/17xymTPsY/S8CmWYkOuOoOwhG8TRugPT938HSI5Ry2rvsTaM9agqU
 o3Lrug00s4tG4qmGQADA+k/8nbPIUcLHSo9jb/5e+/nyu47MkIpRjdu3MTd9IGgTfInlFMRLQ
 H7l4GzjOqZcJvStwQB5O465aVkcXFlOBV7J9a2yGCeBh96QhDkOVJIwdUdO+gWlOGk+C5294r
 w/tHftjVafG4pDqjAxH8u3EOzGikI0eymryprj7TXg8Fvm5dq5Xe/cZVwHKk2d24yRqsADCXS
 5i3BD9vdVyn5I/Xd5oEylss0AlZ3Tm+xJ8wo+2NCbFCi3D2MMQkqbwRK/FPXGFERcYGHnKbJc
 mOuOe09GEPSPY+RtFL8OvTJVV6p4bbKjTpGxv8P388Czv/B9fisJIP7a8BFXpyU6AyNi4xEkj
 1CSd9/drlht+7E0gOQCGXUZepaRSOzZgWTuD5Yxa7hnkSj9rIxwcs2MTP9QNBzi8LT36uomMT
 79uFjdy2iRr/In0BJ8qYD0dAVWqtvT/6awxs9h1a8+RXkRMCAdPfH/mssz124bJgdArqCpZ5q
 W2D+BMlBSX2NTbBqRhC9jfSkFx8TBsOOTpVBvER6ASD31iXlr6un+Hy9WVqVdV8svl4C5HhCG
 mKD6EVNd10OuoArXoHIfKjg43FszASVr2tXzFWrO4rXyYswEceQhZ0kUC63rYo6xRsL4HGfEe
 qih9FjCTKNHOVtwqn8BAGAU+YFrgfRVqYINeWo/JiOzpRpzOF8pNYdffL1DhqtWjN5Ah5o+qk
 rLVDjg==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
>   	};
>   };
>
> diff --git a/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4.dtsi b/arch/arm/=
boot/dts/broadcom/bcm2711-rpi-cm4.dtsi
> index 48e63ab7848c..3860a134d31a 100644
> --- a/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4.dtsi
> +++ b/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4.dtsi
> @@ -3,6 +3,7 @@
>   #include "bcm2711.dtsi"
>   #include "bcm2711-rpi.dtsi"
>   #include "bcm283x-rpi-wifi-bt.dtsi"
> +#include <dt-bindings/leds/common.h>
>
>   / {
>   	compatible =3D "raspberrypi,4-compute-module", "brcm,bcm2711";
> @@ -91,6 +92,23 @@ &genet_mdio {
>   	phy1: ethernet-phy@0 {
>   		/* No PHY interrupt */
>   		reg =3D <0x0>;
> +
> +		leds {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			leds@1 {
> +				color =3D <LED_COLOR_ID_GREEN>;
> +				default-state =3D "keep";
> +				reg =3D <1>;
> +			};
> +
> +			leds@2 {
> +				color =3D <LED_COLOR_ID_AMBER>;
> +				default-state =3D "keep";
> +				reg =3D <2>;
> +			};
> +		};

looking at my hardware setup, i see that the Ethernet PHY is located on
the compute module, but the Ethernet jack including the LEDs is located
on the IO board.

Maybe we should add the LEDs to the IO board dts?

Best regards

>   	};
>   };
>
