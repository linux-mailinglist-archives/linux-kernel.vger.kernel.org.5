Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648F47A19E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjIOJE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjIOJEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:04:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF34E49EC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:03:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBCFC433C8;
        Fri, 15 Sep 2023 09:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694768488;
        bh=C6/KXGgH6tHW8U29QI5yRNYeBy8iAPkFYoHh2nhVIeE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WPvuu1ayMIwkplILF+8RvITgsrg7/Wvs1Iwc3LHh1mIXGDDRUhm/tfbWc+4lyGnKN
         CNQYy9b842a0bcuKVnkc21PyOp6bxS+PFZYOiC+o/DB5aHsHYUQFP6J19cnMx/Vlrj
         X5l34f0piINXbj9eckckZWtIHDucJDC7kkQDMjrI2Nde6wzpLUZb3S3vs2YE4wozMq
         /QPNt5DTjMrDqSanhH7n2ADwUcjLMQxBeY3HqGKf6aL3ShkHaWx3ScPToYTMdRw6WQ
         MqVON4LDNJXTpFK8EgCGq+IIOcJ7oLsMB6foNFveqhgxArQ/IBiu5IEHwK8xNOh9uG
         mAlfV32+fAeyg==
MIME-Version: 1.0
Date:   Fri, 15 Sep 2023 11:01:24 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/mediatek: dsi: Fix EOTp generation
In-Reply-To: <0a184b35-133b-483c-d475-01120fbdc2ca@collabora.com>
References: <20230915075756.263591-1-mwalle@kernel.org>
 <0a184b35-133b-483c-d475-01120fbdc2ca@collabora.com>
Message-ID: <eb1f4f78be9b2da3ae2d54ec9417f2f7@kernel.org>
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

Hi,

Am 2023-09-15 10:58, schrieb AngeloGioacchino Del Regno:
> Il 15/09/23 09:57, Michael Walle ha scritto:
>> The commit c87d1c4b5b9a ("drm/mediatek: dsi: Use symbolized register
>> definition") inverted the logic of the control bit. Maybe it was 
>> because
>> of the bad naming which was fixed in commit 0f3b68b66a6d ("drm/dsi: 
>> Add
>> _NO_ to MIPI_DSI_* flags disabling features"). In any case, the logic
>> wrong and there will be no EOTp on the DSI link by default. Fix it.
>> 
>> Fixes: c87d1c4b5b9a ("drm/mediatek: dsi: Use symbolized register 
>> definition")
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
> 
> Hello Michael,
> your commit is missing a small piece! :-)
> 
> Besides, I've already sent a fix for what you're trying to do here:
> https://lore.kernel.org/linux-arm-kernel/07c93d61-c5fd-f074-abb2-73fdaa81fd65@collabora.com/T/

Ahh thanks, didn't noticed this. If not already applied, I'll send
a Tested-by: later.

Please disregard this patch then.

-michael
