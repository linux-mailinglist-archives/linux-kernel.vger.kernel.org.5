Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B8A79E05E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbjIMHDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbjIMHDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:03:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086F51738
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:03:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a9cd066db5so827180366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694588592; x=1695193392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZ3zQjFWjU6aUGv1M6ufEZQD2GEy4rVqeEvdZE7HUcU=;
        b=jq0kW61GkgjrwMMrGaZpebWkJDASoHyDsSDQmYI1EDZueOPZIzRRHhU5dGS1laGoqJ
         sPqXtMGhxy1ZhqkyXVbpoCsFe69O5ryxI6TNJRL4LZ6VnrLTIzN2etslAin6Uu7t++Fx
         6+xJw13xwCv5cZAIILyB03AtkaUbONyBeip5jcZLVy5jJlQsxDeocN32J8yDNm8YgQCy
         mykspDmxLwknDtnuuHGR6JiG/s3g2ArS/J7xEo18KDUFbnTJJZ+Foh5qtRmIlMIX2SuZ
         SxfPUkY5yBZ9iTLQalWaOg/Vbm5bF0+yLl5wNC6Ks3+Ld9Rw4XQPXjhyNIhjhJRY6VPC
         YYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694588592; x=1695193392;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ3zQjFWjU6aUGv1M6ufEZQD2GEy4rVqeEvdZE7HUcU=;
        b=R01mb0X86tXaNyFzxfCgiT3Q81rnT9/7GmKZL3t7HYCe0otTWRcQEq3ttD/PDJGcgY
         9YbCBhYrYsHp8VuHtlg53rHJJlbmjwsiKk/i5g2EBpJjb8rSMEotf7nBhuLiW0sT38+e
         uXXkdBrtjUVkYcCKERjUKtyDhTV4TvSuUFshfYm6uaJ5lyFfC99Jc4oBFQ0bw2HL53yc
         RWoLcA/U3i+0UbIP7J/fktvDpAwTZlb3Z06G+nd77jEOP6vX73s53LpiFSC/+nQIcHJ9
         koi66xn69A2DOuLUU/73Fnhpzn1c7n56SCgx9k1dzpYIDfwqEQj+cmkifPDK5xbFyDN/
         exEQ==
X-Gm-Message-State: AOJu0YzgpAG5fJAti4uTbivYU56/gJ+nANrn6hzCZr5ESgCL3speTWS+
        pKfwjFg0SscL0PMnEvuUaiplbw==
X-Google-Smtp-Source: AGHT+IEKAbAXa/5JMpdnKFLiyNtux5WP3j+5CeFfg9ME2oCoQ6zAJhpVu5+Wt7iMqVe/JefU7iiaAA==
X-Received: by 2002:a17:906:cc4d:b0:9a2:26e4:a5e8 with SMTP id mm13-20020a170906cc4d00b009a226e4a5e8mr1144760ejb.3.1694588592272;
        Wed, 13 Sep 2023 00:03:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id op5-20020a170906bce500b00992ea405a79sm7968662ejb.166.2023.09.13.00.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 00:03:11 -0700 (PDT)
Message-ID: <3ee11823-a441-b646-bdd7-aedd3a3a55e5@linaro.org>
Date:   Wed, 13 Sep 2023 09:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2 4/5] ASoC: codecs: Change the aw88261 variable name and
 i2c driver name
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.com, shumingf@realtek.com,
        ckeepax@opensource.cirrus.com, herve.codina@bootlin.com,
        13916275206@139.com, ryans.lee@analog.com,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        fido_max@inbox.ru, povik+lin@cutebit.org, arnd@arndb.de,
        harshit.m.mogalapalli@oracle.com, liweilei@awinic.com,
        yijiangtao@awinic.com, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230912065852.347000-1-wangweidong.a@awinic.com>
 <20230912065852.347000-5-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912065852.347000-5-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 08:58, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Change "sound-channel" to "awinic,audio-channel"
> Change "aw88261_smartpa" to "aw88261"



> -	prof_name = aw88261_dev_get_prof_name(aw88261->aw_pa, count);
> -	if (!prof_name) {
> +	ret = aw88261_dev_get_prof_name(aw88261->aw_pa, count, &prof_name);
> +	if (ret) {
>  		strscpy(uinfo->value.enumerated.name, "null",
>  						strlen("null") + 1);
>  		return 0;
> @@ -1189,7 +1190,7 @@ static void aw88261_parse_channel_dt(struct aw88261 *aw88261)
>  	u32 channel_value = AW88261_DEV_DEFAULT_CH;
>  	u32 sync_enable = false;
>  
> -	of_property_read_u32(np, "sound-channel", &channel_value);
> +	of_property_read_u32(np, "awinic,audio-channel", &channel_value);
>  	of_property_read_u32(np, "sync-flag", &sync_enable);

What about this?

Best regards,
Krzysztof

