Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973DB7F5996
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjKWHtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKWHtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:49:20 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F44E7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:49:27 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cf74ad87e0so4897845ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700725767; x=1701330567; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRYYXREQnqSeaqPOY5OUyl6/qjVZptAOkwbxS4AIXhA=;
        b=j69AsyHj8ICXm9hqiVbRRBXpFGZJ/DQceX87H/XbPpejVjnTLk4LqOwJANhyqNREFB
         ZWPF7KncYRcQ10+ZRpn3G7/xU8xBzaLz11QjS0OtESWPE+KwMwuW+OKZ4Hmh1aoqoI8+
         O3Twu6AJb6yxAhfyNMjnTbGtwTUFU5yUwK02imz5pu35vPSmTe5FZB6RWnFcS/9Uj/PP
         lv3nx5z7TvVB7splfJ2xKUSx6ZZlgsK3uhB3aNNO5t9UtLV+JKMWeObGdK7k3n1zfmbA
         IqH9xJNHGbxpNOPfppUj2gQ6qe9xb2jbS90EAB3J4BSfA8nO0kV7g1/W2T5nke63ZzW6
         YTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700725767; x=1701330567;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRYYXREQnqSeaqPOY5OUyl6/qjVZptAOkwbxS4AIXhA=;
        b=ZHXiSplI/YMtfMDhyM2kMuuChs6XlfrxLtmQeT2DlxKnulhscCJR3ENqWW9ppVCEWA
         MqZpfdrfy+u0n7cMmqh5RTHxSVuz9/mIoNExRM+PM0VWIl1uGGvynss+nIfanZ21SxIO
         0FqA+Uh+9dTMvoY4tuYRFZAzEPlFaPBXODqn6j9IWrCrtLSyg/krGi83WJN9tgCY4sbe
         40edLXDTzhB/l6TExuKjqx8Hp+SNqVVx0Qo4uUnPyOMXLb5QDADjqmCZ0rNSTuYLFGmt
         /OoKBEWNqyVz1N3n/uxcYW0BeAEgCSUNIwVqyS/ieZ730kwYd0SxgMSDTz9WmFo/fqad
         ujvw==
X-Gm-Message-State: AOJu0Ywa4+s8E1t2hFRhIVerRDf4eAJd+kGBkLyDBU+M/TBaHyUpvI7S
        Ojou26vjUETu82zQy68IfrE=
X-Google-Smtp-Source: AGHT+IHPh4ZXmU80zy7SINK9DjZ9KI5LgNBbjU/wXvpv8C7xCuWZwocXXpmUDK6NSWCxczZ9qBvZTA==
X-Received: by 2002:a17:903:244e:b0:1cc:4e81:36a4 with SMTP id l14-20020a170903244e00b001cc4e8136a4mr5727627pls.5.1700725766519;
        Wed, 22 Nov 2023 23:49:26 -0800 (PST)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001cc1dff5b86sm679598pld.244.2023.11.22.23.49.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2023 23:49:26 -0800 (PST)
Date:   Thu, 23 Nov 2023 16:49:22 +0900
From:   Yewon Choi <woni9911@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        threeearcat@gmail.com
Subject: Re: [PATCH] vmci_host: use smp_load_acquire/smp_store_release when
 accessing vmci_host_dev->ct_type
Message-ID: <20231123074920.GA10480@libra05>
References: <20231122122005.GA4661@libra05>
 <2023112257-polymer-banknote-4869@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112257-polymer-banknote-4869@gregkh>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 02:34:55PM +0000, Greg Kroah-Hartman wrote:
> On Wed, Nov 22, 2023 at 09:20:08PM +0900, Yewon Choi wrote:
> > In vmci_host.c, missing memory barrier between vmci_host_dev->ct_type
> > and vmci_host_dev->context may cause uninitialized data access.
> > 
> > One of possible execution flows is as follows:
> > 
> > CPU 1 (vmci_host_do_init_context)
> > =====
> > vmci_host_dev->context = vmci_ctx_create(...) // 1
> > vmci_host_dev->ct_type = VMCIOBJ_CONTEXT; // 2
> > 
> > CPU 2 (vmci_host_poll)
> > =====
> > if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) { // 3
> > 	context = vmci_host_dev->context; // 4
> > 	poll_wait(..., &context->host_context.wait_queue, ...);
> > 
> > While ct_type serves as a flag indicating that context is initialized,
> > there is no memory barrier which prevents reordering between
> > 1,2 and 3, 4. So it is possible that 4 reads uninitialized
> > vmci_host_dev->context.
> > In this case, the null dereference occurs in poll_wait().
> > 
> > In order to prevent this kind of reordering, we change plain accesses
> > to ct_type into smp_load_acquire() and smp_store_release().
> > 
> > Signed-off-by: Yewon Choi <woni9911@gmail.com>
> > ---
> >  drivers/misc/vmw_vmci/vmci_host.c | 40 ++++++++++++++++++-------------
> >  1 file changed, 23 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
> > index abe79f6fd2a7..e83b6e0fe55b 100644
> > --- a/drivers/misc/vmw_vmci/vmci_host.c
> > +++ b/drivers/misc/vmw_vmci/vmci_host.c
> > @@ -139,7 +139,7 @@ static int vmci_host_close(struct inode *inode, struct file *filp)
> >  {
> >  	struct vmci_host_dev *vmci_host_dev = filp->private_data;
> >  
> > -	if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
> > +	if (smp_load_acquire(&vmci_host_dev->ct_type) == VMCIOBJ_CONTEXT) {
> 
> This is getting tricky, why not use a normal lock to ensure that all is
> safe?  close isn't on a "fast path", so this shouldn't be a speed issue,
> right?
> 

I think using locks can be considered orthogonal to correcting memory ordering. 

As you pointed out, vmci_host_close is not a performance-critical function
while other functions using vmci_host_dev->context are performance-critical.
If the lock is needed, we will need to add locks in all of them. I cannot be
sure which is better. Besides that, it seems to be a separate issue.

On the other hand, the current implementation doesn't guarantee memory ordering 
which leads to wrong behavior.
This patch fixes this issue by adding primitives. 

Thank you for your reply.

Regards,
Yewon Choi

> thanks,
> 
> greg k-h
