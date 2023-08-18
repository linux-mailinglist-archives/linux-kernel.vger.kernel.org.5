Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1C5780BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376876AbjHRM0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376916AbjHRM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:26:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263A54212
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:26:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4ff91f2d7e2so1143832e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692361575; x=1692966375;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6KmHRgXH23/E2oJzrfRM3pg9QNBCmrrdJhjRvSOBuc=;
        b=DOp10zGGJa2pcqd09Lxc8HM8szx+kfGCWgUmJ6YuVnb2T5LnRPtRFTf6jjsPK1UwCZ
         hz2uot1YOwCVbCC0FLdAYM+7a0eiAuCvFZnpV32R/a1ImDYYJIvsF33Bo+WPCgdYcH4k
         xa/2XxGPJTdN9PWEc0UwgLTPe9p+wq0P91LfYThqWWMXu5LmFLDFLMtZLkRvXPjXByDp
         Y5KMS1bN5A9FSJXEgdyTwZlnECou8D+D3cshv+MWsLwJtgRkgHEGeGw2w1NlW3tZTExn
         vvxIzgzsIlRocL9uu/APepSzjUiuEeEQNbxxhEVyB74745tSmjxHfde8gXVkC6n08Fq9
         haxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692361575; x=1692966375;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6KmHRgXH23/E2oJzrfRM3pg9QNBCmrrdJhjRvSOBuc=;
        b=SICavGNLnQJI2HdH2rlelf4+RNp+gA4wX0HPv1kJ58XY8hQ7xkIIgKOpFEPgXfj0lW
         GIGzmbvN+DMsijgdzDil7kNIKbggqpzgbKYnzguYpb5sp+hrdF8NJKcVSFZBvo+jXILp
         ggf4qX2Y3MIukVIspsw6DepDt2eeew0pM+tSZu/mxnaTso0GVYUuIPBkc/Gm3ixlSzGU
         a1Njr6pTa5W59veOR2znFFa++kMdn767UG1Tap3Dd6WQThUytGWsSp4ROTW1KtxwjMVm
         3YSY6xOKK3QER6WhiDcSqFAwdb7cwQCQkGMyK9urOCfAjxo0gqDv9owwX9IHpkugfeDd
         1t1Q==
X-Gm-Message-State: AOJu0Yy9+tCJK2yuIDvqCWVE+xTqQZqpZYQ0N82LrE6FFrSkkByjEjtz
        qgE28DqHf4ho8MtgCx0rKxZ9CA==
X-Google-Smtp-Source: AGHT+IEBfWW5AYEeRPJ0bYuC6gMHst8aJpiKSoBQHqepoicqtRpRJSg7ZWo0RlrC93utwu+nkavAEQ==
X-Received: by 2002:a05:6512:2314:b0:4fe:8ba9:4c7 with SMTP id o20-20020a056512231400b004fe8ba904c7mr2039541lfu.26.1692361575371;
        Fri, 18 Aug 2023 05:26:15 -0700 (PDT)
Received: from [192.168.1.101] (abxh52.neoplus.adsl.tpnet.pl. [83.9.1.52])
        by smtp.gmail.com with ESMTPSA id q4-20020ac25284000000b004fbf5242e8bsm326070lfm.231.2023.08.18.05.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 05:26:15 -0700 (PDT)
Message-ID: <1f52f47a-d3d9-4740-a9c7-ef0bc99d7925@linaro.org>
Date:   Fri, 18 Aug 2023 14:26:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] media: qcom: camss: Assign the correct number of
 RDIs per VFE
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230817143812.677554-1-bryan.odonoghue@linaro.org>
 <20230817143812.677554-7-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230817143812.677554-7-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.2023 16:38, Bryan O'Donoghue wrote:
> Each Video Front End - VFE - has a variable number of Raw Data Interfaces -
> RDIs associated with it.
> 
> The CAMSS code started from a naive implementation where a fixed define was
> used as a control in a for(){} loop iterating through RDIs.
> 
> That model scales badly. An attempt was made with  VFE_LINE_NUM_GEN2 and
> VFE_LINE_NUM_GEN1 to differentiate between SoCs but, the problem with that
> is "gen1" and "gen2" have no meaning in the silicon. There is no fixed
> constraint in the silicon between VFE and RDI, it is entirely up to the SoC
> designers how many VFEs are populated and how many RDIs to associate with
> each VFE.
> 
> As an example sdm845 has VFE version 175 and sm8250 VFE version 480.
> sdm845 has 2 VFEs with 4 RDIs and 1 VFE Lite with 4 RDIs.
> sm8250 has 2 VFEs with 3 RDIs and 2 VFE Lite with 4 RDIs.
> 
> Clearly then we need a more granular model to capture the necessary data.
> 
> The defines have gone away to be replaced with per-SoC data but, we haven't
> populated the parameter data with the real values.
> 
> Let's call those values out now
> 
> msm8916:
> 1 x VFE
> 3 x RDI per VFE (not 4)
> 
> msm8996:
> 2 x VFE
> 3 x RDI per VFE (not 4)
> 
> sdm660:
> 2 x VFE
> 3 x RDI per VFE (not 4)
> 
> sdm845:
> 2 x VFE
> 4 x RDI per VFE (not 3)
> 1 x VFE Lite
> 4 x RDI per VFE Lite (not 3)
> 
> sm8250:
> 2 x VFE
> 3 x RDI per VFE (not 4)
> 2 x VFE Lite
> 4 x RDI per VFE
> 
> This more complex and correct mapping was not possible prior to passing
> values via driver data. Now that we have that change in place we can
> correctly map VFEs to RDIs for each VFE.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
