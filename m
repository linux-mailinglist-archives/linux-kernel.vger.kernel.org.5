Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D401C7CDBB6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjJRMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjJRMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:32:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62AD131
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:32:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32caaa1c493so5307298f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697632319; x=1698237119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6AC1mpiZBXNStM7oB6tiEEIW9Gl/xCSO0XdtqP4r9QI=;
        b=L8d22yItLcD3kvHroT+xoauIb5VK1vhzjtzeVDcoK2ailNPr2Bu9eLvoBgfW8TQe8N
         +hrIHtnHlhFoHLBRuhbOUpsT52VFVh/kvQ8+a5gb5lKraimWVS8josNmrObjjFMuwnQ+
         mfeD9XTIEXX6Nj3pqhTXW+XLCzb16MUu58oJnLYzuV/mm748AX09EphEcWo34zDHy+Zy
         8LnOQbWt5Bcq0AZTKEi+2uDHQnmfbGe5sYAQxnsyriGw4JkqF0e6rjeNGeC1nEC3/j8i
         tRSggVRRYoQY48Wwr/IXQPqjfahXGfAB1bTugb7iIto4qDD+d9RRWhot4RsW7Z9f1jr5
         wlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632319; x=1698237119;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AC1mpiZBXNStM7oB6tiEEIW9Gl/xCSO0XdtqP4r9QI=;
        b=CvAohKGzMw9mf5AnVv3BqTkXBV4z2trba2j0b19+O7fWZT+yu0aBrXIZ1rCaDLFrL9
         T0Y0+8+RIMAQ3QK2Gbcqb2CgGQjtdsxE3h/cN6bCqssPBcDJBkXCpuUNXTUCM7bSi97n
         UdtnPEmdLTljesAIRhMHM31a6hm9jLapBiqa8OFwTBiljW9FU/Ai/mFO1EaZcIcZpftX
         W0j2XyRgYCgPz/Chxb2IQhZTy+DHTsGFtzcdyz2JPN1FdHp+28SSGgBc3Ctl5Wl3o/j9
         MUOotaYTpZOJS3SYIpO3g+oy+B5Ycv6x4huZSNzMUFDEEFAOjGF8Oskj09yV+5hgBJiy
         GROA==
X-Gm-Message-State: AOJu0YzqJ0xJELpB9qJOxzVL7r4Ix7dVrpAWoidVB3Q5mT48L0T9+KsC
        zVoaEM96sdK0EqJilJ3t1174cWUXNsGIpzl3fa0=
X-Google-Smtp-Source: AGHT+IEKMMvf8PONXEFDRXM1+Ut4jcSZzuPmhpwwTC3gqdN5yY4vrMDr8Q0HEGp6r2Od+KtpVcDcVQ==
X-Received: by 2002:a5d:508f:0:b0:32d:8469:4f64 with SMTP id a15-20020a5d508f000000b0032d84694f64mr3502040wrt.18.1697632319170;
        Wed, 18 Oct 2023 05:31:59 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id b17-20020a05600010d100b003197869bcd7sm2021292wrx.13.2023.10.18.05.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 05:31:58 -0700 (PDT)
Message-ID: <34d784f2-92d4-e06b-3596-36cf0d048f35@linaro.org>
Date:   Wed, 18 Oct 2023 13:31:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ASoC: codecs: wsa884x: allow sharing reset GPIO
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20231018100055.140847-1-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231018100055.140847-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/10/2023 11:00, Krzysztof Kozlowski wrote:
> On some boards with multiple WSA8840/WSA8845 speakers, the reset
> (shutdown) GPIO is shared between two speakers.  Request it as
> GPIOD_FLAGS_BIT_NONEXCLUSIVE to allow such configurations.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
>   sound/soc/codecs/wsa884x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
> index 993d76b18b53..bee6e763c700 100644
> --- a/sound/soc/codecs/wsa884x.c
> +++ b/sound/soc/codecs/wsa884x.c
> @@ -1844,7 +1844,7 @@ static int wsa884x_probe(struct sdw_slave *pdev,
>   		return ret;
>   
>   	wsa884x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
> -						GPIOD_OUT_HIGH);
> +						GPIOD_FLAGS_BIT_NONEXCLUSIVE | GPIOD_OUT_HIGH);
>   	if (IS_ERR(wsa884x->sd_n))
>   		return dev_err_probe(dev, PTR_ERR(wsa884x->sd_n),
>   				     "Shutdown Control GPIO not found\n");
