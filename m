Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BF2775245
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 07:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjHIFgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 01:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHIFgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 01:36:40 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8351D19BC;
        Tue,  8 Aug 2023 22:36:39 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-79095499a17so289208839f.3;
        Tue, 08 Aug 2023 22:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691559399; x=1692164199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ozSe3Xip0veFD/Pau4bFcrazNIB679IK4LW/T8uEi54=;
        b=aSDGWpPklj4hBJB7gFKF4ULIWkRiIJAhVlyZL80MKVKZfhYJHPL/JKWCD1J03xnDiq
         EMYYg7sA6TNocrnyydpfABRDiNClTDEfCghPiifU6jM7WyfxgRbTQadPjyW5PMGdemFa
         XdmQn2BJH02ohBtxtjpX+HaDdIR3LtKRpDeTL17P2atEmqN3PrUZ8PWHxG6C95nAN/Md
         JEVOI3NBcuLV3/L/QsBoEp+9si4jp+GKYrtrdM931BwDW48U5L9gQFnyjbAxstm235SJ
         QITLim9LmQ1bZ0n1I4XEHPkUioLBWAn9MHJB4OSYZml0KAsyKQROS0dgKqGbWXkONWdV
         vhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691559399; x=1692164199;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozSe3Xip0veFD/Pau4bFcrazNIB679IK4LW/T8uEi54=;
        b=iwCyT42IMLekkGVUaEEHgXmhl3oIuLQujtBcghKe1IpDfZd1m4+JuZjgRtV+u7Fl8E
         nkRtN3djqloacjm8GkXCjWAEsU6dgMcVuqwYZL51WT+KMdPsBLgWKRWO8FHhizb2XvK8
         FlqIkeUjmCksAwrnn/77/y2MLu2n1G+gyVEIbK/CQAOBB/wMeknaZNyWBsGRpAtbzoJA
         ojRA7ZBut1T2bghdrz7UZiagbS8WDT3/0//NNgbVUyqtz51Fr99LaacPWM/ymqUyUrr5
         +Jso/ipGYDNZzdZCiWyiM4iJ34QOOgxJfsRPjsnZAoxZRSurOzooWg4aS6FWRrvK9wRT
         TweQ==
X-Gm-Message-State: AOJu0YwAkhZMCA3GAGZTGRrSiS8o8Qzp29+9WQHufzJ+h9XJuFpkXCSc
        RNeDhauGoQU02LTVG4Q5xVY=
X-Google-Smtp-Source: AGHT+IF0qjJpbgtmGOoKd3cMrI5okSDTZY7Vtf7M1eYGF6qtc646IWJLrS7RrWWWdSBh1u9WB/l8yg==
X-Received: by 2002:a05:6e02:e09:b0:349:7cec:db76 with SMTP id a9-20020a056e020e0900b003497cecdb76mr1809606ilk.31.1691559398823;
        Tue, 08 Aug 2023 22:36:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y1-20020a920901000000b00345d6bc6ee3sm3951779ilg.80.2023.08.08.22.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 22:36:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <87dd3019-4eed-1c37-22ad-53ef8e5fcd9e@roeck-us.net>
Date:   Tue, 8 Aug 2023 22:36:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] serial: core: Revert port_id use
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
References: <20230806062052.47737-1-tony@atomide.com>
 <b8829d4b-d221-49ce-b0cd-e82dc79be719@roeck-us.net>
 <20230809052650.GT14799@atomide.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230809052650.GT14799@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/23 22:26, Tony Lindgren wrote:
> Hi,
> 
> * Guenter Roeck <linux@roeck-us.net> [230806 13:19]:
>> On Sun, Aug 06, 2023 at 09:20:50AM +0300, Tony Lindgren wrote:
>>> Guenter reports boot issues with duplicate sysfs entries for multiport
>>> drivers. Let's go back to using port->line for now to fix the regression.
>>>
>>> With this change, the serial core port device names are not correct for the
>>> hardware specific 8250 single port drivers, but that's a cosmetic issue for
>>> now.
>>>
>>> Fixes: d962de6ae51f ("serial: core: Fix serial core port id to not use port->line")
>>> Reported-by: Guenter Roeck <groeck7@gmail.com>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks for testing.
> 
> Guenter, care to also test the patch below on top of this fix and
> see if things still behave for you?
> 

Queued. We should have test results sometime tomorrow.

Guenter

