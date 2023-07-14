Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF102753066
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjGNEMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjGNEMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:12:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A090C271E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:12:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3143798f542so1584773f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689307938; x=1691899938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8CTz13Ju/w9ax8ItZAVN5IBS20v8dpfE5mavSr6QmY=;
        b=d8qAos+3KnkGz93yO8WWHVCCKmxnxkGJKeWhWxHc2Xf0lWJ+2zUVBs2HZFPYhq/2Pm
         4zPX3OgolxCGO1rMqd6s88CbhTvUOVLtmkJOQEsFPl7k0lGsxYnVaXJvROUB0NDjbo3l
         2/o94arb7IgUTDblGtpvp94s9BD8UFCD9+ak0hrLyz3PzaQ2mvVaEk7jJeNC7Yjsqs4d
         GxfZ2oZhhx3TUj2HxkSv0bxAAJySlFXwP5Qa9rJ/Xd/4NtTwoIp6z3ekzp1TMkM8qa6b
         zzrC7qElNpYTiy9Oe6fJVxL+2uEOUqefUOWv/DXabeqQP3kJnrAlKD/B4fI/vz1h8U96
         njYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689307938; x=1691899938;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8CTz13Ju/w9ax8ItZAVN5IBS20v8dpfE5mavSr6QmY=;
        b=RMKG3j8uLyk6sgll/XWo++ubcS9BWDK+QM36j7enH5mev+0rPvcfhuse0N6JlAQNW0
         2TudBZcr0URtMSsq/drfTL49oGMX5Fr6rMgC5rWweyDD0IyTsymCA4jLYEniczlRkcvn
         YuX9mrp33qF2PJPIhY7FVAU0mU/VfTRb4W+GEatyJjSJXmK2IVUocsS6huSv4T7ZHdbn
         08FtoxCtBlxTgkAgmArdKw2Nuo/6qAtFd2dDUy5x1NR1raiQNYboYDWuvJJpaEJ5nz7i
         poFtD1Hv6enfMxNGbH2KRN03zrjYrjSNdCTbIraBmt6aBiLPlC1g95Vm5ErctgXMdL5P
         Hv4Q==
X-Gm-Message-State: ABy/qLa7uCNkDfaiRkPae3UQyVFOcmPUvvkIEWccMtjGLupBwPDDerGx
        exolxrAaFHHzNyYwQHNW7EMP/A==
X-Google-Smtp-Source: APBJJlEiIEZ5oNA1kHIlijl6CR0KNtgyfSCPe+BnecIDGB/eed9crKM0HAEf5FXJE7lQ0/sQpDohiw==
X-Received: by 2002:a5d:68c6:0:b0:313:f235:cd17 with SMTP id p6-20020a5d68c6000000b00313f235cd17mr3038668wrw.40.1689307938125;
        Thu, 13 Jul 2023 21:12:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id r12-20020a0560001b8c00b003141b9ddab3sm9566447wru.114.2023.07.13.21.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 21:12:17 -0700 (PDT)
Message-ID: <627bcf48-d9fb-5bfc-f45b-f9cf614d081d@linaro.org>
Date:   Fri, 14 Jul 2023 06:12:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/2] Add Facebook Yosemite V4 (AST2600) BMC
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230712073752.54624-3-Delphine_CC_Chiu@wiwynn.com>
 <20230714023502.3225096-1-Delphine_CC_Chiu@wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230714023502.3225096-1-Delphine_CC_Chiu@wiwynn.com>
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

On 14/07/2023 04:34, Delphine CC Chiu wrote:
> v2 - Add Facebook Yosemite V4 (AST2600) BMC
> 

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

Best regards,
Krzysztof

