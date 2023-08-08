Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D9C77474D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjHHTN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjHHTNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:13:42 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A8436FE1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:36:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so7776864a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691512548; x=1692117348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0VsB+3QcpVhSzXsrcJCWQORogKC8v/3XnAGMVr+XVo=;
        b=nxx1rC7uFMAFZ1ojsAxu626YRi7DyQE1lpqcQnjOoBHyrunTCZ9KSepJPYgm3zI0BD
         jbB1Z8S0Jxx9LMu59jURK9iiydb006SwNtwjvUGtv5tLMk47qi+jPS7Y7wR4vh2JM3pb
         L9+SvzojFOi5VhOPRVs4xYENNg9KN6yeLswWOurZwfMSvg6J9NOSbiMacz3lxFRvozxJ
         N7B3IY5nMKVd9Kc9lnBRa310rWvTwL0+tX886Gx9YBd+ucUrLXOGLA9c2t6h1pjI9IN7
         DFFjB0ofkqKGPab/zYhoSjH98XlV0xSYAlAvXcx4SIsy4z4W259fMS7RRcG+wBjdRaqo
         gv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512548; x=1692117348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0VsB+3QcpVhSzXsrcJCWQORogKC8v/3XnAGMVr+XVo=;
        b=lGfP3iJrHgDIi7at4M/vwiiSWEbled/7/UBjZcnDAxk5Ro2akZCsJ1twIbe3wYha+/
         PLcfl0oXGG2uHu1TlkJyo6MrKFZTYEUiyt+nGG29Xd7rJwjx+J3c95hkNOZ7rNGJS9UQ
         M8Sj1QIBfT3dbKtNHBoQM7OBY09FZcgHHHwtijEljdGx8dr40OlOYKBG4rXrXCpBD1Xo
         DQ6LJfWjJ2FpQHSOtivHEOiZ42QmoB5hBCpR+p81Cj02qivK6zleDsq4qdRcn1SwX9J4
         wJ/H9iG6Dod54L6zzPVgiprgyRQOmqxi3QcX0/jNX5bgNyL7aYDSaOVny4QZHBTmJ1VT
         8nfA==
X-Gm-Message-State: AOJu0YwqiGInev7xobaTUFUj1UqF6+FT6N+rL4O4Ws1yahcAovqBu423
        2fd1oV2KbPoY36NmJjnSqrBcW/0/neyzGw7Yh7E=
X-Google-Smtp-Source: AGHT+IGZyMVu45JR/04bE0n1F2vFeCDrbv7qqr++NR+xxeRIqEcFbGzKT0+3PpQKpAcf10kY0QPC8w==
X-Received: by 2002:a17:906:8a51:b0:99b:d075:18ba with SMTP id gx17-20020a1709068a5100b0099bd07518bamr8071366ejc.56.1691484813775;
        Tue, 08 Aug 2023 01:53:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b00985ed2f1584sm6290546ejd.187.2023.08.08.01.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 01:53:33 -0700 (PDT)
Message-ID: <9a9a073b-91d8-08f3-c738-38171a9e8640@linaro.org>
Date:   Tue, 8 Aug 2023 10:53:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite 4
 board
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com>
 <20230808084248.1415678-2-Delphine_CC_Chiu@wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808084248.1415678-2-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 10:42, Delphine CC Chiu wrote:
> Document the new compatibles used on Facebook Yosemite 4.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

