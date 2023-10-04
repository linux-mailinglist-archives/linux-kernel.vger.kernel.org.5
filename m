Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010457B7939
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbjJDH5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241516AbjJDH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:57:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011A1AC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:57:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9adca291f99so317829866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696406256; x=1697011056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5Vsk+ralU3n0O47rCc8tQOr+v7R/FfrmtlL/DaMB0=;
        b=EMrjUsf/SmZizdAQbZBlEv8lpn8B9VyDyKo82uPSmTKOjxQGmVTZgYMNTiprhH+bT8
         RPAg704wXBopMZtLSh3fxGfAB/UZM2lGOpvtXo9oP3GMrrqRfCS7SLQxn9YhpH62lJ8C
         Z3ln7E/Y2jCFUIcZDQxu95pIWxKHm2OQrca1lQj4SMWWzdANXWVsZdGqF58B//y42x5b
         OA/zgF2OArH7yNZiDIxUy/bCZkYkaaxDHgJYN3Fph54RM3d+eBDIGwUzmB7SWna1eV8W
         32wStvm1vjTxwQCvdLr5SAJelTgiyfzBtpZ+cJ1Vv63vuUrzWaig+Fie4LYhG6qJAvJo
         FVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696406256; x=1697011056;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5Vsk+ralU3n0O47rCc8tQOr+v7R/FfrmtlL/DaMB0=;
        b=DCjo+2WapwZGiMzGu4pyMHmqPOWcC0xKM3o0v4PspGw7vCDNDhE633VteEDVh2zQ/p
         llWW8HKAx3z/xdrzHHeC++Xb50lS23IqQCS/y6W4JP9rjeyg0cDVvPfVHzsBjl8AS8IW
         EXiAbVpUMbN9cwh3Knz8BRrS4189e07YwmKR+5Q2NaUPbdsT1fFm0zOGMAOWgVCbZWJe
         iZBOGk/vlhynSQ03IDplIbq5AiF7cq1R2k7Vvfmvpfze2KfnyHdQEpGmb3FFZKnT3uWu
         djECvnLMiUmVjA19/+ts6pi/M2twH0YNYEY1X9jVTi0YkAgVQQ2ryTzfe8Z2nt1qt8B5
         ZEDg==
X-Gm-Message-State: AOJu0Yz75j3pAgMphrseidN3/Xo2aL+pcP0xbaBXlfgg8t3x/DrTRfxv
        l7I33FeTyFwO91ZKdW0I7ZTojg==
X-Google-Smtp-Source: AGHT+IExVkG9sutLmv2CCXRkGqFp0eb0ufokjcEUXnRDnQiLLWYXIXB4c/UKg9ZAA39UsmVzRmv4+w==
X-Received: by 2002:a17:906:4496:b0:9b2:babd:cd51 with SMTP id y22-20020a170906449600b009b2babdcd51mr1192483ejo.5.1696406256379;
        Wed, 04 Oct 2023 00:57:36 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id s3-20020aa7d783000000b0053404772535sm1975565edq.81.2023.10.04.00.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 00:57:35 -0700 (PDT)
Message-ID: <37021ef8-55e2-4116-8201-2ab7df9e0fc1@linaro.org>
Date:   Wed, 4 Oct 2023 09:57:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] riscv: dts: sophgo: add initial CV1800B SoC device
 tree
Content-Language: en-US
To:     Chen Wang <unicorn_wang@outlook.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Inochi Amaoto <inochiama@outlook.com>, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com
References: <20230930123937.1551-1-jszhang@kernel.org>
 <20230930123937.1551-5-jszhang@kernel.org>
 <MA0P287MB033277186E21A09127407452FECBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <MA0P287MB033277186E21A09127407452FECBA@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2023 09:23, Chen Wang wrote:
> 
> 在 2023/9/30 20:39, Jisheng Zhang 写道:
>> Add initial device tree for the CV1800B RISC-V SoC by SOPHGO.
>>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>>   arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 117 ++++++++++++++++++++++++
>>   1 file changed, 117 insertions(+)
>>   create mode 100644 arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> 
> Hi, Jisheng, as far as I know, sg2042 and cv180x are now tracked by 
> different people and even in sophgo, they are two independent 
> projects(sg2042 is target for HPC and cv180x is target for embeded 
> device). To facilitate future management and review, I recommend 
> registering the maintainer information in two entries in MAINTAINERS. 
> The example is as follows:
> 
> ```
> 
> SOPHGO CV180X DEVICETREES
> M:  Jisheng Zhang <jszhang@kernel.org>
> F:  arch/riscv/boot/dts/sophgo/cv1800b-milkv-duo.dts
> F:  arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> 
> SOPHGO SG2042 DEVICETREES
> M:  Chao Wei <chao.wei@sophgo.com>
> M:  Chen Wang <unicornxw@gmail.com>
> S:  Maintained
> F:  arch/riscv/boot/dts/sophgo/Makefile
> F:  arch/riscv/boot/dts/sophgo/sg2042-cpus.dtsi
> F:  arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> F:  arch/riscv/boot/dts/sophgo/sg2042.dtsi
> F:  Documentation/devicetree/bindings/riscv/sophgo.yaml
> ```
> 
> For Makefile and sophgo.yaml such common files, just keep in sg2042 
> entry should be fine.
> 
> @Conor, what do you think?

We do no have usually per-board maintainer entries (with few
exceptions). I strongly prefer this one instead:

https://lore.kernel.org/all/829b122da52482707b783dc3d93d3ff0179cb0ca.camel@perches.com/

Best regards,
Krzysztof

