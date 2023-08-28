Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A13B78B61E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjH1RLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjH1RLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:11:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CB3186
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:11:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99cce6f7de2so446673566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693242659; x=1693847459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EVpQ/sEJMXX+kJm+GyyE29h4etZD3k3PLHQlncbkWnk=;
        b=D/SW53fhf8VrQ5lJnCNZHsrzDZhnWFsD7p4TMODQSe7JwQAQoMmTB10liIcUSKtNAg
         LwR5IWMxY9AWo634sxr3hChqpsatMtfxPjYqf4iorTYlJoFJdhBCsAyUC2TwZY+yMNxn
         cmdxZwmeInzaFFH86SkB7c+7ieKk/UJazgBCNaZaRpuNqbfssGeNINELVW6sf3KW6BZq
         zRigVEdKWcvVHgHVhPU0nQljCjmjyJDGt8Z7NimYFE6L0w8lxHaQXwCjUtNTkJ5KV43m
         XdWEXR4syi0jJy5bASr3qqAMOaQitQArClBczQB43zxJzWQZDlA0Lr6mh52qZjk7ydKq
         iftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693242659; x=1693847459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVpQ/sEJMXX+kJm+GyyE29h4etZD3k3PLHQlncbkWnk=;
        b=NXXFYCxdd1cRrvcJuDrYiQhoaGhcmpA8ig0TPOJuWTOa+Zoy2YtiSWOSCpieH0FvZu
         d5E5Rm4pbaeXE1ziUf9oOgu+8YjgtDLEoUPoYXGpNmWur62fvqXB3cHCe7Lp1br/3Xof
         +sDrGtcau/eyX+BeugXZV8vY8SxMrKlULBjQbtHI6uJvJGOWxPTv6tcTUHt0/bM1SSPi
         g/xbjxZib4W1jKGwTjr1LhpOrkVB9DEcNTIgGves3eS5wttE/hDek7wxbTBKr5fzjI5c
         UHU35le9pwCZLI2Aoqj4YXNqhLnikSoGZPcLLnIBMSWBMHXbxbIiIdF77BDh3N6U/3Hv
         O80w==
X-Gm-Message-State: AOJu0YxdNzndhztw4+W+VCWi980dwa/T/lcvDpBq9deZcZ2ugWzMMnit
        nMWQ9y1Yx79GHWa05NUsrxnfWw==
X-Google-Smtp-Source: AGHT+IHi4xv34woK1nBgfW2VEtCq1AYYhJy6Oirt48MbuAkrveaTIuZx3KwuZGABpegca5nmsDb1cw==
X-Received: by 2002:a17:907:60c7:b0:9a2:2635:daab with SMTP id hv7-20020a17090760c700b009a22635daabmr9198583ejc.47.1693242658873;
        Mon, 28 Aug 2023 10:10:58 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id sy22-20020a1709076f1600b00992d0de8762sm4795624ejc.216.2023.08.28.10.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 10:10:58 -0700 (PDT)
Message-ID: <51fe3126-16ba-ade6-b106-e3683f96ad26@linaro.org>
Date:   Mon, 28 Aug 2023 19:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Content-Language: en-US
To:     Shenwei Wang <shenwei.wang@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
 <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
 <PAXPR04MB9185957B729588D3E7CA3A5089E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB9185957B729588D3E7CA3A5089E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 16:04, Shenwei Wang wrote:

>>> Are you suggesting to move the regulator-pd to the imx directory and
>>> add a company prefix to the compatible string?
>>
>> There is no such part of iMX processor as such regulator-power-domain, so I
>> don't recommend that approach. DTS nodes represent hardware, not your SW
>> layers.
>>
> 
> That's not always the case, as we do sometimes need a virtual device. 
> As an example, the "regulator-fixed" acts as a software abstraction layer to create virtual regulator 
> devices by interfacing with the underlying GPIO drivers.

Not true. This is a real regulator device. Real hardware on the board.
You can even see and touch it.

> Similarly, "regulator-pd" provides a software abstraction layer for virtual PD devices built on 
> top of existing regulator drivers.

This is not related to regulator-fixed at all.

> When looking at the conceptual purpose, regulator-fixed and regulator-pd are comparable in 
> that they both offer software abstraction layers for virtual devices."

No. regulator-fixed is a real device. Yours is not.


Best regards,
Krzysztof

