Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB29777DA37
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242035AbjHPGIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbjHPGH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:07:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDE52710
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:07:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so55830815e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692166059; x=1692770859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsYZ939dcLj42q9uy/F44+/jrXXmiBF/awHAuWPvXAk=;
        b=uoJ+LTaG3QZMIz/ZFLv0qitRtNF1EyLtA5yKAhtE0OP5ZF3SDoPOryh+VBT2oJIdZR
         HzuvuvrrGmTfQcJWx1qjBb82be5InQkZkimokkpc6WFYWTThE03x5RDOF5i5RzbiufBU
         k8bruS4aN0nVlwIpq8CMZtnJRo2kutK1aW4gPOHB6XhQ3t/UTuABsHe/EblA5UzRhSOe
         BVMNFLuhMUuF+/2bR5fOkHe93l6aaymbU8tgOUAMFb22GQXtRrUOmxzN7Nq+6AFNp2Hv
         XXo7PP2XgKMS7EhbP3na6XXN9z+/DXSh4vMwE06+Pp6o+J9lk3wdK2NEgkjDbwWXLFn2
         gSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692166059; x=1692770859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsYZ939dcLj42q9uy/F44+/jrXXmiBF/awHAuWPvXAk=;
        b=DGoxjtVrBQhC34XQ2CuVdX4/rv4anUGfrCKHZ7sPvG+PtYGchdOOg2AtQySRCvrCZC
         Dx1RfzTDZe3oWJIaPvYn3nNDag3D20Q48fCkZYLdpfh35eaTItV1EFSO9ldjMkQFZZ8Z
         IhaSk7+xb++Nb7m+Ah/XCpSRI4YpEA15M05vhCZ4WYUJwn5FWnRVdgyKcXvAyQFJ2Q+E
         +kVjHF6cMk5hnbGthnzt7wWZ6IxzrixtD90LmCQFTIYE+gJzstRTRRFLfZPmauLxdCy6
         F7EHffmxSGCK9D0tLyc5V1oYSA78qRhQ3xBuv2BByTLDB8byWGo5j0A+SgpmXRqxHwB8
         wjLQ==
X-Gm-Message-State: AOJu0YxD3S0bhSw54b5HZc97DFVHj1z7f+wCfEb3Juv+/uDG9WLh83ql
        4thYKsMIaBIuaX/RaLNa/iKGzw==
X-Google-Smtp-Source: AGHT+IER5sMU2fdIlArto/rLhBPLokkQ2ZvUUXeHU0aH2Ely9ASzANipMTVKXsFzMCMuJLWXHwMwYQ==
X-Received: by 2002:adf:dd84:0:b0:317:4bdc:6f34 with SMTP id x4-20020adfdd84000000b003174bdc6f34mr710578wrl.64.1692166059333;
        Tue, 15 Aug 2023 23:07:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6802000000b003197c2316ecsm7456530wru.112.2023.08.15.23.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 23:07:38 -0700 (PDT)
Message-ID: <5ec6669f-454f-5c50-7ab2-522940f2c57e@linaro.org>
Date:   Wed, 16 Aug 2023 08:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH linux dev-6.1 v1 1/2] dt-bindings: arm: aspeed: add Meta
 Yosemite 4 board
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        openbmc@lists.ozlabs.org, patrick@stwcx.xyz,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230816060547.40489-1-Delphine_CC_Chiu@wiwynn.com>
 <20230816060547.40489-2-Delphine_CC_Chiu@wiwynn.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230816060547.40489-2-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 08:05, Delphine CC Chiu wrote:
> Document the new compatibles used on Meta Yosemite 4.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

I don't understand this patch prefix and why we are Cc-ed on some v6.1
work. Please split your downstream work not to involve upstream.

Best regards,
Krzysztof

