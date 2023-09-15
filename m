Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BDB7A1F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbjIONPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjIONPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:15:39 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DAC1FE0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:15:34 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso33549711fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694783732; x=1695388532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YTcLJQwSswCsEHlsNnjpEpmfVQ1cqhA1Es4JBakSFY=;
        b=Y+RW2L6LaQ/oMzReRpbt51RwdVDhxgNJTAPKwx87sJVW3wrT7bT05ucCiLXnY3z7RX
         KkzQtIbVmers550bECCbyQfz7fUIkWGv0RCNS0kWt1k26pqYWyfwEyiE1a4oxr+MMOrR
         LqQNALgpWCcqiR5FmgeePerrbIWawlQcdHmzqMRGvCdVtts7Y78eVYq2pIN4xKlT5o8J
         dVB7cnmv2rhDxzi+ZJuoj+vKwzSeok5zpL19uqR9FC+Yr5mUP8eFULev/dTezT42Svr8
         1tJuhs38cBZpwKsGffA/vI/VUPc3KMsNNowJf9e6OdcMbagQpwxgd7sbAKc3e6X09ldl
         jZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694783732; x=1695388532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YTcLJQwSswCsEHlsNnjpEpmfVQ1cqhA1Es4JBakSFY=;
        b=BmKfz7mEzdcKP82yt5JRtlbMZ7Ib9jfOwOnHwzgIaUYprql6JxEgdE6Jq8qgnI0jaI
         qx1fk6y+2b7rR5fl9wPm5dxoJo0vDBT2aNeWmZ+kR/d0v6hJg7MRjsg/ysMzG+/IFY/i
         cqlvXMKYE8Frw06ZDVa9Ee5JcmYKi+OE5Jhq8TsSPuQZ6Ou48iBLr7NiikHldTLzBqY7
         KUDQLrIfudTmhk1Gur8KgmmRX24Yk3SyNDAMpzKVpDO01xHOZLyIPRtIuSuFaFSJVmRE
         XVaG6v6atpe+VigzYA2O6ZpJ2DEbsS66a1lP+uIZM9EHEyUSbFgfCiVi2JdfAK7+sscs
         2UyQ==
X-Gm-Message-State: AOJu0YzvvP3OjSw4yDC34iNlzJveU8Uh18U1I9CU4Yl2ujiLJ/NRG/3B
        8vj9RYwiKrl/IIk9BCQxkLKTww==
X-Google-Smtp-Source: AGHT+IH9HHhAAiakkwGcb0nc6A/BR1ro4tRIpIJUd3BkPy0wX1M6KcFTvJlfvmgHfIQfhqyIgcdVgA==
X-Received: by 2002:a2e:9246:0:b0:2bc:c51d:daa1 with SMTP id v6-20020a2e9246000000b002bcc51ddaa1mr1661473ljg.39.1694783732549;
        Fri, 15 Sep 2023 06:15:32 -0700 (PDT)
Received: from [192.168.69.115] (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
        by smtp.gmail.com with ESMTPSA id wj18-20020a170907051200b009adc5802d30sm1507895ejb.21.2023.09.15.06.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 06:15:32 -0700 (PDT)
Message-ID: <759af455-312c-745f-8532-bae30b64df02@linaro.org>
Date:   Fri, 15 Sep 2023 15:15:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 05/17] pmdomain: bcm: Move Kconfig options to the
 pmdomain subsystem
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-mips@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
 <20230915092003.658361-6-ulf.hansson@linaro.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915092003.658361-6-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/9/23 11:19, Ulf Hansson wrote:
> The Kconfig options belongs closer to the corresponding implementations,
> hence let's move them from the soc subsystem to the pmdomain subsystem.
> 
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: <linux-mips@vger.kernel.org>
> Cc: <linux-rpi-kernel@lists.infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/pmdomain/Kconfig     |  1 +
>   drivers/pmdomain/bcm/Kconfig | 46 ++++++++++++++++++++++++++++++++++++
>   drivers/soc/bcm/Kconfig      | 42 --------------------------------
>   3 files changed, 47 insertions(+), 42 deletions(-)
>   create mode 100644 drivers/pmdomain/bcm/Kconfig

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

