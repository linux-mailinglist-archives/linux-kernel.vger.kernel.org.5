Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1EB8802E43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjLDJOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjLDJOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:14:42 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83B0E6;
        Mon,  4 Dec 2023 01:14:48 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce5a0c37cfso238169b3a.3;
        Mon, 04 Dec 2023 01:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701681288; x=1702286088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=td7arQQdUq802c/iq8WzPBS2L5rlsrypnKsRbx7YZ7Q=;
        b=ng6vYGRCQP/ncD+Qvk22Gm7VEtdsYHiJGUlXc5AryQKJhrHw+02TbWkWR7LNKzrx3A
         NbYb6zuImU5SO+QrYNIHtsTIq6yuvGQs5BDzZEOhyRXbAv2vy+JN9SlqJ5D/YpG0IAPV
         Uk4mk+29kR4HA2mihb0fD460OOFipO87UcXLNQeBKOv+Ibj8gxtAmeopX2vWfyjWf5VJ
         6mEbxn2k4A8lykg58oMnBF7bxtBuqkEYg+dt2DAGdSOP0PhOV00vIIoe4zU26NtssS9R
         kEyB6/QtprfIhKKAf4mKV/Z5QJBjfjlDnUAqw9victdBSh0cpEiFXPefIqDNiXdw9j9N
         7kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681288; x=1702286088;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=td7arQQdUq802c/iq8WzPBS2L5rlsrypnKsRbx7YZ7Q=;
        b=Xj5RIA7wPzeiw5/eE7RRAccAfAyRyVFr4xzE1fpn+Zcf1K0bLuuP6tZu1yX32FYJFr
         eqr2XapZ/4GnKfT1TQpKTAE9TD1AVT7fNFefHNMjmQ9GT52WIdeZAMBXOY3je+ZjCblU
         usD9NRVmXytpnn66DkIQEy5/OUUp7Cb8AHtEdWqrgckUIr4te5A2DfgjYZTvQG7jVeuI
         fUIktclcf0Hz/nsoOLodZZb3ggqFgZpPfhrE8wnuy23uCR0JxoS3yV5t2PF+laFqskV7
         PUhGMLUsI6YCFM8fjq/BnqxPgiKG5sRCs4EK9XM30EFsGWiPTkXXujcw9SLbwbHuxMSP
         n3Rg==
X-Gm-Message-State: AOJu0YzMG2IqE0HaQqlljRgmUjjlv3iEJsNDltHxFuPNsFTx0YjTojq8
        DtSyzMFp/N1gkXeMNr60blc=
X-Google-Smtp-Source: AGHT+IFXKxEEFX8vP4aBeoqt1BTZEmVpqXJif6onxC1JfujMmktO4OxKGd9+qeCqhfM51JReO+Rvfg==
X-Received: by 2002:a05:6a00:3495:b0:6ce:5312:c413 with SMTP id cp21-20020a056a00349500b006ce5312c413mr660791pfb.15.1701681288078;
        Mon, 04 Dec 2023 01:14:48 -0800 (PST)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id m17-20020aa78a11000000b006be4bb0d2dcsm7349362pfa.149.2023.12.04.01.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 01:14:47 -0800 (PST)
Message-ID: <ad6fb2a1-c376-4e03-8b18-12b228799bcc@gmail.com>
Date:   Mon, 4 Dec 2023 17:14:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Add Facebook Minerva Harma (AST2600) BMC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20231204081029.2272626-1-peteryin.openbmc@gmail.com>
 <fddcbad4-5368-4c2a-ba87-f4c4326a8385@linaro.org>
 <3ff5dcd7-69a3-4098-92c6-ed1e8f0bd8f9@gmail.com>
 <f2519d16-1b34-4d77-be69-cf80fa3415a1@linaro.org>
From:   PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <f2519d16-1b34-4d77-be69-cf80fa3415a1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Krzysztof Kozlowski 於 12/4/23 17:06 寫道:
> On 04/12/2023 09:46, PeterYin wrote:
>>
>> Krzysztof Kozlowski 於 12/4/23 16:20 寫道:
>>> On 04/12/2023 09:10, Peter Yin wrote:
>>>> Summary:
>>>> Add linux device tree entry related to Minerva Harma
>>>> specific devices connected to BMC SoC.
>>>>
>>>> v4:https://lore.kernel.org/all/20231204054131.1845775-3-peter.yin@quantatw.com/
>>>> v3:https://lore.kernel.org/all/20231123050415.3441429-3-peteryin.openbmc@gmail.com/
>>>> v2:https://lore.kernel.org/all/cdbc75b9-3be1-4017-9bee-c8f161b6843c@linaro.org/
>>>> v1:https://lore.kernel.org/all/20231024082404.735843-3-peteryin.openbmc@gmail.com/
>>>>
>>>> Change log
>>>> v4 -> v5
>>>>     - Rename document and file from minerva-harma to harma.
>>>
>>> You must explain that you dropped people's review for some reason.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Due to changes in the project name and content, please assist in
>> reviewing it.
> 
> When dropping people's tag, the patch changelog (---) should say that
> you dropped people's tag.
> 
> Best regards,
> Krzysztof
> 
Thank you for your explanation. I will pay attention to it next time.

Thanks,
Peter.
