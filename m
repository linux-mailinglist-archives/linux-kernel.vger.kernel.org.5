Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A065978DFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243891AbjH3TNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243415AbjH3K4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42D31BB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F8FD60FCA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0459C433C7;
        Wed, 30 Aug 2023 10:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693392960;
        bh=Qmj5BFfzATwiV9vaUhtiqnZF81rYO34Lo+8rLqUFuRQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PPgfgzXj75LN3zMV5Fa2zBOZc5G5C3Gj7mYPrwl+CnzU26tuqtCMonnL6DNAvzV79
         PKYHXvtsxWDL0tb2L4itEOPSbwFK6xOYcdm3oyX7LxnL8epupDsf1b4pbUH8DWBO73
         VrAFRwHyNhr7Ap6UruV3O/Jaw3Mtk3JshOJO6hiaAMQBa5B+SboXuavA+8N55zlb8u
         Jb3ZG7Clkebd0Vl2GIArs/gyLB1Yv0ks0fTaXsgzTPGugfl/demP9SzWCslB1aN80K
         AA5OKwqoeEsASc9/I1/4jYmdR69jse6lyT6Nopf6zk++vqhxbOF9Nlu3EWXswqzTSm
         3J/PRWID5ZfDQ==
MIME-Version: 1.0
Date:   Wed, 30 Aug 2023 12:55:55 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] drm/mediatek: dpi/dsi: fix possible_crtcs calculation
In-Reply-To: <fca464b9-9f32-4420-90fd-05e851871c25@notapiano>
References: <20230829131941.3353439-1-mwalle@kernel.org>
 <20230829131941.3353439-2-mwalle@kernel.org>
 <fca464b9-9f32-4420-90fd-05e851871c25@notapiano>
Message-ID: <acec69f943f85b02909d8ce3e4d538c3@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This won't work. On MT8195 there are two display IPs, vdosys0 and 
> vdosys1,
> vdosys0 only has the main path while vdosys1 only has the external 
> path. So you
> need to loop over each one in all_drm_private[j] to get the right crtc 
> ID for
> MT8195.

Ahh thanks, got it.

-michael
