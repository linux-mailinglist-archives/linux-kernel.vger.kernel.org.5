Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF3E7BD5AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345571AbjJIIv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345540AbjJIIvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:51:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C917AC;
        Mon,  9 Oct 2023 01:51:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4AF27660716C;
        Mon,  9 Oct 2023 09:51:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696841482;
        bh=AeV4F+YxzIjrv5/reJdTrfUYSuarpl9kOSA1kuEAPvM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C0fx5MLHjUZ5LPSlk6G1axwyJy0cOqyKNZ52QU6lB43BTBR0w0Mf7fjyUyON7X6H+
         TKUnseRy62LLKr9BPLlejzLwT53I/XgvNNxfkkc5A9mewZd1tLHHFwF9PEXM48chFe
         Z5w6QWRFgGPai6iV2dnoN/ojzmI+WT3ugpjIdLLlTmXzaiuob7RhvaIhbDSZXby/Pe
         6KZousTG9vwzBtpwb2Pu75Veo4pc2hAWE8z3A/9zb56bB+t4pRtmVuC60UKU5RN5a8
         7cDpfFVf6M3EUqOONlJjhPiq2hIwvBrB7wPQNZ7l9hNhod8O/O9UW2Wdke2vXdbXfg
         YFbyQYJAGyibA==
Message-ID: <dfcd36ac-712b-5169-5320-0e1591107252@collabora.com>
Date:   Mon, 9 Oct 2023 10:51:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/8] gpiolib: of: Add quirk for mt2701-cs42448 ASoC sound
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
 <20231006-descriptors-asoc-mediatek-v1-1-07fe79f337f5@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231006-descriptors-asoc-mediatek-v1-1-07fe79f337f5@linaro.org>
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
> These gpio names are due to old DT bindings not following the
> "-gpio"/"-gpios" conventions. Handle it using a quirk so the
> driver can just look up the GPIOs.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

