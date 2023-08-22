Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53D7847D9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbjHVQjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjHVQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:39:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0269E1B0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:39:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b703a0453fso78889111fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692722339; x=1693327139;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izzWQotNuWERu2kCmy60wMqkKBlZUek9ZxEVm/QBaQM=;
        b=U0SI/QX39Tai7Eei2DZTOrCx+eT9YxW9/U7+9nE3daz1jr/7azthT4qvL7p7EI1D3W
         h+YtleiHXkLeEz8sHCGVefieNfIkX2598ox9kbgSOsClQaZrEhcCRk77jiAwh/+jj1Fb
         6R9DFvop3Vktqkoeb94PT8pfKfosBH+hkckCrLFv4G3qlTEKHjUBwu1gi4tzhv0LDovd
         gssxb1/9Fr4z3Si7o9qJtf5A4Tz2n/ZHFLJWEM/3IxL2e7vPmedxkGovyYN/rPXIVrJm
         vUcQr+0b3cSfwvtTmM3qPY73Zbx4IJSwuJkHaQbyR/9LJTa/exCU7DyTnsvLDmp+RjiZ
         rQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692722339; x=1693327139;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izzWQotNuWERu2kCmy60wMqkKBlZUek9ZxEVm/QBaQM=;
        b=WpgS2QhI3276q26rCS8vKL+HpCpeRTIufq1JeT8vqC4kg7POAOpNW76WTf3H2NUbp6
         Gbb3JhkmjS5Aann/1QpEH977fv3WVrfMGCby8hs0jwOR4+/elWdg9WbPbcZ4BCw2CxdV
         mz6CiABAnUdpiYXVsFV779u4A11kklsuV9Gtzeqr4eLirhXFnX5KgQPUyHzyA5VgK7WA
         snyem7ymZHHviQ4WDVpFfyYOfCIvb8+15ZDwcBFj76ZwDmLY8IbeTj1zvx2hb/xjn7wP
         7V1NkAkLJPMUM9+5hDXwPWGCpdeq2PgG5rQ4qfVhYcUYvq1Nt0n9g8duq/GOTV8HxCN2
         Uk/Q==
X-Gm-Message-State: AOJu0Yz0XKPzeHbM8Ti10xVl/E7WUVdPZodTGyqpmyYAb3K2gXeaLqLV
        0r10S5HTCckfG5LWmq6oeD0dyA==
X-Google-Smtp-Source: AGHT+IH58tJZemUBp7ONy/368G7Z6JZPNy1XTx3ukBs5DsMO8tWqj9bjyYYh19jQpZTi+2yen8u7Pw==
X-Received: by 2002:a2e:9e09:0:b0:2b6:dac0:affe with SMTP id e9-20020a2e9e09000000b002b6dac0affemr7682995ljk.31.1692722339192;
        Tue, 22 Aug 2023 09:38:59 -0700 (PDT)
Received: from [192.168.1.101] (abyk189.neoplus.adsl.tpnet.pl. [83.9.30.189])
        by smtp.gmail.com with ESMTPSA id k4-20020a2e8884000000b002b6d68b520esm2746125lji.65.2023.08.22.09.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 09:38:58 -0700 (PDT)
Message-ID: <4f271226-c45a-42a8-95ff-8ec008ce7e72@linaro.org>
Date:   Tue, 22 Aug 2023 18:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] media: qcom: camss: Fix csid-gen2 for test pattern
 generator
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
 <20230822161620.1915110-10-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230822161620.1915110-10-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.2023 18:16, Bryan O'Donoghue wrote:
> From: Andrey Konovalov <andrey.konovalov@linaro.org>
> 
> In the current driver csid Test Pattern Generator (TPG) doesn't work.
> This change:
> - fixes writing frame width and height values into CSID_TPG_DT_n_CFG_0
> - fixes the shift by one between test_pattern control value and the
>   actual pattern.
> So that TPG starts working, but with the below limitations:
> - only test_pattern=9 works as it should
> - test_pattern=8 and test_pattern=7 produce black frame (all zeroes)
> - the rest of test_pattern's don't work (yavta doesn't get the data)
> - regardless of the CFA pattern set by 'media-ctl -V' the actual pixel
>   order is always the same (RGGB for any RAW8 or RAW10P format in
>   4608x2592 resolution).
> 
> Tested with:
> 
> RAW10P format, VC0:
>  media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4608x2592 field:none]'
>  media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4608x2592 field:none]'
>  media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
>  v4l2-ctl -d /dev/v4l-subdev6 -c test_pattern=9
>  yavta -B capture-mplane --capture=3 -n 3 -f SRGGB10P -s 4608x2592 /dev/video0
> 
> RAW10P format, VC1:
>  media-ctl -V '"msm_csid0":2[fmt:SRGGB10/4608x2592 field:none]'
>  media-ctl -V '"msm_vfe0_rdi1":0[fmt:SRGGB10/4608x2592 field:none]'
>  media-ctl -l '"msm_csid0":2->"msm_vfe0_rdi1":0[1]'
>  v4l2-ctl -d /dev/v4l-subdev6 -c test_pattern=9
>  yavta -B capture-mplane --capture=3 -n 3 -f SRGGB10P -s 4608x2592 /dev/video1
> 
> RAW8 format, VC0:
>  media-ctl --reset
>  media-ctl -V '"msm_csid0":0[fmt:SRGGB8/4608x2592 field:none]'
>  media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB8/4608x2592 field:none]'
>  media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
>  yavta -B capture-mplane --capture=3 -n 3 -f SRGGB8 -s 4608x2592 /dev/video0
> 
> Fixes: eebe6d00e9bf ("media: camss: Add support for CSID hardware version Titan 170")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
That's a whole lot to unroll..

[...]
>  		if (tg->enabled) {
> -			/* Config Test Generator */
> -			vc = 0xa;
> -
Which part does this hunk correlate to?

>  			/* configure one DT, infinite frames */
>  			val = vc << TPG_VC_CFG0_VC_NUM;
>  			val |= INTELEAVING_MODE_ONE_SHOT << TPG_VC_CFG0_LINE_INTERLEAVING_MODE;
> @@ -370,14 +367,14 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
>  
>  			writel_relaxed(0x12345678, csid->base + CSID_TPG_LFSR_SEED);
>  
> -			val = input_format->height & 0x1fff << TPG_DT_n_CFG_0_FRAME_HEIGHT;
> -			val |= input_format->width & 0x1fff << TPG_DT_n_CFG_0_FRAME_WIDTH;
> +			val = (input_format->height & 0x1fff) << TPG_DT_n_CFG_0_FRAME_HEIGHT;
> +			val |= (input_format->width & 0x1fff) << TPG_DT_n_CFG_0_FRAME_WIDTH;
>  			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_0(0));
This screams necessity for FIELD_PREP/GET! Could you please convert
it in another series if you have time for it?

Konrad
