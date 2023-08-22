Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509D17849DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHVTDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjHVTDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:03:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D714CDF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:03:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fee87dd251so29867795e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692730995; x=1693335795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4y/tYkdfMEnG/r7NsnV0Qpgrj3K7aEmUSWBwjIvA288=;
        b=gH30mBjXx/T4x3/bbNoWtSwhINjghjbmI9J3A/nzdQk7ADWBsYoMeGxaOkWrgRZh5q
         LXfOR16LnDy6vToem6yQuHi7J7YgaF8bmiLd4CW35bHRCdISaZNllbLfixZzZWC0yaLw
         f8dueIJtEmh44GDIQOm4Pgz1c2Dc6yJ9mAk7SmtDi00s/I+6XfruxLK0XFJU/84qEeO3
         hV8v1ooSZ11Wfp3TEHrWGdCmOP4/7LyEHPp8XTgF+q8XkRyY4h5hcpG5ApwChl3eNp7i
         RPjlIu5ZDtx3lu2/304BpDKhcaTPucOpbhkbWZQRkzFKTzJZ7as16zN4t/sn0WPhUOQT
         FDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692730995; x=1693335795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4y/tYkdfMEnG/r7NsnV0Qpgrj3K7aEmUSWBwjIvA288=;
        b=cfor8J0yiV7pn5YNvk/6c7tyim6BcXeubIje4PkVFzC5E684xtmdU3dUnI88sXWqIy
         ionEy+hcNF1xNgdcLpKDiuYDZb8rGO0nUWjgrmj0MuOY1tuXromaWR6NgOhcDFdkM0Is
         BNIGeyyeOuBAIUcWKuMPlqAghu9pd+5u8IYPIXgKaBzzHolWhZWkPfLKX92Huw+b2q2S
         OZN01NWhOG/EILuHf5SzbmnVGXq+kVwEl3NPpGRgFkolb2/vXDvr+X32D3ErNovMDoYn
         XvJhlcvjmas74yN+u8Z93qjzn9SF/yvA+1vSnMvE71OWgJA0Oa9wKV+09GBuzGki2TnL
         VtEQ==
X-Gm-Message-State: AOJu0YwP0CPjq7iG7n9tacRJWA5mOMGca4LghAzBqcLa00HNmvmKXxWZ
        rInmvcBEZ95DYlDJHcBKw8kFdA==
X-Google-Smtp-Source: AGHT+IFHh+2nHJ5TWX9xOp6UY9xKwnPv1pEu9bofMmPzz2hsGeObe/yNVv85n8wutMxEIwnFylCjTg==
X-Received: by 2002:adf:db4c:0:b0:317:6314:96e2 with SMTP id f12-20020adfdb4c000000b00317631496e2mr8986014wrj.14.1692730994912;
        Tue, 22 Aug 2023 12:03:14 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i14-20020a5d630e000000b0031980783d78sm16577518wru.54.2023.08.22.12.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 12:03:14 -0700 (PDT)
Message-ID: <b5b3a8a6-c54d-c503-db76-c8c38942b3b0@linaro.org>
Date:   Tue, 22 Aug 2023 20:03:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 8/9] media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE
 when VC is greater than 3
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
 <20230822161620.1915110-9-bryan.odonoghue@linaro.org>
 <5c917927-92ed-4139-a69f-95761ec63c83@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <5c917927-92ed-4139-a69f-95761ec63c83@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 17:32, Konrad Dybcio wrote:
>>   	val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
>> +	if (vc > 3)
> I hope you don't pull your hair out, but I think GENMASK(1,0) could be


I generally dislike the pattern of 1 << value in this code but, it's not 
something I'm proposing to solve at this time.

> in order here with a comment about the bitlength requirements

Not parsing the bitlength requirements comment, whatdoyoumean ?

---
bod

