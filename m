Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6F47F3146
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjKUOlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbjKUOlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:41:01 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DC5D51
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:40:54 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1f0f94a08a0so3336463fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700577653; x=1701182453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:in-reply-to:references:user-agent:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImxWZyQw+OzqcqVpcmrRNXVgXf/9MkOc4lXvk9lNMHc=;
        b=QKkWxSbVi1SUuQpLPyJG1BvHG9c8Dksb8rYNC1ZjWysXLKBHMNuLve1yFwoBVUESGU
         HAiHxDyxsbJq0hC9BgM1LobXBPK/1tHChKLsjy0F/9V//av7o8NhCRCt+QNV86jC9CkB
         8quxcnv3A+h9YHUd6sBPPVE+je1D+oYPx/BUqJXqyYoo1WqtCqycJ6auvS502Wt3tn5I
         WKLC47AP859oq+VgcMYXX3KDR77NMbZ6PLyPpZgCza9XsMljqMAVroblgV+4LCeEKH5u
         Gr6rDJrjxFqulCd7m1Jtmal+NzkpJjQ9Y+3U9P9/E9t1Z9AU++ZV1c5Ljw66r5EkmRYU
         kOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700577653; x=1701182453;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:in-reply-to:references:user-agent:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImxWZyQw+OzqcqVpcmrRNXVgXf/9MkOc4lXvk9lNMHc=;
        b=tV0ZRf1hp24NB96Np9YRRcz6Sh2ufBDaMo2aHx4nkiKm1TRSiw2uFPfP/ceHcgibfb
         dXXTVSTEXMkDj2FX9HgBeA/Px4F0TE7y8gtyA8u5W4MkKXDuj74g2pLrK+M4c45do4OV
         rxP2M0Pjnyq15jLodtrQkzbzztAiV/Do6GmSaBbB4b8KZb8vGrNqMSDIGEUCrTae0jLp
         VPqDA8Dm62YU4CBHtF+AECaw0z1oPgAnv9wFf1qfRGrOPqW4VwTGsRoNSZzyxZwp7WpJ
         6q+7WQfFyVAOPY3vmEpRsGIPKLpW4YPtSBitq6mhh9ZMn1apMhl+1Eb8vzHNeDcqffBA
         t5Hw==
X-Gm-Message-State: AOJu0YwyyQA7hg61PU+ZtWwVxY1U/hh3yYlxW7sxLFeOehGT3pNo14RF
        tqJtFQE/DmYtHTL1ts+c6ATxi9cKFLxOLo8FCOqe/o3h0gEIH2rq
X-Google-Smtp-Source: AGHT+IEMmr6OYDSX2nS5vNaDx2wFqAkHqsQ/xko6HAJB9cs9kRZI2B37yAeB6rBMLaCK23pkXxmz2pO5+KzJ323xLhs=
X-Received: by 2002:a05:6870:3b85:b0:1f9:36fe:fd0e with SMTP id
 gi5-20020a0568703b8500b001f936fefd0emr5880414oab.47.1700577652158; Tue, 21
 Nov 2023 06:40:52 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Nov 2023 06:40:51 -0800
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.3
References: <20231121142938.460846-1-nfraprado@collabora.com>
In-Reply-To: <20231121142938.460846-1-nfraprado@collabora.com>
MIME-Version: 1.0
Date:   Tue, 21 Nov 2023 06:40:51 -0800
Message-ID: <CABnWg9uqPc20F93GF_wF2_o4hq9zdAJtyoa8_iMyM8gc9owDXg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: dp: Add phy_mtk_dp module as pre-dependency
To:     =?UTF-8?B?TsOtIGNvbGFzIEYuIFIuIEEuIFByYWRv?= 
        <nfraprado@collabora.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Guillaume Ranquet <granquet@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 15:29, "N=C3=ADcolas F. R. A. Prado"
<nfraprado@collabora.com> wrote:
>The mtk_dp driver registers a phy device which is handled by the
>phy_mtk_dp driver and assumes that the phy probe will complete
>synchronously, proceeding to make use of functionality exposed by that
>driver right away. This assumption however is false when the phy driver
>is built as a module, causing the mtk_dp driver to fail probe in this
>case.
>
>Add the phy_mtk_dp module as a pre-dependency to the mtk_dp module to
>ensure the phy module has been loaded before the dp, so that the phy
>probe happens synchrounously and the mtk_dp driver can probe
>successfully even with the phy driver built as a module.
>
>Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
>Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver=
")
>Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabo=
ra.com>
>
>---

Reviewed-by: Guillaume Ranquet <granquet@baylibre.com>
>
>Changes in v2:
>- Added missing Suggested-by tag
>
> drivers/gpu/drm/mediatek/mtk_dp.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/=
mtk_dp.c
>index e4c16ba9902d..2136a596efa1 100644
>--- a/drivers/gpu/drm/mediatek/mtk_dp.c
>+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
>@@ -2818,3 +2818,4 @@ MODULE_AUTHOR("Markus Schneider-Pargmann <msp@baylib=
re.com>");
> MODULE_AUTHOR("Bo-Chen Chen <rex-bc.chen@mediatek.com>");
> MODULE_DESCRIPTION("MediaTek DisplayPort Driver");
> MODULE_LICENSE("GPL");
>+MODULE_SOFTDEP("pre: phy_mtk_dp");
>--
>2.42.1
>
