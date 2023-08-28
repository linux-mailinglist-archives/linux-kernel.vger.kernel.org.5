Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173D278A91C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjH1Jnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjH1Jns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E2AAA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693215780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=01IAJZlGxE3jZFYcWyiHELiJj0j7MGd1pqgzbgK/uXE=;
        b=V3qQFHVY0BCt1z6f/uWWfiYTw2dz8VWzDNoYPUZPszPd8BMlxJg9gnFnUIioOUH3jn2w6p
        jzvxBldRwsyMawVXoY3U+lXfmp86bIj1Cdv/xylXQoDhCrIspJs4oasrXbP8KnH/xI4cZy
        lZa657bZeGt4dGgfUQ1Hv+KcFlO+NkY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-aKmWqtQrOFym7C9xJcjr2w-1; Mon, 28 Aug 2023 05:42:54 -0400
X-MC-Unique: aKmWqtQrOFym7C9xJcjr2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CAC23C11C62;
        Mon, 28 Aug 2023 09:42:54 +0000 (UTC)
Received: from localhost (unknown [10.72.112.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B284640C6F4C;
        Mon, 28 Aug 2023 09:42:51 +0000 (UTC)
Date:   Mon, 28 Aug 2023 17:42:48 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-riscv@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        thunder.leizhen@huawei.com, dyoung@redhat.com, prudo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] crash_core.c: remove unneeded functions
Message-ID: <ZOxsGIeYYvypf9op@MiWiFi-R3L-srv>
References: <20230827101128.70931-1-bhe@redhat.com>
 <20230827101128.70931-9-bhe@redhat.com>
 <15058508-9e21-0d10-4eca-2c8a5562d36c@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15058508-9e21-0d10-4eca-2c8a5562d36c@sifive.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/23 at 12:26am, Samuel Holland wrote:
> Hi Baoquan,
> 
> On 2023-08-27 5:11 AM, Baoquan He wrote:
> > So far, nobody calls functions parse_crashkernel_high() and
> > parse_crashkernel_high(), remove both of them.
> 
> minor typo: should be parse_crashkernel_low().

Good catch, will update. Thanks.

> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  include/linux/crash_core.h |  4 ----
> >  kernel/crash_core.c        | 18 ------------------
> >  2 files changed, 22 deletions(-)
> > 
> > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > index 2f732493e922..0c512a80a768 100644
> > --- a/include/linux/crash_core.h
> > +++ b/include/linux/crash_core.h
> > @@ -80,10 +80,6 @@ void final_note(Elf_Word *buf);
> >  int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
> >  		unsigned long long *crash_size, unsigned long long *crash_base,
> >  		unsigned long long *low_size, bool *high);
> > -int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
> > -		unsigned long long *crash_size, unsigned long long *crash_base);
> > -int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
> > -		unsigned long long *crash_size, unsigned long long *crash_base);
> >  
> >  #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> >  #ifndef DEFAULT_CRASH_KERNEL_LOW_SIZE
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 6bc00cc390b5..61a8ea3b23a2 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -323,24 +323,6 @@ int __init parse_crashkernel(char *cmdline,
> >  	return 0;
> >  }
> >  
> > -int __init parse_crashkernel_high(char *cmdline,
> > -			     unsigned long long system_ram,
> > -			     unsigned long long *crash_size,
> > -			     unsigned long long *crash_base)
> > -{
> > -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> > -				suffix_tbl[SUFFIX_HIGH]);
> > -}
> > -
> > -int __init parse_crashkernel_low(char *cmdline,
> > -			     unsigned long long system_ram,
> > -			     unsigned long long *crash_size,
> > -			     unsigned long long *crash_base)
> > -{
> > -	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
> > -				suffix_tbl[SUFFIX_LOW]);
> > -}
> > -
> >  /*
> >   * Add a dummy early_param handler to mark crashkernel= as a known command line
> >   * parameter and suppress incorrect warnings in init/main.c.
> 

