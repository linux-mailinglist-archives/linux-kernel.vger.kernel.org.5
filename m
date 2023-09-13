Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F0C79E1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjIMISp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjIMISo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:18:44 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A30199A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:18:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401b5516104so69033885e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694593118; x=1695197918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vwUUxaP5y+PTaTEbxwe7UpWq12N8jlqbyZbCYEg72fo=;
        b=nkycTckrP8HdFKUV5uVj93rz9CIQ0vIe/lWNI5Mht9aWGn9ARA47W+zwCZJLnA7nqz
         9oBLSs8vXq9IPpV9saqED0G8T2XXmWOU3DsfH87Vjd+TftYg5xPMYxfQiLK/QGfsTHqc
         apJdVd/7q1S3uQIUcy3rN25Xmz30yNEg+ic26nzUoVetr5j2N/l4gv137+QSyeJwmACp
         yvbnipujkT06AH0xGaqlr83xnx9IUnNQp89PFoDe2hkLmdAFqhvzOocTWAZECbI/FNai
         W06KC+JZWbFDbY4Vg48+a220GF6ml/d6uMBQ7xhzjfEqbgcD09+BprTovOFKofUfvIfC
         9dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694593118; x=1695197918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwUUxaP5y+PTaTEbxwe7UpWq12N8jlqbyZbCYEg72fo=;
        b=f8v00SKb9YAqqIyYNBsrfpA6V/d9/+4520n4YkBGt77azm37AKpZMCr/lTRwGe4k8u
         xaWGBCRSJpTQroHLyI1mzM50IQyTNTtElZFexbW5nZzDOKBTYwNPkvenu7Cyc+HubO+F
         v0m/yGvzGfrI8/u++FX57nyMKJShNE+o/d+aHkByNNcRdjM+LY66uOokgPGSlCl5QUvD
         8uqprO8NF3+2ur+W/bd/Wtal9DQjGJoGwnDBsPyktx7MeKZW8SM3xr2wpYHay/Kfag6d
         Yjzf+kjzlOfykeZD1h0Lj7D+ikw3kf8d4ytGgUDIHICzPrKSwJz/d0c/Z12ve2Y2tXFR
         EMIg==
X-Gm-Message-State: AOJu0YyHBo8VOD/zNxDKl7BX28N0QNvEP2vA9HZARtlBSmmKqFzVzCfv
        ERS66cW7LMB6BS2ZkTiDHYt6CA==
X-Google-Smtp-Source: AGHT+IGtCk7VyJXdF5BMBjTf7j0eels6E5OC9Af+NH7CCXmJf24asywn1LuqHumwFefnCyRSRVL/Fw==
X-Received: by 2002:a1c:6a11:0:b0:401:b53e:6c3b with SMTP id f17-20020a1c6a11000000b00401b53e6c3bmr1464789wmc.6.1694593118417;
        Wed, 13 Sep 2023 01:18:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id l14-20020a1c790e000000b003fe4ca8decdsm1275565wme.31.2023.09.13.01.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:18:37 -0700 (PDT)
Message-ID: <da6379ee-a024-0dca-4bde-137ad9090fc2@linaro.org>
Date:   Wed, 13 Sep 2023 10:18:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/4] spi: dt-bindings: qup: Document power-domains and OPP
Content-Language: en-US
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230912-spi-qup-dvfs-v1-0-3e38aa09c2bd@kernkonzept.com>
 <20230912-spi-qup-dvfs-v1-1-3e38aa09c2bd@kernkonzept.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912-spi-qup-dvfs-v1-1-3e38aa09c2bd@kernkonzept.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 16:30, Stephan Gerhold wrote:
> Document power-domains and operating-points-v2 to allow making
> performance state votes for certain clock frequencies of the SPI QUP
> controller.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
> ---
>  Documentation/devicetree/bindings/spi/qcom,spi-qup.yaml | 8 +++++++

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

