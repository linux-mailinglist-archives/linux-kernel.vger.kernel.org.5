Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23D87C7DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjJMGeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:34:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225D6B7;
        Thu, 12 Oct 2023 23:34:05 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-690d2441b95so1307873b3a.1;
        Thu, 12 Oct 2023 23:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697178844; x=1697783644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlyxdoKFTBR7H37RyMaaqc2SXLDQKwDfSpSCip1FF40=;
        b=jAWRjCG7YzmUSQmV1asZm4CLbRN36sSL7rc7m6BokdLB+XGIBYV0d4Eh8OFaiqs6E0
         tY9Yx9UsuVYIEokHVPOa1m3EznLJJQTGnODGOpHLNwHVykZmVBcVmAxNTOI11yC9fxM/
         RxIFsWwcHnWTDV9/taPakRUAsyH+bv2jUiBsmhmzwNqjKxzXFIu4ogDRcl1Xtum8XUsL
         mA3GZ5lNnaAbPWTNNugqU8k3YFNjc6UTG+saUqsaeqFbNnn+DxI2o8iOJGlIdV6h3rsX
         K6yDbaRnqxKGtyU852NC6LpwI8vVCiCjlSk6lXzgJKQmn1yeKed3I9ICLSP1rDKNDm3P
         fEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697178844; x=1697783644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlyxdoKFTBR7H37RyMaaqc2SXLDQKwDfSpSCip1FF40=;
        b=iqvPP8nPq+lhsOpAAVN9hQVLO6bLPPhS2ZScBHgb31cLjD2AanN3of/jNLDcitTr3f
         bkoNACkY28NYmg+Zstziu2NBRU+/6dtJYNBloQtRxtNpxFWPiTTgiz1QErDklma62Vd7
         7SQpme+jMcVdgJK9hLtvDL9Jpphzd8ORLzj64N9Rzf4TRkSEvjJ7RHJM+Q0OlavCPH5X
         jFeBW8ihYjxC+HkczAgBZQTQfFGXD8Jixucv+nLMxS5Z5os9RpooOu4MQvMIV9KlfczC
         VD4pWPKsVGK6818R7YHTpLRgGoBlvlSp1t6pid6qjKCLRGvWtqhcOgOuh6YhJlTMXhR/
         +VzQ==
X-Gm-Message-State: AOJu0YycJ5gtrxtaK8B2xutONWluLcA2LfdN/tx5pStACT7VclTXLQyF
        x5oCblwxjdluHprWLUIi42Q=
X-Google-Smtp-Source: AGHT+IFMqeCIwFuVA2/nNRWlGg+AY/FGy848VY3mLigyKGAck5vRgNV02djitq6F/D9TNdeX7Jr3Aw==
X-Received: by 2002:a05:6a00:4519:b0:6b4:64ac:eab2 with SMTP id cw25-20020a056a00451900b006b464aceab2mr481819pfb.1.1697178844407;
        Thu, 12 Oct 2023 23:34:04 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id m26-20020a056a00165a00b00692b0d413c8sm12871539pfc.197.2023.10.12.23.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 23:34:03 -0700 (PDT)
Message-ID: <ea4e278f-3dc8-43d7-9413-1aa1b1e620ab@gmail.com>
Date:   Fri, 13 Oct 2023 14:34:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: reset: Add syscon to nuvoton ma35d1
 system-management node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20231011090510.114476-1-ychuang570808@gmail.com>
 <20231011090510.114476-2-ychuang570808@gmail.com>
 <54cbeebb-ba15-423d-8b5a-755571913031@linaro.org>
Content-Language: en-US
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <54cbeebb-ba15-423d-8b5a-755571913031@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,

Thank you for the review.


On 2023/10/13 上午 03:30, Krzysztof Kozlowski wrote:
> On 11/10/2023 11:05, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add compatible 'syscon' to the system-management node.
> Why? Commit msg should answer to this.
>
> Best regards,
> Krzysztof
>

I added 'syscon' because system control registers are mapped by this driver.
The pinctrl driver needs to access the system control registers through 
'regmap'
with a phandle referring to this node.
I will update the commit message to provide a more detailed explanation
of its purpose.

Best Regards,
Jacky Huang

