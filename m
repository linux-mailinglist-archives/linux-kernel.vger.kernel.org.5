Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0399A7A1E20
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbjIOMHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjIOMHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:07:37 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8D1272C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:04:47 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500bbe3ef0eso2477467e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694779485; x=1695384285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=icfi94Iw++0R/AP2toim4sb84mQcBzKxVTS6OAVvVDA=;
        b=bF20TnzVDLQAx9XBtjZg/o9oA67v0QYYMjqD0x3vaChuSHcT3G9D5dAMBGjVbvcWSr
         r5fB2Vuk9V1zsnC/Ee2V0TSS5zJ92IQ3gRw6+IVVHQvL12PO4lWD1GRaJsLlpTX+P2iU
         LXVgpVu4OaZlYWNL6cuoFTQxGO904oe9yYFuEhN7AhBHos7SQ1akJ4KKK4ICdumBuyxJ
         vFdbYHyZQfqOEKyZmNvI8bLEmZnf2/C/eKSDY3OMNKFd9+I5CvDLXPKR0LHH820RrxeW
         ocQ70QvPs1DCfcSVtOAnTw89CL3yN+5bmCi32Z6EdZwUY2v8hNj+0fonWsD5+HJVSsWa
         cJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694779485; x=1695384285;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icfi94Iw++0R/AP2toim4sb84mQcBzKxVTS6OAVvVDA=;
        b=gSASUHeCwkq3ieRkkPMAPcTjr4PfZC7YTHCM9hUwsGJxfJbJPpglgHH6BI8CyCiFui
         Rwtl5C6EIQ1h2gdmxz6J+2JFafjSlSnUexkwEqV0mR7+QKkhL0Wl4SPEZSdEH6VIRhdv
         NPGcJppTsE/oXxa+WPDTAQSdY0rAm7+kD5tQ9wLE3BWaAG9soAkGBkcIuznXoBEgjYj0
         WwKX25p5eEH6t+Y5Fc0wurgKpDJVwdlzIOVFs9jS8YawUeCvFpSPB2YnDhjgLZ152XLb
         QFbzlc+cm8Z7UBk1fBsQDV5emQJNS4uksPHlFj635Jxgq0sCYoRU8qwvYnkkgy+ufrQL
         78Cg==
X-Gm-Message-State: AOJu0Yy89GoIrzN8L+mmWGjX6WTAQg/BN7NUkGnN6FfFNo4wshAaeE73
        VaQNyuVD0K40Ey4Z1G1Qpb3u1A==
X-Google-Smtp-Source: AGHT+IGC51QtLtToliH13uoTDIZ9HjuO7MczTafyoIlsaog7UILk/Ln075g2op/cY9P/VuE/ZnOIOQ==
X-Received: by 2002:a05:6512:3096:b0:4fe:4896:b6ab with SMTP id z22-20020a056512309600b004fe4896b6abmr601778lfd.15.1694779484198;
        Fri, 15 Sep 2023 05:04:44 -0700 (PDT)
Received: from ?IPV6:2a00:f41:cbe:bc7d:62a6:5d09:5ba7:be5b? ([2a00:f41:cbe:bc7d:62a6:5d09:5ba7:be5b])
        by smtp.gmail.com with ESMTPSA id l18-20020ac24312000000b004fa52552c7csm614093lfh.151.2023.09.15.05.04.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 05:04:43 -0700 (PDT)
Message-ID: <b6ded7b6-1818-402f-8826-2ab1ecd05056@linaro.org>
Date:   Fri, 15 Sep 2023 14:04:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src
To:     Stephen Boyd <sboyd@kernel.org>,
        Danila Tikhonov <danila@jiaxyga.com>, agross@kernel.org,
        andersson@kernel.org, dkatraga@codeaurora.org,
        mturquette@baylibre.com, quic_tdas@quicinc.com, vkoul@kernel.org
Cc:     adomerlee@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230913175612.8685-1-danila@jiaxyga.com>
 <539752971c7a61ce7a5deddc1478686a.sboyd@kernel.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <539752971c7a61ce7a5deddc1478686a.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.2023 18:20, Stephen Boyd wrote:
> Quoting Danila Tikhonov (2023-09-13 10:56:11)
>> Set .flags = CLK_OPS_PARENT_ENABLE to fix "gcc_sdcc2_apps_clk_src: rcg
>> didn't update its configuration" error.
>>
>> Fixes: 2a1d7eb854bb ("clk: qcom: gcc: Add global clock controller driver for SM8150")
>> Tested-by: Arseniy Velikanov <adomerlee@gmail.com>
>> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
>> ---
>>  drivers/clk/qcom/gcc-sm8150.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
>> index 41ab210875fb..05d115c52dfe 100644
>> --- a/drivers/clk/qcom/gcc-sm8150.c
>> +++ b/drivers/clk/qcom/gcc-sm8150.c
>> @@ -774,7 +774,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
>>                 .name = "gcc_sdcc2_apps_clk_src",
>>                 .parent_data = gcc_parents_6,
>>                 .num_parents = ARRAY_SIZE(gcc_parents_6),
>> -               .flags = CLK_SET_RATE_PARENT,
>> +               .flags = CLK_OPS_PARENT_ENABLE,
>>                 .ops = &clk_rcg2_floor_ops,
> 
> In what case are we getting the rcg stuck? I thought that you could
> write the rcg registers while the parent was off and switch to that
> parent if the parent isn't enabled and it wouldn't get stuck.
I think the better question here would be "why isn't
OPS_PARENT_ENABLE the default for all qc clocks on all
platforms" :/

Konrad
