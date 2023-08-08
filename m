Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB8C7747CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbjHHTTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjHHTTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:19:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FC13F3AA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:42:33 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b974031aeaso91388221fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512951; x=1692117751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0jYWt89fmFSSrLeUWw+d1IBZy1QszvyM81Tw6WpAio=;
        b=dq0CcxlX7F66xz1PbERii8PHZMgxoNlNuR/VYK5tuImUFzpg/zhIp3XfgPjuAuBFjn
         gMCaPvByZljwL0ElNZaDXLEK+SOvsBz86KFrB5rrpxyfhdUFjVwL4WESaU85CNgrw/tN
         BJByxuV7nAUqlOYfmz2l1MCglUwo5TH0I+xQ6W4hboEt8OkuK4nNdJ7qZWEUiZ9dxlow
         YPJYekuYqFyRKmmDEmViN/LkmYG0JPORuBy7r+CWFmgc8XgmHf00UsuAKx8Uo3rIVEc5
         ZkAX3l3jU5c7w6ivVS8mqyIxVIPSSXxF+S29iZ2BcAJoF6TKLhr3PCljaT+SkHms4R5x
         5BGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512951; x=1692117751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0jYWt89fmFSSrLeUWw+d1IBZy1QszvyM81Tw6WpAio=;
        b=kr+a9ZbCHJzTNwYPkZ1C6+HESa+XMpVyGTBSHTnoHt+wBSVHjegbASnob81AdVnUjS
         mrwIFRtFEOMJMDcyDby1l+sfjf+oatlrH8U4e9Q5dWFwC/xPzzkczUpsry3LnM+3ngBU
         vMTYxE+3SEccmY1eiXt+OxB1itCeMcnwnh8vvuvVHY7m7OKv7zbjPxvlUm8YeG3KSjvg
         MYsKLsXNM4V4vxhOHl/raBUuFkbXV80BrFs4/dKli3hkD3SbTselHzcTXJ7KKjNtCmyn
         IXqrgu0TVRErOuJnts0O3Iz4uLIzlBz9dKmUOmpqMPiDO3vN200DWTevK7xX2GTI3kL9
         wggQ==
X-Gm-Message-State: AOJu0YwPzeQlBs0RL4/mLbEiBHCvvkmvprldhWlbTLPncjr2p19wgsjH
        o0sTy879nu+BI8PQuaw4J3Pl0QIEsxsJoBF5SvU=
X-Google-Smtp-Source: AGHT+IF7TwOlxokLzu+o14ONSGlkMy+6q2ZjKbBETRdVIsOWw5nJhhnwkULRQFS4WYp8/hPQ0U/VAw==
X-Received: by 2002:aa7:df0a:0:b0:51d:eb90:4928 with SMTP id c10-20020aa7df0a000000b0051deb904928mr11195752edy.30.1691480406002;
        Tue, 08 Aug 2023 00:40:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id o7-20020aa7c7c7000000b005222a38c7b2sm6338725eds.48.2023.08.08.00.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 00:40:05 -0700 (PDT)
Message-ID: <9aae0b76-e5bb-41b5-35f3-1bea43949c61@linaro.org>
Date:   Tue, 8 Aug 2023 09:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite 4
 board
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230808073000.989942-1-Delphine_CC_Chiu@wiwynn.com>
 <20230808073000.989942-2-Delphine_CC_Chiu@wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808073000.989942-2-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 09:29, Delphine CC Chiu wrote:
> Document the new compatibles used on Facebook Yosemite 4.
> 
> Changelog:
> v6 - Change project name from yosemitev4 to yosemite4

Changelog should be under ---

> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---


Best regards,
Krzysztof

