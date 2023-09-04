Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385A2791C21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353347AbjIDRuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbjIDRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:50:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F2DC4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 10:50:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31f4a286ae1so750667f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693849818; x=1694454618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rncWvuUlxPMD3w67Ey6ITQiyZ0HdBuQ5Y0WGNXnOpjc=;
        b=w76M13uwMRSRcX9QCGp4vQd4hDhvFuDAEFnSSeyfCWl9qwDvJd5HoCDWuUAkN+BVgU
         ovLasIiD5CLY5A8lqr5DujGewgnw4s9Po+JOQIaIjemKxtH/xHpPh1BlVorU60CH2LrY
         5vVdAIaF+PsZiuxNnxB5o593wTtX43WPFJj7g+pEybNAGitdtlIKL4s2bsYoN4zb9o1h
         5Vxdlclr4u85yaSLVFwCAzXvterUMTPTxCL1CJxN2bn8YQ703cUvG3GnD6y1cVoPX4Tx
         84orphayihDLM7Z7tSRhTYrHUs1xPTJ7Igk1bBvtYjSOnHytP2JmP/v0SKFGDzEXSW5W
         IuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693849818; x=1694454618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rncWvuUlxPMD3w67Ey6ITQiyZ0HdBuQ5Y0WGNXnOpjc=;
        b=V6W2lJ6sJ8KRusWsSIMDczDLziTs4dwaZ7M53RsdrZVW8MsKG0tvQ2h0BmNSXNpIMo
         bzlmFrks2mn5HurBOh1sNB8OuLK0CZlpI/TqEU4FfXPcVgkPpFvDVJw3dyKfFH/UXt6O
         4/dmKXSbCMD38SfyLx8aSY56zTCU6RxVSMF+OgTfU+pVS+bHMh1vpaKGL2yI1yFB50vJ
         owTcivGoDPRMHeeT/8Q8v8J5NjMD5lIGBVYWk4avku3k8zn7vWLZ//CgfQLCvlqX/N5C
         R/lTRHq9IsHWboVxMhiti9LHUoGZTJp/wu0ebO/hc+hQguh7fLOeK5c+HyDnTXmOVK2w
         ixpA==
X-Gm-Message-State: AOJu0YxcQWyfOMj/hzVrqdvMtrwdJJpWC6xJkdsJ+TRPbvEExPwEBwMi
        lYNLypl1sTBxUcp9sfbbybCMUbhUWCHqxfO+NC2oAQ==
X-Google-Smtp-Source: AGHT+IHePbk13jgFsSUIOOucKm/bV2pYbL3ioyUIE3rbr5yIXNlexJJisBEOHvx1BbsoV9yZB2mI0wbfVLb4771OS9Q=
X-Received: by 2002:adf:f58f:0:b0:319:55bc:4416 with SMTP id
 f15-20020adff58f000000b0031955bc4416mr8462609wro.5.1693849818349; Mon, 04 Sep
 2023 10:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230901080935.14571-1-tinghan.shen@mediatek.com>
In-Reply-To: <20230901080935.14571-1-tinghan.shen@mediatek.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 4 Sep 2023 11:50:07 -0600
Message-ID: <CANLsYkzwfJv7Wh7GBzzOp1VoAUZDkroy9mWKO9hUtdDH4JxuHQ@mail.gmail.com>
Subject: Re: [PATCH v17 00/14] Add support for MT8195 SCP 2nd core
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sept 2023 at 02:09, Tinghan Shen <tinghan.shen@mediatek.com> wrote:
>
> The mediatek remoteproc driver currently only allows bringing up a
> single core SCP, e.g. MT8183. It also only bringing up the 1st
> core in SoCs with a dual-core SCP, e.g. MT8195. This series support
> to bring-up the 2nd core of the dual-core SCP.
>
> v16 -> v17:
> 1. add a comment in scp_add_multi_core() at patchset 8
>

I will add this patchset to my tree when rc1 comes out next week.

Thanks,
Mathieu

> v15 -> v16:
> 1. fix the checkpatch warning at patchset 1
> 2. move changes on scp_probe() to the new added patchset 6
> 3. revise platform_set_drvdata() at patchset 8
> 4. fix commit message at patchset 9
>
> v15 -> v14:
> 1. use the common SCP registers in struct mtk_scp_of_cluster instead of
>    copy it to struct mtk_scp at patchset 5
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
> Tinghan Shen (14):
>   dt-bindings: remoteproc: mediatek: Improve the rpmsg subnode
>     definition
>   arm64: dts: mediatek: Update the node name of SCP rpmsg subnode
>   dt-bindings: remoteproc: mediatek: Support MT8195 dual-core SCP
>   remoteproc: mediatek: Add MT8195 SCP core 1 operations
>   remoteproc: mediatek: Extract SCP common registers
>   remoteproc: mediatek: Revise SCP rproc initialization flow for
>     multi-core SCP
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
>  drivers/remoteproc/mtk_scp.c                  | 539 ++++++++++++++----
>  drivers/remoteproc/mtk_scp_ipi.c              |   4 +-
>  8 files changed, 656 insertions(+), 146 deletions(-)
>
> --
> 2.18.0
>
