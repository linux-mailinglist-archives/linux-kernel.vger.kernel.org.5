Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B6F78CB89
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbjH2RrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjH2Rqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:46:45 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04EBE9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:46:39 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 578053F627
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693331197;
        bh=zyO1tri0MRJL1zB1nk/BPMDzdjLU0lZ3+YO1wfXGttM=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=lVjHVGdfraRBr1a1Ceuu7VDHB4QXlP+McsfzLAIH0QKHGZxqPMcCJe0r7mu94sp7Y
         yjXZ7IrfGQg1BqTDyrX36bCKC8KdFjpPbMVvxeIMT6QN03vrIdPu+IWuvVmOxqXPn3
         R9rOO6lwJExc3rxrvtjfCdXv/4wqRN+/qrUcjP0Oh6/OxjSQO0l4ov1Uyck5d9jEGz
         MPUq0hco1uDF8pba6HOJBTo5P/aqbN7h65zWcplgR0POxiJfhkyvzkFGc/K+Z9IGe3
         ltL08t6Lpm6qKiyVbUAANCs7dMVPTLH3z0DvTfRempyYNpxz0eZnnZritEOOBHzJir
         Vz2epo1+adiFQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a5944adecbso234718066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693331197; x=1693935997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyO1tri0MRJL1zB1nk/BPMDzdjLU0lZ3+YO1wfXGttM=;
        b=OuUCbpryeiLcy0C1C0MGgaThrLhc0/7XLWnZrN9fHVt6OEEsyj5Co73vReFaBi7q+c
         d7u45ZsQ1ZzEKofBr4eP8KG1MYNTr+Aqr3MlVPgVKkMHc+abPrS6T8Ln0yr6vOroeNnZ
         lg7B6Dnpx9HEcfPXYrnOEjiDZcN3ZRjnyC3YtyOuGMWMkBZNWabFcdrb9Dq/6MvcekK5
         +azQRAtohzQFtLCl14LIPxsJT/8+CM1X9pldlPVI1pan293q0wzG8jbOnrJo+XMN25jH
         f81PsMCs/nv0AgS/zfGIuHTYdCqOZ81hGP+COyqLE4gmDwVWmgyvX7ABRwiMN+BNpG37
         KqMg==
X-Gm-Message-State: AOJu0YwmdH+jjA1XoxeA0WLFE9TgknJEwDmLSoqTld+O30xeszUvuRbn
        UGggG8qM77CmAGmek8W08i+8aBtr7NwQT4Xq+lz2nL89HvfwL+We1W7bGKE+D+DHx34DAmFSumi
        uEbhU8fmon7so/NFtgyBjcFFbEGWnxDLRmqk1+ZzbFA==
X-Received: by 2002:a17:906:3096:b0:99d:e617:abeb with SMTP id 22-20020a170906309600b0099de617abebmr25566786ejv.23.1693331197013;
        Tue, 29 Aug 2023 10:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/DGcOIOtKQwaPQUMaVFMpYjgrkZkU2ZDzDmFO3A77GMxyIByHI3TWI4VQEWFXYUTZkEoZjQ==
X-Received: by 2002:a17:906:3096:b0:99d:e617:abeb with SMTP id 22-20020a170906309600b0099de617abebmr25566766ejv.23.1693331196692;
        Tue, 29 Aug 2023 10:46:36 -0700 (PDT)
Received: from localhost (host-95-252-65-153.retail.telecomitalia.it. [95.252.65.153])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090614d600b0099cfd0b2437sm6236416ejc.99.2023.08.29.10.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 10:46:36 -0700 (PDT)
Date:   Tue, 29 Aug 2023 19:46:35 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module/decompress: use vmalloc() for zstd decompression
 workspace
Message-ID: <ZO4u+6atPevjudZm@righiandr-XPS-13-7390>
References: <20230829120508.317611-1-andrea.righi@canonical.com>
 <ZO4fvAKJfKs8USZO@bombadil.infradead.org>
 <4ut44zckyknjwdzvxzefiysfjorl3nzqvs2j3scsrlgmgngjgs@hjrkcqoavq5h>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ut44zckyknjwdzvxzefiysfjorl3nzqvs2j3scsrlgmgngjgs@hjrkcqoavq5h>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:30:55AM -0700, Lucas De Marchi wrote:
> On Tue, Aug 29, 2023 at 09:41:32AM -0700, Luis Chamberlain wrote:
> > On Tue, Aug 29, 2023 at 02:05:08PM +0200, Andrea Righi wrote:
> > > Using kmalloc() to allocate the decompression workspace for zstd may
> > > trigger the following warning when large modules are loaded (i.e., xfs):
> > > 
> > > [    2.961884] WARNING: CPU: 1 PID: 254 at mm/page_alloc.c:4453 __alloc_pages+0x2c3/0x350
> > > ...
> > > [    2.989033] Call Trace:
> > > [    2.989841]  <TASK>
> > > [    2.990614]  ? show_regs+0x6d/0x80
> > > [    2.991573]  ? __warn+0x89/0x160
> > > [    2.992485]  ? __alloc_pages+0x2c3/0x350
> > > [    2.993520]  ? report_bug+0x17e/0x1b0
> > > [    2.994506]  ? handle_bug+0x51/0xa0
> > > [    2.995474]  ? exc_invalid_op+0x18/0x80
> > > [    2.996469]  ? asm_exc_invalid_op+0x1b/0x20
> > > [    2.997530]  ? module_zstd_decompress+0xdc/0x2a0
> > > [    2.998665]  ? __alloc_pages+0x2c3/0x350
> > > [    2.999695]  ? module_zstd_decompress+0xdc/0x2a0
> > > [    3.000821]  __kmalloc_large_node+0x7a/0x150
> > > [    3.001920]  __kmalloc+0xdb/0x170
> > > [    3.002824]  module_zstd_decompress+0xdc/0x2a0
> > > [    3.003857]  module_decompress+0x37/0xc0
> > > [    3.004688]  init_module_from_file+0xd0/0x100
> > > [    3.005668]  idempotent_init_module+0x11c/0x2b0
> > > [    3.006632]  __x64_sys_finit_module+0x64/0xd0
> > > [    3.007568]  do_syscall_64+0x59/0x90
> > > [    3.008373]  ? ksys_read+0x73/0x100
> > > [    3.009395]  ? exit_to_user_mode_prepare+0x30/0xb0
> > > [    3.010531]  ? syscall_exit_to_user_mode+0x37/0x60
> > > [    3.011662]  ? do_syscall_64+0x68/0x90
> > > [    3.012511]  ? do_syscall_64+0x68/0x90
> > > [    3.013364]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > > 
> > > However, continuous physical memory does not seem to be required in
> > > module_zstd_decompress(), so use vmalloc() instead, to prevent the
> > > warning and avoid potential failures at loading compressed modules.
> > > 
> > > Fixes: 169a58ad824d ("module/decompress: Support zstd in-kernel decompression")
> > > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> > > ---
> > >  kernel/module/decompress.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> > > index 8a5d6d63b06c..87440f714c0c 100644
> > > --- a/kernel/module/decompress.c
> > > +++ b/kernel/module/decompress.c
> > > @@ -241,7 +241,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
> > >  	}
> > > 
> > >  	wksp_size = zstd_dstream_workspace_bound(header.windowSize);
> > > -	wksp = kmalloc(wksp_size, GFP_KERNEL);
> > > +	wksp = vmalloc(wksp_size);
> > >  	if (!wksp) {
> > >  		retval = -ENOMEM;
> > >  		goto out;
> > > @@ -284,7 +284,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
> > >  	retval = new_size;
> > > 
> > >   out:
> > > -	kfree(wksp);
> > > +	vfree(wksp);
> > >  	return retval;
> > 
> > Thanks! Applied and queued up.
> 
> I can see at least the gz decompress would need the same kind of change.
> Shouldn't we tackle them all at once?

gz decompress needs to allocate a struct inflate_workspace, that is not
too bad (11 pages on my system), but it also seems safer to just use
vmalloc():

struct inflate_workspace {
	struct inflate_state       inflate_state;        /*     0  9544 */
	/* --- cacheline 149 boundary (9536 bytes) was 8 bytes ago --- */
	unsigned char              working_window[32768]; /*  9544 32768 */

	/* size: 42312, cachelines: 662, members: 2 */
	/* last cacheline: 8 bytes */
};

xz is also using kmalloc() internally in xz_dec_init() to allocate
struct xz_dec that seems to be less than a page, so kmalloc() should be
fine in this case:

struct xz_dec {
...
	/* size: 1232, cachelines: 20, members: 16 */
...
}

In conclusion I think we should be pretty safe for now by just changing
gz and zstd.

Maybe having two separate patches is better (in case we need to revert
just one for any reason...)?

-Andrea
