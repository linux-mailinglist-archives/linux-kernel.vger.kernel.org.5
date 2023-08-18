Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C6B7805CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357982AbjHRGFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358036AbjHRGEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:04:53 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4C43589;
        Thu, 17 Aug 2023 23:04:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 4A88560174;
        Fri, 18 Aug 2023 08:04:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692338688; bh=6RfGVnCZ81mI1IH4EbO9lFplxAUZ3z7hLl2fyDw6MzQ=;
        h=Date:To:Cc:From:Subject:From;
        b=peX6+amz7KiW2eGnVBAEE75g3YRJu0KTDMU+vRDotfgMf8nap+GtPD2aAIW40Mgr7
         8/6kEM1vwfk8IVzVZrfcXxBJ5lRanPr/6vas/Ohoy12cG+ZRoF2/mKWFXExkF9d0xV
         OG5vCZmSWOydrgYdRajf0LvjGQw5lN81n+8PrUxz48ukVh4k5Brp0RH2dAIgfoFyKK
         Xn5ezQ6i7O2tJsp4bGmEH1F5GvgYEFj9TSX/n10jhCROnOU0/DDPGBdvFVMD5/3GDQ
         uBvAN+H0WRLLts9WFBisw5b75cTNeP4GEy4Jd+XTA5bNSMkNOtEeMEfrVj0jFWZ/Eb
         2j4DPS0vffaTQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SVJ8fHRFfbRF; Fri, 18 Aug 2023 08:04:45 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 46BB16015E;
        Fri, 18 Aug 2023 08:04:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692338685; bh=6RfGVnCZ81mI1IH4EbO9lFplxAUZ3z7hLl2fyDw6MzQ=;
        h=Date:To:Cc:From:Subject:From;
        b=jSvJ43joU0nSL6unNiH6tRBH5yd7ILmmVnmh8d7+M/Un2f25/CDCvDtWCGilrTEIL
         aAQ6uJOm+AscjJIRyLYs+R9R7S6saFk8gyodNEpjbEZtk1Fvi7IVBBBrjSkvMpYjFy
         SHaj6acL0tHSp0GA1ddH/ccitkBoZ5wL7EPtNnSRVDoNPmwzBsOSK1bBLdQYBakW1I
         iCGFieAHafODZ8vx1BeHcstYCrVb9Bevo/nBCZvUMCCiyr8qhdeg9eF0KcjqNxnwyZ
         wUFQACkrNYkLW4iIM54hOh535gmzERSXtGqyMdeKwq1flG3KkeAxyu1N8PLk/HA9jK
         MsLE6ZkZpWpiw==
Message-ID: <3bc6a541-dd00-61b3-b8f7-d35d09965654@alu.unizg.hr>
Date:   Fri, 18 Aug 2023 08:04:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: [POSSIBLE BUG] SSL error:FFFFFFFF80000002:system library::No such
 file or directory
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Ubuntu 22.04 LTS, vanilla torvalds kernel, stock config-6.5.0-060500-rc5 + tools/../selftests/net/config,
debug info on.

There seems to be a build error I haven't seen before:

At main.c:298:
- SSL error:FFFFFFFF80000002:system library::No such file or directory: ../crypto/bio/bss_file.c:67
- SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_file.c:75
sign-file: debian/linux-image/lib/modules/6.5.0-rc6+/kernel/arch/x86/events/amd/amd-uncore.ko

So, I understood there is no amd/amd-uncore.ko, but there is a compressed instance in the same directory:

marvin@defiant:~/linux/kernel/linux_torvalds$ ls debian/linux-image/lib/modules/6.5.0-rc6+/kernel/arch/x86/events/amd
amd-uncore.ko.zst
marvin@defiant:~/linux/kernel/linux_torvalds$

Did I do something very stupid?

I think it is almost a default build. I tried my local openssl 3.1.0 and the Ubuntu's 3.1.2 openssl.

NOTE: Disabling the ZSTD module compression and setting it to None solved the problem and the build was
successful.

Many thanks.

Best regards,
Mirsad Todorovac
