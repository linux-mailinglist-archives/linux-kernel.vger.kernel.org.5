Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76177EAD7D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjKNKCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjKNKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:02:10 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428D8191;
        Tue, 14 Nov 2023 02:02:03 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E62F920011;
        Tue, 14 Nov 2023 10:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699956121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1lnq+WegjgapWVtw6ANN/5vC9p0PJaSZ3zKf7qrNvjU=;
        b=dhtfD1f+VCI1J5EjE6P+5EQj/6WvGKBcBWpBLhsKnokMDHowszRitrJYBCniWoswNtR5r3
        D7PmJQeF88qog6nkkqo2a6vxUVJ9LUrlJnc+ji3L5dlGwP4nRRdY61hva5VZNhnY2ja+jh
        51Pjhu1nKEjVY0VBzwTiX+21k1Ep0GsfveVIrbepJ9L9fx/yeOvlD0/FjPU92UAUwt8XF9
        mLlARSGPBEAevbw2Idkao2+7hiovlt9GMsjV3wgjryuGFogGKaMJXYROnjeBKlj488LC9R
        w8wUlneRLGrvx/qliscN5TazNDoTSDnb53yZIpPDWEKjNQuIzWRSmwnbnUz6TQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 6/6] arm64: dts: ti: k3-j7200: use J7200-specific USB
 compatible
In-Reply-To: <20231113-j7200-usb-suspend-v1-6-ad1ee714835c@bootlin.com>
References: <20231113-j7200-usb-suspend-v1-0-ad1ee714835c@bootlin.com>
 <20231113-j7200-usb-suspend-v1-6-ad1ee714835c@bootlin.com>
Date:   Tue, 14 Nov 2023 11:01:59 +0100
Message-ID: <87wmuk64bs.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Th=C3=A9o,

> On our platform, suspend-to-idle or suspend-to-RAM turn the controller
> off thanks to a power-domain. This compatible triggers reset on resume
> behavior to reconfigure the hardware.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/=
dts/ti/k3-j7200-main.dtsi
> index 709081cd1e7f..581905d9199e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -788,7 +788,7 @@ pcie1_ep: pcie-ep@2910000 {
>  	};
>=20=20
>  	usbss0: cdns-usb@4104000 {
> -		compatible =3D "ti,j721e-usb";
> +		compatible =3D "ti,j7200-usb";

What about keeping the old compatible as fallback in the unlikley case
we have a new dtb with an old kernel ?

Gregory

>  		reg =3D <0x00 0x4104000 0x00 0x100>;
>  		dma-coherent;
>  		power-domains =3D <&k3_pds 288 TI_SCI_PD_EXCLUSIVE>;
>
> --=20
> 2.41.0
>
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
