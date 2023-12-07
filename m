Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC24808AEA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443361AbjLGOnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443335AbjLGOnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:43:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701A6C6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:43:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18C1C433C8;
        Thu,  7 Dec 2023 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701960222;
        bh=T2pHHPrWdgufzNO/CKTT1kJEuRLZWujqjBSnGMiCqLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i5ABAqzBGRStFVAPvsTx7m7C1mUruXHLHhJpOjskz8pKaCcBoM6jWwKotQyjhEYiT
         BPRbNUJr+hNG17Ga/Bv1ZfZ98xVyonIB6s74lZKbFLnW54xKC6X54r5JVb6YT5p23r
         NPFUgJajT248hblpnwoC3tWCtY/rpz2m6t+osEWGjpIw3lxjEBOnYU2MB1GQ5lUY1c
         DxP0nUHM0bb7scYXkcY7eFsLBNhizcU4gMXR4ZVghI0qas6DoU6zqrsfVy093RaHXd
         s8gryfL70faLnBRbE9zBQrdapKc6ndIRbiFxTLyg9ZOgfMDtoBLV5/UNy50800565u
         JdmC7VXAjwK3g==
Date:   Thu, 7 Dec 2023 15:43:36 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Sjoerd Simons <sjoerd@collabora.com>
Cc:     kernel@collabora.com, stable@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Conor Dooley <conor+dt@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: armada-3720-turris-mox: set irq type
 for RTC
Message-ID: <20231207154336.5bf6272e@dellmb>
In-Reply-To: <20231128213536.3764212-4-sjoerd@collabora.com>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
        <20231128213536.3764212-4-sjoerd@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 22:35:06 +0100
Sjoerd Simons <sjoerd@collabora.com> wrote:

> The rtc on the mox shares its interrupt line with the moxtet bus. Set
> the interrupt type to be consistent between both devices. This ensures
> correct setup of the interrupt line regardless of probing order.
>=20
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> Cc: stable@vger.kernel.org # v6.2+
> Fixes: 21aad8ba615e ("arm64: dts: armada-3720-turris-mox: Add missing int=
errupt for RTC")
>=20
> ---
>=20
> (no changes since v1)
>=20
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arc=
h/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index 9eab2bb22134..805ef2d79b40 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -130,7 +130,7 @@ rtc@6f {
>  		compatible =3D "microchip,mcp7940x";
>  		reg =3D <0x6f>;
>  		interrupt-parent =3D <&gpiosb>;
> -		interrupts =3D <5 0>; /* GPIO2_5 */
> +		interrupts =3D <5 IRQ_TYPE_EDGE_FALLING>; /* GPIO2_5 */
>  	};
>  };
> =20

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
