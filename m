Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303BE77C1AE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjHNUqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbjHNUpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:45:45 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7A4D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:45:44 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6bca5d6dcedso4067380a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692045943; x=1692650743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KoN76bPFfkcsnM64HQUZ7HA4CiGkKnsbkX3yxcOBzao=;
        b=P3Vv56zYPMYpNQkPIs5DNZZixW9X1/AuRrkQkqJ9jqmPPCE/grxV5s2bNpk1/tqD5H
         +XLNX9oVDfdYhVqmR9xV02lYtO5ow8OreUI8l35uaS0RFQ0mchcYanxAs91YrX4ND6Fq
         m2xjjYA675jlb0xdhF92IJTpsx37rlsw4xTKM+sbuQKlM2uLtH553raVrcjibWjA6mm+
         kEw71deG8w23okTtVraUUSYKEY1or9aDnyh6a+fHGTiiRxQdcVRiGydlMnQo2MCikpkd
         kOp35TqNNovOiO/wzIQqFBNhvw7Fk2bthSiHixEKXn2dJrbkwvQot92s4/xf/HEsKFE6
         Q0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692045943; x=1692650743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoN76bPFfkcsnM64HQUZ7HA4CiGkKnsbkX3yxcOBzao=;
        b=i31sjaQCLpt+FIhu6El88qFIY3wlKo8D3mjh0pt4oSF7YmSjBzUf96vEae/TdnN8GE
         DiRk4DzwQ+g3KvPPUYivMrJ8EYHLW6EBFtnou+DU5ghrYdjmMb7MTZYcKpoPcXr1wWtj
         FXSMQxDCOl+quEUZYUzJeNJow8K9WrFkk3gBPUsfZFPNLI8Z6SrIb/z8GNEmsMQzicdE
         /j2UTPYpq8bpOYLeafjon1Iffl1MJNvKTY4KIYXxzU47AhYl8+iw1wmx8l+l0VY/z6Gg
         OrRSnQfBIe/vFLaucjOeSOoCDIduvMdfiBnVv1+zUS0j4TAKj09nnS/pWVq090Xjowni
         sXIQ==
X-Gm-Message-State: AOJu0YyU2hbsKK/z30+1yiUD/K9J3D/Qb3JJBYlM+luaT3vMqv5RQ7s7
        a1Z7jVtGfZ3DHqL9Su3+ZuTn6JFdFkA=
X-Google-Smtp-Source: AGHT+IHAXd+LBCaNv/IYE44G8+TOcYmb5ZuZn/zSHdH3gF3525nKD6VvDyCq0uPuvmz2MDHS4ZucMQ==
X-Received: by 2002:a05:6830:16d0:b0:6b9:a8e0:deca with SMTP id l16-20020a05683016d000b006b9a8e0decamr9750468otr.22.1692045943384;
        Mon, 14 Aug 2023 13:45:43 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id n22-20020a9d6f16000000b006b8af3a2599sm4609239otq.73.2023.08.14.13.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:45:43 -0700 (PDT)
Date:   Mon, 14 Aug 2023 17:45:38 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check unnecessary parentheses
Message-ID: <ZNqScudJFGCkje+S@alolivei-thinkpadt480s.gru.csb>
References: <ZNqJs126kA+KvSTC@alolivei-thinkpadt480s.gru.csb>
 <2023081438-kennel-regress-a76d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081438-kennel-regress-a76d@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:16:03PM +0200, Greg KH wrote:
> On Mon, Aug 14, 2023 at 05:08:19PM -0300, Alexon Oliveira wrote:
> > Fixed all CHECK: Unnecessary parentheses around
> > as reported by checkpatch to adhere to the Linux kernel
> > coding-style guidelines.
> > 
> > Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> > ---
> >  drivers/staging/vme_user/vme.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > index c7c50406c199..6f08bb21369d 100644
> > --- a/drivers/staging/vme_user/vme.c
> > +++ b/drivers/staging/vme_user/vme.c
> > @@ -307,7 +307,7 @@ struct vme_resource *vme_slave_request(struct vme_dev *vdev, u32 address,
> >  		mutex_lock(&slave_image->mtx);
> >  		if (((slave_image->address_attr & address) == address) &&
> >  		    ((slave_image->cycle_attr & cycle) == cycle) &&
> > -		    (slave_image->locked == 0)) {
> > +		    slave_image->locked == 0) {
> >  			slave_image->locked = 1;
> >  			mutex_unlock(&slave_image->mtx);
> >  			allocated_image = slave_image;
> > @@ -508,7 +508,7 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
> >  		if (((master_image->address_attr & address) == address) &&
> >  		    ((master_image->cycle_attr & cycle) == cycle) &&
> >  		    ((master_image->width_attr & dwidth) == dwidth) &&
> > -		    (master_image->locked == 0)) {
> > +		    master_image->locked == 0) {
> >  			master_image->locked = 1;
> >  			spin_unlock(&master_image->lock);
> >  			allocated_image = master_image;
> > @@ -882,7 +882,7 @@ struct vme_resource *vme_dma_request(struct vme_dev *vdev, u32 route)
> >  		/* Find an unlocked and compatible controller */
> >  		mutex_lock(&dma_ctrlr->mtx);
> >  		if (((dma_ctrlr->route_attr & route) == route) &&
> > -		    (dma_ctrlr->locked == 0)) {
> > +		    dma_ctrlr->locked == 0) {
> >  			dma_ctrlr->locked = 1;
> >  			mutex_unlock(&dma_ctrlr->mtx);
> >  			allocated_ctrlr = dma_ctrlr;
> > @@ -1248,9 +1248,9 @@ void vme_bus_error_handler(struct vme_bridge *bridge,
> >  	list_for_each(handler_pos, &bridge->vme_error_handlers) {
> >  		handler = list_entry(handler_pos, struct vme_error_handler,
> >  				     list);
> > -		if ((aspace == handler->aspace) &&
> > -		    (address >= handler->start) &&
> > -		    (address < handler->end)) {
> > +		if (aspace == handler->aspace &&
> > +		    address >= handler->start &&
> > +		    address < handler->end) {
> >  			if (!handler->num_errors)
> >  				handler->first_error = address;
> >  			if (handler->num_errors != UINT_MAX)
> > @@ -1337,7 +1337,7 @@ int vme_irq_request(struct vme_dev *vdev, int level, int statid,
> >  		return -EINVAL;
> >  	}
> >  
> > -	if ((level < 1) || (level > 7)) {
> > +	if (level < 1 || level > 7) {
> >  		printk(KERN_ERR "Invalid interrupt level\n");
> >  		return -EINVAL;
> >  	}
> > @@ -1386,7 +1386,7 @@ void vme_irq_free(struct vme_dev *vdev, int level, int statid)
> >  		return;
> >  	}
> >  
> > -	if ((level < 1) || (level > 7)) {
> > +	if (level < 1 || level > 7) {
> >  		printk(KERN_ERR "Invalid interrupt level\n");
> >  		return;
> >  	}
> > @@ -1433,7 +1433,7 @@ int vme_irq_generate(struct vme_dev *vdev, int level, int statid)
> >  		return -EINVAL;
> >  	}
> >  
> > -	if ((level < 1) || (level > 7)) {
> > +	if (level < 1 || level > 7) {
> >  		printk(KERN_WARNING "Invalid interrupt level\n");
> >  		return -EINVAL;
> >  	}
> > -- 
> > 2.41.0
> > 
> > 
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - You sent a patch that has been sent multiple times in the past few
>   days, and is the same type to ones that has been recently rejected.
>   Please always look at the mailing list traffic to determine if you are
>   duplicating other people's work.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 

Hi Greg,

I've read other email threads for other patches where you convey the
idea that this can be a false positive and that you don't see a problem
with using extra parentheses either, and also that this sometimes can
confuse developers.
Did I understand it correctly? If so, should I discard this commit then?

> thanks,
> 
> greg k-h's patch email bot

Thank you.

Alexon Oliveira
