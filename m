Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ADC77906F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjHKNKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHKNKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:10:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E928718B;
        Fri, 11 Aug 2023 06:10:20 -0700 (PDT)
Received: from [IPv6:2a00:23c8:b70a:ae01:5e3f:2457:553e:9334] (unknown [IPv6:2a00:23c8:b70a:ae01:5e3f:2457:553e:9334])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5DC816607247;
        Fri, 11 Aug 2023 14:10:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691759418;
        bh=jQ83z7Hu5VwXwq3QjIbsthZn2i9A0u1Eghk8CK3Ws6w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TL6kloXNqgyxRngJsBGtiQtHd6A/j61pttgJ2LCdatj9b6MvNvQqwASdOU8PJkJYB
         Beth1iD1MXERDrAPCr6gTMP0z1iNR/NPz5UYv8KbadwI5DRlrtTepPldiQ+pUtmgyI
         fpeHJv6O9TpjiIMchxNEAZvVnIONwpJ5eqdtKwJyyAwztzVzdan0ceG+YsJVLfgxJM
         qMa7ICpfqBIHIt7FI4CsfYd1InIwdEUK/Rt9lQuaW7AOj5AwgynHBg+T5gNxU7Xsvs
         M8HZ52BIurChufw+Gg34wyjb4vDdnu3TRt+TViAhweUzUBInanePBCFW7ysWqtT2jO
         ph1uR4GGMgQZg==
Message-ID: <6317dfe358f0181aaac3fc4a9d6207a5a7d7efe8.camel@collabora.com>
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: fix t-phy unit name
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Eugen Hristev <eugen.hristev@collabora.com>,
        linux-mediatek@lists.infradead.org
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        kernel@collabora.com
Date:   Fri, 11 Aug 2023 14:10:15 +0100
In-Reply-To: <20230811130700.72787-2-eugen.hristev@collabora.com>
References: <20230811130700.72787-1-eugen.hristev@collabora.com>
         <20230811130700.72787-2-eugen.hristev@collabora.com>
Autocrypt: addr=chris.obbard@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.49.2-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

On Fri, 2023-08-11 at 16:07 +0300, Eugen Hristev wrote:
> Fix:
> Warning (unit_address_vs_reg): /t-phy@1a243000: node has a unit name, but=
 no reg or ranges property
> Warning (unit_address_vs_reg): /soc/t-phy@11c00000: node has a unit name,=
 but no reg or ranges property
>=20
> The ranges is empty thus removing the `@1a243000`, `@11c00000` from
> the node name.

Does this patch need a Fixes: tag?
It would be also quite nice to say in your commit messsage where the error =
comes from (make dtbs_check) :-)

>=20
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> ---
> =C2=A0arch/arm64/boot/dts/mediatek/mt7622.dtsi=C2=A0 | 2 +-
> =C2=A0arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 2 +-
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt7622.dtsi
> index 36ef2dbe8add..3ee9266fa8e9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -905,7 +905,7 @@ sata: sata@1a200000 {
> =C2=A0		status =3D "disabled";
> =C2=A0	};
> =C2=A0
> -	sata_phy: t-phy@1a243000 {
> +	sata_phy: t-phy {
> =C2=A0		compatible =3D "mediatek,mt7622-tphy",
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 "mediatek,generic-tphy-v1";
> =C2=A0		#address-cells =3D <2>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/=
dts/mediatek/mt7986a.dtsi
> index 68539ea788df..24eda00e320d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -434,7 +434,7 @@ pcie_intc: interrupt-controller {
> =C2=A0			};
> =C2=A0		};
> =C2=A0
> -		pcie_phy: t-phy@11c00000 {
> +		pcie_phy: t-phy {
> =C2=A0			compatible =3D "mediatek,mt7986-tphy",
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "mediatek,generic-tphy-v2";
> =C2=A0			#address-cells =3D <2>;
> --=20
> 2.34.1

