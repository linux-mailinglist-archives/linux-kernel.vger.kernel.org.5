Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F7C76235C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjGYUfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGYUfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:35:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BE11BC8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:35:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686baccf661so378761b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690317302; x=1690922102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEBFhajNAbJA8oyQ3SzCNr6bDDYsCg4XK+Nkm+WUeyo=;
        b=eY6zQW3yCE3HW7dgVJNQZhe10AN6qBQt2ko/chealQwqHrG4pM7GbfZSTeJjki77ur
         vvleenmBb5FbgzGEaPwOFmpaKUTOWBHwreBUUoapzQSDFCTju1zARvVMKgp7X7voD+Nl
         sXGfLqWP8rjifH8hqHsJWCsAktmKU/tFHQMq5EuvNH/TroIDEQo6kCLEp9pwNh7VUb3c
         zLdZA9nSTj/zpvIkmp2CT+s8H4mAClm9FNigMM4FuVifUsUmWhUx+sNaPxSb6axgGSDq
         g0fPFLH/O4qJeu+Cfaye5RHsStJDo8BFlqz0YObnHUoCnMYpBXWeebG+Imz7w0UTWiHL
         YF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317302; x=1690922102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEBFhajNAbJA8oyQ3SzCNr6bDDYsCg4XK+Nkm+WUeyo=;
        b=J4XjCiTmulUkzY793rjHldvgNZP+bh9IPPMswRd50Usv9X6fCYz6ezrzmwrsc9JgqG
         YpKJBSIHnJS82yf81c39eQbKbjn8rW/icYyTWDv+xYNJ3/JgBYM4piqbdB+2sxUtIe2V
         JdfkTYbFIPQ4WEQGGfWJanpUW2sV9xAs6ppLHiYVwHBCGWdYm+Vxl7I6iwnffFxRLfXZ
         JkKmGgrOB5+m7DiFWPLhhw4u+Wi4kqEA/l0nHz4D2YHrgGA9oAmtLT8KRLAtSM0wmaK0
         /L/IXM9w6ZiIHjJsxTAZVARD2Hge+cExWedGkq7xeVl1Ap/Xt4dFpu01/SjJ0f+H+YKy
         X5Pg==
X-Gm-Message-State: ABy/qLYz3gqSRnf2HoWKdQJfEXzEoWoaLm3uhs5uWREjXnUBoGO9RxgS
        DpuM1Cqylufhg2dIo3/mZ8FbtA==
X-Google-Smtp-Source: APBJJlGSzayuOHxBmo/tEETnK6cmj1CrVYQ2LOCdES+hgyiq0gr838HgHLCeJA/FeOOzp9ZE+OXsYw==
X-Received: by 2002:a05:6a20:914d:b0:122:10f9:f635 with SMTP id x13-20020a056a20914d00b0012210f9f635mr119916pzc.19.1690317301899;
        Tue, 25 Jul 2023 13:35:01 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2116:2b1f:2fd8:ec8d])
        by smtp.gmail.com with ESMTPSA id s11-20020a63770b000000b0052c22778e64sm10847608pgc.66.2023.07.25.13.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 13:35:01 -0700 (PDT)
Date:   Tue, 25 Jul 2023 14:34:58 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v15 00/13] Add support for MT8195 SCP 2nd core
Message-ID: <ZMAx8mc0tjgPvU3j@p14s>
References: <20230721024132.6548-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721024132.6548-1-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:41:19AM +0800, Tinghan Shen wrote:
> The mediatek remoteproc driver currently only allows bringing up a 
> single core SCP, e.g. MT8183. It also only bringing up the 1st 
> core in SoCs with a dual-core SCP, e.g. MT8195. This series support 
> to bring-up the 2nd core of the dual-core SCP.
> 
> v15 -> v14:
> 1. Use the common SCP registers in struct mtk_scp_of_cluster instead of
>    copy it to struct mtk_scp at patchset 5 
> 2. Use platform_set_drvdata instead of platform_device_add_data at patchset 5 
> 3. Rename l2tcm_lock to cluster_lock at patchset 8
> 4. Check l2tcm_refcnt value before decreasing at patchset 8
> 5. Revise the commit message at patchset 11

I am done reviewing this set.  Checkpatch is giving a warning for patch 01/13,
something I would expect to have been dealt with after 15 iterations.  I will be
away for the next 3 weeks so no point in rushing another revision to sqeeze
in the v6.6 merge window.

Mathieu

> 
> v13 -> v14:
> 1. add review tag to patchset 1,6
> 2. exchange the order of sram power on and reset assert in
> mt8195_scp_c1_before_load at patchset 2
> 3. Use ERR_CAST in patchset 5
> 4. Re-write patchset 7 to remove dependency between core 0 and core 1 
> 5. Add patch set 10 to report watchdot timeout to all cores
> 
> v12 -> v13:
> 1. replace subdevice with new mediatek scp operations in patchset 7 
> 2. add review tag to patchset 3
> 3. modify mediatek,scp phandle name of video-codec@18000000 at patchset 11
> 
> v11 -> v12:
> 1. add scp_add_single/multi_core() to patchset 6
> 2. remove unused comment in patchset 6
> 3. rename list name from mtk_scp_cluster to mtk_scp_list
> 4. rewrite the multi-core probe flow 
> 5. disable rproc->autoboot and boot rproc by request_firmware_nowait at patchset 7 
> 6. remove patchset 7 review tag  
> 
> v10 -> v11:
> 1. rewrite patchset 5 to probe single-core SCP with the cluster list
> 2. Also in patchset 5, move the pointer of mtk_scp object from the
>    platform data property to the driver data property 
> 3. move the appearance of mtk_scp cluster property to patcheset 7
> 
> v9 -> v10:
> 1. move the global mtk_scp list into the platform device driver data structure
> 2. remove an unnecessary if() condition
> 
> v8 -> v9:
> 1. initialize l1tcm_size/l1tcm_phys at patchset 05/11 
> 2. rewrite patchset 06/11 to unify the flow and remove hacks
> 
> v7 -> v8:
> 1. update the node name of mt8192 asurada SCP rpmsg subnode
> 2. squash register definitions into driver patches
> 3. initialize local variables on the declaration at patch v8 06/11 
> 
> v6 -> v7:
> 1. merge the mtk_scp_cluster struct into the mtk_scp structure
>    at the "Probe multi-core SCP" patch
> 
> v5 -> v6:
> 1. move the mtk_scp_of_regs structure from mtk_common.h to mtk_scp.c
> 2. rename the SCP core 0 label from 'scp' to 'scp_c0'
> 
> v4 -> v5:
> 1. move resource release actions to the platform driver remove operation 
> 2. fix dual-core watchdog handling
> 
> v3 -> v4:
> 1. change the representation of dual-core SCP in dts file and update SCP yaml
> 2. rewrite SCP driver to reflect the change of dts node
> 3. drop 'remove redundant call of rproc_boot for SCP' in v3 for further investigation
> 
> v2 -> v3:
> 1. change the representation of dual-core SCP in dts file and update SCP yaml
> 2. rewrite SCP driver to reflect the change of dts node
> 3. add SCP core 1 node to mt8195.dtsi
> 4. remove redundant call of rproc_boot for SCP
> 5. refine IPI error message
> 
> v1 -> v2:
> 1. update dt-binding property description
> 2. remove kconfig for scp dual driver
> 3. merge mtk_scp_dual.c and mtk_scp_subdev.c to mtk_scp.c
> 
> 
> Tinghan Shen (13):
>   dt-bindings: remoteproc: mediatek: Improve the rpmsg subnode
>     definition
>   arm64: dts: mediatek: Update the node name of SCP rpmsg subnode
>   dt-bindings: remoteproc: mediatek: Support MT8195 dual-core SCP
>   remoteproc: mediatek: Add MT8195 SCP core 1 operations
>   remoteproc: mediatek: Extract SCP common registers
>   remoteproc: mediatek: Probe SCP cluster on single-core SCP
>   remoteproc: mediatek: Probe SCP cluster on multi-core SCP
>   remoteproc: mediatek: Remove dependency of MT8195 SCP L2TCM power
>     control on dual-core SCP
>   remoteproc: mediatek: Setup MT8195 SCP core 1 SRAM offset
>   remoteproc: mediatek: Handle MT8195 SCP core 1 watchdog timeout
>   remoteproc: mediatek: Report watchdog crash to all cores
>   remoteproc: mediatek: Refine ipi handler error message
>   arm64: dts: mediatek: mt8195: Add SCP 2nd core
> 
>  .../bindings/remoteproc/mtk,scp.yaml          | 176 +++++-
>  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   2 +-
>  .../boot/dts/mediatek/mt8192-asurada.dtsi     |   2 +-
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      |   6 +-
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  34 +-
>  drivers/remoteproc/mtk_common.h               |  39 +-
>  drivers/remoteproc/mtk_scp.c                  | 534 ++++++++++++++----
>  drivers/remoteproc/mtk_scp_ipi.c              |   4 +-
>  8 files changed, 651 insertions(+), 146 deletions(-)
> 
> -- 
> 2.18.0
> 
