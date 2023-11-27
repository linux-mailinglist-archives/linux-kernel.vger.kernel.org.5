Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A92B7FA671
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjK0Qcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjK0Qck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:32:40 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40709CE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:32:46 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c5071165d5so12188061fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701102764; x=1701707564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVpHuQFa6WA4nsRZaYZzAE/wCMgENUIng7Mv/kONotE=;
        b=bzDJlciMb7/X1AONc7uSVRYVAb7PpFTeKpHsxzw59F5rtsDoDGzNRg3xiEMTA1106f
         USYIXg5st+0G6jgMIZ3m414Bsd1oDZtvGHYe9J8mNQKOsrink+sJSu18LrT7/P1jBNCE
         gWBI6JRz+0ncrW6G3u1k5LVZQzhOHsymfOB3i5DVfnFdyRTbbnfrp5EYKGY+EFpoodil
         ANzFUpBd+L9aufndPcY1uRB9xcWzt/s7sLf+2BdfKeiob+NchDzMwBVmgoCcZRjt53di
         y7XiRUAmAtqE7C8q8eC+z3JNDW/21EpQwnhG6iuVpET/nrFgTJkILfqRXsFqYPU4+342
         1Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102764; x=1701707564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVpHuQFa6WA4nsRZaYZzAE/wCMgENUIng7Mv/kONotE=;
        b=wW1xRvntxR3mSGZ3L3upFMC2vk5gPdh2tMoPqMJeWVxez/+CMCIsk+C3TejSf/PPLP
         0LFyXFz/xnO5qSftsrD/h2gwTzS8Ehq3hOu3ll63v2KlTea2VLlmkq+WQqX1/M+HtJ0r
         740K025kST8MMoxMV5KofVPxLqxAC4lR8AgAExXFQm8Kp7Blq9Ffprre0qWEi/+JmInC
         eCkn800OtyuENh5/ntfgN2YMXTgSv54kJ35cb62Hl3E8/D0I94V3WKSthSVDWBLmqUvA
         YBgiMQmLcsdI6kKjUkxisEJXt6ttEgamdEE6Zo6OHrb+TS6Cn6I8MR0npG7QTpqp7z+j
         0kTg==
X-Gm-Message-State: AOJu0YwPJIcESmvXNTJVSGC+dy2VL7HN4dzIU+je0ryl8NaYf1dzlXJ7
        +gHC0bnzjw1THMrnz51X0ih25w==
X-Google-Smtp-Source: AGHT+IEfQlT78CJBw9qwf+qcFU5klRZs0b6yTOMcHN0VTodZ9E3tmzfKxloBy38dMuEPz5S6nTS55g==
X-Received: by 2002:a05:651c:38d:b0:2c9:99bf:36c7 with SMTP id e13-20020a05651c038d00b002c999bf36c7mr3659649ljp.5.1701102764465;
        Mon, 27 Nov 2023 08:32:44 -0800 (PST)
Received: from debian ([185.117.107.42])
        by smtp.gmail.com with ESMTPSA id bz14-20020a05651c0c8e00b002c12b823669sm1438121ljb.32.2023.11.27.08.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:32:43 -0800 (PST)
Date:   Mon, 27 Nov 2023 17:32:41 +0100
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban.Veerasooran@microchip.com
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: microchip_t1s: conditional collision detection
Message-ID: <ZWTEqXAwxIK1pSHo@debian>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <20231127104045.96722-4-ramon.nordin.rodriguez@ferroamp.se>
 <142ce54c-108c-45b4-b886-ce3ca45df9fe@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <142ce54c-108c-45b4-b886-ce3ca45df9fe@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 04:00:18PM +0000, Parthiban.Veerasooran@microchip.com wrote:
> Hi,
> 
> This implementation was introduced in the below patch itself.
> 
> https://lore.kernel.org/netdev/20230426205049.xlfqluzwcvlm6ihh@soft-dev3-1/T/#m9a52b6c03b7fa637f70aed306b50b442590e24a3
> 

But the change was dropped in that patchset right? It's not present in
netdev-next.

> As it is recommended to do it in a separate patch and also the 
> datasheets of LAN867X Rev.B1 and LAN865X Rev.B0 internal PHY have these 
> register is reserved, we were working for a feasible solution to 
> describe this for customer and mainline. By the time many other things 
> messed up and couldn't reach the mainline on time.
> 

Far as I can tell 'collision detect' is described in the following
sections of respective datasheet:

* 11.5.51 - LAN8650
* 5.4.48  - LAN8670

The rest of the bits are reserved though. The change I propose only
manipulate the documented (bit 15) collision bit.

Is your point that the lan8670 datasheet is only valid for rev.c and not
rev.b?

Andrew suggested on the cover letter that it be interesting to look at
completly disabling collision detect, any strings you can pull at
Microchip to investigate that?
Also any input on my suggested testing methodology is more than welcome.

> We also implemented LAN867X Rev.C1 support already in the driver and 
> published in our product site and in the process of preparing mainline 
> patches. But unfortunately it took little more time to make it.
> 
> https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/CodeExamples/EVB-LAN8670-USB_Linux_Driver_1v0.zip

I'm aware, we've been using a derivative of that work at ferroamp for
development. But it's been driving me nuts, being the 't1s guy' at work,
and maintaining out of tree drivers for weird dev boxes.

It's not my intention to beat you to the punch, I just want a mainlined
driver so that I can spend less of my time on plumbing.

> 
> Anyway, thank you for the support. Good luck!

Likewise!
R
