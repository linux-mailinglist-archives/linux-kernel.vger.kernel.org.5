Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461707F5D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344925AbjKWLIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKWLH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:07:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7021BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700737683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4Skc8GoRCulLSc1L8sW+fd+URsNyF4CrxboNaek2t8=;
        b=VstwxKW4iv7BTCdjvMihVr2bciQgIA2Nv1YwGAfsHaeMNUN9FdIXCQ38CW4gk8YwXRRHjb
        LN5OK7umcMr6Gu+r+VQnGq98nSvo8QKljogQKNgulXNt3NTC2hNG9NX+S4CJRzM3/bVbho
        wSCBVyDaonX4a8X3v6rTi4MKhwuOwLo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-WTlpL2kTM2OxbsT10NKmbg-1; Thu, 23 Nov 2023 06:07:59 -0500
X-MC-Unique: WTlpL2kTM2OxbsT10NKmbg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DF9981B562;
        Thu, 23 Nov 2023 11:07:59 +0000 (UTC)
Received: from localhost (unknown [10.72.112.97])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 982EAC1596F;
        Thu, 23 Nov 2023 11:07:58 +0000 (UTC)
Date:   Thu, 23 Nov 2023 19:07:55 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        akpm@linux-foundation.org, eric_devolder@yahoo.com,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH 1/3] kernel/Kconfig.kexec: drop select of KEXEC for
 CRASH_DUMP
Message-ID: <ZV8yi86cA5mhYNll@MiWiFi-R3L-srv>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-2-bhe@redhat.com>
 <CALrw=nEO3A2MPeSXhO3=cPdrAFB07sQcnjNN5V5jj2YcqAZ+bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALrw=nEO3A2MPeSXhO3=cPdrAFB07sQcnjNN5V5jj2YcqAZ+bQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 at 08:23am, Ignat Korchagin wrote:
> On Thu, Nov 23, 2023 at 7:37 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > Ignat Korchagin complained that a potential config regression was
> > introduced by commit 89cde455915f ("kexec: consolidate kexec and
> > crash options into kernel/Kconfig.kexec"). Before the commit,
> > CONFIG_CRASH_DUMP has no dependency on CONFIG_KEXEC. After the commit,
> > CRASH_DUMP selects KEXEC. That enforces system to have CONFIG_KEXEC=y
> > as long as CONFIG_CRASH_DUMP=Y which people may not want.
> >
> > In Ignat's case, he sets CONFIG_CRASH_DUMP=y, CONFIG_KEXEC_FILE=y and
> > CONFIG_KEXEC=n because kexec_load interface could have security issue if
> > kernel/initrd has no chance to be signed and verified.
> >
> > CRASH_DUMP has select of KEXEC because Eric, author of above commit,
> > met a LKP report of build failure when posting patch of earlier version.
> > Please see below link to get detail of the LKP report:
> >
> >     https://lore.kernel.org/all/3e8eecd1-a277-2cfb-690e-5de2eb7b988e@oracle.com/T/#u
> >
> > In fact, that LKP report is triggered because arm's <asm/kexec.h> is
> > wrapped in CONFIG_KEXEC ifdeffery scope. That is wrong. CONFIG_KEXEC
> > controls the enabling/disabling of kexec_load interface, but not kexec
> > feature. Removing the wrongly added CONFIG_KEXEC ifdeffery scope in
> > <asm/kexec.h> of arm allows us to drop the select KEXEC for CRASH_DUMP.
> 
> Hm... With the patch, when cross compiling for arm and
> CONFIG_KEXEC_CORE=y
> # CONFIG_KEXEC is not set
> CONFIG_CRASH_DUMP=y
> 
> I get the following linker error at the end:
> 
>   CALL    scripts/checksyscalls.sh
>   UPD     include/generated/utsversion.h
>   CC      init/version-timestamp.o
>   LD      .tmp_vmlinux.kallsyms1
> arm-linux-gnueabi-ld: kernel/kexec_core.o: in function `kimage_free':
> kexec_core.c:(.text+0xf5c): undefined reference to `machine_kexec_cleanup'
> arm-linux-gnueabi-ld: kernel/kexec_core.o: in function `__crash_kexec':
> kexec_core.c:(.text+0x15bc): undefined reference to `machine_crash_shutdown'
> arm-linux-gnueabi-ld: kexec_core.c:(.text+0x15c4): undefined reference
> to `machine_kexec'
> arm-linux-gnueabi-ld: kernel/kexec_core.o: in function `kernel_kexec':
> kexec_core.c:(.text+0x1a04): undefined reference to `machine_kexec'
> make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
> make[1]: *** [/home/ignat/git/linux-upstream/Makefile:1154: vmlinux] Error 2
> make: *** [Makefile:234: __sub-make] Error 2

Oops, I forgot this part. This should fix the link error.

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index d53f56d6f840..771264d4726a 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= entry-ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o insn.o patch.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o insn.o patch.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o insn.o patch.o
-obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
+obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
 # Main staffs in KPROBES are in arch/arm/probes/ .
 obj-$(CONFIG_KPROBES)		+= patch.o insn.o
 obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o

