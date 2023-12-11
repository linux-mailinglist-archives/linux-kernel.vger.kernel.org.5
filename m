Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFC480C287
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjLKIAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjLKIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:00:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F92FFE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:00:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-33338c47134so3953832f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1702281609; x=1702886409; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oc+kSt8rWQbkM0yZPeMYjkTQnSao1UOl1shLAF/Yyis=;
        b=ZoWE1gjZxUk2gWak4URI4v83X25wzoR/mH8MBaWCHf0DbaFp9mwWCnJkkpN9bZ7vvm
         8pRh4DI/nd9uyEZ8fP01FOGqW/nQR4cy+36kTdwj0q7HVEvplFuWzL6Ua6ynuryvd1Yu
         F7LmoxWZAsR9hcWCfs/dZiUpCjf5i3Bf7Dv3SqZiHR1UFyVx4Y2TiHjUEG41GYlm2XW3
         ZrZ+Yfv3glcOR2loJ0BtI5qDK+R74ZCuXJdkol3ucq0WmizSq1bTchfKEnBQd11G/1xJ
         819zcHSVbwesMimSzgxximUIrIsgUEt/2TVfXnKcDH9KVDbfp4HCuWsKP9XNNvonIXtN
         lY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702281609; x=1702886409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oc+kSt8rWQbkM0yZPeMYjkTQnSao1UOl1shLAF/Yyis=;
        b=be2eUmLBA5WHAkrL+XuSGbAhCOhPBJcKm88jstZDJWdRdgvDmz5EHDNqfORkiJwOfQ
         RbF/g5pdDOS3OLkXUhp5qBy7JcMbdOBuDDY+/JVZ0IUk6wXmcr20nfZ5lJxNAswPPSqA
         Wyi+efYwt6tgd4B14AaDYG9mZd7j5KvHr8V0GRMmNRaSaiA5u1ZYY8xs4zhSjH8cgYgb
         QqYBwkbRsUmMzO3pUTpUFccwwxWsWRkI2DdaUFW43tVvK+RVCb1Ha8ln+3r2kkJTd16Y
         aMI+PoI7RqPRS5JFkgsFtg6crr3vgk7vS+KZ8541Swer7zPLUh5b9ncjnQjofPoCfIyk
         G0CA==
X-Gm-Message-State: AOJu0YxHIrhUJWUcpnPqijIPBgD+76Il4R6DDUdWey9Hm5aZKayPAa7P
        jRBAo/D6ouXvOE4WXR8Dj3JdA0UmQmDuWUlk0LKJlQ==
X-Google-Smtp-Source: AGHT+IHA5uP3vo9EvqFZGzdj/GbBWKwvHC1fPgKQVZA/rixpi2guCL7bWzm5VHbFHy3dcvLqB5Bw+w==
X-Received: by 2002:a05:6000:506:b0:333:6cf:2b5 with SMTP id a6-20020a056000050600b0033306cf02b5mr1844363wrf.46.1702281608817;
        Mon, 11 Dec 2023 00:00:08 -0800 (PST)
Received: from trax (139.red-79-144-198.dynamicip.rima-tde.net. [79.144.198.139])
        by smtp.gmail.com with ESMTPSA id a9-20020a5d5709000000b003332aa97101sm7911222wrv.38.2023.12.11.00.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:00:08 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Mon, 11 Dec 2023 09:00:06 +0100
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "christian.loehle@arm.com" <christian.loehle@arm.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
        "victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
        "asuk4.q@gmail.com" <asuk4.q@gmail.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "yebin10@huawei.com" <yebin10@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Message-ID: <ZXbBhjZIn5sj6EYO@trax>
References: <20231204150111.3320071-1-jorge@foundries.io>
 <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
 <DM6PR04MB6575A30D162378E82B4D7DDEFC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZXBGTxS7sUSILtLs@trax>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXBGTxS7sUSILtLs@trax>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/23 11:00:47, Jorge Ramirez-Ortiz, Foundries wrote:
> On 06/12/23 07:02:43, Avri Altman wrote:
> > >
> > > On 4/12/23 17:01, Jorge Ramirez-Ortiz wrote:
> > > > Requesting a retune before switching to the RPMB partition has been
> > > > observed to cause CRC errors on the RPMB reads (-EILSEQ).
> > >
> > > There are still 2 concerns:
> > > 1) We don't really know the root cause.  Have you determined if here are
> > > CRC errors in the main partition also?
>
> right, and I don't disagree with that.
>
> As a test I created a 4GB file from /dev/random which I then copied
> several times (dd if= ....)
>
> root@uz3cg-dwg-sec:/sys/kernel/debug/mmc0# cat err_stats
> # Command Timeout Occurred:      0
> # Command CRC Errors Occurred:   0
> # Data Timeout Occurred:         0
> # Data CRC Errors Occurred:      0
> # Auto-Cmd Error Occurred:       0
> # ADMA Error Occurred:   0
> # Tuning Error Occurred:         0
> # CMDQ RED Errors:       0
> # CMDQ GCE Errors:       0
> # CMDQ ICCE Errors:      0
> # Request Timedout:      0
> # CMDQ Request Timedout:         0
> # ICE Config Errors:     0
> # Controller Timedout errors:    0
> # Unexpected IRQ errors:         0
>
> However as soon as I access RPMB and fails (it takes just a few tries) I see:
>
> I/TC: RPMB: Using generated key
> [   86.902118] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
> E/TC:? 0
> E/TC:? 0 TA panicked with code 0xffff0000
> E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
> E/LD:   arch: aarch64
> E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
> E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
> E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
> E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
> E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
> E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
> E/LD:  region  6: va 0xc0019000 pa 0x818ea9ba8 size 0x002000 flags rw-- (param)
> E/LD:  region  7: va 0xc001b000 pa 0x818e97ba8 size 0x001000 flags rw-- (param)
> E/LD:  region  8: va 0xc004f000 pa 0x00001000 size 0x014000 flags r-xs [0]
> E/LD:  region  9: va 0xc0063000 pa 0x00015000 size 0x008000 flags rw-s [0]
> E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc004f000
> E/LD:  Call stack:
> E/LD:   0xc0051a14
> E/LD:   0xc004f31c
> E/LD:   0xc0052d40
> E/LD:   0xc004f624
>
> root@uz3cg-dwg-sec:/var/rootdirs/home/fio# cat /sys/kernel/debug/mmc0/err_stats
> # Command Timeout Occurred:      0
> # Command CRC Errors Occurred:   0
> # Data Timeout Occurred:         0
> # Data CRC Errors Occurred:      1
> # Auto-Cmd Error Occurred:       0
> # ADMA Error Occurred:   0
> # Tuning Error Occurred:         0
> # CMDQ RED Errors:       0
> # CMDQ GCE Errors:       0
> # CMDQ ICCE Errors:      0
> # Request Timedout:      0
> # CMDQ Request Timedout:         0
> # ICE Config Errors:     0
> # Controller Timedout errors:    0
> # Unexpected IRQ errors:         0
>
> > > 2) Forcing this on everyone
> > >
> > > The original idea was that because re-tuning cannot be done in RPMB, the
> > > need to re-rune in RPMB could be avoided by always re-tuning before
> > > switching to RPMB and then switching straight back. IIRC re-tuning should
> > > guarantee at least 4MB more I/O without issue.
> > Performance is hardly an issue in the context of RPMB access -
> > For most cases it’s a single frame.
>
> Yes, the security use case typically stores hashes, variables
> (bootcount, upgrade_available, versions, that sort of thing) and
> certificates in RPMB.
>
> Since you mentioned, I am seeing that tuning before switching to RPMB
> has an impact on performance. As a practical test, just reading a 6 byte
> variable incurs in 50ms penalty in kernel space due to the need to
> retune 5 times. Not great since the request is coming from a Trusted
> Application via OP-TEE through the supplicant meaning this TEE thread
> (they are statically allocated CFG_NUM_THREADS) will be reserved for
> quite a bit of time.
>
> Roughly:
> TA --> OP-TEE (core) --> TEE-supplicant --> Kernel (>50ms) --> OP-TEE --> TA

To add more detail to the timing above, when using RPMB, OP-TEE stores
the secure filesystem on RPMB as well, so accessing one of the variables
stored in the filesystem consists on a number (~5) of individual RPMB
requests (each one forcing a retune, each retune taking around 10ms).

BTW, I also tried delaying the timing between those consecutive retunes
(up to 1 second), but the issue still persisted.

>
> Adrian, I couldn't find the original performance justification for
> enabling this feature globally. At which point do you think it becomes
> beneficial to retune before accessing RPMB?

How should we proceed with this patch then? can it be merged as I
proposed? should I rewrite it differently? not sure what is next

TIA
Jorge
