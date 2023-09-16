Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBE17A3284
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 22:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbjIPUjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 16:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239417AbjIPUil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 16:38:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AABCF2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 13:38:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9a6190af24aso428259666b.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 13:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694896714; x=1695501514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ck99DUFP41VW4qtdyIsbrq+XQAWsmxc+F6KcFhlBIVI=;
        b=OTmPHfbWHTio8SDNvy6ecAlqhcOOlHM/OMt0pyKSBnQEOtL5P57xkKVSiXn3xOfZAw
         KR2TQ6ZWYH5RzQQ0zDxioPBKnNqItVFIWDEo2j/yrqQihi0O6iHF+gH0sM8MD4aKD9Kk
         oWBBFf2vUFIpfWk7CKsow7a+f1LC/yLX1YmWTnBbBiDGwbsyvvHcxQhhf2Va69uDmKiK
         JAXJlQDa/RJFRKYRyxZ12xrImWidMHP41KOh+coxUL/M/Hbm4h+JrxojzvG13jJS4Iiw
         3eO6j0Wp8r7Zn6Ox0lJXMsOAsrlMcv3pgoFdwHITNoCblYIukpaLjWBBQ81uY/Ofy7OX
         Y3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694896714; x=1695501514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck99DUFP41VW4qtdyIsbrq+XQAWsmxc+F6KcFhlBIVI=;
        b=SyIw0sp86PZP1SgSzqaF3IB2szZzYv+yAqlgQs+TavkDSVrOILTVh8hOgizo1b2JiS
         VDQf5hdBm0WF8twDuFR/Og4Kwz5/YT7Uibr89wiQtMm/htod5w3X4JNdWYmonNWWngvr
         sLe7L3xJTuyze/rZXynAgvuA6DmV+V7Tqn6lImihyzWRLebG/3T962oPqsNYlgmCpCs+
         Sbbrv3Zd/rR2TOH90o+Tys585z3x/JgIL4xyAvtIVMvhrpe0mTFdiipsx4t8afkXFTgt
         M+jTscNnysctiT1Rgxo4YwB24Irhh+MkUrz9YekF+rlZ/bUnlb6mWmf6/yPrAMiNMSUg
         CWAA==
X-Gm-Message-State: AOJu0Yy5HpVMXk9rdvF2FCK36+QFhf/JFVnjqJOWAl1T2M2MVjFE0nGL
        j51tJ5al/3CB8XwKI1o7NAnvMA==
X-Google-Smtp-Source: AGHT+IGPpt6HSdp0GP6i/O8o1TEptGSzL8dCPxxFd82lf1rChEkuakTOqy25fHB2mJDQABKyYTWTMQ==
X-Received: by 2002:a17:906:24b:b0:9ad:d084:a024 with SMTP id 11-20020a170906024b00b009add084a024mr4178083ejl.35.1694896713975;
        Sat, 16 Sep 2023 13:38:33 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id l21-20020a1709061c5500b009ad89697c86sm4159546ejg.144.2023.09.16.13.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 13:38:33 -0700 (PDT)
Message-ID: <95863623-8c77-efe8-50fe-4e00cdf5220f@linaro.org>
Date:   Sat, 16 Sep 2023 22:38:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Add Huawei Honor 5X / GR5
 (2016)
Content-Language: en-US
To:     Lukas Walter <lukas.walter@aceart.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230916134147.163764-1-lukas.walter@aceart.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230916134147.163764-1-lukas.walter@aceart.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2023 15:41, Lukas Walter wrote:
> Add a compatible for Huawei Honor 5X / GR5 (2016).
> 
> Signed-off-by: Lukas Walter <lukas.walter@aceart.de>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

