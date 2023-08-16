Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E81577DE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243868AbjHPKVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243906AbjHPKVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:21:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8E92102
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:21:33 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31956020336so3288212f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692181292; x=1692786092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yIU+3v620e/qR+OazD/iwX+iJVdPgWNdheqcCJu+B8s=;
        b=XnRe27BfuV2jwwNMrL+u9V4IDBUVxlfJKPM1M5IgrS/HSjbTBERx8W8BgAEJ9k/S1K
         fuqBMOXlkf8nKAdKbN1Rf2oa/gKLxRiY2VXLeIyuKLMLesZ23iHlkklfTUw1cBqf+0Am
         zC2cPIxlIcx9o1lnZl4X77ErkCSQoZs7uEWzUW0tpS4S1VYv8QJSFhePwN6NLZE+hmtV
         u+DmutSvbuB5r+XEFbTwJlyeq2pzHcZq8C3p9xXuWpUvhQTpGc1Jw3VG6WG2gbvGyxPy
         sUpypm6yRnCGhuJTLkXYSvTM9ZUVoIi5aJ/hi08TPosBStfrLyH6NYhtKka8WbEv78xZ
         RoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692181292; x=1692786092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIU+3v620e/qR+OazD/iwX+iJVdPgWNdheqcCJu+B8s=;
        b=SwhMPlrZT4L/RgQQTI3mQee6z1jTNZ/0AnE26FInOkd/YHokj4EY+ZN2wk3tBqC3mp
         OOhJW6vHeII9jzQzWkwvyWwLEu5ThfEkiwvHuuZCe2GuOva4l0eGyaLo4ikQoUjI9mM/
         IuN+HxKFGXJZWHxVsDcDpF6QhifLqJaZW+UzR0kNz6wJw0UHmB7hN/7cJMUmvgpd08GF
         bqFlqS2+G/a0aVHM8qrtfceurEWrR7dM1GUPjdeckd1Uf9Bd37vBmaSf59hbiaEXvlsr
         T6cs6YTkjdWIq5iuCDAu9pXLPwogHleQ51/WIMBSbd8MGv3EJKgwPXsEPtT/FEQlyeoB
         0ggg==
X-Gm-Message-State: AOJu0Yx2OkZ6yeZSZkJX11tTtVVRjtkPc3E04/XdW4ViPJJkho/4lAKa
        yYqv8G27uCus5Xx/DS21zxvlQA==
X-Google-Smtp-Source: AGHT+IHg7S0wnsIT8U9iSEW8TEsPzDlLOtUItAdmdZ1HCoMKvbEFSom8YJGowp41H1r3hiKJ5Knw5Q==
X-Received: by 2002:adf:e692:0:b0:313:e88d:e6d3 with SMTP id r18-20020adfe692000000b00313e88de6d3mr3427539wrm.14.1692181291609;
        Wed, 16 Aug 2023 03:21:31 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v2-20020adfe282000000b00317ab75748bsm20771710wri.49.2023.08.16.03.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 03:21:31 -0700 (PDT)
Message-ID: <89fabd50-66ce-d94f-38c8-6dd6f343958d@linaro.org>
Date:   Wed, 16 Aug 2023 12:21:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] thermal/drivers/mediatek/lvts_thermal: Make readings
 valid in filtered mode
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yangtao Li <frank.li@vivo.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230713154743.611870-1-nfraprado@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230713154743.611870-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 17:42, Nícolas F. R. A. Prado wrote:
> Currently, when a controller is configured to use filtered mode, thermal
> readings are valid only about 30% of the time.
> 
> Upon testing, it was noticed that lowering any of the interval settings
> resulted in an improved rate of valid data. The same was observed when
> decreasing the number of samples for each sensor (which also results in
> quicker measurements).
> 
> Retrying the read with a timeout longer than the time it takes to
> resample (about 344us with these settings and 4 sensors) also improves
> the rate.
> 
> Lower all timing settings to the minimum, configure the filtering to
> single sample, and poll the measurement register for at least one period
> to improve the data validity on filtered mode.  With these changes in
> place, out of 100000 reads, a single one failed, ie 99.999% of the data
> was valid.
> 
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

