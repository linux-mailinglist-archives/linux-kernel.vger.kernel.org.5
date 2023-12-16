Return-Path: <linux-kernel+bounces-2116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D74815814
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECB9286F32
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429A1134C4;
	Sat, 16 Dec 2023 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PJX9meyu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBEB12B85;
	Sat, 16 Dec 2023 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702709225;
	bh=hOlNrL4DGi2cD4PMnB8p+gC4Zp2KSXfuHJBo1h8i+7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJX9meyu2VD03BC4Dc5OJ/5zEYAj9IOgeMpuTCD5RDkHWNLb1rMyZzkg0K7AQXFi5
	 JgWOb/Rknet9LBLDIfXbfPWpIssrOs1Q1wBeyG+sGxqqYkAdIy0F8G5oW2etoZlxgR
	 jhJyRnFDhb4JYD5j8lAvl4doP6vZd1wjwm5WQwJKucQL2O2d/UyjOKavOoN4FHcAj2
	 mDx6qUufGKQAGFsrFRMIhimxh5F9kW7iLxXb/kvDhHLViHkzhRUfFYfmzpaiflMdnt
	 vEZ5ttFUZHFLUNGa00n+sOqdFl5SW6Edrmrd299MPSAI++S7fGhD76TkGRHSgmMYLy
	 q9UyTU5QWCngg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3488637811D2;
	Sat, 16 Dec 2023 06:47:05 +0000 (UTC)
Date: Sat, 16 Dec 2023 07:47:03 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Moudy Ho <moudy.ho@mediatek.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v8 00/12] add support MDP3 on MT8195 platform
Message-ID: <20231216064703.tb7vf3m2ohrbz6px@basti-XPS-13-9310>
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20231030100626.12564-1-moudy.ho@mediatek.com>

Hey Moudy Ho,

just as a quick note, as this series is based on linux-next, we will
wait for the patches, that this series is depending on, to be merged into
the media_stage repository (https://git.linuxtv.org/media_stage.git/),
before we merge this series into the media subsystem.

Greetings,
Sebastian

On 30.10.2023 18:06, Moudy Ho wrote:
>Changes since v7:
>- Rebase on linux-next.
>- Dependent dtsi files:
>  https://patchwork.kernel.org/project/linux-mediatek/list/?series=797543
>- Dependent bindings:
>  https://patchwork.kernel.org/project/linux-mediatek/list/?series=797555
>- Patch [9/12] has made corresponding adjustments in response to the changes in
>  the compatible name of the PAD component in DTSI and binding.
>- Adding WROT compatible name in the MDP driver's of_match_table in [9/12] to
>  avoid deactivating 'pm_runtime_*' functions.
>
>Changes since v6:
>- Rebase on v6.6-rc5.
>- Dependent dtsi files:
>  https://patchwork.kernel.org/project/linux-mediatek/list/?series=792079
>- Dependent bindings:
>  https://patchwork.kernel.org/project/linux-mediatek/list/?series=792477
>- Move the patch that fixes compile warnings from this series and
>  create a separate standalone patch.
>
>Changes since v5:
>- Rebase on v6.6-rc2.
>- Dependent dtsi files:
>  https://patchwork.kernel.org/project/linux-mediatek/list/?series=786511
>- Dependent bindings:
>  https://patchwork.kernel.org/project/linux-mediatek/list/?series=786520
>- Integrate MMSY/MUTEX structure in "mdp_probe".
>- Fix the build warnings that were detected by the linux-media
>  build scripts tool.
>
>Changes since v4:
>- Rebase on v6.6-rc1
>- Remove any unnecessary DTS settings.
>- Adjust the usage of MOD and clock in blending components.
>
>Changes since v3:
>- Depend on :
>  [1] https://patchwork.kernel.org/project/linux-media/list/?series=719841
>- Suggested by Krzysztof, integrating all newly added bindings for
>  the mt8195 MDP3 into the file "mediatek,mt8195-mdp3.yaml".
>- Revise MDP3 nodes with generic names.
>
>Changes since v2:
>- Depend on :
>  [1] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek/list/?series=711592
>  [2] MDP3: https://patchwork.kernel.org/project/linux-mediatek/list/?series=711618
>- Suggested by Rob to revise MDP3 bindings to pass dtbs check
>- Add parallel paths feature.
>- Add blended components settings.
>
>Changes since v1:
>- Depend on :
>  [1] MDP3 : https://patchwork.kernel.org/project/linux-mediatek/list/?series=698872
>  [2] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek/list/?series=684959
>- Fix compilation failure due to use of undeclared identifier in file "mtk-mdp3-cmdq.c"
>
>Hello,
>
>This patch is used to add support for MDP3 on the MT8195 platform that
>contains more picture quality components, and can arrange more pipelines
>through two sets of MMSYS and MUTEX respectively.
>
>Moudy Ho (12):
>  media: platform: mtk-mdp3: add support second sets of MMSYS
>  media: platform: mtk-mdp3: add support second sets of MUTEX
>  media: platform: mtk-mdp3: introduce more pipelines from MT8195
>  media: platform: mtk-mdp3: introduce more MDP3 components
>  media: platform: mtk-mdp3: add checks for dummy components
>  media: platform: mtk-mdp3: avoid multiple driver registrations
>  media: platform: mtk-mdp3: extend GCE event waiting in RDMA and WROT
>  media: platform: mtk-mdp3: add support for blending multiple
>    components
>  media: platform: mtk-mdp3: add mt8195 platform configuration
>  media: platform: mtk-mdp3: add mt8195 shared memory configurations
>  media: platform: mtk-mdp3: add mt8195 MDP3 component settings
>  media: platform: mtk-mdp3: add support for parallel pipe to improve
>    FPS
>
> .../platform/mediatek/mdp3/mdp_cfg_data.c     | 729 +++++++++++++-
> .../platform/mediatek/mdp3/mdp_reg_aal.h      |  25 +
> .../platform/mediatek/mdp3/mdp_reg_color.h    |  31 +
> .../media/platform/mediatek/mdp3/mdp_reg_fg.h |  23 +
> .../platform/mediatek/mdp3/mdp_reg_hdr.h      |  31 +
> .../platform/mediatek/mdp3/mdp_reg_merge.h    |  25 +
> .../platform/mediatek/mdp3/mdp_reg_ovl.h      |  25 +
> .../platform/mediatek/mdp3/mdp_reg_pad.h      |  21 +
> .../platform/mediatek/mdp3/mdp_reg_rdma.h     |  24 +
> .../platform/mediatek/mdp3/mdp_reg_rsz.h      |   2 +
> .../platform/mediatek/mdp3/mdp_reg_tdshp.h    |  34 +
> .../platform/mediatek/mdp3/mdp_reg_wrot.h     |   8 +
> .../platform/mediatek/mdp3/mdp_sm_mt8195.h    | 283 ++++++
> .../platform/mediatek/mdp3/mtk-img-ipi.h      |   4 +
> .../platform/mediatek/mdp3/mtk-mdp3-cfg.h     |   2 +
> .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 440 +++++++--
> .../platform/mediatek/mdp3/mtk-mdp3-cmdq.h    |   1 +
> .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 895 +++++++++++++++++-
> .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  93 +-
> .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 139 ++-
> .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  50 +-
> .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  15 +
> .../platform/mediatek/mdp3/mtk-mdp3-regs.c    |  18 +
> .../platform/mediatek/mdp3/mtk-mdp3-regs.h    |   1 +
> .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     |   3 +-
> 25 files changed, 2744 insertions(+), 178 deletions(-)
> create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_aal.h
> create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_color.h
> create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_fg.h
> create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_hdr.h
> create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_merge.h
> create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_ovl.h
> create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_pad.h
> create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_tdshp.h
> create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_sm_mt8195.h
>
>-- 
>2.18.0
>

