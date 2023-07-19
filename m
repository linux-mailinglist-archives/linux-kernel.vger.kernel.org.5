Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7F9758D37
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjGSFgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGSFgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:36:41 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B191FCE;
        Tue, 18 Jul 2023 22:36:37 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso9158629a12.2;
        Tue, 18 Jul 2023 22:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689744995; x=1690349795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDbeeMAF25Dt1BLMyZ5tpgdRlA71spcND6k71f+vr88=;
        b=Kac+cDLtfIQQL/p7AgVoQVUaBt6jVdlaxuo3XKSgdc1zvk8shdgr+sdmCs29uukn2a
         dBEcX54moIIj8wdr5NYXLAdGD2VQiz8d/fpGbpcyU0aYPo66Xa+Ve1sp6YwCSCgrqgbX
         pZqnVEZdG/Noc9gNiX1r765lK0Z0y0nqxAga02iCoMbR+Qrhaddk5dF6oY3nXg5Z5mnc
         KWUcJ6jxjJu2tuAJqMc0YMvaBBYX2GH4YW95Ih0YAom0IZQHxu0ngQmkvkeA6OWRO/Jw
         q1okLT/NxVPCLG9AyK/MokQ9sJ15dhLVD2enUorfjE14XGiRjJUi0QHgUvF6w2uCaGd/
         +z4A==
X-Gm-Message-State: ABy/qLbDq4qVHb/dAhPriIyUR2dq2CTKAxq4nSZvU1ItW/mrJ7aWIh49
        +JowqScMyclP5RWw+V3Rfvo=
X-Google-Smtp-Source: APBJJlGNPQr57woYj+uSYDG4JDiEkyWIfNLgHXtdJ5skgjW8Rk0FryOdDQSZiMoW9lDCVvkERD9Vtw==
X-Received: by 2002:aa7:c0cd:0:b0:51d:d30c:f1e3 with SMTP id j13-20020aa7c0cd000000b0051dd30cf1e3mr1476517edp.16.1689744995419;
        Tue, 18 Jul 2023 22:36:35 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id p10-20020aa7d30a000000b0050cc4461fc5sm2167113edq.92.2023.07.18.22.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 22:36:34 -0700 (PDT)
Message-ID: <c0061557-1dc7-0442-b5e0-3e528d0bebb1@kernel.org>
Date:   Wed, 19 Jul 2023 07:36:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] serial: core: Add support for dev_name:0.0 naming for
 kernel console
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719051525.46494-1-tony@atomide.com>
 <35758c24-1543-6f96-7957-b371dc94e59d@kernel.org>
 <20230719052811.GH5194@atomide.com>
 <87431096-e883-c90d-853e-44a463c0e8f2@kernel.org>
 <20230719053220.GI5194@atomide.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230719053220.GI5194@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 07. 23, 7:32, Tony Lindgren wrote:
> * Jiri Slaby <jirislaby@kernel.org> [230719 05:29]:
>> On 19. 07. 23, 7:28, Tony Lindgren wrote:
>>> * Jiri Slaby <jirislaby@kernel.org> [230719 05:25]:
>>>> On 19. 07. 23, 7:15, Tony Lindgren wrote:
>>>>> +/*
>>>>> + * Add preferred console if configured on kernel command line with naming
>>>>> + * "console=dev_name:0.0".
>>>>> + */
>>>>> +static int serial_core_add_preferred_console(struct uart_driver *drv,
>>>>> +					     struct uart_port *port)
>>>>> +{
>>>>> +	char *port_match, *opt, *name;
>>>>> +	int len, ret = 0;
>>>>> +
>>>>> +	port_match = kasprintf(GFP_KERNEL, "console=%s:%i.%i",
>>>>> +			       dev_name(port->dev), port->ctrl_id,
>>>>> +			       port->port_id);
>>>>> +	if (!port_match)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	opt = strstr(saved_command_line, port_match);
>>>>> +	if (!opt)
>>>>> +		goto free_port_match;
>>>>> +
>>>>> +	len = strlen(port_match);
>>>>> +
>>>>> +	if (strlen(opt) > len + 1 && opt[len] == ',')
>>>>> +		opt += len + 1;
>>>>> +	else
>>>>> +		opt = NULL;
>>>>> +
>>>>> +	name = kstrdup(drv->dev_name, GFP_KERNEL);
>>>>
>>>> Why do you dup the name here?
>>>
>>> I was getting ignoring const warning, but maybe the right solution is
>>> to just use const char *name here.. Let me check.
>>
>> So fix add_preferred_console() instead ;).
> 
> Let's see what kind of trouble changing it to use const char *name
> might be.

I don't see any, the string is copied internally. So it should be 
straightforward. Actually all three parameters of 
__add_preferred_console() should be const, IMO. But that involves 
changing struct console_cmdline. But that should be straightforward too.


Aside from that, why do you parse saved_command_line on your own? 
Instead of using setup() or other commonly used mechanisms for command 
line handling?

thanks,
-- 
js
suse labs

