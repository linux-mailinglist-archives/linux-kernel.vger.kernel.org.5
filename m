Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39023760010
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGXTxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXTxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:53:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA66A6;
        Mon, 24 Jul 2023 12:53:19 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:580::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C71586603203;
        Mon, 24 Jul 2023 20:53:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690228398;
        bh=PRkjd2dRnd+EsIcZtdobbsElZ0PbITrpELmxKRMqlKo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Mnt+n2sYU/YWGGZvargH1OGEje/HLjLt18r6XVEqBd4dZvWfIHmsbk18XE89NHhra
         yPBslOaf3pCymMVRLJa2JEUjkitZXlmJJCzG4PhTmAFKxGuaSLVm4AF75mBl8nHBmf
         Kl1ivsXDMwty7uprkXDqmrZG5uQE6f1LNsNjtG7/y9DR3OpcIAZQ2JTyVnj8nuqXGe
         J/jexIdXHa1jiTSaNZYA1PKPO7EoDDt/ovo4H7wBEbGLi+wE5I+YX7I7613aOazlBk
         pSswx//y+Ain44ezlEalmHDi0Tq6jN2ew9Z/TR61IY0sy6iKtIpT/kd8wW1qmfGpXs
         sSHrJahrhYIAA==
Message-ID: <0c8877c39ced8e664c2901ad20fd36fbb90d9d4f.camel@collabora.com>
Subject: Re: [PATCH v2,0/3] media: mediatek: vcodec: Add driver to support
 10bit
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        =?ISO-8859-1?Q?N=EDcolas?= "F . R . A . Prado" 
        <nfraprado@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        Mingjia Zhang <mingjia.zhang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Mon, 24 Jul 2023 15:53:07 -0400
In-Reply-To: <20230722074448.30671-1-yunfei.dong@mediatek.com>
References: <20230722074448.30671-1-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei.

Le samedi 22 juillet 2023 =C3=A0 15:44 +0800, Yunfei Dong a =C3=A9crit=C2=
=A0:
> From: Yunfei Dong <yunfei.dong@mediatek.corp-partner.google.com>
>=20
> Define two capture formats V4L2_PIX_FMT_MT2110R and
> V4L2_PIX_FMT_MT2110T to support 10bit in mt8195, mt8199 and more.
> Getting the size of each plane again when user space set 10bit
> syntax to driver.
>=20
> V4L2_PIX_FMT_MT2110R is used for H264, and V4L2_PIX_FMT_MT2110T
> is used for AV1/VP9/HEVC.
>=20
> patch 1 Add driver to support 10bit
> patch 2 Add capture format V4L2_PIX_FMT_MT2110T to support 10bit tile mod=
e
> patch 3 Add capture format V4L2_PIX_FMT_MT2110R to support 10bit raster m=
ode
> ---
> - compared with v1:
> - Fix set non sps return -EINVAL issue.
> - Driver test pass in mt8195/mt8188 with tast and Youtube.
> - Run v4l2 compliance in mt8195/mt8188 pass.
> - fluster test as below:
> - h264: (JVT-FR-EXT: 29/69  JVT-AVC_V1: 95/135)
> - h265: (JCT-VC-HEVC_V1: 142/147)
> - vp9 : (VP9-TEST-VECTORS: 1/6  VP9-TEST-VECTORS: 276/305)
> - av1 : (CHROMIUM-10bit-AV1-TEST-VECTORS: 22/23   CHROMIUM-8bit-AV1-TEST-=
VECTORS: 11/13
> -        AV1-TEST-VECTORS: Ran 237/239)

Thanks for the fluster reports, I cannot confirm this yet, since it does no=
t
apply. Note that you have forgot to provide V4L2 compliance report as reque=
sted.

>=20
> - send the first version v1:
> - Run 10bit VP9/AV1 fluster test pass.
> - Will return error when the 10bit parameter no correctly in function mtk=
_vdec_s_ctrl.
> ---
>=20
> Reference series:
> [1]: this series depends on v6 which is send by Yunfei Dong.
>      message-id: 20230704131349.8354-1-yunfei.dong@mediatek.com
>=20
> Mingjia Zhang (3):
>   media: mediatek: vcodec: Add capture format to support 10bit tile mode
>   media: mediatek: vcodec: Add capture format to support 10bit raster
>     mode
>   media: mediatek: vcodec: Add driver to support 10bit
>=20
>  .../media/v4l/pixfmt-reserved.rst             |  13 ++
>  .../mediatek/vcodec/decoder/mtk_vcodec_dec.c  |  22 ++-
>  .../vcodec/decoder/mtk_vcodec_dec_drv.h       |   5 +
>  .../vcodec/decoder/mtk_vcodec_dec_stateless.c | 144 +++++++++++++++++-

vcodec/decoder directory no longer exists. Can you rebase your work please =
?

Nicolas

>  drivers/media/v4l2-core/v4l2-common.c         |   4 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
>  include/uapi/linux/videodev2.h                |   2 +
>  7 files changed, 188 insertions(+), 4 deletions(-)
>=20

