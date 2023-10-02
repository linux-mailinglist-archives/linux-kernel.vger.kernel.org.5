Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAD67B5171
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbjJBLeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbjJBLeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:34:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99062BF;
        Mon,  2 Oct 2023 04:34:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 68B1F66071CC;
        Mon,  2 Oct 2023 12:34:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696246445;
        bh=9t/jOl0Thy1T1dExt2YlwpxckJSmjnulYz343ekqiOU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=c2UwnXYA6v1PGmWdlFewrB37q0sywfNvyFg/94NAuO8wbPvLH88UGuTUTvoP0V834
         7iRcR/wpx1DwUXyaST2eBbGrr/9mZOs8nHeLqt37i8mI3aMQL4ILhnukzUtVXaWAVe
         pI8FCG73fK29CrveqlNc8AVBT04GLz0gjHEj9SU/7txpy1rHU0Ljq41bsB+PInh3+8
         OUBuVwUlm8ZZu+VoxRgChPQuPeOPtcvv+FRd93B/3uKyFFNzs/zVIbGFgnFyLYWSqS
         oIjGAVYoHCCAyh/NWulz/WO8fNRytQRf9jBAmt8YhM+VU7mBzbB1/g0CMVgkJK5KUu
         No3ozYeZGszNg==
Message-ID: <7e6fb959-9e0e-ad08-c33a-92cc86eec2d0@collabora.com>
Date:   Mon, 2 Oct 2023 13:34:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] media: mediatek: vcodec: Handle encoder vsi NULL
 pointer case
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        nicolas.dufresne@collabora.com,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Maoguang Meng <maoguang.meng@mediatek.com>
References: <20230926101909.15030-1-irui.wang@mediatek.com>
 <20230926101909.15030-2-irui.wang@mediatek.com>
 <633d4544-e215-2742-a4c0-81698607e830@collabora.com>
In-Reply-To: <633d4544-e215-2742-a4c0-81698607e830@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/10/23 12:48, AngeloGioacchino Del Regno ha scritto:
> Il 26/09/23 12:19, Irui Wang ha scritto:
>> There will be a kernel null pointer exception if 'vsi' is NULL, check
>> 'vsi' is not NULL before assign it to encoder instance.
>>
>> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

Sorry I just noticed that there's no Fixes tag.

This commit needs a Fixes tag, please add one and send a v2.
