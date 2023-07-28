Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E3B766915
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjG1JiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjG1JiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:38:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888F7173F;
        Fri, 28 Jul 2023 02:38:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7EFE26605835;
        Fri, 28 Jul 2023 10:38:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690537092;
        bh=x/NC9kRms1NVzTGvKisnxeIx9pk+AWAePM5eU3NJJEE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=cFsn/MCB70uY4rbKGJ8wTrwILnk7lT3fOOncZ8C8E4B95hFd23zxEUYEobQOWvDRG
         MCOI6OpNFHN5h1baDmQO2d5zHnzLbxyPAbiApr7rQrHFkZANZCNJZrcqLNsrMg7kH0
         XuO2p5lJslgF1X6KyAfwHBeHVZIxp+dp3ljoWERIm4qEjRESjn0jbfPOmM+KCn8b2V
         kErrCb7mhiICxvUNLPQIXq6pZwsJ7QHphPn2oCw/oRTJGxqjQfu3s8WuuEoXI0yFgh
         od5aNQkQEA3/0N53GWxqHm4GWQLWAvLSlDnNWUkrPf6iZrRz9n4u1FoGx+JMuR5G0R
         y8OWTa3enGTcA==
Message-ID: <4eb32bcc-9a1b-c477-71b1-823bd96c0450@collabora.com>
Date:   Fri, 28 Jul 2023 11:38:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/6] ASoC: mediatek: mt7986: add platform driver
To:     Maso Huang <maso.huang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230728090819.18038-1-maso.huang@mediatek.com>
 <20230728090819.18038-4-maso.huang@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230728090819.18038-4-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/07/23 11:08, Maso Huang ha scritto:
> Add mt7986 platform driver.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> ---
>   sound/soc/mediatek/Kconfig                 |  10 +
>   sound/soc/mediatek/Makefile                |   1 +
>   sound/soc/mediatek/mt7986/Makefile         |   8 +
>   sound/soc/mediatek/mt7986/mt7986-afe-pcm.c | 622 +++++++++++++++++++++
>   4 files changed, 641 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt7986/Makefile
>   create mode 100644 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c
> 

..snip..

> +	/* register component */
> +	ret = devm_snd_soc_register_component(&pdev->dev,
> +					      &mt7986_afe_component,
> +					      NULL, 0);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "err_platform\n");

I know I only said about using dev_err_probe(), but "err_platform" doesn't
mean anything!

Please write a human readable error message, like "Cannot register AFE component\n"

> +
> +	ret = devm_snd_soc_register_component(afe->dev,
> +					      &mt7986_afe_pcm_dai_component,
> +					      afe->dai_drivers,
> +					      afe->num_dai_drivers);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "err_dai_component\n");

And the same here, "Cannot register PCM DAI component\n"

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
