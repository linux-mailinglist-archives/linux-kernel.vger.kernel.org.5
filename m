Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BA97EB84E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjKNVN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjKNVN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:13:27 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1170DCA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:13:24 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1f0f94a08a0so3849894fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699996403; x=1700601203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tb6MNC2wGxuXxd2+cPpsv13ZJEM5y6CPqgenn14e1M0=;
        b=MxIoZLRV5aHEqjlKp7qsOqqzPtD8hcMXH3t6LlELu/r1Mpa6fC7pqSv7f2Sew8TAuh
         PLdRxctPPXX1njpRakQhmMUO4A6VkK/HKfjRZtmv+o8ly2capih78McKUDK4Bpyx9C9m
         /3VJEdEWtKv0wIbtZZ7AbXimu6WR43arQADSG/EZQQuu3DJG1VpY8JIhdlMH6mQ4SCiw
         puY4HODcH8ECRE5/L0yh8LG6rtY/61v5kur3DQFs3TzngHEKRo6LHUSSRaNSnCVekt0a
         cBrkqB7Glzm0/jaTBUYCtBv+ECvR3XikR+1TvX5LeRZ3hEVFChBePhdC+NGBtjMtbwWE
         84Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996403; x=1700601203;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb6MNC2wGxuXxd2+cPpsv13ZJEM5y6CPqgenn14e1M0=;
        b=m7JEghfP8SC5PzTK81xlbSPsUxoe/GhKZr0DPQuDlVBNtVkq8CFmSpTrUwqEtfELvE
         JbrZqNASlsOuJo/JLS8u4nr2Ag39V+JAglm6W4XFE7VbaRBahxTehMKvku23RJObExOC
         pHyNeKh/7GsgznkA82Lr8/RCeDPrL/tZGno5xQErWPc30jErFpHhA8RChOuT79G7CFlY
         KoSg4INHokvEHqXMys6NQpRSL3jhoQ9JfUWNAQQHc33rWiygA7P7k+aEY4XgYjqCbsjj
         MRFOo3zpNNKlny2pvQgr+Kaf6IAIdPx8L4sI5lBk9eSC+0e1SnvtnBE4l0G+trHW6D4E
         jY8A==
X-Gm-Message-State: AOJu0Yz6CJmMBSL8LZz62MBJxLRenHKcgShStTh46WUAYaBfAMIh74QU
        xviJ3VQ+UY7nsWQso2zp6ymP7g==
X-Google-Smtp-Source: AGHT+IGr7ycGTIdJkDJYs4jS9FBfvXGDdbQ2JaNiH72HfeNE9PkawKpgDobAFtmdlhFAeIRoidyl5A==
X-Received: by 2002:a05:6870:670e:b0:1ef:cedd:5c32 with SMTP id gb14-20020a056870670e00b001efcedd5c32mr14491876oab.3.1699996403338;
        Tue, 14 Nov 2023 13:13:23 -0800 (PST)
Received: from [172.25.83.73] ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id o2-20020ac841c2000000b0041803dfb240sm3022260qtm.45.2023.11.14.13.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 13:13:20 -0800 (PST)
Message-ID: <be9a9d55-acbe-4d31-8aa9-cb0ed5945919@linaro.org>
Date:   Tue, 14 Nov 2023 22:13:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add binding for Sophgo CV1800B
 reset controller
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>, Conor Dooley <conor@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chao Wei <chao.wei@sophgo.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20231113005503.2423-1-jszhang@kernel.org>
 <20231113005503.2423-2-jszhang@kernel.org>
 <20231113-washable-elbow-629bf42b9be1@squawk> <ZVIr8VH+29lpSpxb@xhacker>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZVIr8VH+29lpSpxb@xhacker>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/2023 15:00, Jisheng Zhang wrote:
> On Mon, Nov 13, 2023 at 01:36:54PM +0000, Conor Dooley wrote:
>> On Mon, Nov 13, 2023 at 08:55:00AM +0800, Jisheng Zhang wrote:
>>> Add devicetree binding for Sophgo CV1800B SoC reset controller.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>
>> With the unterminated ifndef that was pointed out by the robots fixed,
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>
>>> +/*				0-1	*/
>>> +/*				10	*/
>>> +/*				13	*/
>>> +/*				15	*/
>>> +/*				17	*/
>>> +/*				36-39	*/
>>> +/*				53-57	*/
>>> +/*				59-60	*/
>>> +/*				63-73	*/
>>> +/*				90	*/
>>> +/*				94	*/
>>> +/*				102-292	*/
>>
>> There are quite a lot of gaps here, do you know why that is?
> 
> The tail bits are for cpusys, so I guess the SoC designer want to
> seperate them with guard? I'm not sure.
> 

There is misunderstanding here. You add here IDs, which are abstract.
Any gaps do not make any sense for bindings.

Best regards,
Krzysztof

