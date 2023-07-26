Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F61762D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjGZHYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjGZHXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:23:17 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307F23C1D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1690356063;
        bh=xKmoC7w1avaQZLZw1nd7d8Fje+BhvbgbhJZnag/Cd58=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HJYPTpA+UP6KYzhdmVpDWQQYs+jkqxpCC/Enh2FcZuRPv6XOsya/9sEqTWraHSXOF
         VBZ/7DMcww6N3tkH8Wp7pVSNtI/Lsa68FhPcdMSaCd/OsTf/CIDm5R96x2aEndXxC0
         HBMNsFdD9BqGrYWzJ9SyerbopcanNAAphSWKBM6I=
Received: from [192.168.124.11] (unknown [61.150.43.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id B4816659A1;
        Wed, 26 Jul 2023 03:21:01 -0400 (EDT)
Message-ID: <174b4c41d10fa1b31821482ec737733ca4633464.camel@xry111.site>
Subject: Re: [PATCH] ASoC: loongson: mark OF related data as maybe unused
From:   Xi Ruoyao <xry111@xry111.site>
To:     YingKun Meng <mengyingkun@loongson.cn>, broonie@kernel.org,
        lgirdwood@gmail.com
Cc:     krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
        kernel test robot <lkp@intel.com>
Date:   Wed, 26 Jul 2023 15:20:59 +0800
In-Reply-To: <20230726070648.700754-1-mengyingkun@loongson.cn>
References: <20230726070648.700754-1-mengyingkun@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-26 at 15:06 +0800, YingKun Meng wrote:
> The ASoC Sound Card driver can be compile tested with !CONFIG_OF
> making 'loongson_asoc_dt_ids' unused:
>=20
> sound/soc/loongson/loongson_card.c:200:34: warning: unused variable
> 'loongson_asoc_dt_ids' [-Wunused-const-variable]

Hmm, why not guard the definition with #ifdef CONFIG_OF instead?

Source text is first and foremost for the human reader, not for the
compiler, and an ifdef clearly shows the condition when the definition
is not used.

> Here we solve it in the same way as [1].
>=20
> [1] https://lore.kernel.org/all/20201125164452.89239-1-krzk@kernel.org/
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307242008.xqdjgk04-lkp@i=
ntel.com
> Fixes: d24028606e76 ("ASoC: loongson: Add Loongson ASoC Sound Card Suppor=
t")
> Signed-off-by: YingKun Meng <mengyingkun@loongson.cn>
> ---
> =C2=A0sound/soc/loongson/loongson_card.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/loongson/loongson_card.c b/sound/soc/loongson/loon=
gson_card.c
> index 9ded16329747..7dd7adc13484 100644
> --- a/sound/soc/loongson/loongson_card.c
> +++ b/sound/soc/loongson/loongson_card.c
> @@ -197,7 +197,7 @@ static int loongson_asoc_card_probe(struct platform_d=
evice *pdev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> =C2=A0}
> =C2=A0
> -static const struct of_device_id loongson_asoc_dt_ids[] =3D {
> +static const struct of_device_id loongson_asoc_dt_ids[] __maybe_unused =
=3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "loongs=
on,ls-audio-card" },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ /* sentinel */ },
> =C2=A0};

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
