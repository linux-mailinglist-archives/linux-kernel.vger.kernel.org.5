Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0237A1726
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjIOHTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjIOHTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:19:54 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8035E0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:19:49 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31ad9155414so1623298f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694762388; x=1695367188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWppzIvE71bQdSmepb9Q7KfKBm9EUT935/Q3Gt6YfSo=;
        b=uOpWahmPXxeJ0oqMDTQ+rdXqD5GiGtl+kqr4PIhib6epz5+BTpij05JDBpwXxPCKIV
         EiaUoRwl0OQ0SwFk/e8qQm3++VDl+9C/w/xillpablFLj1UaERmND6X+5lAYWRERxQnP
         yB9xgmzLKWCB6HnRC0ksV6kErhRMsQkBsZszYFmWBW40D/7JJjR9YHE7TrHyUEZ2EsYI
         TYYn1hw2pwTsl4d5bV7gJhracrya6nsT/VbdyVWLgOjlcq+iXvPd8iVZT7ZS8A978pgF
         2S+AMyPjivhfdkvwGrVjSn6H+PDt96BSVd1Rcdow4sZzFuINSy1cGBTNVO7htTflU60G
         vlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762388; x=1695367188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWppzIvE71bQdSmepb9Q7KfKBm9EUT935/Q3Gt6YfSo=;
        b=k5QiUpyQVizRw/a4vsO0e1GsrKG+kL285Pq3r4xe7RqhHt+g1INhPLH0GtvYCydFxI
         0+orGo+SHt3vJm/Cqit8DEvCONeEqt9bt3ExWA5qIXOW5hS3YE0SGOkdG9E4Kms8yoQW
         wVyQLpKVX7+9jsHiK9fPTZzUIXLKDYpOhK9Q97Uc83MlqD0TyqW1xfx43iDHsilCrJ+M
         VjoYudhqDjMwyX6jOWH9V1Jj596IxJD6aND5uIqMwyS4BDsbFSH67Er1UcMSokpZ02uc
         uHHzWdStFfDOJutcupQrmKWMdCP3qaBb3XiVHlByRDQZMwsGI1k5aOZtAIX9TlsgOvWd
         ccHg==
X-Gm-Message-State: AOJu0Ywbwd0Nqa+0yERhBYPvhUw40dXYYP3sH6uuNLG7QYFbAczvYUN3
        vXPoe1rn1l3etRLMfIbM+pfG1Q==
X-Google-Smtp-Source: AGHT+IEtogEt5SzjYHhCTVd0LkUEWxZ8PBeGANpHgtQjRN4h7y4lYJIqFvei9LFkm8l25UnU9mIeyQ==
X-Received: by 2002:adf:ef8a:0:b0:314:1ce9:3c86 with SMTP id d10-20020adfef8a000000b003141ce93c86mr794603wro.0.1694762388245;
        Fri, 15 Sep 2023 00:19:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d4d44000000b00317e77106dbsm3622789wru.48.2023.09.15.00.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:19:47 -0700 (PDT)
Message-ID: <e087f579-198b-49b9-97f0-b642400feaef@linaro.org>
Date:   Fri, 15 Sep 2023 09:19:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 02/12] dt-bindings: vendor-prefixes: add milkv/sophgo
Content-Language: en-US
To:     Wang Chen <unicornxw@gmail.com>, linux-riscv@lists.infradead.org,
        conor@kernel.org, aou@eecs.berkeley.edu,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
References: <20230915071409.117692-1-wangchen20@iscas.ac.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915071409.117692-1-wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 09:14, Wang Chen wrote:
> Add new vendor strings to dt bindings.

Why? Where is the user?

Why did I got only 2/12?

> 
> Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 4 ++++
>  1 file changed, 4 insertions(+)


Best regards,
Krzysztof

