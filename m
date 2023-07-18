Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB4A757AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjGRLsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjGRLsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:48:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F19C0;
        Tue, 18 Jul 2023 04:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1689680892;
        bh=qkoJ1TZtcbRhGyivE/SKxy/6onKpIFRvIjW5wMAgnBM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YEPnsELMRu2D63Po1X6IMo2QJZo1eeq40G3q70WNISWlYL4FRhEQ37pMLkjrQ4mBJ
         5xNE2tapB5aAsebvtRoEMWnJHZJHmRjcjvPQxEzbUGzfGCN0z3SgXv3Uq8G67davGC
         yCQFDYEKUu6fF7/8ssxM376PlGMPjTbRjCKwtC+uUHfyIGoRvXbuUKPSBkqDIDq5q7
         JcTEVmEwbilBc37Z9U3ob+DNVY9aeD8LGCJ4AlAZSxnwgoSkhyVSCn7AzDSyxV2WCM
         az8MGdjlTUrwvozShNmcwBuTGqiXLAPAmWYSKo0MeWf+ZGMWkn85vFDjMsOC12FZ5p
         SUB7lDSRwQTRQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R4xzG5srnz4wxV;
        Tue, 18 Jul 2023 21:48:10 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Geoff Levand <geoff@infradead.org>
Subject: Re: linux-next: Tree for Jul 13 (drivers/video/fbdev/ps3fb.c)
In-Reply-To: <ZLYHtVuS7AElXcCb@debian.me>
References: <20230713123710.5d7d81e4@canb.auug.org.au>
 <ccc63065-2976-88ef-1211-731330bf2866@infradead.org>
 <ZLYHtVuS7AElXcCb@debian.me>
Date:   Tue, 18 Jul 2023 21:48:05 +1000
Message-ID: <874jm1jv9m.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:
> On Thu, Jul 13, 2023 at 09:11:10AM -0700, Randy Dunlap wrote:
>> on ppc64:
>> 
>> In file included from ../include/linux/device.h:15,
>>                  from ../arch/powerpc/include/asm/io.h:22,
>>                  from ../include/linux/io.h:13,
>>                  from ../include/linux/irq.h:20,
>>                  from ../arch/powerpc/include/asm/hardirq.h:6,
>>                  from ../include/linux/hardirq.h:11,
>>                  from ../include/linux/interrupt.h:11,
>>                  from ../drivers/video/fbdev/ps3fb.c:25:
>> ../drivers/video/fbdev/ps3fb.c: In function 'ps3fb_probe':
>> ../drivers/video/fbdev/ps3fb.c:1172:40: error: 'struct fb_info' has no member named 'dev'
>>  1172 |                  dev_driver_string(info->dev), dev_name(info->dev),
>>       |                                        ^~
>> ../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
>>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>>       |                                     ^~~~~~~~~~~
>> ../drivers/video/fbdev/ps3fb.c:1171:9: note: in expansion of macro 'dev_info'
>>  1171 |         dev_info(info->device, "%s %s, using %u KiB of video memory\n",
>>       |         ^~~~~~~~
>> ../drivers/video/fbdev/ps3fb.c:1172:61: error: 'struct fb_info' has no member named 'dev'
>>  1172 |                  dev_driver_string(info->dev), dev_name(info->dev),
>>       |                                                             ^~
>> ../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
>>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>>       |                                     ^~~~~~~~~~~
>> ../drivers/video/fbdev/ps3fb.c:1171:9: note: in expansion of macro 'dev_info'
>>  1171 |         dev_info(info->device, "%s %s, using %u KiB of video memory\n",
>>       |         ^~~~~~~~
>> 
>> 
>
> Hmm, there is no response from Thomas yet. I guess we should go with
> reverting bdb616479eff419, right? Regardless, I'm adding this build regression
> to regzbot so that parties involved are aware of it:
>
> #regzbot ^introduced: bdb616479eff419
> #regzbot title: build regression in PS3 framebuffer

Does regzbot track issues in linux-next?

They're not really regressions because they're not in a release yet.

Anyway I don't see where bdb616479eff419 comes from.

The issue was introduced by:

  701d2054fa31 fbdev: Make support for userspace interfaces configurable

The driver seems to only use info->dev in that one dev_info() line,
which seems purely cosmetic, so I think it could just be removed, eg:

diff --git a/drivers/video/fbdev/ps3fb.c b/drivers/video/fbdev/ps3fb.c
index d4abcf8aff75..a304a39d712b 100644
--- a/drivers/video/fbdev/ps3fb.c
+++ b/drivers/video/fbdev/ps3fb.c
@@ -1168,8 +1168,7 @@ static int ps3fb_probe(struct ps3_system_bus_device *dev)
 
 	ps3_system_bus_set_drvdata(dev, info);
 
-	dev_info(info->device, "%s %s, using %u KiB of video memory\n",
-		 dev_driver_string(info->dev), dev_name(info->dev),
+	dev_info(info->device, "using %u KiB of video memory\n",
 		 info->fix.smem_len >> 10);
 
 	task = kthread_run(ps3fbd, info, DEVICE_NAME);


cheers
