Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AC77C7DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjJMGmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJMGmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:42:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD2B7;
        Thu, 12 Oct 2023 23:42:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405d70d19bcso3916145e9.0;
        Thu, 12 Oct 2023 23:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697179330; x=1697784130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJDDNL3pXjaU/LWIBGNMR/pP6OjReijyLg1dxRAslEQ=;
        b=h9fmurepaipdsdgHX2S5/Z7sm1mb3WUxdQwFurgEvMWRgr4SC3OGD/4S90TOwkNZIt
         /nbnqSIc4/lp/hBcb9aoL59vcu4+67MHCflfKvCGih0Qbbz1N27Pc5X0BZHDBBEpd3D9
         ukiVHsBih/zm7p2/Xsru9yOf5DI5tBJpKVwUX4ppb5pyhKTbsCraYZwAVPFIg2DjuLAi
         LoyAm2eggw2ABCTYeREFfqqizhakvXPI6vG5irlZTQKQk12HKyr8Bm2qLbIIKZdq1qeM
         J4YST+v2INpCoLd/kdeV3+Vw1J/vB++gjIitb+EEjaCf4wtYHOBSgRVcT/I9mo+/0+cU
         LgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697179330; x=1697784130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lJDDNL3pXjaU/LWIBGNMR/pP6OjReijyLg1dxRAslEQ=;
        b=wpFuSsWZCqwsp/NwU6gtwogKOYkMaY0v7ri9+9aa9Awy8XllYRRoiXczEImB1l8RcQ
         oWizfXwCnSVtVCqIu550rC1IHMiPMHfXqKS9KVOKvX3xZPVXp5LX+5SIrJBRRLndHDXd
         bOFj07zPMrnPtQK1su/S7gx3UG+4UgTFrhEe+5YM6a/B5XRxB+Jg6YE+dCF6hNyjUcNK
         6awbIkejmLaqUfjv7AYp5mR0nnio+ZxM2MfRd8uoj2/tydY6g0Yi3Xpyfxo3WAkZ4qCP
         JGVGY+LxIEeoollpTJFvIoQc+6a1OstwBEZy1DJ98lXavIIJEuyuEkUYCg59ZfYMCe0w
         s+1Q==
X-Gm-Message-State: AOJu0YwAHg78hiaXamPBkA+5Zj5hbyXjhFf7mFlaXfnyAsSVKkjUUTn2
        whhZz5TSM4FGcnN+yq+ErkY=
X-Google-Smtp-Source: AGHT+IGXc9aoLgbvZSoZ/d3zdkmRGU5brtsb70ztTPNgNWz3j3pu7gCNOksJZW8fxhyqkWeUo7wtLg==
X-Received: by 2002:adf:b610:0:b0:32d:8872:aaca with SMTP id f16-20020adfb610000000b0032d8872aacamr4922329wre.5.1697179329449;
        Thu, 12 Oct 2023 23:42:09 -0700 (PDT)
Received: from [192.168.0.100] (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id dh13-20020a0560000a8d00b00327cd5e5ac1sm5515228wrb.1.2023.10.12.23.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 23:42:09 -0700 (PDT)
Message-ID: <e93e4008-65c5-4f1d-812a-64b48f0513a2@gmail.com>
Date:   Fri, 13 Oct 2023 08:42:07 +0200
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
> them in 2007. All of these drivers are obsolete or orphaned.


Hi Arnd,

we should take into account how good the wlan connection is.
This of course leads to tests on real hardware. I do have a vt6655. 
Please have a look at the test results below. In a nutshell it is a very 
bumpy connection you get with vt6655. You can have issues to connect on 
every channel and data is coming in waves. So sometimes you will almost 
not notice you have a wlan connection and then it takes very long to 
load the next site. Ping times up to 80 seconds. Packet losses up to 
40%. So I assume all users have gone away from this module as it is not 
comfortable.

Do you think this helps you?

I do have two vt6656 hardware as well. Are you interested in tests?
I can do a patch to remove vt6655. Do you think it makes sense?

Thanks for your support.

Bye Philipp


Used AP is Archer C6

Maximum throuput is 3,3 MByte/s

Build Link time in seconds
Channel
1	5, >90, 4, 14, 10, 4
2	12, 2, 7, >90, 60, 60
3	3, 3, 3, 3, 3
4	>90, >90, >90, reboot, 15
5	4, 4, 50, 3, 3, 40,
6	30, 5, 5, 5, 5, 4,
7	5, 10, 50, 40, 40
8	4, 4, 4, 50, 18, 4
9	5, 3, 60, 5, 3
10	untested
11	untested
12	untested
13	untested

Ping statistics:

Channel 2
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ ping 192.168.0.1
PING 192.168.0.1 (192.168.0.1) 56(84) bytes of data.
64 bytes from 192.168.0.1: icmp_seq=1 ttl=64 time=4328 ms
64 bytes from 192.168.0.1: icmp_seq=2 ttl=64 time=3319 ms
64 bytes from 192.168.0.1: icmp_seq=3 ttl=64 time=2298 ms
64 bytes from 192.168.0.1: icmp_seq=4 ttl=64 time=1280 ms
64 bytes from 192.168.0.1: icmp_seq=5 ttl=64 time=256 ms
64 bytes from 192.168.0.1: icmp_seq=6 ttl=64 time=40441 ms
64 bytes from 192.168.0.1: icmp_seq=7 ttl=64 time=39428 ms
64 bytes from 192.168.0.1: icmp_seq=8 ttl=64 time=38404 ms
64 bytes from 192.168.0.1: icmp_seq=10 ttl=64 time=36378 ms
64 bytes from 192.168.0.1: icmp_seq=11 ttl=64 time=35360 ms
64 bytes from 192.168.0.1: icmp_seq=12 ttl=64 time=534 ms
64 bytes from 192.168.0.1: icmp_seq=14 ttl=64 time=0.840 ms
64 bytes from 192.168.0.1: icmp_seq=15 ttl=64 time=1.03 ms
64 bytes from 192.168.0.1: icmp_seq=16 ttl=64 time=8.89 ms
64 bytes from 192.168.0.1: icmp_seq=17 ttl=64 time=34.7 ms
64 bytes from 192.168.0.1: icmp_seq=18 ttl=64 time=337 ms
64 bytes from 192.168.0.1: icmp_seq=19 ttl=64 time=1150 ms
64 bytes from 192.168.0.1: icmp_seq=20 ttl=64 time=141 ms
64 bytes from 192.168.0.1: icmp_seq=21 ttl=64 time=1720 ms
64 bytes from 192.168.0.1: icmp_seq=22 ttl=64 time=705 ms
64 bytes from 192.168.0.1: icmp_seq=23 ttl=64 time=1018 ms
64 bytes from 192.168.0.1: icmp_seq=24 ttl=64 time=1.66 ms
^C
--- 192.168.0.1 ping statistics ---
24 packets transmitted, 22 received, 8.33333% packet loss, time 57075ms
rtt min/avg/max/mdev = 0.840/9415.608/40441.144/15566.854 ms, pipe 7


Channel 3
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ ping 192.168.0.1
PING 192.168.0.1 (192.168.0.1) 56(84) bytes of data.
64 bytes from 192.168.0.1: icmp_seq=1 ttl=64 time=3053 ms
64 bytes from 192.168.0.1: icmp_seq=2 ttl=64 time=2046 ms
64 bytes from 192.168.0.1: icmp_seq=3 ttl=64 time=1026 ms
64 bytes from 192.168.0.1: icmp_seq=4 ttl=64 time=2.72 ms
64 bytes from 192.168.0.1: icmp_seq=5 ttl=64 time=2467 ms
64 bytes from 192.168.0.1: icmp_seq=6 ttl=64 time=1453 ms
64 bytes from 192.168.0.1: icmp_seq=7 ttl=64 time=429 ms
64 bytes from 192.168.0.1: icmp_seq=9 ttl=64 time=19522 ms
64 bytes from 192.168.0.1: icmp_seq=10 ttl=64 time=18498 ms
64 bytes from 192.168.0.1: icmp_seq=11 ttl=64 time=17482 ms
64 bytes from 192.168.0.1: icmp_seq=12 ttl=64 time=16459 ms
64 bytes from 192.168.0.1: icmp_seq=13 ttl=64 time=15435 ms
64 bytes from 192.168.0.1: icmp_seq=14 ttl=64 time=66.1 ms
64 bytes from 192.168.0.1: icmp_seq=16 ttl=64 time=10886 ms
64 bytes from 192.168.0.1: icmp_seq=17 ttl=64 time=9862 ms
64 bytes from 192.168.0.1: icmp_seq=18 ttl=64 time=8843 ms
64 bytes from 192.168.0.1: icmp_seq=19 ttl=64 time=7821 ms
64 bytes from 192.168.0.1: icmp_seq=20 ttl=64 time=6798 ms
64 bytes from 192.168.0.1: icmp_seq=21 ttl=64 time=5774 ms
64 bytes from 192.168.0.1: icmp_seq=22 ttl=64 time=644 ms
64 bytes from 192.168.0.1: icmp_seq=23 ttl=64 time=1.18 ms
64 bytes from 192.168.0.1: icmp_seq=24 ttl=64 time=1.28 ms
64 bytes from 192.168.0.1: icmp_seq=26 ttl=64 time=21370 ms
64 bytes from 192.168.0.1: icmp_seq=27 ttl=64 time=20347 ms
64 bytes from 192.168.0.1: icmp_seq=28 ttl=64 time=19323 ms
64 bytes from 192.168.0.1: icmp_seq=29 ttl=64 time=18302 ms
64 bytes from 192.168.0.1: icmp_seq=30 ttl=64 time=17278 ms
64 bytes from 192.168.0.1: icmp_seq=31 ttl=64 time=16254 ms
64 bytes from 192.168.0.1: icmp_seq=32 ttl=64 time=885 ms
64 bytes from 192.168.0.1: icmp_seq=33 ttl=64 time=1.21 ms
^C
--- 192.168.0.1 ping statistics ---
37 packets transmitted, 30 received, 18.9189% packet loss, time 69423ms
rtt min/avg/max/mdev = 1.184/8744.248/21370.185/7841.585 ms, pipe 7


Channel 4
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ ping 192.168.0.1
PING 192.168.0.1 (192.168.0.1) 56(84) bytes of data.
64 bytes from 192.168.0.1: icmp_seq=1 ttl=64 time=1.62 ms
64 bytes from 192.168.0.1: icmp_seq=2 ttl=64 time=6.71 ms
64 bytes from 192.168.0.1: icmp_seq=3 ttl=64 time=1224 ms
64 bytes from 192.168.0.1: icmp_seq=4 ttl=64 time=200 ms
64 bytes from 192.168.0.1: icmp_seq=5 ttl=64 time=1202 ms
64 bytes from 192.168.0.1: icmp_seq=6 ttl=64 time=188 ms
64 bytes from 192.168.0.1: icmp_seq=7 ttl=64 time=605 ms
64 bytes from 192.168.0.1: icmp_seq=8 ttl=64 time=1120 ms
64 bytes from 192.168.0.1: icmp_seq=9 ttl=64 time=116 ms
64 bytes from 192.168.0.1: icmp_seq=11 ttl=64 time=1.42 ms
64 bytes from 192.168.0.1: icmp_seq=16 ttl=64 time=4.88 ms
64 bytes from 192.168.0.1: icmp_seq=17 ttl=64 time=8853 ms
64 bytes from 192.168.0.1: icmp_seq=18 ttl=64 time=7843 ms
64 bytes from 192.168.0.1: icmp_seq=19 ttl=64 time=6820 ms
64 bytes from 192.168.0.1: icmp_seq=20 ttl=64 time=5799 ms
64 bytes from 192.168.0.1: icmp_seq=21 ttl=64 time=4776 ms
64 bytes from 192.168.0.1: icmp_seq=22 ttl=64 time=3753 ms
64 bytes from 192.168.0.1: icmp_seq=23 ttl=64 time=671 ms
64 bytes from 192.168.0.1: icmp_seq=30 ttl=64 time=962 ms
64 bytes from 192.168.0.1: icmp_seq=31 ttl=64 time=0.850 ms
64 bytes from 192.168.0.1: icmp_seq=32 ttl=64 time=1757 ms
64 bytes from 192.168.0.1: icmp_seq=33 ttl=64 time=738 ms
64 bytes from 192.168.0.1: icmp_seq=35 ttl=64 time=6150 ms
64 bytes from 192.168.0.1: icmp_seq=36 ttl=64 time=5126 ms
64 bytes from 192.168.0.1: icmp_seq=37 ttl=64 time=4100 ms
64 bytes from 192.168.0.1: icmp_seq=38 ttl=64 time=3080 ms
64 bytes from 192.168.0.1: icmp_seq=41 ttl=64 time=3.84 ms
64 bytes from 192.168.0.1: icmp_seq=44 ttl=64 time=3874 ms
64 bytes from 192.168.0.1: icmp_seq=45 ttl=64 time=2855 ms
64 bytes from 192.168.0.1: icmp_seq=46 ttl=64 time=1837 ms
64 bytes from 192.168.0.1: icmp_seq=47 ttl=64 time=814 ms
64 bytes from 192.168.0.1: icmp_seq=49 ttl=64 time=4101 ms
64 bytes from 192.168.0.1: icmp_seq=50 ttl=64 time=3078 ms
64 bytes from 192.168.0.1: icmp_seq=51 ttl=64 time=2054 ms
64 bytes from 192.168.0.1: icmp_seq=52 ttl=64 time=1032 ms
64 bytes from 192.168.0.1: icmp_seq=53 ttl=64 time=3.99 ms
64 bytes from 192.168.0.1: icmp_seq=58 ttl=64 time=8270 ms
64 bytes from 192.168.0.1: icmp_seq=59 ttl=64 time=7246 ms
64 bytes from 192.168.0.1: icmp_seq=60 ttl=64 time=6222 ms
64 bytes from 192.168.0.1: icmp_seq=61 ttl=64 time=5195 ms
64 bytes from 192.168.0.1: icmp_seq=62 ttl=64 time=4176 ms
64 bytes from 192.168.0.1: icmp_seq=63 ttl=64 time=3155 ms
64 bytes from 192.168.0.1: icmp_seq=64 ttl=64 time=74.5 ms

^C--- 192.168.0.1 ping statistics ---
66 packets transmitted, 43 received, 34.8485% packet loss, time 70196ms
rtt min/avg/max/mdev = 0.850/2769.484/8852.940/2640.961 ms, pipe 7

Channel 5
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ ping 192.168.0.1
PING 192.168.0.1 (192.168.0.1) 56(84) bytes of data.
64 bytes from 192.168.0.1: icmp_seq=2 ttl=64 time=289 ms
64 bytes from 192.168.0.1: icmp_seq=3 ttl=64 time=2.51 ms
64 bytes from 192.168.0.1: icmp_seq=4 ttl=64 time=2108 ms
64 bytes from 192.168.0.1: icmp_seq=5 ttl=64 time=1103 ms
64 bytes from 192.168.0.1: icmp_seq=6 ttl=64 time=79.5 ms
64 bytes from 192.168.0.1: icmp_seq=7 ttl=64 time=1528 ms
64 bytes from 192.168.0.1: icmp_seq=8 ttl=64 time=514 ms
64 bytes from 192.168.0.1: icmp_seq=10 ttl=64 time=2051 ms
64 bytes from 192.168.0.1: icmp_seq=11 ttl=64 time=1023 ms
64 bytes from 192.168.0.1: icmp_seq=12 ttl=64 time=5.14 ms
64 bytes from 192.168.0.1: icmp_seq=17 ttl=64 time=4098 ms
64 bytes from 192.168.0.1: icmp_seq=18 ttl=64 time=3075 ms
64 bytes from 192.168.0.1: icmp_seq=19 ttl=64 time=2047 ms
64 bytes from 192.168.0.1: icmp_seq=20 ttl=64 time=1028 ms
64 bytes from 192.168.0.1: icmp_seq=21 ttl=64 time=7.99 ms
64 bytes from 192.168.0.1: icmp_seq=22 ttl=64 time=6.62 ms
64 bytes from 192.168.0.1: icmp_seq=23 ttl=64 time=0.961 ms
64 bytes from 192.168.0.1: icmp_seq=25 ttl=64 time=993 ms
64 bytes from 192.168.0.1: icmp_seq=26 ttl=64 time=1.64 ms
64 bytes from 192.168.0.1: icmp_seq=29 ttl=64 time=1.07 ms
64 bytes from 192.168.0.1: icmp_seq=31 ttl=64 time=1.67 ms
64 bytes from 192.168.0.1: icmp_seq=32 ttl=64 time=4091 ms
64 bytes from 192.168.0.1: icmp_seq=33 ttl=64 time=3078 ms
64 bytes from 192.168.0.1: icmp_seq=34 ttl=64 time=2054 ms
64 bytes from 192.168.0.1: icmp_seq=35 ttl=64 time=1037 ms
64 bytes from 192.168.0.1: icmp_seq=36 ttl=64 time=9.86 ms
64 bytes from 192.168.0.1: icmp_seq=38 ttl=64 time=3238 ms
64 bytes from 192.168.0.1: icmp_seq=39 ttl=64 time=2214 ms
64 bytes from 192.168.0.1: icmp_seq=40 ttl=64 time=1191 ms
64 bytes from 192.168.0.1: icmp_seq=44 ttl=64 time=1.62 ms
64 bytes from 192.168.0.1: icmp_seq=45 ttl=64 time=2.07 ms
64 bytes from 192.168.0.1: icmp_seq=47 ttl=64 time=9473 ms
64 bytes from 192.168.0.1: icmp_seq=48 ttl=64 time=8450 ms
64 bytes from 192.168.0.1: icmp_seq=49 ttl=64 time=7443 ms
64 bytes from 192.168.0.1: icmp_seq=50 ttl=64 time=6420 ms
64 bytes from 192.168.0.1: icmp_seq=51 ttl=64 time=5396 ms
64 bytes from 192.168.0.1: icmp_seq=52 ttl=64 time=264 ms
64 bytes from 192.168.0.1: icmp_seq=57 ttl=64 time=5447 ms
64 bytes from 192.168.0.1: icmp_seq=58 ttl=64 time=4423 ms
64 bytes from 192.168.0.1: icmp_seq=59 ttl=64 time=3403 ms
64 bytes from 192.168.0.1: icmp_seq=60 ttl=64 time=2379 ms
64 bytes from 192.168.0.1: icmp_seq=61 ttl=64 time=1356 ms
64 bytes from 192.168.0.1: icmp_seq=62 ttl=64 time=333 ms
64 bytes from 192.168.0.1: icmp_seq=64 ttl=64 time=4098 ms
64 bytes from 192.168.0.1: icmp_seq=65 ttl=64 time=3074 ms
64 bytes from 192.168.0.1: icmp_seq=68 ttl=64 time=3.35 ms
^C
--- 192.168.0.1 ping statistics ---
73 packets transmitted, 46 received, 36.9863% packet loss, time 77231ms
rtt min/avg/max/mdev = 0.961/2148.809/9473.428/2393.957 ms, pipe 6


Channel 6
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ ping 192.168.0.1
PING 192.168.0.1 (192.168.0.1) 56(84) bytes of data.
64 bytes from 192.168.0.1: icmp_seq=1 ttl=64 time=7.30 ms
64 bytes from 192.168.0.1: icmp_seq=3 ttl=64 time=29.6 ms
64 bytes from 192.168.0.1: icmp_seq=4 ttl=64 time=0.779 ms
64 bytes from 192.168.0.1: icmp_seq=5 ttl=64 time=62.7 ms
64 bytes from 192.168.0.1: icmp_seq=6 ttl=64 time=1.02 ms
64 bytes from 192.168.0.1: icmp_seq=7 ttl=64 time=1.23 ms
64 bytes from 192.168.0.1: icmp_seq=8 ttl=64 time=69.6 ms
64 bytes from 192.168.0.1: icmp_seq=9 ttl=64 time=5125 ms
64 bytes from 192.168.0.1: icmp_seq=10 ttl=64 time=4097 ms
64 bytes from 192.168.0.1: icmp_seq=11 ttl=64 time=3073 ms
64 bytes from 192.168.0.1: icmp_seq=12 ttl=64 time=2050 ms
64 bytes from 192.168.0.1: icmp_seq=13 ttl=64 time=1026 ms
64 bytes from 192.168.0.1: icmp_seq=14 ttl=64 time=2.72 ms
64 bytes from 192.168.0.1: icmp_seq=20 ttl=64 time=1025 ms
64 bytes from 192.168.0.1: icmp_seq=21 ttl=64 time=1.27 ms
64 bytes from 192.168.0.1: icmp_seq=24 ttl=64 time=1.36 ms
64 bytes from 192.168.0.1: icmp_seq=31 ttl=64 time=3105 ms
64 bytes from 192.168.0.1: icmp_seq=32 ttl=64 time=2081 ms
64 bytes from 192.168.0.1: icmp_seq=33 ttl=64 time=1057 ms
64 bytes from 192.168.0.1: icmp_seq=34 ttl=64 time=33.6 ms
64 bytes from 192.168.0.1: icmp_seq=36 ttl=64 time=9281 ms
64 bytes from 192.168.0.1: icmp_seq=37 ttl=64 time=8257 ms
64 bytes from 192.168.0.1: icmp_seq=38 ttl=64 time=7230 ms
64 bytes from 192.168.0.1: icmp_seq=39 ttl=64 time=6211 ms
64 bytes from 192.168.0.1: icmp_seq=40 ttl=64 time=5187 ms
64 bytes from 192.168.0.1: icmp_seq=41 ttl=64 time=57.5 ms
64 bytes from 192.168.0.1: icmp_seq=43 ttl=64 time=2.21 ms
64 bytes from 192.168.0.1: icmp_seq=46 ttl=64 time=5256 ms
64 bytes from 192.168.0.1: icmp_seq=47 ttl=64 time=4232 ms
64 bytes from 192.168.0.1: icmp_seq=48 ttl=64 time=3208 ms
64 bytes from 192.168.0.1: icmp_seq=49 ttl=64 time=2184 ms
64 bytes from 192.168.0.1: icmp_seq=50 ttl=64 time=1161 ms
64 bytes from 192.168.0.1: icmp_seq=51 ttl=64 time=137 ms
64 bytes from 192.168.0.1: icmp_seq=53 ttl=64 time=2050 ms
64 bytes from 192.168.0.1: icmp_seq=54 ttl=64 time=1026 ms
64 bytes from 192.168.0.1: icmp_seq=55 ttl=64 time=2.56 ms
64 bytes from 192.168.0.1: icmp_seq=67 ttl=64 time=6337 ms
64 bytes from 192.168.0.1: icmp_seq=68 ttl=64 time=5313 ms
64 bytes from 192.168.0.1: icmp_seq=69 ttl=64 time=4290 ms
64 bytes from 192.168.0.1: icmp_seq=70 ttl=64 time=3267 ms
64 bytes from 192.168.0.1: icmp_seq=71 ttl=64 time=2243 ms
64 bytes from 192.168.0.1: icmp_seq=72 ttl=64 time=185 ms
64 bytes from 192.168.0.1: icmp_seq=74 ttl=64 time=10465 ms
64 bytes from 192.168.0.1: icmp_seq=75 ttl=64 time=9441 ms
64 bytes from 192.168.0.1: icmp_seq=76 ttl=64 time=8418 ms
64 bytes from 192.168.0.1: icmp_seq=77 ttl=64 time=7395 ms
64 bytes from 192.168.0.1: icmp_seq=78 ttl=64 time=6371 ms
64 bytes from 192.168.0.1: icmp_seq=79 ttl=64 time=217 ms
^C
--- 192.168.0.1 ping statistics ---
84 packets transmitted, 48 received, 42.8571% packet loss, time 94747ms
rtt min/avg/max/mdev = 0.779/2964.129/10465.412/3091.896 ms, pipe 6

Channel 7
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ ping 192.168.0.1
PING 192.168.0.1 (192.168.0.1) 56(84) bytes of data.
64 bytes from 192.168.0.1: icmp_seq=1 ttl=64 time=1.21 ms
64 bytes from 192.168.0.1: icmp_seq=4 ttl=64 time=1438 ms
64 bytes from 192.168.0.1: icmp_seq=5 ttl=64 time=423 ms
64 bytes from 192.168.0.1: icmp_seq=6 ttl=64 time=5164 ms
64 bytes from 192.168.0.1: icmp_seq=7 ttl=64 time=4150 ms
64 bytes from 192.168.0.1: icmp_seq=8 ttl=64 time=3127 ms
64 bytes from 192.168.0.1: icmp_seq=9 ttl=64 time=2105 ms
64 bytes from 192.168.0.1: icmp_seq=10 ttl=64 time=1077 ms
64 bytes from 192.168.0.1: icmp_seq=11 ttl=64 time=58.2 ms
64 bytes from 192.168.0.1: icmp_seq=12 ttl=64 time=1464 ms
64 bytes from 192.168.0.1: icmp_seq=13 ttl=64 time=450 ms
64 bytes from 192.168.0.1: icmp_seq=15 ttl=64 time=1.23 ms
64 bytes from 192.168.0.1: icmp_seq=20 ttl=64 time=3587 ms
64 bytes from 192.168.0.1: icmp_seq=21 ttl=64 time=2567 ms
64 bytes from 192.168.0.1: icmp_seq=22 ttl=64 time=1546 ms
64 bytes from 192.168.0.1: icmp_seq=23 ttl=64 time=522 ms
64 bytes from 192.168.0.1: icmp_seq=24 ttl=64 time=2585 ms
64 bytes from 192.168.0.1: icmp_seq=25 ttl=64 time=1570 ms
64 bytes from 192.168.0.1: icmp_seq=26 ttl=64 time=546 ms
64 bytes from 192.168.0.1: icmp_seq=27 ttl=64 time=2042 ms
64 bytes from 192.168.0.1: icmp_seq=28 ttl=64 time=1026 ms
64 bytes from 192.168.0.1: icmp_seq=29 ttl=64 time=2.58 ms
64 bytes from 192.168.0.1: icmp_seq=34 ttl=64 time=1026 ms
64 bytes from 192.168.0.1: icmp_seq=35 ttl=64 time=2.20 ms
64 bytes from 192.168.0.1: icmp_seq=38 ttl=64 time=1.19 ms
64 bytes from 192.168.0.1: icmp_seq=41 ttl=64 time=4003 ms
64 bytes from 192.168.0.1: icmp_seq=42 ttl=64 time=2979 ms
64 bytes from 192.168.0.1: icmp_seq=43 ttl=64 time=1958 ms
64 bytes from 192.168.0.1: icmp_seq=44 ttl=64 time=934 ms
64 bytes from 192.168.0.1: icmp_seq=45 ttl=64 time=0.908 ms
64 bytes from 192.168.0.1: icmp_seq=48 ttl=64 time=1.65 ms
64 bytes from 192.168.0.1: icmp_seq=51 ttl=64 time=1.16 ms
64 bytes from 192.168.0.1: icmp_seq=52 ttl=64 time=1825 ms
64 bytes from 192.168.0.1: icmp_seq=53 ttl=64 time=811 ms
64 bytes from 192.168.0.1: icmp_seq=54 ttl=64 time=1081 ms
64 bytes from 192.168.0.1: icmp_seq=55 ttl=64 time=66.2 ms
64 bytes from 192.168.0.1: icmp_seq=56 ttl=64 time=2656 ms
64 bytes from 192.168.0.1: icmp_seq=61 ttl=64 time=1.16 ms
64 bytes from 192.168.0.1: icmp_seq=62 ttl=64 time=2.29 ms
64 bytes from 192.168.0.1: icmp_seq=63 ttl=64 time=2035 ms
64 bytes from 192.168.0.1: icmp_seq=64 ttl=64 time=1030 ms
64 bytes from 192.168.0.1: icmp_seq=65 ttl=64 time=3.12 ms
64 bytes from 192.168.0.1: icmp_seq=69 ttl=64 time=3080 ms
64 bytes from 192.168.0.1: icmp_seq=70 ttl=64 time=2057 ms
64 bytes from 192.168.0.1: icmp_seq=71 ttl=64 time=1033 ms
64 bytes from 192.168.0.1: icmp_seq=72 ttl=64 time=10.3 ms
64 bytes from 192.168.0.1: icmp_seq=74 ttl=64 time=1026 ms
64 bytes from 192.168.0.1: icmp_seq=75 ttl=64 time=2.20 ms
64 bytes from 192.168.0.1: icmp_seq=82 ttl=64 time=1.18 ms
64 bytes from 192.168.0.1: icmp_seq=84 ttl=64 time=1.45 ms
64 bytes from 192.168.0.1: icmp_seq=86 ttl=64 time=38.4 ms
64 bytes from 192.168.0.1: icmp_seq=87 ttl=64 time=1398 ms
64 bytes from 192.168.0.1: icmp_seq=88 ttl=64 time=388 ms
64 bytes from 192.168.0.1: icmp_seq=91 ttl=64 time=2.75 ms
64 bytes from 192.168.0.1: icmp_seq=96 ttl=64 time=1.16 ms
 From 192.168.0.100 icmp_seq=101 Destination Host Unreachable
 From 192.168.0.100 icmp_seq=102 Destination Host Unreachable
 From 192.168.0.100 icmp_seq=103 Destination Host Unreachable
^C
--- 192.168.0.1 ping statistics ---
104 packets transmitted, 55 received, +3 errors, 47.1154% packet loss, 
time 104564ms
rtt min/avg/max/mdev = 0.908/1180.168/5164.367/1279.558 ms, pipe 6


Channel 8
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ ping 192.168.0.1
PING 192.168.0.1 (192.168.0.1) 56(84) bytes of data.
64 bytes from 192.168.0.1: icmp_seq=2 ttl=64 time=2.05 ms
64 bytes from 192.168.0.1: icmp_seq=4 ttl=64 time=10622 ms
64 bytes from 192.168.0.1: icmp_seq=5 ttl=64 time=9602 ms
64 bytes from 192.168.0.1: icmp_seq=6 ttl=64 time=8580 ms
64 bytes from 192.168.0.1: icmp_seq=7 ttl=64 time=7553 ms
64 bytes from 192.168.0.1: icmp_seq=8 ttl=64 time=6533 ms
64 bytes from 192.168.0.1: icmp_seq=9 ttl=64 time=379 ms
64 bytes from 192.168.0.1: icmp_seq=13 ttl=64 time=12034 ms
64 bytes from 192.168.0.1: icmp_seq=14 ttl=64 time=11010 ms
64 bytes from 192.168.0.1: icmp_seq=15 ttl=64 time=9990 ms
64 bytes from 192.168.0.1: icmp_seq=16 ttl=64 time=8967 ms
64 bytes from 192.168.0.1: icmp_seq=17 ttl=64 time=7944 ms
64 bytes from 192.168.0.1: icmp_seq=18 ttl=64 time=766 ms
64 bytes from 192.168.0.1: icmp_seq=20 ttl=64 time=1.20 ms
64 bytes from 192.168.0.1: icmp_seq=21 ttl=64 time=28892 ms
64 bytes from 192.168.0.1: icmp_seq=22 ttl=64 time=27879 ms
64 bytes from 192.168.0.1: icmp_seq=23 ttl=64 time=26859 ms
64 bytes from 192.168.0.1: icmp_seq=24 ttl=64 time=25837 ms
64 bytes from 192.168.0.1: icmp_seq=25 ttl=64 time=24813 ms
64 bytes from 192.168.0.1: icmp_seq=26 ttl=64 time=23790 ms
64 bytes from 192.168.0.1: icmp_seq=27 ttl=64 time=226 ms
64 bytes from 192.168.0.1: icmp_seq=28 ttl=64 time=28.2 ms
64 bytes from 192.168.0.1: icmp_seq=29 ttl=64 time=0.860 ms
64 bytes from 192.168.0.1: icmp_seq=30 ttl=64 time=24568 ms
64 bytes from 192.168.0.1: icmp_seq=31 ttl=64 time=23553 ms
64 bytes from 192.168.0.1: icmp_seq=32 ttl=64 time=22530 ms
64 bytes from 192.168.0.1: icmp_seq=33 ttl=64 time=21507 ms
64 bytes from 192.168.0.1: icmp_seq=34 ttl=64 time=20483 ms
64 bytes from 192.168.0.1: icmp_seq=35 ttl=64 time=19461 ms
64 bytes from 192.168.0.1: icmp_seq=36 ttl=64 time=3.59 ms
64 bytes from 192.168.0.1: icmp_seq=40 ttl=64 time=1262 ms
64 bytes from 192.168.0.1: icmp_seq=41 ttl=64 time=238 ms
64 bytes from 192.168.0.1: icmp_seq=42 ttl=64 time=5464 ms
64 bytes from 192.168.0.1: icmp_seq=43 ttl=64 time=4449 ms
64 bytes from 192.168.0.1: icmp_seq=44 ttl=64 time=3426 ms
64 bytes from 192.168.0.1: icmp_seq=45 ttl=64 time=2404 ms
64 bytes from 192.168.0.1: icmp_seq=46 ttl=64 time=1380 ms
64 bytes from 192.168.0.1: icmp_seq=47 ttl=64 time=357 ms
64 bytes from 192.168.0.1: icmp_seq=49 ttl=64 time=1026 ms
64 bytes from 192.168.0.1: icmp_seq=50 ttl=64 time=1.87 ms
64 bytes from 192.168.0.1: icmp_seq=55 ttl=64 time=9121 ms
64 bytes from 192.168.0.1: icmp_seq=56 ttl=64 time=8097 ms
64 bytes from 192.168.0.1: icmp_seq=57 ttl=64 time=7081 ms
64 bytes from 192.168.0.1: icmp_seq=58 ttl=64 time=6053 ms
64 bytes from 192.168.0.1: icmp_seq=59 ttl=64 time=5033 ms
64 bytes from 192.168.0.1: icmp_seq=60 ttl=64 time=928 ms
64 bytes from 192.168.0.1: icmp_seq=61 ttl=64 time=1.57 ms
^C
--- 192.168.0.1 ping statistics ---
62 packets transmitted, 47 received, 24.1935% packet loss, time 117405ms
rtt min/avg/max/mdev = 0.860/9377.356/28891.850/9451.513 ms, pipe 7

Channel 9
kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ ping 192.168.0.1
PING 192.168.0.1 (192.168.0.1) 56(84) bytes of data.
64 bytes from 192.168.0.1: icmp_seq=1 ttl=64 time=530 ms
64 bytes from 192.168.0.1: icmp_seq=2 ttl=64 time=5415 ms
64 bytes from 192.168.0.1: icmp_seq=3 ttl=64 time=4389 ms
64 bytes from 192.168.0.1: icmp_seq=4 ttl=64 time=3367 ms
64 bytes from 192.168.0.1: icmp_seq=5 ttl=64 time=2342 ms
64 bytes from 192.168.0.1: icmp_seq=6 ttl=64 time=1322 ms
64 bytes from 192.168.0.1: icmp_seq=7 ttl=64 time=298 ms
64 bytes from 192.168.0.1: icmp_seq=8 ttl=64 time=6751 ms
64 bytes from 192.168.0.1: icmp_seq=9 ttl=64 time=5737 ms
64 bytes from 192.168.0.1: icmp_seq=10 ttl=64 time=4713 ms
64 bytes from 192.168.0.1: icmp_seq=11 ttl=64 time=3686 ms
64 bytes from 192.168.0.1: icmp_seq=12 ttl=64 time=2666 ms
64 bytes from 192.168.0.1: icmp_seq=13 ttl=64 time=1642 ms
64 bytes from 192.168.0.1: icmp_seq=14 ttl=64 time=618 ms
64 bytes from 192.168.0.1: icmp_seq=15 ttl=64 time=1.98 ms
64 bytes from 192.168.0.1: icmp_seq=19 ttl=64 time=10797 ms
64 bytes from 192.168.0.1: icmp_seq=22 ttl=64 time=7726 ms
64 bytes from 192.168.0.1: icmp_seq=23 ttl=64 time=6707 ms
64 bytes from 192.168.0.1: icmp_seq=24 ttl=64 time=5683 ms
64 bytes from 192.168.0.1: icmp_seq=25 ttl=64 time=555 ms
64 bytes from 192.168.0.1: icmp_seq=31 ttl=64 time=24573 ms
64 bytes from 192.168.0.1: icmp_seq=32 ttl=64 time=23554 ms
64 bytes from 192.168.0.1: icmp_seq=33 ttl=64 time=22539 ms
64 bytes from 192.168.0.1: icmp_seq=34 ttl=64 time=21515 ms
64 bytes from 192.168.0.1: icmp_seq=35 ttl=64 time=20492 ms
64 bytes from 192.168.0.1: icmp_seq=36 ttl=64 time=1042 ms
64 bytes from 192.168.0.1: icmp_seq=37 ttl=64 time=26.6 ms
64 bytes from 192.168.0.1: icmp_seq=43 ttl=64 time=1.39 ms
64 bytes from 192.168.0.1: icmp_seq=46 ttl=64 time=1.83 ms
64 bytes from 192.168.0.1: icmp_seq=47 ttl=64 time=4576 ms
64 bytes from 192.168.0.1: icmp_seq=48 ttl=64 time=3562 ms
64 bytes from 192.168.0.1: icmp_seq=49 ttl=64 time=2538 ms
64 bytes from 192.168.0.1: icmp_seq=50 ttl=64 time=1514 ms
64 bytes from 192.168.0.1: icmp_seq=51 ttl=64 time=486 ms
64 bytes from 192.168.0.1: icmp_seq=53 ttl=64 time=56133 ms
64 bytes from 192.168.0.1: icmp_seq=54 ttl=64 time=55109 ms
64 bytes from 192.168.0.1: icmp_seq=55 ttl=64 time=54086 ms
64 bytes from 192.168.0.1: icmp_seq=56 ttl=64 time=53058 ms
64 bytes from 192.168.0.1: icmp_seq=57 ttl=64 time=52034 ms
64 bytes from 192.168.0.1: icmp_seq=58 ttl=64 time=829 ms
64 bytes from 192.168.0.1: icmp_seq=60 ttl=64 time=1021 ms
64 bytes from 192.168.0.1: icmp_seq=61 ttl=64 time=1.21 ms
^C
--- 192.168.0.1 ping statistics ---
61 packets transmitted, 42 received, 31.1475% packet loss, time 133834ms
rtt min/avg/max/mdev = 1.210/11277.187/56132.925/17137.608 ms, pipe 7

Channel 10 - 13 untested
