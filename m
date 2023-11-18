Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27DC7EFCDB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 02:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjKRBIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 20:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjKRBIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 20:08:06 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A29D7E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 17:08:02 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9df8d0c2505so490639066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 17:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700269681; x=1700874481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/w2dNhxptt00UyJYxsmM3CJJF2NzIAk4hqmNz7VaSoY=;
        b=tTlx+NtZWvNL6PryRt56vFAgy4LpOKNKxcKSEfi7YKfZoUfLZFiH0RGtBzXr9iJQAa
         cefHEUbzcIofbn1VR3OMmaaLyol/GADv+l7+h4X8NsS+kD3eW8sOCXvCTrxkW4YWXeLm
         0EMHTpQ+/B7G2+Mc2+r1mZDsrD4vu2bB8ZYbeVgBJvfgEx2U9EU/Ff61NMKher4XniBM
         kuJqTPLeQ+NFjGvyDquaOEX2jC1ko43tlKBJtHxBYP5wInYOxVpyuWoFmnSJE3v23X8/
         8+qFHu6G4ttKWDTZG+Pj04xROjCGQskpwabasUfKPEUDeVN2yKZf4PJ/UnXzNcDlEYUm
         h0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700269681; x=1700874481;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/w2dNhxptt00UyJYxsmM3CJJF2NzIAk4hqmNz7VaSoY=;
        b=YSR0/uqMYR+7faJng1Q4xcIinLjzm3uwyltvuj4VCAnNv3HCmdRYwLl04oR1ZhN2p2
         BquW5vVTCKVmzZox4ZSOgigmxTM7PuaJMd3N4yU8FggXMWx6o/1pTv0F6lfYzFf5boyr
         JOu+8bvvGQy/JaSsoJPjWYh64jRCNyn0oGIXkiFVP+7bWvSQW1DCH3Em9+lwfwm3fTt5
         2xR1+WerHHQXlt/uneCrQdaF4FNyoDv3LXL/DXXWdVktk5o++ZgNddr2IXFgAIE8NkU7
         iYaty2EfPOCbs1RFA6kT56MV5qkGqMEIhxkT5RFVg/mYW5aqVbQhb2m+T/npDj7azGMU
         H4OQ==
X-Gm-Message-State: AOJu0Yzzw5PQuWBFD/amwGiYwH++vHQU5FbkNhJLjYhMg6krLK+P+iU2
        6ueN1/ddN8kkTX6Tqizot+tXZw==
X-Google-Smtp-Source: AGHT+IEbGV6iUJucloKhyrHRBZZEqVWRTg7PQimNFxgwJSyRhld4iR/eGiqHHroxm5v8Cq0QJqMWzQ==
X-Received: by 2002:a17:906:3009:b0:9c3:97d7:2c67 with SMTP id 9-20020a170906300900b009c397d72c67mr693683ejz.25.1700269681121;
        Fri, 17 Nov 2023 17:08:01 -0800 (PST)
Received: from [192.168.201.100] (178235187040.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.40])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709060b4c00b009b928eb8dd3sm1327704ejg.163.2023.11.17.17.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 17:08:00 -0800 (PST)
Message-ID: <0c1ba8b7-7253-41d4-a024-5f7618f6485c@linaro.org>
Date:   Sat, 18 Nov 2023 02:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231117080737.606687-1-quic_rohiagar@quicinc.com>
 <20231117080737.606687-2-quic_rohiagar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231117080737.606687-2-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.11.2023 09:07, Rohit Agarwal wrote:
> Add interconnect nodes to support interconnects on SDX75.
> Also parallely add the interconnect property for UART required
> so that the bootup to shell does not break with interconnects
> in place.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
