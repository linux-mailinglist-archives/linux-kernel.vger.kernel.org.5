Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090B77AA7B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjIVEYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjIVEYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:24:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855A8F;
        Thu, 21 Sep 2023 21:24:43 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bf55a81eeaso14400905ad.0;
        Thu, 21 Sep 2023 21:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695356683; x=1695961483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UANZyGmjU/rf/hK8ONbL0wqx5cYEjVcGLbn13RAx4hk=;
        b=EkUs6/RqjqU38xsdKSANVcT6mrEL355Bd3PTIZzqnee/awhfWHIJbDFeIFP2zHbB6K
         iuTu2yaonkwVYdiyQDxhZJaziiK9r1i8qQTZi7hDNpz6g0yX6fK+hv6Qj1FAeIaKt3lr
         saixZ4wCPFVOkMtQYwLFXzOxrt21QtFCT/t1S6nCpr0hMe9w9Q/dH5W1ENgr62yrd0R5
         j8/KbWdKiRcH+ZzAcUs5weMYv6gHIZ0MGAancGssaf1VVbPT1iMABxfbY7DXfUv7G/cG
         tDLH6TRNqaXElCAogs/nNm9iujMQ7nes7zrMv0noGi+8duBddlM62uVHBIYPilsaPceb
         W50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695356683; x=1695961483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UANZyGmjU/rf/hK8ONbL0wqx5cYEjVcGLbn13RAx4hk=;
        b=XyoLTxU1W7KmjAjtsC8tnBMML5oNiVkZ6CZWVfymyAF+CMwRvRp3tj/lyri5n8DGk5
         x5F3WiMdKCnCiVvBg9vUSuwgs+wrgfOsAjb+Pu0UPxmJPxEzUA6RkIH4NmGw+aWm/42H
         yIh0xgpwtqd9Naq8LIdOf3RxdLTtg2bN/HvXIw9uvaT5eimNUa57QfKR9jeT+OSWslFK
         9bcr/yfv8WYXo4EBimY5RBzmMGvX+5bT7HIk4I9CeGFKsheCXrLhxCz4ygWjo8nDV9tp
         wPwa7QZVss0/69Z5UuEZP0xGhVbBG03h2fw4XKnI34pWe6lb/rKeUYXClqKB5cELqjLC
         pYZg==
X-Gm-Message-State: AOJu0YxVqMyV04pOE4W4o5Q7r/MrwcemkGmHS/C1yvXlCPbMEUAIQGLx
        mi1Xgw4hjSSsgnm8BEY+VHg=
X-Google-Smtp-Source: AGHT+IFLeYl/hqcN1av+CN9Hovwsh2LyVNxwX5EzZ0iQs3U418VrmAdETV2vUyQd9SJIl2aRIw9yqg==
X-Received: by 2002:a17:90a:dc0f:b0:274:84f3:d73a with SMTP id i15-20020a17090adc0f00b0027484f3d73amr7685324pjv.28.1695356682746;
        Thu, 21 Sep 2023 21:24:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090ae50400b0026f39c90111sm2290286pjy.20.2023.09.21.21.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 21:24:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <85ddf493-934f-75c4-7a3a-728289c1ee09@roeck-us.net>
Date:   Thu, 21 Sep 2023 21:24:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] watchdog: aspeed: Add sysfs attributes for reset mask
 bits
Content-Language: en-US
To:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-watchdog@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Eddie James <eajames@linux.ibm.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>
References: <20230922013542.29136-2-zev@bewilderbeest.net>
 <91be26169ebbddf3c05cd19626478246cb72a72a.camel@codeconstruct.com.au>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <91be26169ebbddf3c05cd19626478246cb72a72a.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 21:16, Andrew Jeffery wrote:
> On Thu, 2023-09-21 at 18:35 -0700, Zev Weiss wrote:
>> The AST2500 and AST2600 watchdog timers provide the ability to control
>> which devices are reset by the watchdog timer via a reset mask
>> resgister.  Previously the driver ignored that register, leaving
>> whatever configuration it found at boot and offering no way of
>> altering its settings.  Add a 'reset_ctrl' sysfs subdirectory with a
>> file per bit so that userspace can determine which devices the reset
>> is applied to.
>>
>> Note that not all bits in the hardware register are exposed -- in
>> particular, the ARM CPU and SOC/misc reset bits are left hidden since
>> clearing them can render the system unable to reboot.
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> ---
>>
>> I'm porting OpenBMC to a platform that requires that the LPC controller remain
>> un-reset by a BMC reboot.  With this patch userspace can control the reset
>> mask of the Aspeed watchdog timer, with a few bits remaining unexposed so as
>> to prevent some almost-certainly undesirable situations.  If there are other
>> bits that people feel shouldn't be exposed (or conversely if someone feels
>> strongly that the "dangerous" bits _should_ be exposed) I can adjust
>> accordingly.
> 
> 
> Is there a reason this has to be managed by userspace? It sounds a lot
> like a property of platform design, in which case exposing this feature
> in the devicetree might be a better approach.
> 

Same sentiment here.

Guenter


