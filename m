Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927FC7570F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjGRAap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjGRAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:30:39 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072D8E55;
        Mon, 17 Jul 2023 17:30:39 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so5150204276.0;
        Mon, 17 Jul 2023 17:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689640238; x=1692232238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EiMZKpl53JQSB9rulZ6MDgvkhDFysXrAr8elkbqn8cI=;
        b=VivF9ac2wYpN3rqbrqWSprPvaOkNZ/NIK0XY89VxJyJunyGIh16wp4f8jMvu2pqOH/
         thf213MfarUJ0udydtgn/qn0+crNQim3t/LUTEPPv645baYrUAgw+s1k0U4PHdrryqiS
         fbJC4aPz8cnXMo09KxcPK7jk5pVtxfzXwoygvqHt21v7FQe3L1P4Refgrmdm6WFWK61G
         HB2Jsh3o/VQxqBFAVMM1ik7OubKpkBnL2iempCfqET/JeAdzwwlf4OfyV/tVrDvkKT3l
         BSp0fJDtcE71xnySuIpw5HkNgir3nY84/Metdt7mSNrqr+ekZVDRNvBo3nDBEdemYU7e
         re4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689640238; x=1692232238;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EiMZKpl53JQSB9rulZ6MDgvkhDFysXrAr8elkbqn8cI=;
        b=MgW8Yh6ZetOK2fhbEEYp5I+yWbSAi1WiDk/Ysu9Iln2ThGwfDtEyLXr6qOw+43KDCq
         uB4XliQf9X7I1rtjZlcUDRysz8r4GXjydr7AbQ7kO2+x/acpdZH3XhmXgpHet1DliA3t
         nt3ULRE2goBREuOp5Nc1s0BcN+B70tHVf7mwB75xT3W2Eat5vAJo5KG583wZ8/yacF/F
         oKyLLBZ0UL2Y8k8UEZ/FXTUE9EJ7Ka9nETHu7OGOCFIiJ8bv46UpX6GaPIIVgkBbnPQo
         0N592mq5QJxBSghQgpnEUItSpTX9gooS3qN6khhIcQpZuyxOJbDiBATU2uh7Z0JWcw2I
         KpPQ==
X-Gm-Message-State: ABy/qLYf+NLdRF6r1yZ8tMkfNYye0IzCsQ8ZeCxkilnc2n2lF/jkLUip
        MwsSyfKhEM7yQd8dNdxCzpPhg1TUbyk=
X-Google-Smtp-Source: APBJJlHNs/rzoUoojBPcaqol1N+YaQJ1LaI6HOB8O8hnGxZobezq44TZtAJvYU7xwBG2wwBTFG9TQA==
X-Received: by 2002:a81:83d2:0:b0:57a:63f:f760 with SMTP id t201-20020a8183d2000000b0057a063ff760mr12601175ywf.7.1689640238193;
        Mon, 17 Jul 2023 17:30:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r74-20020a0de84d000000b00545a081849esm169670ywe.46.2023.07.17.17.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 17:30:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <53d3823c-1ec3-56a3-e20f-5dfdbd2b02f5@roeck-us.net>
Date:   Mon, 17 Jul 2023 17:30:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] hwmon: Remove duplicated include in lm75.c
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230718002836.118268-1-yang.lee@linux.alibaba.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230718002836.118268-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 17:28, Yang Li wrote:
> ./drivers/hwmon/lm75.c: linux/of.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5900
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Already fixed in hwmon-next.

Guenter

> ---
>   drivers/hwmon/lm75.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 72cdc405a3b0..bcfa8193e5e7 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -14,7 +14,6 @@
>   #include <linux/hwmon-sysfs.h>
>   #include <linux/err.h>
>   #include <linux/of.h>
> -#include <linux/of.h>
>   #include <linux/regmap.h>
>   #include <linux/util_macros.h>
>   #include <linux/regulator/consumer.h>

