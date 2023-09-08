Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734137983B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 10:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbjIHIJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 04:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjIHIJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:09:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CC91BDA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 01:09:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so2335093a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694160550; x=1694765350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ixdxf6ADLtfc3k52NJIrh3sBh7U9FJFSAc3uQUGhqM0=;
        b=YjLtzvWxmewb7yJD5n3xrsMNJpsh907wVbli4e1f07ysCLO2GrS1T1EaZagWZ/dTZ3
         RYm5kl+0/HvN4ow13tpxDTVzZdwxLnldoF0Wi7LDn2LG5onjog80tqlbQSidKViXr/eL
         NjwoNoGyPI5viNcDYDwnE0QvZqdZN1yobwBC8Qn3SUpzv8vf+xUdnl4YhVvV4Phy/xV8
         +gp4DQW9GthQrhYyAbk9VuO4Jf7XLefuH4QKIIhW056ZU5C6DHcAeKKFK/0pPomDvKST
         MuQtYfKODnKdxRoknwBOJliMANUv9N7l/9+kNIXqNHdpAObilVFPAnBw96DKyU0y0YyE
         jX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694160550; x=1694765350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixdxf6ADLtfc3k52NJIrh3sBh7U9FJFSAc3uQUGhqM0=;
        b=ZJmgR+EOL7c9f1aLVAmCaxoWElIg5ozq+5CALXjbpqgBKgDE8tWxvGS3dw78cgNQMa
         bqeXwDvjTmmJ67EcGSM9AyMLGdnwxf1/F2cMqE4VFBXCUBEffcfZSGzijX0yAKmFTs5d
         9jpm2dnBv9mBXgo94FgJYG9LfbTmo5n5WJjgXBp+lN0j1OpJYUMQWl1UKll676ve5iZQ
         X7VtcTMj1xQC1p6ip6BGbVEnl7M25N4DHwPi3JAHWAY5JjEwvoLa2s97zzPWlc25q3k4
         shgS61N5NS59RGNN2ZPJv426MbOKT4xdOKqIlt1qpkjCagls22qF8roY6rYflNPANoAb
         9Vng==
X-Gm-Message-State: AOJu0YzX06hJIblwMlQpqCAmYWsTXNPfcFyrvrDSZXqwN9kp/z/Iwz7D
        HEW5a+TGosL2MNsDuPS5BHixng==
X-Google-Smtp-Source: AGHT+IHEKr9UWNCkQo4zWs7G4j29nlhFDqnHZiT9RVRSwap+/d7XIqQd5mLTvZyDXk4+BGTRnkjlkg==
X-Received: by 2002:a17:906:8a59:b0:9a5:b876:22e1 with SMTP id gx25-20020a1709068a5900b009a5b87622e1mr1247355ejc.30.1694160549874;
        Fri, 08 Sep 2023 01:09:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id h25-20020a170906855900b00989828a42e8sm675231ejy.154.2023.09.08.01.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 01:09:09 -0700 (PDT)
Message-ID: <924bcd94-5dbb-2db4-f0a3-d320d8c56ad5@linaro.org>
Date:   Fri, 8 Sep 2023 10:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/6] dt-bindings: mfd: qcom,tcsr: Add compatible for
 sm4450
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, lee@kernel.org
Cc:     robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_tsoni@quicinc.com,
        quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
        quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
        quic_aiquny@quicinc.com, kernel@quicinc.com,
        quic_bjorande@quicinc.com
References: <20230908065847.28382-1-quic_tengfan@quicinc.com>
 <20230908065847.28382-3-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230908065847.28382-3-quic_tengfan@quicinc.com>
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

On 08/09/2023 08:58, Tengfei Fan wrote:
> Document the qcom,sm4450-tcsr compatible.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

