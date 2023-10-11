Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96D07C5AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjJKSNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjJKSNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:13:31 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6019893;
        Wed, 11 Oct 2023 11:13:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405e48d8e72so463235e9.0;
        Wed, 11 Oct 2023 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697048007; x=1697652807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QjCK+8QWq0gyUTkOiemvLVBkLYH9fn7QPYSepTTFeHY=;
        b=mBWPjFlzGVneCMylpLUE/Wq5/dn/bjU7EFFSpzc+g+dxiMG8Pt6XtOTNbxJBVhemZB
         txsWa86cdfxgFc8liOipEdgQhDPTwgki3DjCh8WUMtTNmhHusJfwUZEbY+GlrqZJQ1Oi
         epk0Uuaa5oVx7eVnAKb0+2HAR96WusqziPpgQTrTNMVXrQQnheKc58Gr/a7e/27LCZo+
         x4B3wtKr3PblhEgnzofTr26x0PexrodvKYrN8jLPFQGuooHK+tZh8bd1U26I69rgeXfn
         +XKHbcnfw1rjs90HUsOofW6yADqRMFnaK3KZi2YQweyl7PIRgPd/dLN8eXOzv+SRVQrX
         A3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697048007; x=1697652807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjCK+8QWq0gyUTkOiemvLVBkLYH9fn7QPYSepTTFeHY=;
        b=OL0db3kSOdeFeywWSYXB6ZeS2fFwYkPNF3RYpp0lhLbal887P3+sYGnbyZfUQbFmZE
         S9oK6rtI4icIzY2wOWezekxrCIrPe/PGk02nkyhRHqT3+KPt8LQuRThiyxz2YjONRWIP
         bhPLUQJ75hoy4Mv9Qmp0M9dXlf/zBWp4J8DHnms9bH4qTG2s/AIehh65xn4CyqfGdx3h
         fzzGDvucXPdjYhNIx9GHQS7lDhKeV2dDGlWCT4WW9TfJfMlg3bVcP0OV8TVbVS6WQQsQ
         fUnrveWQsHpEzLux47jBPz3PQX5oeMbP697vm+Lpf9RE3ooJSafM/61JC5srZbb55HcK
         axlQ==
X-Gm-Message-State: AOJu0Ywhif4sYFNd6ObpG1Fp1QD1ii0kotKNOrz9tbSJF83iSqnGj66V
        DsCrSx8mvoz6St5qGzhgFWyK4oJvawE=
X-Google-Smtp-Source: AGHT+IFK4ka32EySjBz/6awgdfZmmdt1F6crkvar+uu1FGIncSQscSUhhQ50bPLYw87kYR5wveh+5g==
X-Received: by 2002:a05:600c:5117:b0:407:52f0:b01a with SMTP id o23-20020a05600c511700b0040752f0b01amr5639522wms.2.1697048006483;
        Wed, 11 Oct 2023 11:13:26 -0700 (PDT)
Received: from [192.168.0.104] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id az17-20020a05600c601100b003fef5e76f2csm1366706wmb.0.2023.10.11.11.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 11:13:26 -0700 (PDT)
Message-ID: <da777a72-55d1-4ee3-91c8-30afe7659f54@gmail.com>
Date:   Wed, 11 Oct 2023 20:13:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC] wireless: move obsolete drivers to staging
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Jakub Kicinski <kuba@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
References: <20231010155444.858483-1-arnd@kernel.org>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20231010155444.858483-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 17:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de> While looking at the old drivers 
> using the obsolete .ndo_do_ioctl() callback, I found a number of network 
> drivers that are especially obsolete, in particular for 802.11b 
> (11Mbit/s) or even older wireless networks, using non-busmaster 
> ISA/PCMCIA style bus interfaces, and using the legacy wireless extension 
> ioctls rather than the netlink interfaces that were meant to replace 
> them in 2007. All of these drivers are obsolete or orphaned. We had 
> previously discussed this topic, but nobody ever moved the files, so I 
> now went through the list to my best knowledge. These are the drivers 
> that I would classify as "probably unused" by now:

I found a USB WLAN Stick with a rtl8192u. I got it last Saturday and 
found out that the firmware is missing in my ubuntu 20.04. I found it on 
the web and fixed it. When I started the driver my computer crashed. The 
missing part was: priv->priv_wq = alloc_workqueue("priv_wq", 0, 0); 
Fixing this the next error was a network = kzalloc(sizeof(*network), 
GFP_KERNEL); in wrong context with leads to a crash of my computer. 
Fixing this leads to another issue which lets my computer crash.

For me the firmware of rtl8192u was intentionally missing because of the 
issues with the driver.

What this has to do with your question?
Can we check for missing firmware in main distributions to know which 
drivers are considered to be old and unused?

Bye Philipp
