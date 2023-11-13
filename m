Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBAB7E9B44
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjKMLig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKMLif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:38:35 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE3DD6A;
        Mon, 13 Nov 2023 03:38:31 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D50361C0072; Mon, 13 Nov 2023 12:38:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1699875508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EAyXszHtRdE1BBbkJKoK+xUoJRMnmO0Ng8MajCCXXeE=;
        b=oZ6iug6lHz81l8qjRZCg00hy2PwoLO2zZ7Yl1ySH6w9vL4ZHgbyhnhSBQNB0kMf+riZTjP
        ihjQZXossJmcKGUdwBVEow+L7CfBiINvvwKeXSKOJiseR/OR7j8YUgMFc12eIgoNkymRl9
        pdhP5uc7Jy66YN+qdPpbvbmj2dIsYDU=
Date:   Mon, 13 Nov 2023 12:38:28 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>, tjmercier@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jianjiao.zeng@mediatek.com,
        kuohong.wang@mediatek.com,
        Vijayanand Jitta <quic_vjitta@quicinc.com>,
        Joakim Bech <joakim.bech@linaro.org>,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        ckoenig.leichtzumerken@gmail.com
Subject: Re: [PATCH v2 0/8] dma-buf: heaps: Add secure heap
Message-ID: <ZU/V2XX71GbaV6Q8@duo.ucw.cz>
References: <20231111111559.8218-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+UPm1Kfn/l4nJAP4"
Content-Disposition: inline
In-Reply-To: <20231111111559.8218-1-yong.wu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+UPm1Kfn/l4nJAP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patchset adds three secure heaps:
> 1) secure_mtk_cm: secure chunk memory for MediaTek SVP (Secure Video Path=
).
>    The buffer is reserved for the secure world after bootup and it is used
>    for vcodec's ES/working buffer;
> 2) secure_mtk_cma: secure CMA memory for MediaTek SVP. This buffer is
>    dynamically reserved for the secure world and will be got when we start
>    playing secure videos, Once the security video playing is complete, the
>    CMA will be released. This heap is used for the vcodec's frame buffer.=
=20
> 3) secure_cma: Use the kerne CMA ops as the allocation ops.=20
>    currently it is a draft version for Vijay and Jaskaran.

Is there high-level description of what the security goals here are,
somewhere?

BR,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--+UPm1Kfn/l4nJAP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZVIKtAAKCRAw5/Bqldv6
8iG9AJ99RhByi/gP/cqaMDDkFg2adWOtcgCgicBpfQqh45WCONn3cfMdR3OcoPg=
=6oEJ
-----END PGP SIGNATURE-----

--+UPm1Kfn/l4nJAP4--
