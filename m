Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F2878F601
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 01:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347732AbjHaXIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 19:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbjHaXId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:08:33 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22426FD;
        Thu, 31 Aug 2023 16:08:30 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1c4c5375329so879411fac.2;
        Thu, 31 Aug 2023 16:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693523309; x=1694128109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAkL29w30IBhvvJdHJX9nCTc0zMhLdBZUZnVSQ/ZN/4=;
        b=O4VegZeV/fwj/XtGWWvqZSOoMCF2Wwx77aV5ZjNmQQM7U5p1occ2pJ9nNpAXmames/
         O0KycrPiK9RpRsl6ZHm9uq6aJTkuaRG+46eMYVp9L1f5TIbTeKyPDd1jDIcALfZOuIGx
         EK8lPSx1m+fi0Wa1V6ubnB5ePbjdR4sMSfING2T3iKD9wvSv37dMpOhLuaCLqn7HZIPD
         O/4dZmY7UB8JHyGpmQIUN8llKzbqlg5NAeyHyQOc+ZU9rAEsoz7ljadj4bzGS3HQejLa
         5cBEjPAEtMtwgOILpVSHqy2pK5hw6ndWuUhhcIfm2V6UFeHbnkxY6nN3YKbnDdxH36OM
         4/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693523309; x=1694128109;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAkL29w30IBhvvJdHJX9nCTc0zMhLdBZUZnVSQ/ZN/4=;
        b=UNjt+1eIgqfS8BXuOUJPfzqMm+aKJ6dYBOAv7YhwM6aYcDRw9aAxFN2armlbbVA+Dv
         ++mt7mh9w2hwyYHrSqAB4Xi+2Zo6/Qz8O5LatyI+Gq8NxidgNtWq5sRB2yH1I3VElz8+
         SCW79AeFSrNOqNXNUMt57/53cKeCYLLIxqCPx/OazJwAW/Yn8b+87C9SbHXcYiW1kh7N
         kgPsmSvDEP+F1i3wyVWNkHqHaxFree5IMfEoS4vi9LQvedUNy2ms567/9so+p2sjFz6S
         y84rN5ilciVnENxQsqtc4fd0RIvVOl9n0DF5cW1K9IbIhFy3bBWkKG4/ZBe3IysohHGT
         wcUQ==
X-Gm-Message-State: AOJu0Yy/0VtyjllWgYPsbb/AaIhZ1OWH+jfoC8Wvuu2qcot/KgruLDHy
        SJ1Mdc3Gd6LbAFfhn0Q9q9Y=
X-Google-Smtp-Source: AGHT+IH9UFscX0xilqqMkKi9iMSnO4T6uBbGhY42CzpADPjsgKOguQZm/EO+fSGK/CCUfJCr0mruGQ==
X-Received: by 2002:a05:6870:b687:b0:1bf:8a8:dfa with SMTP id cy7-20020a056870b68700b001bf08a80dfamr1004284oab.11.1693523309257;
        Thu, 31 Aug 2023 16:08:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d4-20020a0cdb04000000b0064f378f89a7sm977651qvk.73.2023.08.31.16.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 16:08:28 -0700 (PDT)
Message-ID: <48812e7c-1bbf-0084-41be-f62d2cc60231@gmail.com>
Date:   Thu, 31 Aug 2023 16:08:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] serial: 8250_port: Check IRQ data before use
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
References: <20230831222555.614426-1-andriy.shevchenko@linux.intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230831222555.614426-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 15:25, Andy Shevchenko wrote:
> In case the leaf driver wants to use IRQ polling (irq = 0) and
> IIR register shows that an interrupt happened in the 8250 hardware
> the IRQ data can be NULL. In such a case we need to skip the wake
> event as we came to this path from the timer interrupt and quite
> likely system is already awake.

I suppose that is fair to say.

> 
> Without this fix we have got an Oops:
> 
>      serial8250: ttyS0 at I/O 0x3f8 (irq = 0, base_baud = 115200) is a 16550A
>      ...
>      BUG: kernel NULL pointer dereference, address: 0000000000000010
>      RIP: 0010:serial8250_handle_irq+0x7c/0x240
>      Call Trace:
>       ? serial8250_handle_irq+0x7c/0x240
>       ? __pfx_serial8250_timeout+0x10/0x10
> 
> Fixes: 0ba9e3a13c6a ("serial: 8250: Add missing wakeup event reporting")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks Andy!
-- 
Florian

