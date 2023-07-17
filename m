Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160BE756E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGQUk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGQUkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:40:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC7F1B0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:40:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9936b3d0286so705441566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689626453; x=1692218453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qsbuf3RPbQPVf+4WdMEnUAqNMgaL0d1YoOJRV82aCKA=;
        b=zS4AGQ1OhUBgX67e8EsFP0sJibDRDHW6Lb+3fISsRExE//XBJ/vSXstkv0nlJOnuC0
         WEsQAN4JBXWjriJupy+P2TSh+O33xP2XYHLxbauifss08CmcCj7w4eiIAhKkU7dbt5HN
         FiR/JHedjlZtN10fs6Cz0d1WqGjBC1Duv1+bLF9VmVhY4hnBwK7mLH+pD6l6V2c9EpRS
         AcOT38EHV43sFx8ev/IpCJGO4DJ/97kpBPzv07jMbHwjC9iRcwGI+mriSnSW3kl25z7v
         zUinoqgrNQdNuZ5MStxDcA9tchmWNYtJbhNFZWwn75YuwH0jloCxmc8e1K4TZoAo/GON
         8TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689626453; x=1692218453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsbuf3RPbQPVf+4WdMEnUAqNMgaL0d1YoOJRV82aCKA=;
        b=WrIAXMAUofK+85H1AkV6a8LcLnNYZQOX+KXvpDXsDBum2HmAD1Z/rZKtGB2oFa+N4i
         jTfmuE5aeJ84NUEXzVBLFBlAlaqq/oe5YQL7189hLsFuPDVGbbH9wjsm74QVcFWRvIx6
         GlvqRKpUF3581ricuzLWLfhlxcZP89SonqgM1TPwBJfowiynhZ3t40M7V9wVTijcNyi/
         y9NwiB3CjfHr/E6y4WaI+oSnhWOX/iI10DLyH4mlqjBg/wyhourDXKnxhqA6TWfeKE45
         b4wS5FziLGM839bgGhrbmzeUQr5pwfFufQxVeUTqS7LGCO/bUjcbinMZ3k3tn87BZ7sB
         VWQw==
X-Gm-Message-State: ABy/qLY9v7HOm53kQo6+6p3VSOPGumzvMDDnJJXugDkuMk5FtnDi7U5I
        zDAUrh7aM7dl/xhp83wBSN/A7g==
X-Google-Smtp-Source: APBJJlGZqwMGrv/lBAVXmEwqvyCbJpsT6m6ffvhLAi5J1UvzCHfarcHAvYwQAXY5sZryz5PYEfGn5A==
X-Received: by 2002:a17:906:2201:b0:98d:fc51:b3dd with SMTP id s1-20020a170906220100b0098dfc51b3ddmr11477113ejs.41.1689626453324;
        Mon, 17 Jul 2023 13:40:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w21-20020a1709064a1500b00997d76981e0sm104654eju.208.2023.07.17.13.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 13:40:52 -0700 (PDT)
Message-ID: <98292541-8435-53cb-22d9-716ed6541485@linaro.org>
Date:   Mon, 17 Jul 2023 22:40:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1 3/5] ASoC: codecs: ACF bin parsing and check library
 file for aw88261
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.co, shumingf@realtek.com,
        herve.codina@bootlin.com, flatmax@flatmax.com,
        ckeepax@opensource.cirrus.com, doug@schmorgal.com,
        fido_max@inbox.ru, pierre-louis.bossart@linux.intel.com,
        kiseok.jo@irondevice.com, liweilei@awinic.com,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yijiangtao@awinic.com, zhangjianming@awinic.com
References: <20230717115845.297991-1-wangweidong.a@awinic.com>
 <20230717115845.297991-4-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717115845.297991-4-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
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

On 17/07/2023 13:58, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> The AW88261 is an I2S/TDM input, high efficiency
> digital Smart K audio amplifier with an integrated 10.25V
> smart boost convert

So all your commits are doing the same?

> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  sound/soc/codecs/aw88261/aw88261_lib.c | 997 +++++++++++++++++++++++++
>  sound/soc/codecs/aw88261/aw88261_lib.h |  91 +++
>  2 files changed, 1088 insertions(+)
>  create mode 100644 sound/soc/codecs/aw88261/aw88261_lib.c
>  create mode 100644 sound/soc/codecs/aw88261/aw88261_lib.h
> 
> diff --git a/sound/soc/codecs/aw88261/aw88261_lib.c b/sound/soc/codecs/aw88261/aw88261_lib.c
> new file mode 100644
> index 000000000000..b8f00708dacf
> --- /dev/null
> +++ b/sound/soc/codecs/aw88261/aw88261_lib.c
> @@ -0,0 +1,997 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +// aw88261_lib.c  -- ACF bin parsing and check library file for aw88261
> +//
> +// Copyright (c) 2023 awinic Technology CO., LTD
> +//
> +// Author: Jimmy Zhang <zhangjianming@awinic.com>
> +// Author: Weidong Wang <wangweidong.a@awinic.com>
> +//
> +
> +#include <linux/crc8.h>
> +#include <linux/i2c.h>
> +#include "aw88261_lib.h"
> +#include "aw88261_device.h"
> +
> +#define AW88261_CRC8_POLYNOMIAL 0x8C
> +DECLARE_CRC8_TABLE(aw_crc8_table);
> +
> +static char *profile_name[AW88261_PROFILE_MAX] = {

Cannot be const char *?

...

> +EXPORT_SYMBOL_GPL(aw88261_dev_load_acf_check);

Why?



Best regards,
Krzysztof

