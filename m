Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C34D7510AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjGLSlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjGLSlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:41:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0EA1BF6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:41:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9926623e367so918732866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689187266; x=1691779266;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZLq4R87R5jkVSAr0Jr+cCgPx8KxznXCRdPr34yo9iBk=;
        b=URtHlRWaEiowfCvOYITa3MImIgJgLbzLL5/M7vhhLaAvwy4rYFwQ18wvKSUx+eW37l
         6QQPPUZhdYTpuJTMl8Ldf5CzoadqI55ahnL5035SaReoO6zn1SoC6do6fgGpNhSC5cIH
         8fpFiQvNt6nEOZoKs0lkJABlyrNuMqO0jFZuziL7BgBJ8vns2GE/RY/K8m+jxwyrYJwh
         j3fKCzmYJ6mAqdb5IpEsjE5FU7epObSDMEM+00TXLELi/TghK/SJ9BCZUFuhh4SjSinF
         K3SW0O8CpXG1nvTNfzzJZ6vF1KYoM0I+QM72l5vRf5JFI5xoGA2EDU1jytwrMiOflKTR
         RUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689187266; x=1691779266;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLq4R87R5jkVSAr0Jr+cCgPx8KxznXCRdPr34yo9iBk=;
        b=FvZRJORuOQ3UqGrzHbSUNCI5ebj76sT8VITSYNt6fpnc537MJ594FFzKr2Kqzdsnob
         EAkmDrX3cOzPtY/Sm3lTK3nX6b3tuqBf54XXxnrMzaXwaMzIz6gWATbqMocj8OKB2A1C
         QGvGw/TS6yFrv5Bt9EgmQTYar8TYwtMWuUE8lPZUMUFMsBbkb+8wMHlNcpU+BomPpPBP
         umh/O80+gTvk6xdQKV8GxuEOih+KJZ+JwShrDJTcXkVymvkFVt07eLS21SqUuxVu5UFi
         ASebQzI3U3eq78fWupIBbW3XBwGr9aPr+O1LxblUtV3aB4XI39qn/oPDfKQKPhJGqsMA
         G6Hw==
X-Gm-Message-State: ABy/qLaC8I5Od8niqTtOzx0PuuWpAr2CMfULswj03b4U+S2MIkQudlxq
        RJUA6uFrdK9eDItX3zGsy1qYdg==
X-Google-Smtp-Source: APBJJlGUI8A1MT5EgsdNqMWJ913RxESWNHMcNmRRo+Kwer8dbceZZOMSNwnt55Yx4PX50rX4+KJmdg==
X-Received: by 2002:a17:906:2a48:b0:988:c3f9:3ad6 with SMTP id k8-20020a1709062a4800b00988c3f93ad6mr16876124eje.42.1689187266121;
        Wed, 12 Jul 2023 11:41:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id op26-20020a170906bcfa00b009892cca8ae3sm2853411ejb.165.2023.07.12.11.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 11:41:05 -0700 (PDT)
Message-ID: <2517e06b-61b0-baa5-cfb8-72d0b05a780f@linaro.org>
Date:   Wed, 12 Jul 2023 20:41:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/7] dt-bindings: arm: fsl: add mu binding doc
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gaurav.jain@nxp.com,
        linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
 <20230616181144.646500-2-pankaj.gupta@nxp.com>
 <a06dbb80-c9b2-3a57-cbc5-b18432b4029a@linaro.org>
In-Reply-To: <a06dbb80-c9b2-3a57-cbc5-b18432b4029a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 15:21, Krzysztof Kozlowski wrote:
>> +  mbox-names:
>> +    items:
>> +      - const: tx
>> +      - const: rx
>> +
>> +  fsl,ele_mu_did:
> 
> No underscores. Drop all properties not related to hardware.

How is this related to hardware?

Best regards,
Krzysztof

