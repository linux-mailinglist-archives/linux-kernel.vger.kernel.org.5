Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4B87E221F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjKFMqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjKFMpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:45:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D640519A9;
        Mon,  6 Nov 2023 04:45:16 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E4F03660748D;
        Mon,  6 Nov 2023 12:45:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699274715;
        bh=IZ5sRu5ZB8QlbMlKzbR2HpoB5MIw6ONqWmWF6csTMas=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Az2KZY+o+wvZ9fBcZcv9AIiSZ99w7vR7RAcnpC5akxEst/P8HePevq+ZcVYM5tdrT
         gIcdpKjOAW1aIcmMlSFF6UxjMqaMLWV2ESSjmtotMgpPnO3ztaYU1IU7BkyIZttpVF
         ziL80JQb4wMnXB4TIpjwVMaMuSh6EW+KrMCzmp6+y35ElBPOhnGBG+dsM4scfcyYPO
         lFnuAJjMig+H8Ghz1Q80vmXaoJU6r313uIEIKoeII+TPlK1sjA/0HCYa3KMdhrZ8pr
         S8xqhf+zbQt8gv0AYjn34/s+wrESl+LLcS9/qwb4yJU3XNAv8ND0W0cMkypPx/m74V
         XarvBsrDC+8yA==
Message-ID: <813b3a54-f973-410f-950b-d99f6e563f1f@collabora.com>
Date:   Mon, 6 Nov 2023 13:45:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/12] add support MDP3 on MT8195 platform
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231030100626.12564-1-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/10/23 11:06, Moudy Ho ha scritto:
> Changes since v7:
> - Rebase on linux-next.
> - Dependent dtsi files:
>    https://patchwork.kernel.org/project/linux-mediatek/list/?series=797543
> - Dependent bindings:
>    https://patchwork.kernel.org/project/linux-mediatek/list/?series=797555
> - Patch [9/12] has made corresponding adjustments in response to the changes in
>    the compatible name of the PAD component in DTSI and binding.
> - Adding WROT compatible name in the MDP driver's of_match_table in [9/12] to
>    avoid deactivating 'pm_runtime_*' functions.
> 

On MT8195 Cherry Tomato Chromebook, whole series is

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Changes since v6:
> - Rebase on v6.6-rc5.
> - Dependent dtsi files:
>    https://patchwork.kernel.org/project/linux-mediatek/list/?series=792079
> - Dependent bindings:
>    https://patchwork.kernel.org/project/linux-mediatek/list/?series=792477
> - Move the patch that fixes compile warnings from this series and
>    create a separate standalone patch.
> 
> Changes since v5:
> - Rebase on v6.6-rc2.
> - Dependent dtsi files:
>    https://patchwork.kernel.org/project/linux-mediatek/list/?series=786511
> - Dependent bindings:
>    https://patchwork.kernel.org/project/linux-mediatek/list/?series=786520
> - Integrate MMSY/MUTEX structure in "mdp_probe".
> - Fix the build warnings that were detected by the linux-media
>    build scripts tool.
> 
> Changes since v4:
> - Rebase on v6.6-rc1
> - Remove any unnecessary DTS settings.
> - Adjust the usage of MOD and clock in blending components.
> 
> Changes since v3:
> - Depend on :
>    [1] https://patchwork.kernel.org/project/linux-media/list/?series=719841
> - Suggested by Krzysztof, integrating all newly added bindings for
>    the mt8195 MDP3 into the file "mediatek,mt8195-mdp3.yaml".
> - Revise MDP3 nodes with generic names.
> 
> Changes since v2:
> - Depend on :
>    [1] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek/list/?series=711592
>    [2] MDP3: https://patchwork.kernel.org/project/linux-mediatek/list/?series=711618
> - Suggested by Rob to revise MDP3 bindings to pass dtbs check
> - Add parallel paths feature.
> - Add blended components settings.
> 
> Changes since v1:
> - Depend on :
>    [1] MDP3 : https://patchwork.kernel.org/project/linux-mediatek/list/?series=698872
>    [2] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek/list/?series=684959
> - Fix compilation failure due to use of undeclared identifier in file "mtk-mdp3-cmdq.c"
> 
> Hello,
> 
> This patch is used to add support for MDP3 on the MT8195 platform that
> contains more picture quality components, and can arrange more pipelines
> through two sets of MMSYS and MUTEX respectively.
> 
> Moudy Ho (12):
>    media: platform: mtk-mdp3: add support second sets of MMSYS
>    media: platform: mtk-mdp3: add support second sets of MUTEX
>    media: platform: mtk-mdp3: introduce more pipelines from MT8195
>    media: platform: mtk-mdp3: introduce more MDP3 components
>    media: platform: mtk-mdp3: add checks for dummy components
>    media: platform: mtk-mdp3: avoid multiple driver registrations
>    media: platform: mtk-mdp3: extend GCE event waiting in RDMA and WROT
>    media: platform: mtk-mdp3: add support for blending multiple
>      components
>    media: platform: mtk-mdp3: add mt8195 platform configuration
>    media: platform: mtk-mdp3: add mt8195 shared memory configurations
>    media: platform: mtk-mdp3: add mt8195 MDP3 component settings
>    media: platform: mtk-mdp3: add support for parallel pipe to improve
>      FPS
> 
>   .../platform/mediatek/mdp3/mdp_cfg_data.c     | 729 +++++++++++++-
>   .../platform/mediatek/mdp3/mdp_reg_aal.h      |  25 +
>   .../platform/mediatek/mdp3/mdp_reg_color.h    |  31 +
>   .../media/platform/mediatek/mdp3/mdp_reg_fg.h |  23 +
>   .../platform/mediatek/mdp3/mdp_reg_hdr.h      |  31 +
>   .../platform/mediatek/mdp3/mdp_reg_merge.h    |  25 +
>   .../platform/mediatek/mdp3/mdp_reg_ovl.h      |  25 +
>   .../platform/mediatek/mdp3/mdp_reg_pad.h      |  21 +
>   .../platform/mediatek/mdp3/mdp_reg_rdma.h     |  24 +
>   .../platform/mediatek/mdp3/mdp_reg_rsz.h      |   2 +
>   .../platform/mediatek/mdp3/mdp_reg_tdshp.h    |  34 +
>   .../platform/mediatek/mdp3/mdp_reg_wrot.h     |   8 +
>   .../platform/mediatek/mdp3/mdp_sm_mt8195.h    | 283 ++++++
>   .../platform/mediatek/mdp3/mtk-img-ipi.h      |   4 +
>   .../platform/mediatek/mdp3/mtk-mdp3-cfg.h     |   2 +
>   .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 440 +++++++--
>   .../platform/mediatek/mdp3/mtk-mdp3-cmdq.h    |   1 +
>   .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 895 +++++++++++++++++-
>   .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  93 +-
>   .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 139 ++-
>   .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  50 +-
>   .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  15 +
>   .../platform/mediatek/mdp3/mtk-mdp3-regs.c    |  18 +
>   .../platform/mediatek/mdp3/mtk-mdp3-regs.h    |   1 +
>   .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     |   3 +-
>   25 files changed, 2744 insertions(+), 178 deletions(-)
>   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_aal.h
>   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_color.h
>   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_fg.h
>   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_hdr.h
>   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_merge.h
>   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_ovl.h
>   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_pad.h
>   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_tdshp.h
>   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_sm_mt8195.h
> 

