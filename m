Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AD57D313D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjJWLHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjJWLHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:07:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB78FD7E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:07:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D3796606F51;
        Mon, 23 Oct 2023 12:07:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698059225;
        bh=H1B9KGgQAiRUFMaOD7pDr+fGSwuRs81e04oqqbnXjZ0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=TMmCx2aKkdcBER4WpXQVelH7qKmezHjQUJy5COnfDn6OHB3zqBVlTo9CVwPKEo3IS
         VpaTwSsPGsCPN6AiPa/NHfebcyOfP4awZmHhbZK/HcohNASZ0VyN51NhiSJ/qNyUAy
         OPklcHBMBhh+wadySMo+ufaI/n4ANhf5+q8SrQN52toT02g5dMVQi8xWCbRWgSXV4+
         y9gJClwIYYgjwiRgylhJ8Y59IkUpeV+HoZskBcZYGF3HCewS9eR8L/6sFe4k2LC7Lj
         P7uBU41qCXV2IE3JvdBfsa8zfSJSaDzkLvu3UGtQTxWVjFMG6YnL3i6CXltevycI1V
         XAII2clCo2drA==
Message-ID: <07af235a-c6d5-4d8d-9b44-ff7157e2a80c@collabora.com>
Date:   Mon, 23 Oct 2023 13:07:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: mediatek: mt7986: remove redundant remove
 function
Content-Language: en-US
To:     Maso Huang <maso.huang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231023095453.4860-1-maso.huang@mediatek.com>
 <20231023095453.4860-2-maso.huang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231023095453.4860-2-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/10/23 11:54, Maso Huang ha scritto:
> Remove redundant remove function of mt7986-wm8960.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>

You're doing more than what you're advertising; you are:

1. Dropping the remove callback; and
2. Removing the mt7986_wm8960_priv structure

You can do that in one single commit if you really want to, but you have to
use the appropriate commit title and description, saying exactly what you're doing.

Regards,
Angelo

