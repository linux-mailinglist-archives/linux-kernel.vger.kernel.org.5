Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD578DEC3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbjH3THj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242214AbjH3H31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:29:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41504CCA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:29:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-500c7796d8eso1679389e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693380562; x=1693985362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iakEJtZPdxSu3loWtUm60QLK0RtulO60Tw6Q/Ct/Ti8=;
        b=zjrtGskQGRNzYFBEtelRu0WOODjFB5qmW4XHwuGNlTe7C6qoQmlNWtxKzCg4qrDOF+
         QRwBkWfVtAm/GTWxJpGXbjpJqe7DolxHb9q1WJcTezpYYcxKXpm1Vxx0wtY0AtsHRI1M
         Gl4+2kdSpisDhe7oZJ2DZaCHoN1qd0PuaXEnHMN3XQS+LPEVIkB6tEUQZcw2+6242g/K
         ueCwMYuf/EeD2WomViR4nqxk/7qwl8m+fq2POmQQz36mbqKVGD/tx8VMCw1MmX1niwiZ
         Vu7mxtB+6nGljZ5IoIUiOyir4WWxxLI8OSraITmTd2TskUapq56stSUN5XghpXtSejxQ
         8OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693380562; x=1693985362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iakEJtZPdxSu3loWtUm60QLK0RtulO60Tw6Q/Ct/Ti8=;
        b=iVuRdnb2Lv1jdiMgAbrFcGHEPrVa8757ywxy/2wl7hBFa4hh+xaWG7iKPPqbhIQrzV
         uFKYkUI/XIBnLkRNQ3P1aix6yZ081tPV4WW7jzTVahRla+oeKuJgmFMkwWRdKHnGNtM+
         lfV+LobGogJkn1Gi1x3eH1qnsP06RxJChI/5FZZMM3iH+zh+BBCIa2/u6IAmw3kPrNw9
         9Ej2cSmL09eERKvLNkNypiGGpVt3pa13h6iqFngqk876Z6m/gcqSjhqj2WSeoDEHgTNz
         NIeLusYqE+9WL4RCk/w+uf1npdgO0Ow0wfQRASWezMgOaNOcYYi+9emh3j56EIl8+fN1
         0ocA==
X-Gm-Message-State: AOJu0YynJlK3YnzP0IsDtUWDwUN9x4bxdeWM7swtXm+/z/Td1P+n8wAO
        P9IHeqFGAoRnin/rFKqf4YjH/A==
X-Google-Smtp-Source: AGHT+IEGnWlpcrzRAyVDAFi6dDUGQjQoD1ziGKw9kQ9wLhBjpqukVGu9aK7EcgK7UhYkENFAmJHs5g==
X-Received: by 2002:a05:6512:3d09:b0:500:7efe:313c with SMTP id d9-20020a0565123d0900b005007efe313cmr1135381lfv.24.1693380562262;
        Wed, 30 Aug 2023 00:29:22 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id b14-20020a05640202ce00b00522572f323dsm6417426edx.16.2023.08.30.00.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 00:29:21 -0700 (PDT)
Message-ID: <b375b88c-0d9c-30a9-21f6-283083cf3880@linaro.org>
Date:   Wed, 30 Aug 2023 09:29:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Drop unused properties
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20230830031846.127957-1-william.qiu@starfivetech.com>
 <20230830031846.127957-2-william.qiu@starfivetech.com>
 <20230830-commence-trickery-40eaa193cb15@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230830-commence-trickery-40eaa193cb15@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 08:50, Conor Dooley wrote:
> On Wed, Aug 30, 2023 at 11:18:44AM +0800, William Qiu wrote:
>> Due to the change of tuning implementation, it's no longer necessary to
>> use the "starfive,sysreg" property in dts, so drop the relevant
>> description in dt-bindings here.
> 
> How does changing your software implantation invalidate a description of
> the hardware?
> 

Which is kind of proof that this syscon was just to substitute
incomplete hardware description (e.g. missing clocks and phys). We
should have rejected it. Just like we should reject them in the future.

There are just few cases where syscon is reasonable. All others is just
laziness. It's not only starfivetech, of course. Several other
contributors do the same.

Best regards,
Krzysztof

