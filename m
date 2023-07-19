Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E224F758DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGSGYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGSGYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:24:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B4E1FC0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:24:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so7158844a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689747882; x=1692339882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ccyKM4c4UEqeSLzEinIny4sZDE5dNDTL0N9N17eCxtE=;
        b=ve4angk7F91LhVNlCl1qkrEK7LFpZTU/+7owB4XDF2ZVdh+Lc+uK2tw1TEUV70KrSX
         wF7Q7BQOc0UTlYil0POfFquiw0pzfSTKHpUdGRAaVcz3NKxzaCllxGlgE9rjde76/FIe
         kam3I+BV4TaI4YJ9zvkkx1wGBJWCX+A4vD0WKhv/oPuQ6u3E+AKw6cgPpLrA+VekMP9o
         WVmLc2mm+N6o1Xw8zGdh4h/nlBpyALWjXQPJy64ysqExD6nFZrHzXBqLKg2KYCO5LRUO
         IWagxcOGY+6Gn3GwjcKFTCZp3Qaohzce1zdo48rkOZe5q8KP1Aey6V1URTGEJvj05O0J
         MItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689747882; x=1692339882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ccyKM4c4UEqeSLzEinIny4sZDE5dNDTL0N9N17eCxtE=;
        b=XWGsN8Zl/XpiOvD0PuWUjWclG3KkpAKh4JDncJe1aVW7nGA4+tQYyr0lyrjcN+uKPY
         UZDGykjZpKkL6vNN5IQL1NIK8zof9E29TdyORYm2mXi+jBTOjc74UpT1j4a9TeV4BX5K
         10PP3ukQ+7/Lb8+5R2Q7GLIxwuca5pqXpd3fCk5IewVVw78MxpxoRzIFIsX7ieYKr+Sn
         ZgAHlYAD9nvQeF2qtUujVTCMtf3g63CKncxHQ15Z5dTR0SCsBOUhPgXMEsDubWPZgsC0
         yV9ZF3yG6CS+lzIFlNhb/eJpCyIPEYxRoAtteY7gpprhi5IimAGqvCmluOCL3XrH+Ee2
         jrVA==
X-Gm-Message-State: ABy/qLbI7Pyz8IYwfWe6ogvJkqmQcJ+UM6k2tyO3OVlkZwfZCmbMYip2
        heKddqHnNjWN3aaX2QWCo5kB8Q==
X-Google-Smtp-Source: APBJJlG0SJESoICmsz810RgoxjW57d1zLBusGoGAMt4TEGBP2HcOV3sxDWwzLWhu8xl61MKTC25u6g==
X-Received: by 2002:aa7:c944:0:b0:51d:f3b2:87b8 with SMTP id h4-20020aa7c944000000b0051df3b287b8mr1450218edt.0.1689747882319;
        Tue, 18 Jul 2023 23:24:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id g21-20020a056402115500b0051de52f8adesm2288656edw.32.2023.07.18.23.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 23:24:41 -0700 (PDT)
Message-ID: <4096c968-aa77-5638-7f67-2a478d41ded3@linaro.org>
Date:   Wed, 19 Jul 2023 08:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1 2/5] ASoC: codecs: aw88261 function for ALSA Audio
 Driver
Content-Language: en-US
To:     wangweidong.a@awinic.com
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        ckeepax@opensource.cirrus.com, colin.i.king@gmail.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        doug@schmorgal.com, fido_max@inbox.ru, flatmax@flatmax.com,
        herve.codina@bootlin.com, kiseok.jo@irondevice.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, rf@opensource.cirrus.com,
        robh+dt@kernel.org, shumingf@realtek.com, tiwai@suse.com,
        trix@redhat.com, yijiangtao@awinic.com, zhangjianming@awinic.com
References: <4ef0d83e-b0c9-1f6e-c1a4-24d650630fe4@linaro.org>
 <20230719030955.41489-1-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719030955.41489-1-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 05:09, wangweidong.a@awinic.com wrote:
> Hi, Krzysztof,
> Thank you very much for your advice, 
>  but I have a few questions I'd like to discuss with you
> 
> On 18/07/2023 16:58, krzysztof.kozlowski@linaro.org wrote:
>> On 17/07/2023 13:58, wangweidong.a@awinic.com wrote:
>>> From: Weidong Wang <wangweidong.a@awinic.com>
>>>
>>> The AW88261 is an I2S/TDM input, high efficiency
>>> digital Smart K audio amplifier with an integrated 10.25V
>>> smart boost convert
> 
>> It's the same as in patch before. This does not help and does not
>> justify having one driver split into two.
> 
> I will modify the commit information and differentiate the commit 
>  information for each file
> 
>>>
> 
> ...
> 
>>> +
>>> +static void aw_dev_i2s_tx_enable(struct aw_device *aw_dev, bool flag)
>>> +{
>>> +	int ret;
>>> +
>>> +	if (flag) {
>>> +		ret = regmap_update_bits(aw_dev->regmap, AW88261_I2SCFG1_REG,
>>> +			~AW88261_I2STXEN_MASK, AW88261_I2STXEN_ENABLE_VALUE);
>>> +	} else {
>>> +		ret = regmap_update_bits(aw_dev->regmap, AW88261_I2SCFG1_REG,
>>> +			~AW88261_I2STXEN_MASK, AW88261_I2STXEN_DISABLE_VALUE);
>>> +	}
> 
>> You should not need {} here and in multiple other places.
> 
> I will delete {} as suggested
> 
>>> +	if (ret)
>>> +		dev_dbg(aw_dev->dev, "%s failed", __func__);
> 
>> Why you are not handling the errors properly?
> 
> Do you need to use dev_err instead?

No, return err and handle it somehow (if it is reasonable).

..

>>> +	} else {
>>> +		if (aw_dev->prof_cur != aw_dev->prof_index) {
>>> +			ret = aw88261_dev_fw_update(aw_dev);
>>> +			if (ret < 0)
>>> +				return ret;
>>> +		}
>>> +	}
>>> +
>>> +	aw_dev->prof_cur = aw_dev->prof_index;
>>> +
>>> +	return ret;
>>> +}
>>> +EXPORT_SYMBOL_GPL(aw88261_dev_reg_update);
> 
>> Same question. And in all other places as well.
> 
> This function will be called in aw88261.c, can I keep it?

Not really. Being used in other unit does not mean you need export.

Best regards,
Krzysztof

