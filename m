Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A653C76C445
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjHBEuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHBEuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:50:16 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28991BFA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:50:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so67467705e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 21:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690951814; x=1691556614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yaqardF0pb2/HEf8H3F4BSFfwImn9MsiTj+RKr8iF7M=;
        b=dBRE6JLQWDPZSUFSDID6jOWxqb31u/DKaULTPfN1g9VD0mBwq1CKBAtC7hXBRMZ701
         SF8epD3D+d5DnMrbja2CJKZWV+fQ1rFNR2Loh150/FuMV+wz0oVxml3CH2Nxvc/OvlPt
         R7KPbwHAWQyIhyoDav3afhdighd1fW1vosFcVCS1XwrV/xDT/QYswDurPjZzPpoA6pn5
         eb2dFv+JQjFkTO1HWj42mBpioeHql4jrBWULooFkYO8K5OVpyH0SWaMCSj/o59g7g+ZO
         GOSAMRt68Yt+1sM78C8Y92bQzgJxMKmNhDMicMkij7horHdGCvWD4+oectZstryBpI1a
         dodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690951814; x=1691556614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yaqardF0pb2/HEf8H3F4BSFfwImn9MsiTj+RKr8iF7M=;
        b=j0Syd5mpB5z1xcazCQeyIE1PgJOCptX/Z56NIuUSQ48Vb3od6YTH9B+PkSoeFCpDpK
         cULJ3CgoE/vQrGWek8htLzxZi4kx2t69MheGI6CgCx6Zx/mCWJdh+mGzA7ZFYTFWzHkB
         RCSzDUYca/9vIta4LkPz4Hr12Cf5kRkugdGWAQvKzW6/iD/tex03Yq1MW8KVUIl1T8sl
         HSGt0G+mdCjcKO9zE3arcOvagybLXVKcvehSyvkwUUUoOqyfcdbbbZEsQoh4Ndv7Ir1d
         N/u5JCMpWbUgqAscd/26EpW6hZuRo/qW+Zz4xqtXMeMJPGYqeNj+3TxD8ZTnsPiLK2RJ
         H+Yg==
X-Gm-Message-State: ABy/qLYTWWE3lSSzrm41b+K//hvWLJZGTz4nQFNduBLwBpOFx8Ym4PrQ
        NYlcpqFwxFZz2g4UPk4Xk4+6xoBeLHq5xG0C4rW0cy+E
X-Google-Smtp-Source: APBJJlFGNgQ0IM3+wA4Mu9KisUDZJtMLF1CX2PC83Ksm6JaIYzitNCS738ZBU+Yw3HQMD06fF6huog==
X-Received: by 2002:a05:600c:ad6:b0:3fd:30f7:2be1 with SMTP id c22-20020a05600c0ad600b003fd30f72be1mr3558887wmr.39.1690951814293;
        Tue, 01 Aug 2023 21:50:14 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id m14-20020a7bce0e000000b003fbc9b9699dsm561651wmc.45.2023.08.01.21.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 21:50:13 -0700 (PDT)
Message-ID: <b52c3d0a-7cc9-f606-2e1d-ab44d6ff0b31@tuxon.dev>
Date:   Wed, 2 Aug 2023 07:50:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: dts: at91: ksz9477_evb: Add missing timer nodes
Content-Language: en-US
To:     Lukasz Majewski <lukma@denx.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230712152111.3756211-1-lukma@denx.de>
 <20230726101902.769f6541@wsk>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230726101902.769f6541@wsk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.07.2023 11:19, Lukasz Majewski wrote:
> Dear Community,
> 
>> Without this change the KSZ9477-EVB board hangs just after passing
>> execution flow from u-boot to Linux kernel.
>>
>> This code has been copied from at91-sama5d3_xplained.dts.
>>
>> Test setup: Linux 6.5-rc1
>> Config:     arch/arm/configs/sama5_defconfig
>> Toolchain:  gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabi
>>
>> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Applied to at91-dt, thanks!
