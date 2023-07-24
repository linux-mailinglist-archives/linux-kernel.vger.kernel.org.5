Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBAA75EEA9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjGXJGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjGXJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:06:32 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793381B4;
        Mon, 24 Jul 2023 02:06:30 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so31185485e9.3;
        Mon, 24 Jul 2023 02:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189589; x=1690794389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yj+GBFRStnxILe3ObHWp/95S7KmQejbrCjhWLVkCxI0=;
        b=hKKLhCiVLbGxY7F4aXXmj0OgudkPFQzhDBsaqlJGCbUEnkK7dKylUuRBpi503p3x18
         B2XwT9wKuT39zecRk8x+fRbDDq+uSIW1i7T5BvfgZFuhWLrZMANMr5aV5NC+YwBZ7E7R
         +mhcniXg1sPtZItL4REKj/jawZ5pEWPUVeDGJy4ZwYxwII5CA3hZrsGb0n8bCZz6u5Y5
         BayO5kNpx9JzbQUFQAzebYFpr06NFZR4XOeKQ/RCThjQUDE90kz/wn8eZyiwKP1zIKCQ
         Jn8Lav7/6ga63n8mj3lnfYOSg3VTXxe7zTtqWszRjfAg10xyEL0erwi63/vTkdB2QglG
         S5tw==
X-Gm-Message-State: ABy/qLYcQ63+opbmbgpccuGeOU/MzRae7JVkP4rjFypFesncITL9CgG/
        x77gATsTwMjAp851Runjy7M=
X-Google-Smtp-Source: APBJJlHFo9DQF8jjV5t0H0gNqn3vh763FAk1sP+MQD+4WHG/Ri+VwQ++s9xEu2ZMe/K4lymNMxFRSQ==
X-Received: by 2002:a1c:6a1a:0:b0:3f7:f884:7be3 with SMTP id f26-20020a1c6a1a000000b003f7f8847be3mr6373697wmc.4.1690189588732;
        Mon, 24 Jul 2023 02:06:28 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id v11-20020a1cf70b000000b003fbacc853ccsm9760621wmh.18.2023.07.24.02.06.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:06:28 -0700 (PDT)
Message-ID: <f080926e-d158-c787-91a8-d3ef0c2a399c@kernel.org>
Date:   Mon, 24 Jul 2023 11:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 3/3] serial: core: Fix serial core controller port name
 to show controller id
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230724050709.17544-1-tony@atomide.com>
 <20230724050709.17544-4-tony@atomide.com>
 <ZL48mdJbBXPdcf25@smile.fi.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <ZL48mdJbBXPdcf25@smile.fi.intel.com>
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

On 24. 07. 23, 10:55, Andy Shevchenko wrote:
> On Mon, Jul 24, 2023 at 08:07:05AM +0300, Tony Lindgren wrote:
>> We are missing the serial core controller id for the serial core port
>> name. Let's fix the issue for sane /sys/bus/serial-core/devices, and to
>> avoid issues addressing serial ports later on.
> 
> ...
> 
>> -	return dev_set_name(dev, "%s.%s.%d", type->name, dev_name(port->dev), id);
>> -}
>> +	if (type == &serial_ctrl_type)
> 
> 	...
> 
>> +}
> 
> While at it, have you tried to use --patience when forming patches? Does it
> make any (better) difference?

Or moving "struct device_type"s to one place in a separate patch might 
do the desired trick too ;).

-- 
js
suse labs

