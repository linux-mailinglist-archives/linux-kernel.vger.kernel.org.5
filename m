Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6793767EB3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjG2L3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjG2L3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:29:42 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEC2E6F
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 04:29:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-317798b359aso2768827f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690630173; x=1691234973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yl2EKCv4YXbcjRsX9gIcMNI5UcqTI5Buzhhnk6Ju+qU=;
        b=P7noIDsXbNnRhgZ1Mg3Z6aypdp1IfKBXuSfbDb6P+Y4WdJIRu8DanXwPlS9AVO2hbT
         jZ3NSkpiAR1i89IgUTyjN0WwgAo5BPK9pt+yrIN8+CvZEi/QPZCmQNhwNX0VgskvMikR
         0yYM504A/wqMl/1wf2sPqb7JrsLSrPJoripGqlv9ePgBnR5yDVPE08vx/4GGmcOcjlr/
         PG05+rkdkWJfPT+1ldi96YIqim1KM421qUQGQinyuPZ7GJ59f7u6cinCMtKr7Yn7nA6C
         T2S8U1WNRMlyKUVpUvA3bq1wxPXG7xld7mWMIvZxM4k/Xd5HrE6FBng13CfT0vwlIDVx
         /LuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690630173; x=1691234973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yl2EKCv4YXbcjRsX9gIcMNI5UcqTI5Buzhhnk6Ju+qU=;
        b=b4/2S1QwfiYAG8wqYaATEx3ozd1sKpx7QbI4evYYOkcnA70gwiI2CNtu6pLYR2V0YZ
         knqzWER9WuZ55rp/itPgA05tPM/lffLu55Qac1EeeqVyaAzl99RTkTulWwtAReCg5Pvu
         foRmEtbQllM+IFDaQ0x5aWRjFrVLEC60Gg6H7TH9STM7AHOrCllkLyHdTAY7p4QniLKO
         YMVqm1LDG4BJfce7iQlfiN259KJ51SWTasZxpsa9wtgGbKraiS+bhPxewrj2H8I3hYzi
         d0ft6CnRsOtzMnQ64KmkyF/pTb/cfJhQOn9Z4mHi443wJKzY2BLlW27xrPTKiu38yp3F
         CiOA==
X-Gm-Message-State: ABy/qLZteOwnX9pCuoUl9bMj9zh3nmn9ijG14uE7oy9Mb4bqvysLLeJC
        CiYXNTDX1mQHrOBRyHUwi7Delg==
X-Google-Smtp-Source: APBJJlEy4rj/lqQ6TbWxXc1ZF0trMQbNs5KXGdjrzM2nkfjDzE3xUyG1e4YjtrkMvWKeBrYRYVhf0g==
X-Received: by 2002:adf:fa09:0:b0:317:3deb:a899 with SMTP id m9-20020adffa09000000b003173deba899mr3659091wrr.1.1690630172870;
        Sat, 29 Jul 2023 04:29:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z8-20020adfec88000000b0031773a8e5c4sm7224137wrn.37.2023.07.29.04.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 04:29:32 -0700 (PDT)
Message-ID: <c4cc2dfa-ca3f-1d51-8a3b-a131ccc54d03@linaro.org>
Date:   Sat, 29 Jul 2023 13:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V3 5/5] ASoC: codecs: aw88261 chip register file, Kconfig
 and Makefile
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.com, shumingf@realtek.com,
        ryans.lee@analog.com, 13916275206@139.com,
        herve.codina@bootlin.com, ckeepax@opensource.cirrus.com,
        doug@schmorgal.com, fido_max@inbox.ru, povik+lin@cutebit.org,
        liweilei@awinic.com, yijiangtao@awinic.com, colin.i.king@gmail.com,
        trix@redhat.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zhangjianming@awinic.com
References: <20230729091223.193466-1-wangweidong.a@awinic.com>
 <20230729091223.193466-6-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230729091223.193466-6-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2023 11:12, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Mainly includes aw88261 register table, Makefile and Kconfig.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  sound/soc/codecs/Kconfig               |  15 +
>  sound/soc/codecs/Makefile              |   3 +
>  sound/soc/codecs/aw88261/aw88261_reg.h | 374 +++++++++++++++++++++++++
>  3 files changed, 392 insertions(+)
>  create mode 100644 sound/soc/codecs/aw88261/aw88261_reg.h
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index c2de4ee72183..1e3526812cc8 100644
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
> @@ -640,6 +641,20 @@ config SND_SOC_AW88395
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
> +	  This option enables support for aw88261 Smart PA.
> +	  The awinic AW88261 is an I2S/TDM input, high efficiency
> +	  digital Smart K audio amplifier. The output voltage of
> +	  boost converter can be adjusted smartly according to
> +	  the input amplitude.
> +
>  config SND_SOC_BD28623
>  	tristate "ROHM BD28623 CODEC"
>  	help
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index b48a9a323b84..9df43de213f0 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -49,6 +49,8 @@ snd-soc-aw8738-objs := aw8738.o
>  snd-soc-aw88395-lib-objs := aw88395/aw88395_lib.o
>  snd-soc-aw88395-objs := aw88395/aw88395.o \
>  			aw88395/aw88395_device.o
> +snd-soc-aw88261-objs := aw88261/aw88261.o \
> +			aw88261/aw88261_device.o
>  snd-soc-bd28623-objs := bd28623.o
>  snd-soc-bt-sco-objs := bt-sco.o
>  snd-soc-chv3-codec-objs := chv3-codec.o
> @@ -431,6 +433,7 @@ obj-$(CONFIG_SND_SOC_ARIZONA)	+= snd-soc-arizona.o
>  obj-$(CONFIG_SND_SOC_AW8738)	+= snd-soc-aw8738.o
>  obj-$(CONFIG_SND_SOC_AW88395_LIB) += snd-soc-aw88395-lib.o
>  obj-$(CONFIG_SND_SOC_AW88395)	+=snd-soc-aw88395.o
> +obj-$(CONFIG_SND_SOC_AW88261)	+=snd-soc-aw88261.o
>  obj-$(CONFIG_SND_SOC_BD28623)	+= snd-soc-bd28623.o
>  obj-$(CONFIG_SND_SOC_BT_SCO)	+= snd-soc-bt-sco.o
>  obj-$(CONFIG_SND_SOC_CHV3_CODEC) += snd-soc-chv3-codec.o
> diff --git a/sound/soc/codecs/aw88261/aw88261_reg.h b/sound/soc/codecs/aw88261/aw88261_reg.h
> new file mode 100644
> index 000000000000..7ef128a3e6ee
> --- /dev/null
> +++ b/sound/soc/codecs/aw88261/aw88261_reg.h
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: GPL-2.0-only

If you add the headers now, it means they are not used in any previous
patches. Therefore drop the header - it is useless.

Best regards,
Krzysztof

