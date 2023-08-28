Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6687B78B830
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjH1TXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjH1TXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:23:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13FA195
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:23:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso771027666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693250594; x=1693855394;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quIC8r/2M5bmXpGrl7OPUPyT92RZlgBwJSIBrvkGRqA=;
        b=Fc1xwtcoWcWIMeccc+reNEx/vm62Yg5YEieBfKF7CUQXBOahorNYEZUqt8ZOCNidTW
         ak9bHTNDV5tQhMppPNFCxwCnAsbCrCj136cy/+28IX0q3hyB++fSVyPxhdqSsknQRqTN
         D9z8WoF2lipzcdsxzQHx1f2XSZ9dICd4/z0BBDAk9DoIgmkbPIrzqZRCG8vc4sekqeUm
         e50+ou392W0Q99Ur2LWbbePwgggd8VAyOJs/94SimjDPabJSWYot79eAK5PdYaV6PiFB
         5ztadUon+Js17vCEcdbO0nBgmoMA5UA9+Me53vVKfdVRzrmWW++th2g8C0O68f8sWNhW
         dgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693250594; x=1693855394;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quIC8r/2M5bmXpGrl7OPUPyT92RZlgBwJSIBrvkGRqA=;
        b=iLWqsIj3mjP7wiM6uWunAtNbjSiqYSEWzJ78Gjrw9PfspKf/V9IYDhdFQCg3FHsbai
         hajnKAxCNRqRscywpRVhDhGoV8OhVHrTrdpfAEZ0dO4zyQ8vVvUqCUyKoWA8umB8mGuY
         G9+ghJQ204SqKWv7rQmgjIPBiPit1dHCRJG58THUKTfdBsNuN+hnwanTraLPTEz3fbCb
         ZLKJtNepPsCj87RG+BNMWrtdArCfGxf54WYRiXIL7DxK6C0yyq/MPj/QeBOHQHE4fx/i
         CXWjaWT9AIfmyVMpJk2bMKkJgWqFeXlr/CklM6Rb4TMS6giZ0JOwVt/6372OFpb4W8z+
         bhHA==
X-Gm-Message-State: AOJu0YxuAdSGFi+v7A6QAJ434MpLfgoAa2OrrdkzHN5QL0AVs+Y/GZLJ
        KVehM67a8tGi3lijLMBFkpPPGw==
X-Google-Smtp-Source: AGHT+IFoFEPbZK4IGrEqGuM5fFL74+/7U+GcnSltCBLhEp/yPgE2S/IR+dTJBpXle+IFmH2xTRBqOQ==
X-Received: by 2002:a17:907:78cf:b0:9a5:9f3c:961e with SMTP id kv15-20020a17090778cf00b009a59f3c961emr558768ejc.18.1693250594168;
        Mon, 28 Aug 2023 12:23:14 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b0098e2969ed44sm4934214ejn.45.2023.08.28.12.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 12:23:13 -0700 (PDT)
Message-ID: <1c97c487-bd25-2fb2-4002-105186f3b87c@linaro.org>
Date:   Mon, 28 Aug 2023 21:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5/7] dt-bindings: nvmem: Add compatible for IPQ5018
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
 <1693250307-8910-6-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1693250307-8910-6-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 21:18, Sricharan Ramabadhran wrote:
> Document the QFPROM on IPQ5018.
> 
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---

I suggest you to send independent patches from different subsystem in
their own patchsets. You make it easier for the maintainer, thus help
yourself as well (usually).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

Best regards,
Krzysztof

