Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D12A767407
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjG1Rzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjG1Rzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:55:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0B73C1F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:55:36 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso37017431fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690566935; x=1691171735;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J50FXHBVMY76jU86gdZA2hOUW6PaI5nolOLYf+ebiaY=;
        b=hZdqr3GqH1hXtYipXXVyx+LyNKzCHTAMWViYak7U5KMHQPctf/TwIHCPkL7dpLPh+G
         As6ugvww8cLF2tv6y3hy6wODKLWIoHdrJWEAwbOOW3n5krErLhgcCshds8/Rco4UgjCr
         yP96bDZWp7V2CcmmciIYHyS+ZKZPZNUS2+Lz3Say9pMKVj8ai67H+JBQfqXwyo7udZWU
         dQfObvns/GPXNF1NDDmIWgABDLbe1BMW9r4U/ZjpPRCwS62TKxfiEiKo6ox5sw0Wk9T2
         oz7tYeA9TagpPie1B6/yfiYmOFlBh84v7oWVeVgiGBqTh91vRfwm56HLahj7NVt6qKPR
         8dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566935; x=1691171735;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J50FXHBVMY76jU86gdZA2hOUW6PaI5nolOLYf+ebiaY=;
        b=Kkxb/qmxHPrGKsBxkc1qooLDYl8XW1wSZC/HxG9CfWy0ZMVPtjOqFe9I9l7/Gdx23k
         75oBVmKD5SGBMF0eSixbXS6VcflJi3T1SOUT8ITt2n8UWDZ0VeG+stnslPVktSOqRMIA
         2pYildT3KnYi3wkMwj6BEXfaERv/Dn26IBimCQ5E/umiu81RoNfPcawtAkv6OTOgS12r
         zEy9EqRfeS1MHO+pBoVDn+yHv1CSX6oeDN/pHoYFJVGQ7wTFG91MdcawvLcvoCJoRmJg
         xUdSqR3X3AgCm3Z/HCbGgHCQoPObxm8hNOPyHY2KVySlH5zEBCyNW5sF87ROwhRcto9e
         zrwg==
X-Gm-Message-State: ABy/qLbu0v4WqtV6kAAZ6+Caert/8mv6x1nrXU5M6xPtC+HEtBxS64zU
        +3huxlx4Eb/LA1g5nBI/g+D/iw==
X-Google-Smtp-Source: APBJJlEdAdkNxm/VMjBas2n7DxBuJYqVKFC6TaGzlwER+arPmE+bBMALlJPr2kpQ/5UXmJ53563PLg==
X-Received: by 2002:a2e:9b14:0:b0:2b4:7559:32b0 with SMTP id u20-20020a2e9b14000000b002b4755932b0mr2156492lji.19.1690566934940;
        Fri, 28 Jul 2023 10:55:34 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id v20-20020a2e9614000000b002b9af8422a8sm1054627ljh.130.2023.07.28.10.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:55:34 -0700 (PDT)
Message-ID: <cd1fea83-3e0c-32c2-dc9f-61569366e212@linaro.org>
Date:   Fri, 28 Jul 2023 19:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/33] iris: add helpers for media format
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, mchehab@kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-17-git-send-email-quic_vgarodia@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1690550624-14642-17-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.2023 15:23, Vikash Garodia wrote:
> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> Add helpers to calculate stride, scanline, buffer size
> etc. for different media formats.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
[...]


> +
> +#ifndef MSM_MEDIA_ALIGN
> +#define MSM_MEDIA_ALIGN(__sz, __align) (((__align) & ((__align) - 1)) ?\
> +	((((__sz) + (__align) - 1) / (__align)) * (__align)) :\
> +	(((__sz) + (__align) - 1) & (~((__align) - 1))))
<linux/align.h>?

> +#endif
> +
> +#ifndef MSM_MEDIA_ROUNDUP
> +#define MSM_MEDIA_ROUNDUP(__sz, __r) (((__sz) + ((__r) - 1)) / (__r))
> +#endif
> +
> +/*
> + * Function arguments:
> + * @v4l2_fmt
> + * @width
> + * Progressive: width
> + * Interlaced: width
> + */
Kerneldoc would be cooler

[...]

> +static inline unsigned int video_rgb_stride_pix(unsigned int colorformat,
> +						unsigned int width)
> +{
> +	unsigned int bpp = 4;
Always?


Konrad
