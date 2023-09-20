Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD627A8E66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjITV0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjITV0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:26:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F4AC2;
        Wed, 20 Sep 2023 14:26:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c451541f23so1971905ad.2;
        Wed, 20 Sep 2023 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695245203; x=1695850003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=th/9vupS9N7HihfI0m/+P7N+XsjQ36n+EjQPTEIq14I=;
        b=CPUsygF6zqdih2nh2wcY3coUu84LOU8sRYZ07S8bK8DLWFdZ3GKiXwOez+5KWG0Szb
         ycIYrIDK2USTS6AiXkS9o0sMYIBvSfa1GnpqHiJZOHPZfgGOcd4zP/unfhxzxOpGCaEe
         u8AjOkok1yV9sbgfOjJxErfjjGnSe2V9P3eMFIgBB1e5fibIefm0BXkcT1JzNow0qqrB
         1po9rqADrbNGvk+Im5rtHbHTdPnMODLExcQ2URj8f9cD7WFUUc4v1FBYua6Fo+oKAbSQ
         CSeB442Aso6fAnK5j2nRsctN7x+89drkHRI6Hhqm32NEd38WsP3RI3gopPncBYNxEedc
         s9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245203; x=1695850003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=th/9vupS9N7HihfI0m/+P7N+XsjQ36n+EjQPTEIq14I=;
        b=DYPPAsknFxzRYmBHge1zkexlsWL2odrAVXMZgg4tHSgKccaUses6a64y6g85pDXhmu
         FGfwGYnhJYKuA+RFThiCIsOXPVbAF+zR9d39s5k8VFF40w2AE28zvCxVMyRJlHPSGYeU
         V/mF+6dp7p74W5JT9yGxede6Hvcdm/UBcB3M6fvHbrtubjS6U3bls8HPst6CNJgTmoTM
         LRCwFl05Q5KvE7nPW2eE4IF02L+WOQ5QYLd6VuKnMGzGwSJFumkql3cn5zFotgrS2wQr
         4BHh0tNy7wqsGaUwOtc5/SqRQ5T7GHvR3/YpqZJYkNmjR8/YDeZJ3whNoIFkMMGYNak4
         xiZg==
X-Gm-Message-State: AOJu0YxckqhH6L7cXlY9iFK3uHbZkzIN5a/rmkakau+fibkPHUhSWyup
        zhYjItKK7NQjXBuPqADYZAw=
X-Google-Smtp-Source: AGHT+IEOsqM6Xh264zpMWkX1cDMJLNbPPNEIJ+IJqNX1hlerdUWDS0HXlHp89YL8w/V87LAf2MOU5A==
X-Received: by 2002:a17:902:e811:b0:1b5:1467:c4e8 with SMTP id u17-20020a170902e81100b001b51467c4e8mr4358490plg.15.1695245203607;
        Wed, 20 Sep 2023 14:26:43 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t3-20020a170902e84300b001c3721897fcsm12195575plg.277.2023.09.20.14.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:26:40 -0700 (PDT)
Message-ID: <8b9355d7-a5b4-2138-0d23-a1511ec677d8@gmail.com>
Date:   Wed, 20 Sep 2023 14:26:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/6] watchdog: ar7_wdt: remove driver to prepare for
 platform removal
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-5-wsa+renesas@sang-engineering.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920201035.3445-5-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 13:10, Wolfram Sang wrote:
> AR7 is going to be removed from the Kernel, so remove its watchdog
> support. This allows us to remove the platform because this driver
> includes a platform specific header.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

