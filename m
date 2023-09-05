Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07634792B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243444AbjIEQtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353739AbjIEHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:46:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7673FCC;
        Tue,  5 Sep 2023 00:46:44 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 97E5966071F8;
        Tue,  5 Sep 2023 08:46:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693900003;
        bh=iVSSjE9/cDR/vb6gfa9QEPy8bbBHcPSNTM8rId6Vj1A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mBozDZO9FUZ+xEUFBzpXScqadGnVdhN1h7klNZLiMacQspgC+ouurNBbY+sZusuaw
         OOgD3AwpZbxkYhfPtFgoYLfDCFsWKUTFf1kl4dLW5rVE+cARrpubWNcY2JbkOnOYOe
         qXdrJVJgbxIscLugRKZmOE2ZwVe5NTEpYZiydnqShmCrbMyi2VWFbuPIeduT8rbRUt
         4kRDdHnIEVePdSjhWbQA2MScJdR2SvN7ePla9EaJKcjiN/DU+Vs5iuoXTYJt/xBUp1
         c+NE8hKf6J46GO/TPpOVMWsyozPnPti94RKUosYHQ/mzi9gn21JJ9fxX3mYLNQVTmC
         elM+nMdLTHhng==
Message-ID: <cf5f7df1-64eb-05d8-e6d4-87ef0a846f79@collabora.com>
Date:   Tue, 5 Sep 2023 09:46:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v17 00/14] Add support for MT8195 SCP 2nd core
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230901080935.14571-1-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230901080935.14571-1-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/09/23 10:09, Tinghan Shen ha scritto:
> The mediatek remoteproc driver currently only allows bringing up a
> single core SCP, e.g. MT8183. It also only bringing up the 1st
> core in SoCs with a dual-core SCP, e.g. MT8195. This series support
> to bring-up the 2nd core of the dual-core SCP.
> 

Whole series is
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

On MT8195 Tomato Chromebook.

> v16 -> v17:
> 1. add a comment in scp_add_multi_core() at patchset 8
> 
> v15 -> v16:
> 1. fix the checkpatch warning at patchset 1
> 2. move changes on scp_probe() to the new added patchset 6
> 3. revise platform_set_drvdata() at patchset 8
> 4. fix commit message at patchset 9
> 
> v15 -> v14:
> 1. use the common SCP registers in struct mtk_scp_of_cluster instead of
>     copy it to struct mtk_scp at patchset 5
> 2. use platform_set_drvdata instead of platform_device_add_data at patchset 5
> 3. rename l2tcm_lock to cluster_lock at patchset 8
> 4. check l2tcm_refcnt value before decreasing at patchset 8
> 5. revise the commit message at patchset 11
> 
> v13 -> v14:
> 1. add review tag to patchset 1,6
> 2. exchange the order of sram power on and reset assert in
> mt8195_scp_c1_before_load at patchset 2
> 3. use ERR_CAST in patchset 5
> 4. re-write patchset 7 to remove dependency between core 0 and core 1
> 5. add patch set 10 to report watchdot timeout to all cores
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
>     platform data property to the driver data property
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
>     at the "Probe multi-core SCP" patch
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
> Tinghan Shen (14):
>    dt-bindings: remoteproc: mediatek: Improve the rpmsg subnode
>      definition
>    arm64: dts: mediatek: Update the node name of SCP rpmsg subnode
>    dt-bindings: remoteproc: mediatek: Support MT8195 dual-core SCP
>    remoteproc: mediatek: Add MT8195 SCP core 1 operations
>    remoteproc: mediatek: Extract SCP common registers
>    remoteproc: mediatek: Revise SCP rproc initialization flow for
>      multi-core SCP
>    remoteproc: mediatek: Probe SCP cluster on single-core SCP
>    remoteproc: mediatek: Probe SCP cluster on multi-core SCP
>    remoteproc: mediatek: Remove dependency of MT8195 SCP L2TCM power
>      control on dual-core SCP
>    remoteproc: mediatek: Setup MT8195 SCP core 1 SRAM offset
>    remoteproc: mediatek: Handle MT8195 SCP core 1 watchdog timeout
>    remoteproc: mediatek: Report watchdog crash to all cores
>    remoteproc: mediatek: Refine ipi handler error message
>    arm64: dts: mediatek: mt8195: Add SCP 2nd core
> 
>   .../bindings/remoteproc/mtk,scp.yaml          | 176 +++++-
>   .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |   2 +-
>   .../boot/dts/mediatek/mt8192-asurada.dtsi     |   2 +-
>   .../boot/dts/mediatek/mt8195-cherry.dtsi      |   6 +-
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  34 +-
>   drivers/remoteproc/mtk_common.h               |  39 +-
>   drivers/remoteproc/mtk_scp.c                  | 539 ++++++++++++++----
>   drivers/remoteproc/mtk_scp_ipi.c              |   4 +-
>   8 files changed, 656 insertions(+), 146 deletions(-)
> 


