Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02877F5D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344912AbjKWLKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKWLKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:10:05 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541E1BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:10:11 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cbe6d514cdso412388b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700737811; x=1701342611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YnPIxcNUwxZIAQpLJFkXUu+mZlTcP31SPZMOLg6sxfA=;
        b=XvaXi9IbgzCwbkNHxK32qLLu1yh+86yqCevUQTcAHmOoBEPosSkTuUvSAHq6bXWXdj
         YzS8SSheIM6kxbqxVoAEBCmjbqHUjvV/RM0+7B26PGMWsY+LHAjbAtxBm3bOEtn/oJ5q
         lWiF3gdABI+rsI8sn7uwnHimU3OlRHn9xLmA5+L7oHdqjb35xBSZe0mzTEWQoCC7aEku
         cAIZOtvCllDBBDCmnNul8odLXDpak1n/8m6uOU0d/Bk4zW5msx2tPE6iMx7nddXI5YNx
         2QnLHBuo3iKua8XVJQz2YFN6SjOnRpnGYVhKWFPDFBQY9i08XentFNN6aPEG0FT2JCKJ
         gnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700737811; x=1701342611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnPIxcNUwxZIAQpLJFkXUu+mZlTcP31SPZMOLg6sxfA=;
        b=NBidRQ9wK2nQqVJHeLIZ5mSuqS1zURdlBhr3j1UYuIGsuykFSSOlXkMDuAZI38GV1n
         4qAYd/OA5q7vhAcZS1dsOaP+04SCc4kyPXCfkuLL12AUBDWdL5MbEjJtUbNZ4yNJXxv2
         6tFE48HiGPRQlkFKIvp7nk+Rg91exIqgleVsiVkD9oUVg8jCJuQy6CiZGCBH/NmmuMxq
         yD+r0eXza6cYlXcSDczTQ5tb8MoG+y5Be0RyQATtlg+baDd1tw8cv9NRQzWsJ+cfCU5f
         0y283HAq/X9ZMAzpEL0T4p8WLuFniO2LQuZxaSDCUG1BpgYtiKzGLjC8Qh1Pd7k+nxHo
         haig==
X-Gm-Message-State: AOJu0Ywyw5tpUPb+n47mrLVH9+E27/0J21vGq15OCUvprdqhrOlynogs
        DPHHlAY39Me55PFe/kITPWY=
X-Google-Smtp-Source: AGHT+IFVv0clC/hkcgsHEwC2gmcFDNuwfjjutMqSNeQMrJsu68lFVwO+nLEtlilzfGZ+HDcS9Ourmg==
X-Received: by 2002:a05:6a00:4ac7:b0:6c2:cf23:3e21 with SMTP id ds7-20020a056a004ac700b006c2cf233e21mr5764471pfb.17.1700737811113;
        Thu, 23 Nov 2023 03:10:11 -0800 (PST)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id a9-20020aa78e89000000b0068fb8e18971sm979405pfr.130.2023.11.23.03.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 03:10:10 -0800 (PST)
Date:   Thu, 23 Nov 2023 20:08:29 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yewon Choi <woni9911@gmail.com>, Bryan Tan <bryantan@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmci_host: use smp_load_acquire/smp_store_release when
 accessing vmci_host_dev->ct_type
Message-ID: <ZV8yrfAnCv-sxLbq@dragonet>
References: <20231122122005.GA4661@libra05>
 <2023112257-polymer-banknote-4869@gregkh>
 <20231123074920.GA10480@libra05>
 <2023112331-wise-regain-72dc@gregkh>
 <ZV8kPHlGoPYKORQn@dragonet>
 <2023112352-congested-puzzling-f76d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112352-congested-puzzling-f76d@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 10:14:52AM +0000, Greg Kroah-Hartman wrote:
> On Thu, Nov 23, 2023 at 07:06:52PM +0900, Dae R. Jeong wrote:
> > On Thu, Nov 23, 2023 at 08:44:46AM +0000, Greg Kroah-Hartman wrote:
> > > On Thu, Nov 23, 2023 at 04:49:22PM +0900, Yewon Choi wrote:
> > > > On Wed, Nov 22, 2023 at 02:34:55PM +0000, Greg Kroah-Hartman wrote:
> > > > > On Wed, Nov 22, 2023 at 09:20:08PM +0900, Yewon Choi wrote:
> > > > > > In vmci_host.c, missing memory barrier between vmci_host_dev->ct_type
> > > > > > and vmci_host_dev->context may cause uninitialized data access.
> > > > > > 
> > > > > > One of possible execution flows is as follows:
> > > > > > 
> > > > > > CPU 1 (vmci_host_do_init_context)
> > > > > > =====
> > > > > > vmci_host_dev->context = vmci_ctx_create(...) // 1
> > > > > > vmci_host_dev->ct_type = VMCIOBJ_CONTEXT; // 2
> > > > > > 
> > > > > > CPU 2 (vmci_host_poll)
> > > > > > =====
> > > > > > if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) { // 3
> > > > > > 	context = vmci_host_dev->context; // 4
> > > > > > 	poll_wait(..., &context->host_context.wait_queue, ...);
> > > > > > 
> > > > > > While ct_type serves as a flag indicating that context is initialized,
> > > > > > there is no memory barrier which prevents reordering between
> > > > > > 1,2 and 3, 4. So it is possible that 4 reads uninitialized
> > > > > > vmci_host_dev->context.
> > > > > > In this case, the null dereference occurs in poll_wait().
> > > > > > 
> > > > > > In order to prevent this kind of reordering, we change plain accesses
> > > > > > to ct_type into smp_load_acquire() and smp_store_release().
> > > > > > 
> > > > > > Signed-off-by: Yewon Choi <woni9911@gmail.com>
> > > > > > ---
> > > > > >  drivers/misc/vmw_vmci/vmci_host.c | 40 ++++++++++++++++++-------------
> > > > > >  1 file changed, 23 insertions(+), 17 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
> > > > > > index abe79f6fd2a7..e83b6e0fe55b 100644
> > > > > > --- a/drivers/misc/vmw_vmci/vmci_host.c
> > > > > > +++ b/drivers/misc/vmw_vmci/vmci_host.c
> > > > > > @@ -139,7 +139,7 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
> > > > > >  {
> > > > > >  	struct vmci_host_dev *vmci_host_dev = filp->private_data;
> > > > > >  
> > > > > > -	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
> > > > > > +	if (smp_load_acquire(&vmci_host_dev->ct_type) == VMCIOBJ_CONTEXT) {
> > > > > 
> > > > > This is getting tricky, why not use a normal lock to ensure that all is
> > > > > safe?  close isn't on a "fast path", so this shouldn't be a speed issue,
> > > > > right?
> > > > > 
> > > > 
> > > > I think using locks can be considered orthogonal to correcting memory ordering. 
> > > 
> > > But they ensure proper memory ordering.
> > 
> > Yes, using a lock obviously ensures memory ordering.
> > 
> > > > If the lock is needed, we will need to add locks in all of them. I cannot be
> > > > sure which is better. Besides that, it seems to be a separate issue.
> > > 
> > > Nope, I think it's the same issue :)
> > > 
> > > > On the other hand, the current implementation doesn't guarantee memory ordering 
> > > > which leads to wrong behavior.
> > > > This patch fixes this issue by adding primitives. 
> > > 
> > > But it's still wrong, again, what keeps the value from changing right
> > > after checking it?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > It seems that VMCI assumes that vmci_host_dev->context is not NULL if
> > vmci_host_dev->ct_type == VMCIOBJ_CONTEXT (because all readers of
> > vmci_host_dev->context check whether vmci_host_dev->ct_type is
> > VMCIOBJ_CONTEXT or not, and access vmci_host_dev->context without
> > checking whether is it NULL or not). So I think this patch clarifies
> > this assumption.
> > 
> > As you said, we need to ensure that vmci_host_dev->context is not
> > changed after checking vmci_host_dev->ct_type. But
> > (1) the only place that changes vmci_host_dev->context is
> > vmci_host_close() and
> 
> Then why is it even checked in close()?

It is because close() needs to destory vmci_host_dev->context if it is
created.

> > (2) (I think) vmci_host_close() do not concurrently run with readers
> > of vmci_host_dev->context. IIUC, all readers of vmci_host_dev->context
> > are system calls (eg, ioctl handlers or the poll handler). So I think
> > the ref count of the file saves us here. (Otherwise, Syzkaller will
> > tell us the truth maybe?)
> 
> Ok, then why is this needed to be checked then at all?

It is because vmci_host_dev->context is created by
ioctl(IOCTL_VMCI_INIT_CONTEXT). So it is possible that vmci_host_dev
is created but vmci_host_dev->context is *not* created. All other
places should be careful of this.

> > At least, this patch introduces no change of the logic but the
> > guarantees of the memory ordering, so I think this patch is safe?
> 
> I think the logic is incorrect, don't try to paper over it thinking that
> the issue to be solved is "memory ordering" please.  Solve the root
> issue here.

I don't exactly get the point what you think the root issue is.

We can have a system call sequence like this:
fd = open("/dev/vmci")
ioctl(fd, VMCI_VERSION2, user_version)
ioctl(fd, INIT_CONTEXT) // this somewhat depends on ioctl(VMCI_VERSION2) as it runs `context->user_version = user_version`

Between open() and ioctl(INIT_CONTEXT), we have vmci_host_dev
initialized but vmci_host_dev->context is not initialized. We need to
check whether vmci_host_dev->context is initialized in other
places. And I still think store_release/load_acquire can be used to
declare that context is created and check whether context is created
or not. Please excuse me if I'm wrong...


Best regards,
Dae R. Jeong
