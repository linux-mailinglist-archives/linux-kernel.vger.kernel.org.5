Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2577BD5AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345552AbjJIIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345470AbjJIIvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:51:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E3AC;
        Mon,  9 Oct 2023 01:51:22 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7A803660708F;
        Mon,  9 Oct 2023 09:51:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696841481;
        bh=k9DxY2pZj9VNMIEbtEzEch2H2eOqQpTLPwo754uwNQI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bRARrHT/3htPKK0RbfsYILUajqJ8xnE4AfA8k4NWozgsApd7HnLzwhD4a1qVaSxv6
         nj76yiKGeYsvyn/M/OeYmgUKOh/hMl+uppMl6d3FPSGx2LKAvEL3c9sTrEl7ZsIqN2
         PgsNGQDhd7i1CE1YJZnE2Qet9yJUwIMwR2pOmRrh950giBGlAGhmd8xoSx0znxR9ml
         kP1jnzscbYxXk9zZd6SMaQbl1pWczeBfK1oKYtC+8J8A537eekbp3ek2JDqrZhc4kz
         zQr8OP+IiByFOcM0VcElQI9NdHe9YFMpV0XqXsCziRlR8nAtPdddxcQNs45IAkcy2w
         QOszP5mjsRvsg==
Message-ID: <85c73436-988e-2493-1b47-967481b279bd@collabora.com>
Date:   Mon, 9 Oct 2023 10:51:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/8] ASoC: mediatek: mt2701-cs42448: Convert to GPIO
 descriptors
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org
References: <20231006-descriptors-asoc-mediatek-v1-0-07fe79f337f5@linaro.org>
 <20231006-descriptors-asoc-mediatek-v1-2-07fe79f337f5@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231006-descriptors-asoc-mediatek-v1-2-07fe79f337f5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/10/23 15:46, Linus Walleij ha scritto:
> The driver is pretty straight-forward to convert to use GPIO
> descriptors, however a separate patch is needed to accept
> the DT GPIO resources ending with "-gpio1" and "-gpio2"
> instead of the standard "-gpio" or "-gpios" name convention.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

