Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B175FF88
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjGXTGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGXTG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:06:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1D21BCA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:06:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5222b917e0cso2164559a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690225570; x=1690830370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ARogtLV1RFi23rA4Eq6YEJ7tIgrbKGbfHhga/QvC0fU=;
        b=w0kQy3xiLmArXRkkGu10vZ23WrHCfJLWIXo9QxV+sek2oXdNWu2anZlxzT+qkbBsHV
         HL2hbzWcVsbMl8+yiex4lhMms+WPq6/OqGZqlbtDDCvQlPYqHhuKuK1ZoTZRfPOTjN8W
         HYcaW60qbC3XNSDX5BqZ38V76iV3C+6J4LO07s6H2LT7DTBK9EkfIW5UkWnv4HUsL/Ev
         1W6ZNTqBHKdnibskaSOSQZ2HXRGCq1usIeFAvpMDaPoEepeWU+jxwscrZz0vLxwidAYU
         cXPjtxD8SB8okSLgQiB0flkAv2HWqHJ8KhPPRvynHdM8woQsP/eJPhoEY5CnAtfOO6Ns
         CkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690225570; x=1690830370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARogtLV1RFi23rA4Eq6YEJ7tIgrbKGbfHhga/QvC0fU=;
        b=aQwdSa/vx5eCtTxC0AyA2stJLATZuUFwMtSZouzrxUySeUR+PaXHdQA8vLwikbqZrJ
         s2FjctagV7W58W2BsKAsLgk38/x4ttjwgcBEY+NK1QYRcRYEUI8siva3AzAtRmKF1YDj
         UTXRYGgv0uF+hyWTR15X9o/pqac9yqUleu0ILcn+k1xWgav+4rlY3vxHB7o8kxgTQfsK
         PxWBe8e3YHjq74cGetRNPdPSx+F3mj74ab9tRiNjJD1L8M9BrvnayHfDSmoVRzEsbIBU
         qK83M2/MCUUJZmb4dchQ+CfPjgXh1rQWHBpl1DS+xFs6wyz8s6WX0HxDJNHD50xjayLx
         nD4g==
X-Gm-Message-State: ABy/qLZsg/HLQ21o+XAQFJ1Slk788xHftU81Eq+SUpyVibIPKZLB5z9H
        c43dAtut+CcV1J/2deY3LVGbNA==
X-Google-Smtp-Source: APBJJlFhBfPgz5j3cak/MLvEFnT1GfFIYwYH+XuXWgIqTQF5ElhY9BQssoVDyngMXlOqYXdd6ZWVKA==
X-Received: by 2002:a05:6402:1814:b0:521:d23b:f2c5 with SMTP id g20-20020a056402181400b00521d23bf2c5mr9287843edy.14.1690225570119;
        Mon, 24 Jul 2023 12:06:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id h1-20020aa7de01000000b0051a4fcf7187sm6524547edv.62.2023.07.24.12.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 12:06:06 -0700 (PDT)
Message-ID: <34be3638-ed14-bb0b-eb2e-c44f43c582f2@linaro.org>
Date:   Mon, 24 Jul 2023 21:06:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] pinctrl: qcom: sm8350-lpass-lpi: add SM8350 LPASS
 TLMM
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230719192058.433517-1-krzysztof.kozlowski@linaro.org>
 <20230719192058.433517-2-krzysztof.kozlowski@linaro.org>
 <CACRpkdbK7gU36nVOm0J+HbLk5JRKki+30=UaJ6hZjF1DiB4bBw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CACRpkdbK7gU36nVOm0J+HbLk5JRKki+30=UaJ6hZjF1DiB4bBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 20:09, Linus Walleij wrote:
> On Wed, Jul 19, 2023 at 9:21 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> 
>> Add driver for pin controller in Low Power Audio SubSystem (LPASS).  The
>> driver is similar to SM8250 LPASS pin controller, with difference in one
>> new pin (gpio14) belonging to swr_tx_data.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> This sure looks good to me.
> 
> Krzystof, can you collect a branch with pin control changes for
> Qualcomm chips that I can pull? If it's OK with Bjorn that is.

Sure, I can go through the lore search results and grab recent submissions.

Best regards,
Krzysztof

