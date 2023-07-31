Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A0F7697B5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjGaNfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjGaNfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:35:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81E0170A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:35:19 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E56EC6606FD9;
        Mon, 31 Jul 2023 14:35:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690810517;
        bh=vXYdwuWWssmuPwqUqCNDUS6WYl7HIDaFQxEbS2ZYzH0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jO2JHy7n1CCI+MkmkIVqAgz4PNh61jcXkFQb66KzT/xDlFGZ+LU1DyoikiYVWjU/I
         Eml2fnnNVguX7xXwEW3i+en8wZq86SeJSqZato8HOMB5H3wjnrUW9ev3hnmiRYaJOy
         b4TfWAYgkYmNYuCoYbZhTLLjzxSx0ImX3A8+53m5W7jIGbBBHfHVVhaSynQXjgrxGt
         /gNrXOzu6J1yj7GhWAS1bDsVSn+eSAFI/IdWtJwY9FSem1/jE3sWaWbtYAdCs+bzEp
         bFwlVNYC1q/ZUWmwAfaCSD+R9wZRsGsRTDX2bHd73DM4789qG/Wvkb3KE5MLl2QJIm
         djbkgGr70V4fg==
Message-ID: <3c6f6ca4-c563-525e-e773-3539678956ae@collabora.com>
Date:   Mon, 31 Jul 2023 15:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] ASoC: mediatek: mt8188-mt6359: support dynamic
 pinctrl
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230725035304.2864-1-trevor.wu@mediatek.com>
 <20230725035304.2864-2-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230725035304.2864-2-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/07/23 05:53, Trevor Wu ha scritto:
> To avoid power leakage, it is recommended to replace the default pinctrl
> state with dynamic pinctrl since certain audio pinmux functions can
> remain in a HIGH state even when audio is disabled. Linking pinctrl with
> DAPM using SND_SOC_DAPM_PINCTRL will ensure that audio pins remain in
> GPIO mode by default and only switch to an audio function when necessary.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


