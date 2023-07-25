Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2958761D18
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjGYPPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjGYPPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:15:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151A919BA;
        Tue, 25 Jul 2023 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=mYmfoCdflZ9uHA5txqbILukt8Ar2VVGNn6p5XL0M74c=; b=Z0QafXBY9g7/F8RhSqaEe5YZJH
        VwZdQaj/KqdXcx4sTag58JbhWnT09v8dwx1+7N816ztPp4sVJISvCg1ZxCvXwmUhSginMUOmuCZMS
        GY6lVyPtJYpRb9BPB+xhggWXjYetlOshGlx8DbNqHEjChWsq1LFY83hSGZXJ1U/IB9Ev8X6nXEHz0
        CHAG2uRdHea8Zxbs9SgTk56p9eaDV5E+/NnZyGKc1aaV59zbV40ky/EhuXXM3BPvQpRDwOWMhOE8Y
        2lO1jGhdlKyumMevKErHr9G73KY/LsqECnQwPb7Oo3VmqUT7zCHa9tlMvf9XNp+te9kf4x21+rERw
        WWN7NQBw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOJjv-007taN-1z;
        Tue, 25 Jul 2023 15:14:19 +0000
Message-ID: <6cc4f622-0e83-cd49-73d7-06ad90a3f5d8@infradead.org>
Date:   Tue, 25 Jul 2023 08:14:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V2 4/4] ASoC: codecs: aw88261 chip register file, Kconfig
 and Makefile
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.com, shumingf@realtek.com,
        povik+lin@cutebit.org, 13916275206@139.com,
        herve.codina@bootlin.com, ryans.lee@analog.com,
        ckeepax@opensource.cirrus.com,
        ajye_huang@compal.corp-partner.google.com,
        sebastian.reichel@collabora.com, yijiangtao@awinic.com,
        trix@redhat.com, colin.i.king@gmail.com, liweilei@awinic.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhangjianming@awinic.com
References: <20230725115649.67560-1-wangweidong.a@awinic.com>
 <20230725115649.67560-5-wangweidong.a@awinic.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230725115649.67560-5-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/23 04:56, wangweidong.a@awinic.com wrote:
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index c2de4ee72183..ab21ad20978f 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -55,6 +55,7 @@ config SND_SOC_ALL_CODECS
>  	imply SND_SOC_ALC5632
>  	imply SND_SOC_AW8738
>  	imply SND_SOC_AW88395
> +	imply SND_SOC_AW88261
>  	imply SND_SOC_BT_SCO
>  	imply SND_SOC_BD28623
>  	imply SND_SOC_CHV3_CODEC
> @@ -640,6 +641,18 @@ config SND_SOC_AW88395
>  	  digital Smart K audio amplifier with an integrated 10V
>  	  smart boost convert.
>  
> +config SND_SOC_AW88261
> +	tristate "Soc Audio for awinic aw88261"
> +	depends on I2C
> +	select CRC8
> +	select REGMAP_I2C
> +	select GPIOLIB
> +	select SND_SOC_AW88395_LIB
> +	help
> +	  this option enables support for aw88261 Smart PA.

	  This

> +	  The awinic AW88261 is an I2S/TDM input, high efficiency
> +	  digital Smart K audio amplifier.

-- 
~Randy
