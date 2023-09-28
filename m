Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313967B1737
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjI1JYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjI1JYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:24:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384AF195
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:24:39 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6193B6607336;
        Thu, 28 Sep 2023 10:24:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695893078;
        bh=90qF0JONfyTIpjPjha6pxFcSPf8q+bYBcasiV6AC/Lg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NvnPBOkADSUaW55IC8fDbA6G7I72J9az9eTx7GvhpdjNJDb1jvku8R8LRt4s6TbC8
         GkeMuciCmReU1Kq5qm8S1b3WwXL886siidlEZ8cjVvF9Pj/h2np7bGkleM0I+3NNPN
         uNGnpUIDz717uwbwMwbjJCckfdPReiG0XoqsKtBh4BwGj56soFBDAQMwjBHHlqAy/y
         t8CJeM60tq/sUuM9b/g++gojCw9OUjvsES2Qnjs/Qo6A9yhGjUh825f68K7ROrk8Tq
         /ahrpJp+wh+30R37uLVt3q0WTKQeRdpyQa0TCBHKc4SF4S9EOMLoXhP+4QzxF2wHpG
         rDaSYmK2/0Kcw==
Message-ID: <bde3f76a-6cc8-e92c-0b35-d6edbe87c014@collabora.com>
Date:   Thu, 28 Sep 2023 11:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v10 4/9] drm/mediatek: Add encoder_index interface for
 mtk_ddp_comp_funcs
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230927153833.23583-1-jason-jh.lin@mediatek.com>
 <20230927153833.23583-5-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230927153833.23583-5-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/09/23 17:38, Jason-JH.Lin ha scritto:
> To support dynamic connector selection function, each ddp_comp need to
> get their encoder_index to identify which connector should be selected.
> 
> Add encoder_index interface for mtk_ddp_comp_funcs to get the encoder
> identifier by drm_encoder_index().
> Then drm driver will call mtk_ddp_comp_encoder_index_set() to store the
> encoder_index to each ddp_comp in connector routes.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


