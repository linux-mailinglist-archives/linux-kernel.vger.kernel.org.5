Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7F8801A01
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 03:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjLBCWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 21:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBCWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 21:22:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA26CD48
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 18:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701483747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iWacCUu2+jQgLRypYgT2he0mdkQUbsb+sKjSsZ4uLUY=;
        b=diRHECspcGWJ+xxnLzwJQok86MBOlytGyYr/IrN5CEKafCEKd/415lwKV4x6+qGfzdYiUH
        L3A3F9ISWUn8b0TJySoEqYmeooVjtznMWxfg8cNYiaUKYyuv8Z9znKA0IY7up8Ex9HbNej
        UMNNF5pvkQCaaKAMYiAraNswLY9X78I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-7v1jVeiSPby4hQqRPG56sw-1; Fri, 01 Dec 2023 21:22:21 -0500
X-MC-Unique: 7v1jVeiSPby4hQqRPG56sw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D6F5811E7D;
        Sat,  2 Dec 2023 02:22:20 +0000 (UTC)
Received: from localhost (unknown [10.72.113.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 682152026D4C;
        Sat,  2 Dec 2023 02:22:19 +0000 (UTC)
Date:   Sat, 2 Dec 2023 10:22:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        kexec <kexec@lists.infradead.org>
Subject: Re: linux-next: Tree for Dec 1 (riscv, crash_core)
Message-ID: <ZWqU1+Xxr6PG+2Ov@MiWiFi-R3L-srv>
References: <20231201133726.4a4413dd@canb.auug.org.au>
 <bbd1bbfb-c482-433d-bce9-2b591b8e855e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbd1bbfb-c482-433d-bce9-2b591b8e855e@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

On 12/01/23 at 11:53am, Randy Dunlap wrote:
> 
> 
> On 11/30/23 18:37, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20231130:
> > 
> 
> on riscv 32-bit or 64-bit, with
> # CONFIG_MMU is not set

Can you provide your .config so that I reproduce it? Disabling
CONFIG_MMU need find all places where it's selected by other config items.

> 
> In file included from ../arch/riscv/kernel/crash_core.c:3:
> ../arch/riscv/kernel/crash_core.c: In function 'arch_crash_save_vmcoreinfo':
> ../arch/riscv/kernel/crash_core.c:8:27: error: 'VA_BITS' undeclared (first use in this function)
>     8 |         VMCOREINFO_NUMBER(VA_BITS);
>       |                           ^~~~~~~
> ../include/linux/crash_core.h:78:64: note: in definition of macro 'VMCOREINFO_NUMBER'
>    78 |         vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
>       |                                                                ^~~~
> ../arch/riscv/kernel/crash_core.c:8:27: note: each undeclared identifier is reported only once for each function it appears in
>     8 |         VMCOREINFO_NUMBER(VA_BITS);
>       |                           ^~~~~~~
> ../include/linux/crash_core.h:78:64: note: in definition of macro 'VMCOREINFO_NUMBER'
>    78 |         vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)
>       |                                                                ^~~~
> ../arch/riscv/kernel/crash_core.c:12:58: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'int' [-Wformat=]
>    12 |         vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
>       |                                                        ~~^
>       |                                                          |
>       |                                                          long unsigned int
>       |                                                        %x
> ../arch/riscv/kernel/crash_core.c:14:64: error: 'VMEMMAP_START' undeclared (first use in this function)
>    14 |         vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
>       |                                                                ^~~~~~~~~~~~~
> ../arch/riscv/kernel/crash_core.c:15:62: error: 'VMEMMAP_END' undeclared (first use in this function); did you mean 'MEMREMAP_ENC'?
>    15 |         vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
>       |                                                              ^~~~~~~~~~~
>       |                                                              MEMREMAP_ENC
> 
> 64-bit only: 
> 
> ../arch/riscv/kernel/crash_core.c:17:64: error: 'MODULES_VADDR' undeclared (first use in this function)
>    17 |         vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
>       |                                                                ^~~~~~~~~~~~~
> ../arch/riscv/kernel/crash_core.c:18:62: error: 'MODULES_END' undeclared (first use in this function)
>    18 |         vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
>       |                                                              ^~~~~~~~~~~
> 
> 
> 
> -- 
> ~Randy
> 

