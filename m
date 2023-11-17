Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697107EF70A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346168AbjKQRhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346146AbjKQRhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:37:17 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605B3E5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:37:10 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50949b7d7ffso3231207e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700242628; x=1700847428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qPWfawxMvCCwqgwMcoz01kVUlEDZwsGaKlCMKco8RAs=;
        b=EUHekREu0jCPjysi23dKCma4wjjQv4tXXanOI7xgbWblA++fHFQ0InQxfh/3OGuUy+
         mgO/NfO3oC49RDpqkLjSJ0+FaLr74gQ+lbjuCsvkYtyAJL0Uhhg7huTZzyzNAAeAkBzy
         cIv3nvmf+JEHvtCsu4sg3h21Ma3C6YCnf9p4qs2RI/YkibdqPY+Z93eZCF8iYtqQ8qFQ
         5McSAU8KeTfaiUUAqIXr6eyYGdouB2EheCP/XunFKg79wdGFKk077ylOXp2TfY3Ms8w7
         /Ovdd6iRjz5D8TMzbtLGCPLY2rgbaVemqhZ7745y3vzPCW3I/f2XMWvpeyF9JKMrU3hn
         mRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700242628; x=1700847428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPWfawxMvCCwqgwMcoz01kVUlEDZwsGaKlCMKco8RAs=;
        b=e3kQywpP2po0EGgfUaRgqRbSLxrzhVUAueSEqReUxHsXEs0kEaEXN9OUhlbRGPr/hW
         axLdKsUafjRdNVwrKXqSY2aXjNrPI6zA4Liol4h6ibpIXtZsQkiR3DPtdoTFafLURANQ
         WT1AAAybNgX+9G8TTUJinezt1+6p5YTZ+JduAJHBuRKKa40W6Whe7Gm21GwRWBe20iTU
         VoK27NvMJcTeIVpaGZOi1zaC4UFL09H3BbhAMOLgLvaQPlJiovPq0O/WznGNEdCnJMOQ
         gE5JSfIHQ6qNBLCRPTQ4JwtKl8k0CaYgEQpcdQyaAL+1I904h21pynKZNG3CM0b6Cxxr
         57MA==
X-Gm-Message-State: AOJu0YzatJ0+qCQafiu6GUoYkhw27RMRsbsmVFhTEc3Po1VM9sqKmYfs
        +hzqSYb5OVhUg9fHMoopilLYLQ==
X-Google-Smtp-Source: AGHT+IG8vNGCKqG775W9hqhVbWFrKq/2354SflCixUg3G4oiDXO4NcB1WZozj6WQ/9GOg8GMkwEY4A==
X-Received: by 2002:a05:6512:48d6:b0:509:49f1:b7c8 with SMTP id er22-20020a05651248d600b0050949f1b7c8mr211662lfb.21.1700242628451;
        Fri, 17 Nov 2023 09:37:08 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm2918402wrs.26.2023.11.17.09.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 09:37:07 -0800 (PST)
Message-ID: <f41954c0-e303-4d6c-b308-d0dfd00ee251@arista.com>
Date:   Fri, 17 Nov 2023 17:37:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 net-next 23/23] Documentation/tcp: Add TCP-AO
 documentation
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Dominik Gaillardetz <dgaillar@ciena.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Francois Tetreault <ftetreau@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki Yoshifuji <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Mohammad Nassiri <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20231023192217.426455-24-dima@arista.com>
 <2745ab4e-acac-40d4-83bf-37f2600d0c3d@web.de>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <2745ab4e-acac-40d4-83bf-37f2600d0c3d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On 11/17/23 13:07, Markus Elfring wrote:
> …
>> +++ b/Documentation/networking/tcp_ao.rst
>> @@ -0,0 +1,444 @@
> …
>> +                                          … failure. But sine keeping
> …
> 
> I find this wording improvable.
> How do you think about to use the word “since” here?

Nice, there are people who actually read the docs! :-)

I'll send a patch crediting you.

Thanks,
             Dmitry

