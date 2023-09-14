Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB4079FAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjINFnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjINFnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:43:39 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE42AC;
        Wed, 13 Sep 2023 22:43:35 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-52f9a45b4bdso562608a12.3;
        Wed, 13 Sep 2023 22:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694670213; x=1695275013;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlZDiGz8e/osauYT4zKDfZbr/tlfGTh4cki0WmddMNs=;
        b=qe1cl+VPfi5PBKpHTvaBMsKwZj0tLrnHGLTu6FHLoLoMfO+3pBlDF+Z0bSOP09K8Lt
         stE/PfWRdEv0n8t2XJMWR6+XQw8iLGjCCOWNkgWOh5Lx4pCzq5UYEFjBuMS/HqCOdIt1
         L9cKSuSfVRbWxkSotIKlpq/28C1Buepp86d5cDsZK60dHYZe7EelecS8QnWf6QF5XteE
         i8BFtDQkdd3ycJSE6RmfgjE8YPmFTrDQ8NFQAEouhjM3lNeZZjeZhcsa/amW0bBt935g
         pvw28T/pfYr/IOVTHCCRS0wuFSxtghxJP2LhQ91uX1f/uwZjM7yMuqa+dqoxbo1DtvkD
         HYZg==
X-Gm-Message-State: AOJu0YyFUlBxpfHzFyzBMm9vJSlLsr19GuLdpYwwdPteoGJlI0hyJjWP
        utKGVikgFMrxZdFQbLO9lZcjrlsyQfQ=
X-Google-Smtp-Source: AGHT+IEkjOcxno+IHNzOB3L7DtrgSRd5jy7s+LBqGQqb8gqM+yUB6Ll4FnjZMsG54diT+Fo2+WOJ0Q==
X-Received: by 2002:a17:906:224a:b0:9a1:f871:8a5f with SMTP id 10-20020a170906224a00b009a1f8718a5fmr3474544ejr.32.1694670213373;
        Wed, 13 Sep 2023 22:43:33 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id j26-20020a170906255a00b009adad3f9034sm478965ejb.21.2023.09.13.22.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 22:43:32 -0700 (PDT)
Message-ID: <4c9c637a-9117-4f43-a64f-892fa33958c1@kernel.org>
Date:   Thu, 14 Sep 2023 07:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20230912110350.14482-1-tony@atomide.com>
 <20230912110350.14482-3-tony@atomide.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20230912110350.14482-3-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 09. 23, 13:03, Tony Lindgren wrote:
> --- /dev/null
> +++ b/drivers/tty/serial/serial_base_con.c
...
> +/* Adds a command line console to the list of consoles for driver probe time */
> +static int __init serial_base_add_con(char *name, char *opt)
> +{
> +	struct serial_base_console *con;
> +
> +	con = kzalloc(sizeof(*con), GFP_KERNEL);
> +	if (!con)
> +		return -ENOMEM;
> +
> +	con->name = kstrdup(name, GFP_KERNEL);
> +	if (!con->name)
> +		goto free_con;
> +
> +	if (opt) {
> +		con->opt = kstrdup(opt, GFP_KERNEL);
> +		if (!con->name)

con->opt

> +			goto free_name;
> +	}
> +
> +	list_add_tail(&con->node, &serial_base_consoles);
> +
> +	return 0;
> +
> +free_name:
> +	kfree(con->name);
> +
> +free_con:
> +	kfree(con);
> +
> +	return -ENOMEM;
> +}
> +
> +/* Parse console name and options */
> +static int __init serial_base_parse_one(char *param, char *val,
> +					const char *unused, void *arg)
> +{
> +	char *opt;
> +
> +	if (strcmp(param, "console"))
> +		return 0;
> +
> +	if (!val)
> +		return 0;
> +
> +	opt = strchr(val, ',');
> +	if (opt) {
> +		opt[0] = '\0';
> +		opt++;
> +	}

Can this be done without mangling val, i.e. without kstrdup below?

> +	if (!strlen(val))

IOW, can this check be "val - opt > 0" or alike?

> +		return 0;
> +
> +	return serial_base_add_con(val, opt);
> +}
> +
> +/*
> + * The "console=" option is handled by console_setup() in printk. We can't use
> + * early_param() as do_early_param() checks for "console" and "earlycon" options
> + * so console_setup() potentially handles console also early. Use parse_args().

So why not concentrate console= handling on one place, ie. in 
console_setup()? The below (second time console= handling) occurs quite 
illogical to me.

> + */
> +static int __init serial_base_opts_init(void)
> +{
> +	char *command_line;
> +
> +	command_line = kstrdup(boot_command_line, GFP_KERNEL);
> +	if (!command_line)
> +		return -ENOMEM;
> +
> +	parse_args("Setting serial core console", command_line,
> +		   NULL, 0, -1, -1, NULL, serial_base_parse_one);
> +
> +	kfree(command_line);
> +
> +	return 0;
> +}

thanks,
-- 
js
suse labs

