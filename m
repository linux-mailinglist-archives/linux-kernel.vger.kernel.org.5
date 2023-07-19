Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D57758D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGSF3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGSF3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:29:32 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B596CD2;
        Tue, 18 Jul 2023 22:29:31 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so96343641fa.2;
        Tue, 18 Jul 2023 22:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689744570; x=1690349370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BT4nzBp82aR2sqeLIUaJEs6yXbxXtnG7f8mxLuZymQA=;
        b=foRGV5z9gFkwy5G3HgU8HKDe99y1Zy/VNaMGY1B91ubgl6An7mO3jE4PyjUT6NO7nh
         R7Fc48he5KT3tHr9xSbI2kgPnJTJe4TZOWiJj8G/4Im1sb/8Y6oWOtZ5UgddSFRcdJ/2
         5vdk1EnVE2/itsOWoYsL0prdYchpti71R59y2RevsXwQurfmZOty+iXHd+A51mtWK3Rs
         Xm350U0j9TynAUiQlW0QB3hP3t5L3qOIpHyRY6EeLKN5ldjTk3ZBFQFmWIGg0uFAG0mb
         b5WMi91QnWb/AIq5lNrk5dXUqlRl0/QqjTM2Zd0XNEPI4VPR8eonpPoNfye9bEh208cL
         bSTA==
X-Gm-Message-State: ABy/qLaqe5Emun1CI10ZnaRf6p/4OM1TuyWENFkFv+nC8kQdp39ePTFd
        sD+++t4PCNvy6Hhz8qI6V2w=
X-Google-Smtp-Source: APBJJlG6L9wQU4y2nJVfHX+NFUu854MHbLYnKYwFA+Wjso46kfWVt5XUc7z9A0nbuLRvllGfukrcZA==
X-Received: by 2002:a2e:3a1a:0:b0:2b6:e2c6:6e1c with SMTP id h26-20020a2e3a1a000000b002b6e2c66e1cmr12410304lja.14.1689744569737;
        Tue, 18 Jul 2023 22:29:29 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id lw17-20020a170906bcd100b00993017b64a8sm1801462ejb.224.2023.07.18.22.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 22:29:29 -0700 (PDT)
Message-ID: <87431096-e883-c90d-853e-44a463c0e8f2@kernel.org>
Date:   Wed, 19 Jul 2023 07:29:28 +0200
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
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230719052811.GH5194@atomide.com>
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

On 19. 07. 23, 7:28, Tony Lindgren wrote:
> * Jiri Slaby <jirislaby@kernel.org> [230719 05:25]:
>> On 19. 07. 23, 7:15, Tony Lindgren wrote:
>>> +/*
>>> + * Add preferred console if configured on kernel command line with naming
>>> + * "console=dev_name:0.0".
>>> + */
>>> +static int serial_core_add_preferred_console(struct uart_driver *drv,
>>> +					     struct uart_port *port)
>>> +{
>>> +	char *port_match, *opt, *name;
>>> +	int len, ret = 0;
>>> +
>>> +	port_match = kasprintf(GFP_KERNEL, "console=%s:%i.%i",
>>> +			       dev_name(port->dev), port->ctrl_id,
>>> +			       port->port_id);
>>> +	if (!port_match)
>>> +		return -ENOMEM;
>>> +
>>> +	opt = strstr(saved_command_line, port_match);
>>> +	if (!opt)
>>> +		goto free_port_match;
>>> +
>>> +	len = strlen(port_match);
>>> +
>>> +	if (strlen(opt) > len + 1 && opt[len] == ',')
>>> +		opt += len + 1;
>>> +	else
>>> +		opt = NULL;
>>> +
>>> +	name = kstrdup(drv->dev_name, GFP_KERNEL);
>>
>> Why do you dup the name here?
> 
> I was getting ignoring const warning, but maybe the right solution is
> to just use const char *name here.. Let me check.

So fix add_preferred_console() instead ;).

thanks,
-- 
js
suse labs

