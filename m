Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED820770A12
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjHDUvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHDUvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:51:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AA810CA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:50:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so24039525e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 13:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20221208.gappssmtp.com; s=20221208; t=1691182257; x=1691787057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oRdtvajcr0+92CY77W3iHbJU9XUO/PBM1l9BDnbFdFc=;
        b=xs8zzZqm1qGHId3LlKUmwK5FOhtA0omVwvGrdA1ntw5jFrQfqgQoGr3y/s+EEF0uHO
         Bdt4pWHgGB11RE9UkjVl8kf8u/EFSl/7pa+X9c2x6ZF3tSOpFJ7tAe03nuR+7ddrRCuy
         Po61hPXefC4YtgUWH3mLtGMwLObmQ7NDS4+EUm8LEEC754QIJWmu/Xkrj5t8Qjfkuzbk
         xJDAcRAZpRQaS0mFivlN5Ti3XEAcocC/3uotIq6NjLfFFfsK6GcUuh9JoLTcu9nnAJ1R
         SoiXG/a2ShqUuoNpYzJpb/ze/AKDS3H/LIKLK3RgTLc7P+69T6hBe0S8/bLb546Lfm/B
         l+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691182257; x=1691787057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRdtvajcr0+92CY77W3iHbJU9XUO/PBM1l9BDnbFdFc=;
        b=W9J+d2EdNG+c6iC72HFhUZjEQC3LhOclIk4hzr0Ylj6zRsjeWCEhCy0o1mTQSCZ1wH
         564wqPyKQR4hk2LM8PHD/IB7rtDAsep0vMmIIfm+CzmynxQdrINnL/3quc1I+0QA/7r1
         jnfKxqMYAnvQdjRweXqCud6AmZK5JK65NTyuaYctibjOUk5+V8XsFTzvh+iZx1wcWbPq
         +qdVlqa8JQGEETxs9MK+ak08xB4c7b/Rc0+EcZ6TzJ5WryFjHsCAerrNfMP9VDqXTOrU
         ULwTYE6f5Y3EmcAl8FEJebntsxkdqP/wtjC8clTlflDIEPV76DRoD5DOjG34oe9IYu+H
         sSuQ==
X-Gm-Message-State: AOJu0YySXBmckBCwXrbmcPZ5i00oljcy21YEeWmseXCvxI5TjQL2oSNv
        2jo7Z49i3E88IZim7QbF/LBg1Q==
X-Google-Smtp-Source: AGHT+IG9nktERXD1XuryHQ2ywTah8rg+BCMhCDCxvrQusPr01OSsEg0ZZxE1+OpK3eP+FA9bGulG8Q==
X-Received: by 2002:a7b:ce0e:0:b0:3fb:b56b:470f with SMTP id m14-20020a7bce0e000000b003fbb56b470fmr2187419wmc.14.1691182256933;
        Fri, 04 Aug 2023 13:50:56 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u7-20020a5d5147000000b0031437ec7ec1sm3355379wrt.2.2023.08.04.13.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 13:50:56 -0700 (PDT)
Message-ID: <ef61906d-98f2-2806-9ad7-2a99f7928bb1@nexus-software.ie>
Date:   Fri, 4 Aug 2023 21:50:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/6] media: venus: hfi_venus: Support only updating
 certain bits with presets
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
 <20230731-topic-8280_venus-v1-3-8c8bbe1983a5@linaro.org>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <20230731-topic-8280_venus-v1-3-8c8bbe1983a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 21:09, Konrad Dybcio wrote:
> On some platforms (like SM8350) we're expected to only touch certain bits
> (such as 0 and 4 corresponding to mask 0x11). Add support for doing so.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/core.h      |  1 +
>   drivers/media/platform/qcom/venus/hfi_venus.c | 15 ++++++++++++---
>   2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index d996abd339e1..2999c24392f5 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -38,6 +38,7 @@ struct freq_tbl {
>   struct reg_val {
>   	u32 reg;
>   	u32 value;
> +	u32 mask;
>   };
>   
>   struct bw_tbl {
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index 19fc6575a489..d4bad66f7293 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -349,10 +349,19 @@ static void venus_set_registers(struct venus_hfi_device *hdev)
>   	const struct venus_resources *res = hdev->core->res;
>   	const struct reg_val *tbl = res->reg_tbl;
>   	unsigned int count = res->reg_tbl_size;
> -	unsigned int i;
> +	unsigned int i, val;

u32 val;

> +
> +	for (i = 0; i < count; i++) {
> +		val = tbl[i].value;

struct reg_val looks like this

struct reg_val {
         u32 reg;
         u32 value;
};

val should be declared a u32

> -	for (i = 0; i < count; i++)
> -		writel(tbl[i].value, hdev->core->base + tbl[i].reg);
> +		/* In some cases, we only want to update certain bits */

I'll trust this is a legitimate and true statement.

> +		if (tbl[i].mask) {
> +			val = readl(hdev->core->base + tbl[i].reg);
> +			val = (val & ~tbl[i].mask) | (tbl[i].value & tbl[i].mask);

feels like something regmap_update_bits() already does though, I prefer 
this because there's less code in it.

> +		}
> +
> +		writel(val, hdev->core->base + tbl[i].reg);
> +	}

With the val declaration fix

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
