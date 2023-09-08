Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A532797FD4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 02:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjIHAqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 20:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjIHAqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 20:46:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973801BCD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 17:46:18 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso11466265ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 17:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694133978; x=1694738778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vBzMi7nuJEjnLrIfSvx0g5ii+P5l6wXDMWk+6BeTQpU=;
        b=fELu8LP4S7jZFcMfhy5QSyTAo/fGJXqQvolzoUcLTpj+3vzNc2d9UgVmpGuB39vMu9
         eyoPL2z4wFTtHb7qH6cw3wNeMt/VjVHrZnAyCUZc/otk7qXiwVNvX3mw/iECYGiAc7pF
         2/LC/aujKBTLz0qfE74X+nQD3i+7oKKziAvwn392mU9h2WhzQjEgw6SmoEas5eyklWhc
         v9wxUkCjxxMqizguqTghFS7AMQUfsSS8AmpSDsL4WfkGGfFtw8XM9B/+qPgMPTPlbS2m
         MvxSmTSR9HrEh/RZfGwhy9kQKd7uWJWqLxa83GMdM9ql/J7H3Ynh60yTcCdqsuENk0+a
         UhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694133978; x=1694738778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBzMi7nuJEjnLrIfSvx0g5ii+P5l6wXDMWk+6BeTQpU=;
        b=NPbPHDQN2MVXrTqxG4oshOhSZpg75HZPMVy6A+u0btPUOxBTGM430wI398rIXodSPc
         mEBG//QSK7Q19QtNHPnBEACxcgcVHASHl+RllS30fafsIfI0Cz8yqFR7AfsmyEABOG6R
         2OIchx6Xs5KD494LMoo7PFsqJZm1aomsn0del4efblrhlruRBkO2SLZrU7GT1yhqMUVT
         2l+y1biudPpoqsSlhXATORcImHqW2wb+XgXoyhrnLlzUk7TAUAq+otbm8rSo4apIHpFC
         Pzzi872LyaBr2AY5CboMjaRgWvnjBCwPoLhxpsyHtlP9J2tQ2w+lY17My+WxK/5OS/Hk
         VEbw==
X-Gm-Message-State: AOJu0Yx7rqRPGkrz2j4+2PVvOcdIn136BYghFgADFxU/OwuN6rC7bzF1
        EnNWnJJVYiNbfpIfjlTn4uNIFSUYAm4=
X-Google-Smtp-Source: AGHT+IGWKVuAn9zIbN0xHNClqeExD/6A9pM1A1/2u5kzg1ko3yEMSGNowadf3wlGQwgR9C03fLLiDg==
X-Received: by 2002:a17:902:e741:b0:1b8:c580:5fb9 with SMTP id p1-20020a170902e74100b001b8c5805fb9mr1463386plf.14.1694133977980;
        Thu, 07 Sep 2023 17:46:17 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:1d9d:935e:2152:72e4? ([2001:df0:0:200c:1d9d:935e:2152:72e4])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902ee4600b001a6f7744a27sm340630plo.87.2023.09.07.17.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 17:46:17 -0700 (PDT)
Message-ID: <6ff868a4-d433-6e92-8bf2-573fee19ce2c@gmail.com>
Date:   Fri, 8 Sep 2023 12:46:11 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 22/52] m68k: atari: Add and use "atari.h"
Content-Language: en-US
To:     Finn Thain <fthain@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org
References: <cover.1694093327.git.geert@linux-m68k.org>
 <0778d9dd186928666d760d5523c7d2311f781621.1694093327.git.geert@linux-m68k.org>
 <142e4eb5-b47e-e27c-1be3-bc6c5df889c0@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <142e4eb5-b47e-e27c-1be3-bc6c5df889c0@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On 8/09/23 11:57, Finn Thain wrote:
> On Thu, 7 Sep 2023, Geert Uytterhoeven wrote:
>
>> diff --git a/arch/m68k/atari/atari.h b/arch/m68k/atari/atari.h
>> new file mode 100644
>> index 0000000000000000..494a03ddac3d16ae
>> --- /dev/null
>> +++ b/arch/m68k/atari/atari.h
>> @@ -0,0 +1,15 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +struct rtc_time;
>> +
>> +/* ataints.c */
>> +void atari_init_IRQ(void);
>> +
>> +/* atasound.c */
>> +void atari_microwire_cmd(int cmd);
>> +void atari_mksound(unsigned int hz, unsigned int ticks);
>> +
>> +/* time.c */
>> +void atari_sched_init(void);
>> +int atari_mste_hwclk(int op, struct rtc_time *t);
>> +int atari_tt_hwclk(int op, struct rtc_time *t);
> Wouldn't atariints.h and atarihw.h be more appropriate places for some of
> these?

atariints.h already has some prototypes, so yes on that account.

atarihw.h only has inlines, but sound and time related prototypes could 
be added there, too.

Geert's intentions might have been avoiding inclusion of all the 
hardware specific data in those two files, but the only source file to 
benefit from this is config.c (the other three already include 
atariints.h and atarihw.h).

OTOH, considering this patch series adds a lot of other headers that 
only contain prototypes, it might be better to keep to that pattern 
everywhere.

Cheers,

     Michael


