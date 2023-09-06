Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4694C793DD1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbjIFNg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241140AbjIFNgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:36:54 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45E710D7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:36:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bcc0adab4so550164066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694007406; x=1694612206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Bh7czQR1hQXADffVntw/KnBkGqWTT3clTrz5Nsb9lk=;
        b=XjUPhVltT+pmwimjfqxz2vZpFaQ2JRELNO4xWFBRX4sdasKfU/OENfsrMlfaEEoEvA
         9zX7OsqYa4TalAw0WcVU1jHt3wQHY3G+XvGcxwIvrzb6nzAEMB23huUCJkfiz+/9VBky
         XExY3TqdfoNTUJBB3ZV4n6fNfeq3VV4WEzGpDKmwzcprjAPsHBjTRu6AsdKD2V5A0ylq
         PqzQe6ojrb3H+Djq+9/baZn/XbG1p30iSeOQSqaMfWik5qgQEPkwL/yK+t1YSClNdcwn
         Lw1Lp3i04Dy3F3QUnAqix15d7gW81u2s3QuNbkUOyyaDQwwEcj5IvO0D+j4lKtg2hwjX
         LamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007406; x=1694612206;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Bh7czQR1hQXADffVntw/KnBkGqWTT3clTrz5Nsb9lk=;
        b=I2wmOfg0Waf31jV4RhlxaYIORt4vO22uHsvGVKrEC3+B3lY3m36lzfoq5fGchncJxG
         mMXwV9hGdBk1NvIN1pRI2CcsabxTYAZ7GbTYZGrUigl9vUd63RSPEdU9vjh5N4fjNJMn
         p7qqis4939OtVrcWj067hRAJPvEW8ne2ukWhem2HluVXTX/aZzU0XiolSxT7ces55rm3
         DRlSC/EHFwRvZhlsPdMUligLXyrtj6QN++9DhAvvjcKDEX/+jzRM7/gOrpuKYRH1VuoA
         aT1e2kW+kq7VQlIhWZwYmCzv/ntpkm0dXSLnUbs+8l1GtDoeozvw2N3oo3/Ld8Yt4yiX
         MJdg==
X-Gm-Message-State: AOJu0YwPM/zJHm8THsX+COIivNfUrNml1b0HSU9npN59spIXLIn4L5tp
        qlOLWOhNIYl1VE3muT02iasoqw==
X-Google-Smtp-Source: AGHT+IHBzP+TiqpWDNzZ9toX2Xd5vDyK6tzpuUfH72QuW1rBbCf3XVVfF2a3ulYoHLg09QTFl4/uOg==
X-Received: by 2002:a17:907:60c7:b0:9a1:ffec:aadd with SMTP id hv7-20020a17090760c700b009a1ffecaaddmr249677ejc.56.1694007406571;
        Wed, 06 Sep 2023 06:36:46 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id q6-20020a170906940600b0098e78ff1a87sm8997887ejx.120.2023.09.06.06.36.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 06:36:45 -0700 (PDT)
Message-ID: <80d60185-4333-189a-fb51-6dc789d3a294@linaro.org>
Date:   Wed, 6 Sep 2023 15:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] dt-bindings: rtc: mcp795: move to trivial-rtc
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Bartczak <emilbart@gmail.com>,
        Josef Gajdusek <atx@atx.name>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230906-topic-rtc_mcp795_yaml-v3-1-5262f1b39920@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230906-topic-rtc_mcp795_yaml-v3-1-5262f1b39920@gmail.com>
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

On 06/09/2023 15:34, Javier Carrasco wrote:
> The current mcp795 bindings in text format do not support validation and
> are missing the optional interrupt property that is currently supported.
> 
> Adding the missing property makes the bindings identical to the existing
> trivial-rtc bindings.
> 
> Add maxim,mcp795 to the trivial-rtc bindings and delete current .txt
> bindings
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> The current mcp795 bindings in text format do not support validation and
> are missing the optional interrupt property that is currently supported.
> 
> Adding the missing property makes the bindings identical to the existing
> trivial-rtc bindings.
> 
> Add maxim,mcp795 to the trivial-rtc bindings and delete current .txt
> bindings
> ---
> Changes in v3:
> - Order the compatible property alphabetically
> - Link to v2: https://lore.kernel.org/r/20230906-topic-rtc_mcp795_yaml-v2-1-f9bef40c99b9@gmail.com
> 

Thank you!

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

