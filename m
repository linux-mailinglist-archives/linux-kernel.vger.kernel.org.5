Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAD07BD5BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345606AbjJIIvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345590AbjJIIvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:51:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FDFE9;
        Mon,  9 Oct 2023 01:51:30 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E9D1D66072A7;
        Mon,  9 Oct 2023 09:51:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696841488;
        bh=MPdLVb/pvOTZLkwQXRDilr3q3ShdQdO9Sr5gzkHwXDs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jJ/dDJsKYGIO7JPg7gDYbl5cO1tGQ54DIuLQSnO2Gbza9F0vf5+Y3eDd8SIlg1kNn
         HRT18v12JJTvSgBz77n9QcIzmp1Sxt/CliQXn4bAZg90Zodi5C0W3qA89BmWJDp/F7
         b04d59JxjEqe48xEqBAMvjvg8A/NbEetEREK22AfsIzPyoG7AWnGLEajMk9mK+l1dz
         Gxi+NVU7QhhqH4Jn4Ogf/IirSSHrUFIcNRAaMzs/cZl4CVGiMUidhe2LkQ30cg5D3k
         A7JdL9/1XI/1ZLCJeNHYBA13x1hNfNCMkDLlX/WQ1XAFNhJANxbAaAfmOggRTFSLq6
         mAFp6pdpwn68Q==
Message-ID: <d8fd9384-4db2-014c-c0fe-5cb150cb20ac@collabora.com>
Date:   Mon, 9 Oct 2023 10:51:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 7/8] ASoC: mt8186-mt6366-rt1019-rt5682s: Drop unused
 include
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
 <20231006-descriptors-asoc-mediatek-v1-7-07fe79f337f5@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231006-descriptors-asoc-mediatek-v1-7-07fe79f337f5@linaro.org>
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
> This driver includes the legacy GPIO header <linux/gpio.h> but
> is not using any symbols from it. AFE has a custom GPIO
> implementation that is not using the kernel GPIO framework,
> so it need not include it either.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

