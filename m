Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446A47AA5D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjIUXuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUXuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:50:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B778F102
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1695340228;
        bh=UUmux8/Cg3ThyE8UwqG2/nXFVX8BSQmnhjAf5f0s7Qo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ai6593xBSTRx0fCOrgZMlKzEr0DfS3sIswGFwktvHA/5e4hVScmF4Mp7P6Wwxhf+U
         P9jq+ZYJllCH+gXhwqRbLAygJxl1fOiDdW8qSiv76wbndCKpDyBYm+XGHplTRB+VnL
         BYodGXuqfwe72zTxaRkVsPWOxOZLJZlAxj49EZDpVNAPK0/i1s1ttWb2mpvF+HQHQa
         dpjc3Gl/UW9y63AQRBKMJRMWUYRp2xY245+oEI9KudGzxaQlKPNIft+9wuBZ+UKxmY
         XjBZ09dllD8GZYneLEQka5iwlA6JxnVVqJHyHOqRDhzFBwrgdbUxeaPQktZ29+kmV5
         wQ10mrDpgMqZg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RsBwf14Pwz4x5G;
        Fri, 22 Sep 2023 09:50:25 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Yuan Tan <tanyuan@tinylab.org>, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, w@1wt.eu, linux@weissschuh.net,
        Philippe =?utf-8?Q?Ma?= =?utf-8?Q?thieu-Daud=C3=A9?= 
        <philmd@linaro.org>
Subject: Re: [PATCH v3 1/3] powerpc/config: Cleanup pmac32_defconfig
In-Reply-To: <A81E00EBD697C30F+9c7a7721-e949-4ca6-a6b3-8eeb181718f2@tinylab.org>
References: <cover.1694685860.git.tanyuan@tinylab.org>
 <23b30e8e9e31e7a6af4aa7d317699e1538ad89c2.1694685860.git.tanyuan@tinylab.org>
 <87y1h87vf3.fsf@mail.lhotse>
 <A81E00EBD697C30F+9c7a7721-e949-4ca6-a6b3-8eeb181718f2@tinylab.org>
Date:   Fri, 22 Sep 2023 09:50:25 +1000
Message-ID: <87o7hvm6gu.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yuan Tan <tanyuan@tinylab.org> writes:
> On 9/14/2023 9:10 PM, Michael Ellerman wrote:
>> Yuan Tan <tanyuan@tinylab.org> writes:
>>> Use 'make savedefconfig' to cleanup pmac32_defconfig, based on Linux
>>> 7.6-rc1
>> Thanks but I don't like doing these updates in a single commit like
>> this, it's easy to accidentally lose a symbol.
> Yeah I have the same concerns too.
>>
>> I prefer an explanation for what's changing for each symbol. See
>> 1ce7fda142af ("powerpc/configs/64s: Drop IPV6 which is default y") and
>> the commits leading up to it, to see what I mean.
>>
>> But I suspect you probably don't want to go to all that effort, which is
>> fine :)
>
> I am not familiar with other options, so I'd better not do that. :)
>
> By the way, just to be cautious, since the defconfig can only be updated
> by 'savedefconfig'[1], how can we write an explanation for a single
> change in an option?

Well the defconfig can be updated manually, but the changes you make
manually should match what savedefconfig would do.

> I mean, when I change one option, the value of the other undetermined
> option will be set just like in patch 1.

At that point I just stage the change to the option I'm changing, and
leave the other lines modified by savedefconfig alone. That way you can
commit the changes made by savedefconfig in multiple steps, explaining
what happens along the way, and the end result is the same as what
savedefconfig generates.

So for example at the moment if you do savedefconfig on
pmac32_defconfig, the start of the diff looks like:

 1  diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
 2  index 57ded82c2840..17df965be099 100644
 3  --- a/arch/powerpc/configs/pmac32_defconfig
 4  +++ b/arch/powerpc/configs/pmac32_defconfig
 5  @@ -1,4 +1,3 @@
 6  -CONFIG_ALTIVEC=y
 7   # CONFIG_LOCALVERSION_AUTO is not set
 8   CONFIG_SYSVIPC=y
 9   CONFIG_POSIX_MQUEUE=y
10  @@ -8,12 +7,8 @@ CONFIG_IKCONFIG=y
11   CONFIG_IKCONFIG_PROC=y
12   CONFIG_LOG_BUF_SHIFT=14
13   CONFIG_BLK_DEV_INITRD=y
14  -# CONFIG_COMPAT_BRK is not set
15   CONFIG_PROFILING=y
16  -CONFIG_MODULES=y
17  -CONFIG_MODULE_UNLOAD=y
18  -CONFIG_MODULE_FORCE_UNLOAD=y
19 -CONFIG_PARTITION_ADVANCED=y
20 +CONFIG_ALTIVEC=y
21  # CONFIG_PPC_CHRP is not set
22  CONFIG_CPU_FREQ=y
23  CONFIG_CPU_FREQ_GOV_POWERSAVE=y

So you can stage lines 6 and 20, and commit that as "Update for symbol
movement", ie. nothing changed other than a symbol moved.

Then repeat that until eventually the config is up to date.

cheers
