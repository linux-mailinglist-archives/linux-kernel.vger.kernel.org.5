Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772047F6E72
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345002AbjKXIkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKXIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:40:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DC8D53
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700815242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TtiruDUnh8gIdyydjQh1DSHosPodlSxaPwJiylzKhys=;
        b=F4thSS2tcNtsIBSxb9UmTsg3yRymx+/UJCKri+bf7PDNdTsrFVTGYat4Kn77z5JOxiam0s
        a27ws93ho2CgCRVvB3YuQI2hOneCVtzak+GqCtBWaS4vhscs8D+/U4ryTCuol2+UGVg75B
        X9AQVfI9XFDorHL7e3GwNOXY0uunD2M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-QXyK2TnoOxKNhbHg3BDyOw-1; Fri, 24 Nov 2023 03:40:39 -0500
X-MC-Unique: QXyK2TnoOxKNhbHg3BDyOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98B7D828CEA;
        Fri, 24 Nov 2023 08:40:38 +0000 (UTC)
Received: from localhost (unknown [10.72.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D59C0112130A;
        Fri, 24 Nov 2023 08:40:36 +0000 (UTC)
Date:   Fri, 24 Nov 2023 16:40:33 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
        nathan@kernel.org, yujie.liu@intel.com
Subject: Re: [PATCH v2 2/7] kexec_file: print out debugging message if
 required
Message-ID: <ZWBhgfhFONEYcJZf@MiWiFi-R3L-srv>
References: <20231124033642.520686-1-bhe@redhat.com>
 <20231124033642.520686-3-bhe@redhat.com>
 <971ed2ceaeeba882d2b4c39015ee5ae5db3f5e82.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971ed2ceaeeba882d2b4c39015ee5ae5db3f5e82.camel@perches.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/23 at 11:16pm, Joe Perches wrote:
> On Fri, 2023-11-24 at 11:36 +0800, Baoquan He wrote:
> > Replace pr_debug() with the newly added kexec_dprintk() in kexec_file
> > loading related codes.
> 
> trivia for pr_debug -> kexec_dprintk conversions for
> the entire patch set:

OK, will check all patchset and adjust the indendation, thanks.

> 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> []
> > @@ -551,9 +551,12 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
> >  		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
> >  		phdr->p_align = 0;
> >  		ehdr->e_phnum++;
> > -		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
> > +#ifdef CONFIG_KEXEC_FILE
> > +		kexec_dprintk("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, "
> > +			"sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
> >  			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
> >  			ehdr->e_phnum, phdr->p_offset);
> 
> It's good form to rewrap continuation lines to the open parenthesis
> 
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> []
> > @@ -389,11 +391,12 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >  	if (ret)
> >  		goto out;
> >  
> > +	kexec_dprintk("nr_segments = %lu\n", image->nr_segments);
> >  	for (i = 0; i < image->nr_segments; i++) {
> >  		struct kexec_segment *ksegment;
> >  
> >  		ksegment = &image->segment[i];
> > -		pr_debug("Loading segment %d: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> > +		kexec_dprintk("segment[%d]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
> >  			 i, ksegment->buf, ksegment->bufsz, ksegment->mem,
> >  			 ksegment->memsz);
> 
> here too etc...
> 

