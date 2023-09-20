Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805357A8E35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjITVJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjITVJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:09:06 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CD99E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:09:01 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79f82b26abfso1878739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 14:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695244140; x=1695848940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8qUn3nxGjNlx+f6POlIyJmp9wGSkysuKBIJu4Ey/ztc=;
        b=PmrDRRkN7VYjnIFvafgeop5wexrTqWpalPNPv6n5F+CkVplMqnN5XI7A9F+oxIOZK+
         JdXRhR14SXRYpsn5Gaq0Ild/9MQMS7u4O5ZaFd7AgPJXMkZdRrZDjzGt+R6/eqLyFdiB
         ApypnjAJ/eKKS2ChdyBLRXZmxMQnQ2st3ioqXg2GijTwMSKUgWfqaGklpcULZ3JyZVQi
         eD+raW/RLkXhT1QkXl1Q/tuPI1nPLznJnB+yNgt128mHNv3UCssbv4VDXvIyjbu1JXQW
         qiE1+xZoXMQV9ylohRfAAjM2R3n1u9YGSYcjNcll/Rbn1jf2y/0dknt+/7ygGdmqkh7v
         jC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695244140; x=1695848940;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qUn3nxGjNlx+f6POlIyJmp9wGSkysuKBIJu4Ey/ztc=;
        b=FfFTgyRKBlCVzE6RGSg4BLlgWF6xo5eQm+W9q3PMdf62SsR2EokiGTmdmlzs+kjMey
         qP1POFXwg6PnZUBObnsSaeS0+18H/2UyWSKcIqnOs8bqXHANWAlawxSTTjBTWbbP//CK
         lWS2Z5XYGgM8zWzzrknnUVWIwV96lHcEOFhsN5T9nNbxo7IiSZwwd4ZHtiEgQnopHhr+
         x9TVtG8GgnmklkJOXG4AEG+i69iw0avyIpeO3PBhZnrudk1rmufMez5ASBpw+foAWKO/
         k6IF1RJVaIVzXIYC0GSZJWhNusuq291Uy/Y7sMMp7S36q/TqJuNwsGwo540FnQhr4ZQR
         Siag==
X-Gm-Message-State: AOJu0YwIblrGOh97MUIxWPRYNYF+wWJis+nvOHSoPQ0Ikgh7nxEaEEMv
        ZE65oCeZz0dP9M3NX4hn+lg=
X-Google-Smtp-Source: AGHT+IGYw1W53KWnZypxbWlred60PHqCTpktHE7s1/fHzgD86UCvYVfeqqgF3vg0lzaN3E3IbNtdsg==
X-Received: by 2002:a6b:5b16:0:b0:792:72b8:b90 with SMTP id v22-20020a6b5b16000000b0079272b80b90mr4046635ioh.16.1695244140223;
        Wed, 20 Sep 2023 14:09:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e18-20020a02a512000000b0042b3dcb1106sm4458413jam.47.2023.09.20.14.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:08:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ad1f36ab-29a6-98b6-8782-3980323760e1@roeck-us.net>
Date:   Wed, 20 Sep 2023 14:08:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0
 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned
 int[]'}
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
References: <202309192013.vI4DKHmw-lkp@intel.com>
 <CAL_JsqJ0BoR7Dan3=oyWPa6HU3YV=eOFTO5fx7u5zz2i=eB-jQ@mail.gmail.com>
 <a57afd40-71a2-aa68-84cb-44d2a88a1e2b@roeck-us.net>
 <CAL_JsqJYPJVTxH=d5nYK78+ZWhZAfh4VhEyBLqzyg4MzMhrX0g@mail.gmail.com>
 <194e2d22-9eff-ec6c-9bc9-13b62bda870a@roeck-us.net>
 <CAL_JsqKcD4AttSVUEi5zuF8S1E4xNdqdZVKiHmk0r79SRW5Cqw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAL_JsqKcD4AttSVUEi5zuF8S1E4xNdqdZVKiHmk0r79SRW5Cqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 09:20, Rob Herring wrote:
[....]

>>
>> Sure, but I still argue that this isn't worth it for drivers like this one.
>> Are you going to submit a fix ? Because otherwise I'll submit a patch
>> to drop COMPILE_TEST from MACHZ_WDT.
> 
> I honestly don't know what the fix is. There's a compiler flag to
> allow 0 address, but that seems like a big hammer. From what I read on
> the fix for gcc-12, we shouldn't be getting this, but I haven't
> confirmed. I was hoping for comment from Geert as the issue doesn't
> appear to be the driver, but the arch code.
> 
> Furthermore, I just built the same HEAD and config as reported and
> don't see this error. I'm using kernel.org nolibc gcc 13.2.0 which
> should be the same version.
> 

Exactly my point. So now we are stuck with a report like this on a
driver which probably has 0 users and we don't know how to fix it,
all to get the benefit of being able to compile it for an architecture
and platform which will never use it.

I seem to recall similar errors with m68k and COMPILE_TEST last time
I tried to enable it on watchdog drivers, so I am not sure if this is
entirely new.

Guenter

