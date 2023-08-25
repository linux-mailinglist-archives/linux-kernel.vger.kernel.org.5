Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C04788501
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243193AbjHYKgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244460AbjHYKgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:36:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B61173F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:36:21 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so1177740a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692959780; x=1693564580;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HnnnISbb0TpSgVVoJ28XkZwpDRboyHLlXiKPbTL7hTM=;
        b=gQr0rDQubo0vt+T3kQEfvxXbYnO3u4tqp0eSB/24hKCYPMIhgi9Hj5Mc5o8DTuoKVf
         Urn+u3CN7WT7D+x3JqxgcJxsq6VUhd8IZ6i/bbi1ORWxyfGqXDJP27OwvAnAkXKM6CLc
         aobuvdLeKwHlI6wP1tagEijCFNxgEl4iNvzPhTb2V5dyCIBPMAZeeHW5Qxd2BXOEr1pL
         NDZDobQQt5Bf6x+ZRZnagleF8aMj5TO3XUe/T5foDC6Vua0mNlX5BM4BNxDQlgHawnCR
         EhmYsTRzCqAPo3JCtgoe6H1BV0W2o+kPDZZQkHZluFEvXNKuXgEDMOEo+7QZ7O4UWt5F
         RXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692959780; x=1693564580;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnnnISbb0TpSgVVoJ28XkZwpDRboyHLlXiKPbTL7hTM=;
        b=Y3qsTCsn+L36IjDLZ1/R4EEyYuJsBQly2zDLWntRo5+9wj68y/ZBwyt0BUQ45kBtx5
         CEjsP1lAz1QnXywLKC6oEt9Tpo4QSNLiK913Kte5bNl1E9p8GRS9kiuPsZjxw5Cd1tjS
         A2bjy4xcUqx6BLpLQphpn90J2fE+FDXWFnjLdGANJ/zWQ4Xc2QLJmVG3cBXwxEDDax9k
         aJyePSJV+6YXp1l5wvpZ2YrhdKqe4SxwCkkoEWLl4xToZD/IzyGRiurHKGz2AzF46bhz
         4qx2GXImS4Ywmckhx207PzRJyO2eyg2CvQW7kHYllsHu7hH3h6wct9pH8x84l8dFu/+i
         Nyng==
X-Gm-Message-State: AOJu0YyJiui49rqngMj+d0f0jHRE/kajVrz3zJfe2x/6n+Od4S5g5oRf
        x6g8J3eJMr2Bo7anZ7b6I0ueIQ==
X-Google-Smtp-Source: AGHT+IEBSo8fqbVupT4baEDRXyQBUSAT9CmB5VJ/QCzRSBh/BQZlcPS9Pv24c3T722NR4Kf3psq9dw==
X-Received: by 2002:a05:6402:658:b0:52a:1d54:2530 with SMTP id u24-20020a056402065800b0052a1d542530mr7509242edx.27.1692959780184;
        Fri, 25 Aug 2023 03:36:20 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id m15-20020a50ef0f000000b005254b41f507sm867671eds.32.2023.08.25.03.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 03:36:19 -0700 (PDT)
Message-ID: <24113913-7756-6d9b-70a2-aeeed9ecf4e7@linaro.org>
Date:   Fri, 25 Aug 2023 12:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/5] dt-bindings: phy: qcom,m31: Add IPQ5018 compatible
Content-Language: en-US
To:     Nitheesh Sekar <quic_nsekar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230825093531.7399-1-quic_nsekar@quicinc.com>
 <20230825093531.7399-2-quic_nsekar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230825093531.7399-2-quic_nsekar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2023 11:35, Nitheesh Sekar wrote:
> IPQ5332 qcom,m31 phy driver can support IPQ5018.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

