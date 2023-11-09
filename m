Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD457E6FF4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344458AbjKIRPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjKIRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:14:59 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53B030E6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:14:57 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-778a92c06d6so67815585a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 09:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1699550097; x=1700154897; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6Z8arH/L8dbgBy2K8H+HC60RfY1WMKLKdBsQeTpXgQI=;
        b=dFueesu+Fku2jkuCwyHb/+JjjXApQO7bdJfsf3j1HpFHXe5DAYlCuMikO9RvFMHjGZ
         OgojdW7TaYSs41AgZ0jynAVUIRwa5w2lRijsZGXcBfegrA9EsVDhNuqQPSTYViiajoT9
         4EueS8qUwYOLMXMqC872JJo6kjO/3ypkEUiv4nLkkxl052lD3lfr5hc/9YD+K2jF9zsf
         KKrqUig5YnLQQX1qeyvrrx3f6d6sZmBMI88ztyOfWNiX8humzz++UHVCEO54h7+BgJhI
         vJKQRDOIczxI4j+6AVi5wWX8OgCJ9YmXVpLIkliDyWbtraYTtxo2SlF3JVdbAoNSkz0r
         IXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550097; x=1700154897;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Z8arH/L8dbgBy2K8H+HC60RfY1WMKLKdBsQeTpXgQI=;
        b=oYV9DoTupMRPzbPU1jdOcA+NLtZoFt4prZ2lSrI+7GhblHhxQ4m98Hd8snMWx4avU3
         SuHulEsRFqTSkJWQtDll6hp0DoqgaRXi34Yu32GBwUtH9zZDjFs+PHbvW5RUiEMYWyGZ
         sA1KBV0Nnv2cJQcxMWXxPXjT++H/SwgZTNlGlpYpd76m5lFMxGh15XEpJK2XvPF6jeWw
         fjw9ml+3lo3EO2+ORpSInrFqaJypO19wGF6ONWvdDScRR+SifgoKS5TEJ12tiWfM7QRN
         hsx3dZmS0lxaWijJEUAxzi0nKc5b3w0EpXyctoGRp47TOsSlZAxXBdPG5wbNhppGNdEE
         VOFw==
X-Gm-Message-State: AOJu0YzX+DQgp4UZzGDzAvmcdZJcyvAeLZ9gHyVhVLT/zjmS7t3EsyKj
        olaCWVhtIsonLbF2PrW85Yjtzg==
X-Google-Smtp-Source: AGHT+IHk0n0eRBECeJL4V3CQV/YSwTJA0WV6rOAi2qVWDwbsxMkM1rm/tlV9wSVWqrrPcgEnKL7yxQ==
X-Received: by 2002:ae9:e214:0:b0:777:617d:5f6b with SMTP id c20-20020ae9e214000000b00777617d5f6bmr5042051qkc.36.1699550096816;
        Thu, 09 Nov 2023 09:14:56 -0800 (PST)
Received: from ?IPv6:2606:6d00:17:6dc0::c73? ([2606:6d00:17:6dc0::c73])
        by smtp.gmail.com with ESMTPSA id d27-20020a05620a137b00b00772662b7804sm34891qkl.100.2023.11.09.09.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:14:56 -0800 (PST)
Message-ID: <74c95ceb6c8554fb850ce79d6c75b1ca5a6b2514.camel@ndufresne.ca>
Subject: Re: [PATCH v8 00/12] add support MDP3 on MT8195 platform
From:   nicolas@ndufresne.ca
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Thu, 09 Nov 2023 12:14:55 -0500
In-Reply-To: <813b3a54-f973-410f-950b-d99f6e563f1f@collabora.com>
References: <20231030100626.12564-1-moudy.ho@mediatek.com>
         <813b3a54-f973-410f-950b-d99f6e563f1f@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

Le lundi 06 novembre 2023 =C3=A0 13:45 +0100, AngeloGioacchino Del Regno a
=C3=A9crit=C2=A0:
> Il 30/10/23 11:06, Moudy Ho ha scritto:
> > Changes since v7:
> > - Rebase on linux-next.
> > - Dependent dtsi files:
> >    https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D7=
97543
> > - Dependent bindings:
> >    https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D7=
97555
> > - Patch [9/12] has made corresponding adjustments in response to the ch=
anges in
> >    the compatible name of the PAD component in DTSI and binding.
> > - Adding WROT compatible name in the MDP driver's of_match_table in [9/=
12] to
> >    avoid deactivating 'pm_runtime_*' functions.
> >=20
>=20
> On MT8195 Cherry Tomato Chromebook, whole series is
>=20
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>

Would you mind dropping a short description of what your test consist ?
Which userspace have been used, did you cover all the pixel formats
combination ? Did you test scaling, rotation, etc. ?

Nicolas

>=20
> > Changes since v6:
> > - Rebase on v6.6-rc5.
> > - Dependent dtsi files:
> >    https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D7=
92079
> > - Dependent bindings:
> >    https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D7=
92477
> > - Move the patch that fixes compile warnings from this series and
> >    create a separate standalone patch.
> >=20
> > Changes since v5:
> > - Rebase on v6.6-rc2.
> > - Dependent dtsi files:
> >    https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D7=
86511
> > - Dependent bindings:
> >    https://patchwork.kernel.org/project/linux-mediatek/list/?series=3D7=
86520
> > - Integrate MMSY/MUTEX structure in "mdp_probe".
> > - Fix the build warnings that were detected by the linux-media
> >    build scripts tool.
> >=20
> > Changes since v4:
> > - Rebase on v6.6-rc1
> > - Remove any unnecessary DTS settings.
> > - Adjust the usage of MOD and clock in blending components.
> >=20
> > Changes since v3:
> > - Depend on :
> >    [1] https://patchwork.kernel.org/project/linux-media/list/?series=3D=
719841
> > - Suggested by Krzysztof, integrating all newly added bindings for
> >    the mt8195 MDP3 into the file "mediatek,mt8195-mdp3.yaml".
> > - Revise MDP3 nodes with generic names.
> >=20
> > Changes since v2:
> > - Depend on :
> >    [1] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek=
/list/?series=3D711592
> >    [2] MDP3: https://patchwork.kernel.org/project/linux-mediatek/list/?=
series=3D711618
> > - Suggested by Rob to revise MDP3 bindings to pass dtbs check
> > - Add parallel paths feature.
> > - Add blended components settings.
> >=20
> > Changes since v1:
> > - Depend on :
> >    [1] MDP3 : https://patchwork.kernel.org/project/linux-mediatek/list/=
?series=3D698872
> >    [2] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek=
/list/?series=3D684959
> > - Fix compilation failure due to use of undeclared identifier in file "=
mtk-mdp3-cmdq.c"
> >=20
> > Hello,
> >=20
> > This patch is used to add support for MDP3 on the MT8195 platform that
> > contains more picture quality components, and can arrange more pipeline=
s
> > through two sets of MMSYS and MUTEX respectively.
> >=20
> > Moudy Ho (12):
> >    media: platform: mtk-mdp3: add support second sets of MMSYS
> >    media: platform: mtk-mdp3: add support second sets of MUTEX
> >    media: platform: mtk-mdp3: introduce more pipelines from MT8195
> >    media: platform: mtk-mdp3: introduce more MDP3 components
> >    media: platform: mtk-mdp3: add checks for dummy components
> >    media: platform: mtk-mdp3: avoid multiple driver registrations
> >    media: platform: mtk-mdp3: extend GCE event waiting in RDMA and WROT
> >    media: platform: mtk-mdp3: add support for blending multiple
> >      components
> >    media: platform: mtk-mdp3: add mt8195 platform configuration
> >    media: platform: mtk-mdp3: add mt8195 shared memory configurations
> >    media: platform: mtk-mdp3: add mt8195 MDP3 component settings
> >    media: platform: mtk-mdp3: add support for parallel pipe to improve
> >      FPS
> >=20
> >   .../platform/mediatek/mdp3/mdp_cfg_data.c     | 729 +++++++++++++-
> >   .../platform/mediatek/mdp3/mdp_reg_aal.h      |  25 +
> >   .../platform/mediatek/mdp3/mdp_reg_color.h    |  31 +
> >   .../media/platform/mediatek/mdp3/mdp_reg_fg.h |  23 +
> >   .../platform/mediatek/mdp3/mdp_reg_hdr.h      |  31 +
> >   .../platform/mediatek/mdp3/mdp_reg_merge.h    |  25 +
> >   .../platform/mediatek/mdp3/mdp_reg_ovl.h      |  25 +
> >   .../platform/mediatek/mdp3/mdp_reg_pad.h      |  21 +
> >   .../platform/mediatek/mdp3/mdp_reg_rdma.h     |  24 +
> >   .../platform/mediatek/mdp3/mdp_reg_rsz.h      |   2 +
> >   .../platform/mediatek/mdp3/mdp_reg_tdshp.h    |  34 +
> >   .../platform/mediatek/mdp3/mdp_reg_wrot.h     |   8 +
> >   .../platform/mediatek/mdp3/mdp_sm_mt8195.h    | 283 ++++++
> >   .../platform/mediatek/mdp3/mtk-img-ipi.h      |   4 +
> >   .../platform/mediatek/mdp3/mtk-mdp3-cfg.h     |   2 +
> >   .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    | 440 +++++++--
> >   .../platform/mediatek/mdp3/mtk-mdp3-cmdq.h    |   1 +
> >   .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 895 +++++++++++++++++=
-
> >   .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  93 +-
> >   .../platform/mediatek/mdp3/mtk-mdp3-core.c    | 139 ++-
> >   .../platform/mediatek/mdp3/mtk-mdp3-core.h    |  50 +-
> >   .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  15 +
> >   .../platform/mediatek/mdp3/mtk-mdp3-regs.c    |  18 +
> >   .../platform/mediatek/mdp3/mtk-mdp3-regs.h    |   1 +
> >   .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     |   3 +-
> >   25 files changed, 2744 insertions(+), 178 deletions(-)
> >   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_aal.h
> >   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_color=
.h
> >   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_fg.h
> >   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_hdr.h
> >   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_merge=
.h
> >   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_ovl.h
> >   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_pad.h
> >   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_tdshp=
.h
> >   create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_sm_mt8195=
.h
> >=20
>=20

