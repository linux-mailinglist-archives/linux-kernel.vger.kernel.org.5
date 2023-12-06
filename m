Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F38807903
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442829AbjLFTzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442828AbjLFTzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:55:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD26D5A;
        Wed,  6 Dec 2023 11:55:21 -0800 (PST)
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E3AF6607355;
        Wed,  6 Dec 2023 19:55:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701892519;
        bh=CkVlcx+Z8D6zKOTzgGQDWy9DnJ9h2npW9kYFRrf3yew=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jU856g8GESQdCTMCRG7VeRN8Kjh3/NWarjQb0RBbEBnWUUvknwaVcS1Fsp7kD3vLB
         +67EcNM7ELH1/XWC5D+Lo8I5CKVsyp9Rr1Vqj9Ztc1ZlSL+mfE6TSz+2irKzN3PrUg
         zfXcY/QRXOWrZZuMuXg6y5lUn4HAd5xwjU2imvW+9zDZp+PuiohRrrtP+WgspdvF28
         ObdXPbrNMgDOm6h5EelzFjyMgtL7pKppMPzKZSBS1Ni1zmsyK9yP6Mf4mL29lE5kgd
         axTnArLo6Lmf+LGhvtallCj2gybEPxfk3FCF2athW6wgM3g2UnD0PH8ikZrsj2dHYW
         mkPOjopqr0yYQ==
Message-ID: <f76f9d460b6d7e37aadc4100dbbd57321e5330c2.camel@collabora.com>
Subject: Re: [PATCH v2 2/2] media: chips-media: wave5: Remove K3 References
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Brandon Brnich <b-brnich@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nishanth Menon <nm@ti.com>, Darren Etheridge <detheridge@ti.com>
Date:   Wed, 06 Dec 2023 14:55:07 -0500
In-Reply-To: <20231206185254.1748473-3-b-brnich@ti.com>
References: <20231206185254.1748473-1-b-brnich@ti.com>
         <20231206185254.1748473-3-b-brnich@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As this is a DT call made by TI, there is not much to review.

Le mercredi 06 d=C3=A9cembre 2023 =C3=A0 12:52 -0600, Brandon Brnich a =C3=
=A9crit=C2=A0:
> Change compatible string to match dt bindings for TI devices. K3 family
> prefix should not be included as it deviates from naming convention.
>=20
> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/CAMuHMdUYOq=3Dq1j=3Dd+Eac28hthOUAaNUk=
uvxmRu-mUN1pLKq69g@mail.gmail.com/
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>

This should just be picked.

Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>


> ---
>  V1 -> V2: Fix style issues in commit message
>=20
>  drivers/media/platform/chips-media/wave5/wave5-vpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drive=
rs/media/platform/chips-media/wave5/wave5-vpu.c
> index bfe4caa79cc9..0d90b5820bef 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> @@ -272,7 +272,7 @@ static const struct wave5_match_data ti_wave521c_data=
 =3D {
>  };
> =20
>  static const struct of_device_id wave5_dt_ids[] =3D {
> -	{ .compatible =3D "ti,k3-j721s2-wave521c", .data =3D &ti_wave521c_data =
},
> +	{ .compatible =3D "ti,j721s2-wave521c", .data =3D &ti_wave521c_data },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, wave5_dt_ids);

