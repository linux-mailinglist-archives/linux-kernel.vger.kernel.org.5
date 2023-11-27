Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8507F97F0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjK0D3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0D3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:29:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5D4E1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701055758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PnTrWVmf8fnOo5Xt1U1MdbL+1iOZnlvT18JnDKebNVY=;
        b=EXp33dBEsG04CjJUFMi20gRz8P9INblYyrb4lemhmoZDno6b/lyTQI0E+TzkEjhMXIAUib
        FH+UXXqqLuZnOO3jdRSTfoqqHOlxbLB1tQjVxTZ/xHfkKhQCI9URZwBlhrw1zcCt7sYp43
        amVp7dLrARODQ+Ntaj5NVD3z0Ykz41Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-l4JqyT8yPdyOLUMGAlVFQg-1; Sun, 26 Nov 2023 22:29:14 -0500
X-MC-Unique: l4JqyT8yPdyOLUMGAlVFQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2977A185A780;
        Mon, 27 Nov 2023 03:29:14 +0000 (UTC)
Received: from localhost (unknown [10.72.112.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8BD336E2;
        Mon, 27 Nov 2023 03:29:07 +0000 (UTC)
Date:   Mon, 27 Nov 2023 11:29:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric_devolder@yahoo.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        akpm@linux-foundation.org, ignat@cloudflare.com
Subject: Re: [PATCH 0/3] kernel/Kconfig.kexec: drop select of KEXEC for
 CRASH_DUMP
Message-ID: <ZWQNACdS12xDXL7A@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <5ab45f48-9ec2-4611-81a2-4dc2f1854c4f@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab45f48-9ec2-4611-81a2-4dc2f1854c4f@yahoo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/23 at 06:07pm, Eric DeVolder wrote:
> 
> On 11/23/23 01:36, Baoquan He wrote:
> > Ignat reported a potential config regression was introduced by
> > commit 89cde455915f ("kexec: consolidate kexec and crash options
> > into kernel/Kconfig.kexec"). Please click below link for more details:
> > 
> > https://lore.kernel.org/all/CALrw=nHpRQQaQTP_jZfREgrQEMpS8jBF8JQCv4ygqXycE-StaA@mail.gmail.com/T/#u
> > 
> > The patch 1 fix the regression by removing incorrect CONFIG_KEXEC
> > ifdeffery scope adding in arm's <asm/kexec.h>, then dropping the
> > select of KEXEC for CRASH_DUMP. This is tested and passed a cross
> > comiping of arm.
> > 
> > Patch 2 is to fix a build failure when I tested patch 1 on x86_64, the
> > wrong CONFIG_KEXEC iddeffery is replaced with CONFIG_KEXEC_CORE. Test
> > passed on x86_64.
> > 
> > Patch 3 is to fix an unnecessary 'select KEXEC' in s390 ARCH. Removing
> > the select won't impact anything. Test passed on a ibm-z system.
> 
> I apologize for my delay in responding, I did not have a computer with me
> during my holiday travel.
> 
> I was able to re-run my Kconfig test script with this patch series (now that
> I'm running this on private resources, it takes half a day 8( ). The script
> only performs comparisons of the .config before (LHSB) and after (RHSB) the
> patch series; it does NOT do any building. At any rate, what that revealed
> was only differences in s390. That means that all other arches do not have
> any unintended side effects. The differences with patch3 applied look like:
> 
> FAIL: allnoconfig arch/s390/configs/kasan.config
> LHSB {'CONFIG_CRASH_CORE': 'y', 'CONFIG_KEXEC_CORE': 'y', 'CONFIG_KEXEC':
> 'y'}
> RHSB {'CONFIG_KEXEC': 'n'}
> 
> The 'allnoconfig' and 'olddefconfig' targets failed for all s390 defconfigs.
> The LHSB is the pre-patch values, and the RHSB is the post-patch values. So
> this states that CRASH_CORE and KEXEC_CORE were set previously, but now they
> are not. KEXEC obviously is being turned off intentionally.
> 
> Hope this helps some.

Thanks, Eric. Alexander has pointed out this in patch 3 reviewing
comment. I misunderstood the select KEXEC in s390 arch where they
intend to do. As I replied to Alexander, I will drop patch 3. 

> 
> 
> > Baoquan He (3):
> >    kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
> >    drivers/base/cpu: crash data showing should depends on KEXEC_CORE
> >    s390/Kconfig: drop select of KEXEC
> > 
> >   arch/arm/include/asm/kexec.h | 4 ----
> >   arch/s390/Kconfig            | 1 -
> >   drivers/base/cpu.c           | 6 +++---
> >   kernel/Kconfig.kexec         | 1 -
> >   4 files changed, 3 insertions(+), 9 deletions(-)
> > 
> 

