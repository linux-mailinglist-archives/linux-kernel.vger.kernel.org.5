Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967097A1011
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjINVwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjINVwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:52:18 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E08D1BFA;
        Thu, 14 Sep 2023 14:52:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-271914b8aa4so1097626a91.1;
        Thu, 14 Sep 2023 14:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694728334; x=1695333134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHdSXUe2YO9OjLwFdWgsvV1wdj09sbciRHGaU5xVoJs=;
        b=S/uVCLwkOg/8fs95EUeYN+UodRWH/0sTOrPco0h37xqlhKmpWRPwqt4aPIVz0d6u+u
         9OCxI9wkVGG7jDVr92reSEKEls/GQBikRaFYr8O19ZZCz+I2Zf5Jax4KuIZHhmfYNUsi
         5XzhCy1nNGghk/GPC7ic/e5iDnXbTsivGO9GRvL1SOHfrQuODa+7YZ3S+TGICI4dXA2a
         xNJi0jfGIqIbHyxrFCc6tRgxIhwswkooa9MnhMJVxHcXtUkrEjduwbXss1wxLGP7hOue
         xT9YtlhA/sodn7Z8Ums4n23LbNf1HdnCCz8oNitiGAsJkJ+rfPVAsvTR1vN6wHM0EfX1
         rt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694728334; x=1695333134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHdSXUe2YO9OjLwFdWgsvV1wdj09sbciRHGaU5xVoJs=;
        b=mka6VC6Uqe5nhZPrq7I1L9om3poG0C0xOSz2qHXIHNUN+iWy+2kP/PGDZ7/2IGt8p/
         Wm+tK2z69lhDR3R7CP2oYpVn6SSJshgMqxF6AhkAUIZxJ7I0mT4+2kkyULrv/HhKw170
         /yhsiArjjJHqDA+soK8hxmwMFAT1foodUePiBuE0c+KPUtiuC4veSraSa5a+GgLLQcxG
         dShOLhl8XcgIDm7FQMXCHCxEqqCA0q2YAAe8e8R/MJgHqBA7vPqSKk8hEtMt1ytJexCs
         rBCslTP2F1fZp8x49097Jr17jLkRi6ZEjE+fybv5xu7NND/SXwAXPlTX1nIRcV4t4+Zh
         MELQ==
X-Gm-Message-State: AOJu0Yzfde+KEUcsH59kYTmbJ5Iq4jwjTWMNZVFQEELA7WF3kjVIPmmd
        ht4ti98CSEeE4ZATL7zoUEs=
X-Google-Smtp-Source: AGHT+IHkVYJPEorfPQ8KAPWgvo1j0blda6r6Vu03J32w1cBLrnmwap8eY+BMOr0QV0YqAeIv2BpvIg==
X-Received: by 2002:a17:90b:f04:b0:274:6d36:5b32 with SMTP id br4-20020a17090b0f0400b002746d365b32mr2736464pjb.30.1694728333969;
        Thu, 14 Sep 2023 14:52:13 -0700 (PDT)
Received: from [10.67.51.148] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t14-20020a17090ae50e00b002676e961261sm3834685pjy.1.2023.09.14.14.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 14:52:13 -0700 (PDT)
Message-ID: <41d02786-ffcb-89b0-4087-bd8fb138177f@gmail.com>
Date:   Thu, 14 Sep 2023 14:52:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH tty v1 22/74] serial: bcm63xx-uart: Use port lock wrappers
Content-Language: en-US
To:     John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Yangtao Li <frank.li@vivo.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <20230914183831.587273-23-john.ogness@linutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230914183831.587273-23-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/23 11:37, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> When a serial port is used for kernel console output, then all
> modifications to the UART registers which are done from other contexts,
> e.g. getty, termios, are interference points for the kernel console.
> 
> So far this has been ignored and the printk output is based on the
> principle of hope. The rework of the console infrastructure which aims to
> support threaded and atomic consoles, requires to mark sections which
> modify the UART registers as unsafe. This allows the atomic write function
> to make informed decisions and eventually to restore operational state. It
> also allows to prevent the regular UART code from modifying UART registers
> while printk output is in progress.
> 
> All modifications of UART registers are guarded by the UART port lock,
> which provides an obvious synchronization point with the console
> infrastructure.
> 
> To avoid adding this functionality to all UART drivers, wrap the
> spin_[un]lock*() invocations for uart_port::lock into helper functions
> which just contain the spin_[un]lock*() invocations for now. In a
> subsequent step these helpers will gain the console synchronization
> mechanisms.
> 
> Converted with coccinelle. No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

