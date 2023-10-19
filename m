Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1EA7CF066
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344684AbjJSGtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjJSGto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:49:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD2211D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:49:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c0ecb9a075so53640575ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 23:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697698181; x=1698302981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lalSj6IAXslW9mGJi1k5+HZnt4EEAFejpUpcXFOh2Dc=;
        b=xhkeaboKH6I+NJ07NMjmj0K+6pyRvlsF+STl+Dd48YDfjm+E0lT/JAKaseydAzm8TT
         Tr2O+pLilQUpC5puef9z5uaaui225Upo/TjWy7Lv8d8JMuHZa6SnbmJx9ljcn+mHww3Y
         HsO1pBp2Nqr/o2xa4YDLch2EMDtVN4WZg4x2fc2F8hPjiquvNEvVnzSmF22RoG1bN6hM
         7bo1X9XEaqEiTgiCt6TTNCVj4Y9Iod0xORRwq+OPzKPHRcBXCY47C4wvcfh5ra9VNN0A
         aWw4bpm6ZvQv4ailxXlEoLBKHctjj97QV5jBRCQIWiZbH3lybOrqm7iuthlOrvJ3tVf8
         NC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697698181; x=1698302981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lalSj6IAXslW9mGJi1k5+HZnt4EEAFejpUpcXFOh2Dc=;
        b=iG+6w2DLNFmejR04BwJ/6z3Lsb/CvXLmcQWDXFzhlOaAFKk5hVLmvbDguJu0sKdfYK
         NhRDnF8DSZ1HMDvUPFBa/FbVDBygH7cB+FMgeKzbE9/ZlDJ3WqkAiAOsZFSwm+NuE2Sp
         OkPWZjSwYGsqSs53KR06LTIsHwA5Tbr5RlH7vkRkgu7dEH8paSzLAo1vs1sR9rWKkqHM
         GuqeRMTtK/PyuvzqUJy7vzxeRYkKV8J14B41b2YWTZ/MJhuUWjvpVzhYX48nqDWyHZ32
         R1BbH3K36dE9gY9hK5HrNIcT9KPjfYzC4y0nMp39pbIQ2rimGuzVVMG4pd3Ybo4aujoc
         /eSA==
X-Gm-Message-State: AOJu0YwZ4tDv0BpiPhVoKZ/icjV66IZ2fpapK/skqtvT41axQcAAmJ4Y
        gvswcqPaUHeZMI7KeMaxE7CoAA==
X-Google-Smtp-Source: AGHT+IEzNBsYC3TcMAHNGkSkQmxLGmeqfkA2Sc5YzA38i9N4A9xIDm5+uzeBzi1nomRlUiFu+NaVrg==
X-Received: by 2002:a17:90b:e13:b0:271:7cd6:165d with SMTP id ge19-20020a17090b0e1300b002717cd6165dmr1273479pjb.26.1697698181147;
        Wed, 18 Oct 2023 23:49:41 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id y24-20020a17090aa41800b00277371fd346sm921819pjp.30.2023.10.18.23.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:49:40 -0700 (PDT)
Date:   Thu, 19 Oct 2023 12:19:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: document
 IPQ6018
Message-ID: <20231019064938.am5qbaqsio7h7zal@vireshk-i7>
References: <20231016175532.2081344-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016175532.2081344-1-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-23, 19:55, Robert Marko wrote:
> Document IPQ6018 compatible for Qcom NVMEM CPUFreq driver.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> index 7391660a25ac9..f929892d654ea 100644
> --- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
> @@ -28,6 +28,7 @@ select:
>            - qcom,apq8064
>            - qcom,apq8096
>            - qcom,ipq5332
> +          - qcom,ipq6018
>            - qcom,ipq8064
>            - qcom,ipq8074
>            - qcom,ipq9574

Applied. Thanks.

-- 
viresh
