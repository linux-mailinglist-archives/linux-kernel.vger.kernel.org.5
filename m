Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A1F764FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjG0JcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjG0Jbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:31:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A27F10CB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 02:22:44 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DDFCB660702D;
        Thu, 27 Jul 2023 10:22:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690449763;
        bh=S/wbNwp3nrSfYIJnj3igDnsaM+YXoYwXtjo1HiG2GSY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UeHMww9WHVwfwzRWImHwPNMGzQT6w3uY4WUBl3itguPwaAsQyhCIkLVcsr6LNGUCM
         cq1yGASbKjo2bYM1LiERIssfgP8hq3Rnkk9eN+PkkH1jF+4uzTtwRcJhFvzPq/XI73
         68Ht18QlmtjF18Y9oFcW+6fnDtO2Qcb2N4IskV8NPybKToDPUa7xmZgmjkm9+AAbTP
         MP8lSR8AZnXzoMJ+ZbehchOXAn6ILdIo2KQN+XJCU8pT2F4ju7WbJd6dOeqifmBUvD
         KvZDPQldI8hpv+rgj4FjSui5VWU82WzqMP+tDhn1Pc5mFERcn5wTnHgKyr4dLyVKG1
         mZNkCK0gzT56Q==
Message-ID: <040c1db8-4ae1-2a6c-ff58-282ed938e565@collabora.com>
Date:   Thu, 27 Jul 2023 11:22:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/mediatek: Fix potential memory leak if vmap() fail
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
References: <20230706134000.130098-1-suijingfeng@loongson.cn>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230706134000.130098-1-suijingfeng@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/07/23 15:40, Sui Jingfeng ha scritto:
> Also return -ENOMEM if such a failure happens, the implement should take
> responsibility for the error handling.
> 
> Fixes: 3df64d7b0a4f ("drm/mediatek: Implement gem prime vmap/vunmap function")
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


