Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BC077C1B0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjHNUrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjHNUqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:46:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BE3E5E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BD0A63BCC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B19EC433C8;
        Mon, 14 Aug 2023 20:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692046001;
        bh=01MR9is/VePpgtSbotJk8xIJEmRI7DTqHoGMedAbxOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aer3BNRR6Qr4vbFAaq/eAdiLy+Nyatt2FbJTKTLETxJe8DV90IhWYe5cfPlFI2SwG
         NlvADW0kv7GEV9cjMNAsTRVsQG9LFPlqbZ7bTqIBH/VkNKDx5t2WhwesDy8JakBm7v
         F+KDEewcd8JThYbQFgGKY3itpXgZPr8KHp4HvNzI=
Date:   Mon, 14 Aug 2023 22:46:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check blank lines not necessary
Message-ID: <2023081410-railroad-overbill-cb05@gregkh>
References: <ZNqBd/08H/Y5UEOm@alolivei-thinkpadt480s.gru.csb>
 <2023081448-sustainer-prelaw-25a2@gregkh>
 <ZNqPIvaQJ9HO8p9x@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNqPIvaQJ9HO8p9x@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 05:31:30PM -0300, Alexon Oliveira wrote:
> On Mon, Aug 14, 2023 at 10:17:10PM +0200, Greg KH wrote:
> > On Mon, Aug 14, 2023 at 04:33:11PM -0300, Alexon Oliveira wrote:
> > > Fixed all CHECK: Blank lines aren't necessary after an open brace '{'
> > > and CHECK: Blank lines aren't necessary before a close brace '}'
> > > as reported by checkpatch to adhere to the Linux kernel
> > > coding-style guidelines.
> > > 
> > > Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> > > ---
> > >  drivers/staging/vme_user/vme.c | 5 -----
> > >  1 file changed, 5 deletions(-)
> > > 
> > > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > > index 5eb0d780c77f..c7c50406c199 100644
> > > --- a/drivers/staging/vme_user/vme.c
> > > +++ b/drivers/staging/vme_user/vme.c
> > > @@ -308,7 +308,6 @@ struct vme_resource *vme_slave_request(struct vme_dev *vdev, u32 address,
> > >  		if (((slave_image->address_attr & address) == address) &&
> > >  		    ((slave_image->cycle_attr & cycle) == cycle) &&
> > >  		    (slave_image->locked == 0)) {
> > > -
> > >  			slave_image->locked = 1;
> > >  			mutex_unlock(&slave_image->mtx);
> > >  			allocated_image = slave_image;
> > > @@ -510,7 +509,6 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
> > >  		    ((master_image->cycle_attr & cycle) == cycle) &&
> > >  		    ((master_image->width_attr & dwidth) == dwidth) &&
> > >  		    (master_image->locked == 0)) {
> > > -
> > >  			master_image->locked = 1;
> > >  			spin_unlock(&master_image->lock);
> > >  			allocated_image = master_image;
> > > @@ -682,10 +680,8 @@ ssize_t vme_master_read(struct vme_resource *resource, void *buf, size_t count,
> > >  		count = length - offset;
> > >  
> > >  	return bridge->master_read(image, buf, count, offset);
> > > -
> > >  }
> > >  EXPORT_SYMBOL(vme_master_read);
> > > -
> > 
> > This line needs to be there, checkpatch should not have complained about
> > it.
> > 
> 
> Hmm, ACK. It complained, as below:
> 
> CHECK: Blank lines aren't necessary after an open brace '{'
> #311: FILE: drivers/staging/vme_user/vme.c:311:
> +		    (slave_image->locked == 0)) {
> +
> --
> CHECK: Blank lines aren't necessary after an open brace '{'
> #513: FILE: drivers/staging/vme_user/vme.c:513:
> +		    (master_image->locked == 0)) {
> +
> --
> CHECK: Blank lines aren't necessary before a close brace '}'
> #684: FILE: drivers/staging/vme_user/vme.c:684:
> +
> +}
> --
> CHECK: Blank lines aren't necessary before a close brace '}'
> #686: FILE: drivers/staging/vme_user/vme.c:686:
> +
> +}
> --
> CHECK: Blank lines aren't necessary after an open brace '{'
> #890: FILE: drivers/staging/vme_user/vme.c:890:
> +		    (dma_ctrlr->locked == 0)) {
> +
> --
> 
> Should I keep them then and forget this patch?

No, those are all valid warnings.  You removed a line that checkpatch
did not complain about, and should not be removed :(

thanks,

greg k-h
