Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7288C7A1720
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjIOHRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjIOHRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:17:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F9AA1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:17:38 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-401187f8071so12080615e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694762257; x=1695367057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nKlXZwcMYS0nRM5520Aq9RRDReEviWQWXfnNE3DisAk=;
        b=zQUPEQ4TLLMfBDHiiOH9g+n5mpOaR37gNSRRzTXRpMH8KE+0VXzWplCuEgG4t3RUxq
         thzUqs+ZvUievRu+WPmN8jz6LLhBmtj3MPKrF6EENYvztlLTmqgSfPCEGdio5ARh21GI
         YW93WzFV+Bv/v2NFCTMm/DmhdOj2gb/UqiBDJ00+sUmmOP+iNbyp1JM2YDCwHQYjSAu0
         4h7es5Zal1MxtWOPePo9k31PPghZ9QbWm3uDY3lSf6p3BKek3E6r40cBZdctNMLp2TEs
         HKgYObh1/VlPP3g+dNl/VI4PeWOLPYFUkqNH4sO8oFUBZZKlBQ3yNKHYo0Uhnjfapgh7
         JDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762257; x=1695367057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKlXZwcMYS0nRM5520Aq9RRDReEviWQWXfnNE3DisAk=;
        b=Mr7LkJMkM/kQwwJAZ7uXXz1ooUrrHB6YhjaH+IxBhuMEp2UXiZRxgA+sJ5QBC9HgYs
         BXEeDom2KWtanaB8N977qsE7pfuQAuveOzMBT1036g7zHAyNI7+3CRPB3aTMOMwN4bS9
         O5hSoiB0yrV2yeql3CqrTqIF7Gs2SBM9hSGIaTwoUZCJfFpVqrerXnpxfxmHWxYSd7NF
         o55FLxIjQj0aLZ+gMs8PMPZLqG28tJkcYtDpeDWhyEZE5kTazch/oUMuY+4BH0nxRh5V
         Xmqbjs4lJVwpq5QZZIf1PW6UwPuH2LbmCplLQzjtQIgr88bGwmcxbdOzrxfL+kEWzFCM
         BfGA==
X-Gm-Message-State: AOJu0Yw18Fjl67dBgj6qgwa8rBIJTd1sr2i1zNTAdp3GRDNvFNTd5Bzg
        WaUQwqUXXbEI8oXhDwGXMahqVg==
X-Google-Smtp-Source: AGHT+IFLPQoHUaGnhgNK8hVifo28q8Mg3P4hJPyPf8HjItYYBfnS1qR1isuRtxNCFzzz2hmRHqOfxw==
X-Received: by 2002:a05:600c:28f:b0:402:e68f:8a4f with SMTP id 15-20020a05600c028f00b00402e68f8a4fmr557370wmk.0.1694762256675;
        Fri, 15 Sep 2023 00:17:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id x7-20020a05600c2d0700b00404719b05b5sm3392964wmf.27.2023.09.15.00.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:17:36 -0700 (PDT)
Message-ID: <a48d1d09-e967-3226-7173-4e2a58ffae1d@linaro.org>
Date:   Fri, 15 Sep 2023 09:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: Add Qualcomm SM4450
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com
References: <20230915020129.19611-1-quic_tengfan@quicinc.com>
 <20230915020129.19611-2-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915020129.19611-2-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 04:01, Tengfei Fan wrote:
> The Qualcomm SM4450 SoC has several bus fabrics that could be controlled
> and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---

qcom,sm4450-rpmh.example.dtb: interconnect@1700000: reg: [[0, 24117248],
[0, 200832]] is too long

Did you test it before sending? No, you did not. Eh :(

Best regards,
Krzysztof

