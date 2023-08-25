Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E5278803D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242454AbjHYGst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242463AbjHYGs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:48:28 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DCD1FF5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:48:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so858429a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692946098; x=1693550898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8i2MFIt9PPqdiA+U5wmi4xH4F0pC3lElXMemaJZn+M=;
        b=nYrg8AojLgKfBTJR0zhZr48566By9omWhYw+Kq3sOrzLq7icKWhoJcL/6LFJZdho5P
         sTIgp1gksE0/7K8CBOD0yspGPqVaowW/RZCzLgpOe8mKEzaPf4XDHW58TXJ9mq+lAbo3
         itRxQz1VmH49t0gl+8z+5Km2lSeX4EDLdu5wLqhVVxnjleSC8k5mXrrP27RJI+wSmuzk
         AGVugAE5E4PpVyz6cV/MNJTi2T2p8UGumpZpbfcW0kl+tFlVJBr/jpZxh3xksHfQ/cLf
         YoNTbblSaYtDwJ7R7r9npyNWgJylAEeY7YnGlX7KNktnehBuPMqOMTwTD9+k3N8tVY/Y
         PaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946098; x=1693550898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8i2MFIt9PPqdiA+U5wmi4xH4F0pC3lElXMemaJZn+M=;
        b=bln8eHxfGZwQ/gfSk1u8jbrhiHnLiVmTgPzovWP2yTsIh/qvkNGztIXmkHXehQXZkw
         K8DqhHLYHSGboarnE7FD4LMyw2Ny/MX9Bdo644frjY3cQJhGaFd4zw99868T/hS+Hxiu
         UDTBK793WtQN+PGIFHSOro7CffREaEZW38pTyrTAafSIGEEK/XyBun3pJuM/G9iAeqls
         WKgb2rg9lJjWbypJVhc62AYlgLL0meRgrQrgkA65QlSka5c3+78/eY3ai51PXZh50yn7
         IPKyi5/gYC3qGJdNPbWPRxgfYtdvOflmKk55PrdhhfBW7sg58F+q0k98Yb7rY5WjIOa9
         oyEw==
X-Gm-Message-State: AOJu0Yz+cXTTaBpiSgV4C8wGBGDoa1K8yoKPSf0lrsirWbPJAke9AT2q
        qI/xHoA2I2PrqjoxhSzMO/gqGw==
X-Google-Smtp-Source: AGHT+IG1z3CKEe9GDWj6KdXNBIZTtTn0My78Dw9qopv5OUPpIdAbGaSU1cOUD33d11NlsXOVgQFmIQ==
X-Received: by 2002:aa7:d996:0:b0:522:d6f4:c0eb with SMTP id u22-20020aa7d996000000b00522d6f4c0ebmr11753745eds.40.1692946098347;
        Thu, 24 Aug 2023 23:48:18 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id n25-20020a05640206d900b0052a1c0c859asm663682edy.59.2023.08.24.23.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 23:48:17 -0700 (PDT)
Message-ID: <f8a1391d-3716-04e5-7e36-fe670c75df4c@linaro.org>
Date:   Fri, 25 Aug 2023 08:48:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: syscon: Add compatibles for
 Loongson-1 syscon
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-2-keguang.zhang@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824125012.1040288-2-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 14:50, Keguang Zhang wrote:
> Add Loongson LS1B and LS1C compatibles for system controller.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

