Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574FF77C1C9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjHNUvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjHNUvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:51:18 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A89C3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:51:16 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bcb15aa074so2937839a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692046275; x=1692651075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6w5W3N4z/R1wmqArsnIh7Uu9/mMtIFy3tf8fGTkmf8=;
        b=NZXGALlzO36NaPHcKVSp64zmWXpa4qjPlQv9O5S8Nfub9f76N+VugvnyjOczh/UIgO
         RSY2x8gplNQh9vaUE+smPBPPm1ZKUKyJKVRUpVq4V172q7GTx8VwvC2ksw5xIrXmja48
         DgQRXAWWWFl+BdXga6KIz3wu8htgTO2Otnm9/f8H/SUdgWgdGipQ87cQAyUHatHVLomL
         oInYPecehZbiu3CStqsLod7gxexVjbF4306l8wmBwtAc7l9/GsRrommap1qbeGVYLIbr
         VWdu9Y0KusxZUn7PZwwdxCbQ/7UzkpcZwOz2kXX4syCUuW94VQIC+mhrNGWZMmmzeulh
         dpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692046275; x=1692651075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6w5W3N4z/R1wmqArsnIh7Uu9/mMtIFy3tf8fGTkmf8=;
        b=eJPslWIIBkSOQoFBwBHJmwru4f2Ilwb+5+zVAOsxutkwPYZbVBPiCxtx1+EUq3C9pY
         IUCG1kQjse0W/GzGYsMmfl8wAkZRODwE1Msmw3wZqSS6ZLwxdXU0CSeDVlf5NZF6a8ve
         c/TCQZHnuf7+RN8+XupbDM8hvVISSYwq8fjIbSePZZuZJN1RrIaufZGXb+4xW8qiezJV
         bzcyM298oivgmtfKpBeR2VQd6a0PIQydmEwaXhwHij7by7kCdmfk5ODDg0cFu6QzwpWh
         des12O3TrBdli0iUBYp/8gar4DFfMxO2ML4zesJc9x9osGqAXRMrq1Z4peo4ELWEJT7G
         w9KA==
X-Gm-Message-State: AOJu0YwKtlFk0ElBe02UhpK7641aCeeT1qb1UzFk81ZZfrQrcfBtTawB
        Bl1rYK571PDReobOGR4VKsA=
X-Google-Smtp-Source: AGHT+IF8To7ajDk5voVdr7BnC5C2Un42fuBi9miXKH+18ua+CD0ak8K77xvG6K+Mw1dC4EZPJV/myA==
X-Received: by 2002:a9d:6d93:0:b0:6bc:6445:e24f with SMTP id x19-20020a9d6d93000000b006bc6445e24fmr43784otp.19.1692046275651;
        Mon, 14 Aug 2023 13:51:15 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:86d6:7871:f7e9:8a15:865a])
        by smtp.gmail.com with ESMTPSA id l6-20020a9d7346000000b006b991ac6408sm4727797otk.40.2023.08.14.13.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:51:15 -0700 (PDT)
Date:   Mon, 14 Aug 2023 17:51:10 -0300
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix check blank lines not necessary
Message-ID: <ZNqTvrQiprKkeX1z@alolivei-thinkpadt480s.gru.csb>
References: <ZNqBd/08H/Y5UEOm@alolivei-thinkpadt480s.gru.csb>
 <2023081448-sustainer-prelaw-25a2@gregkh>
 <ZNqPIvaQJ9HO8p9x@alolivei-thinkpadt480s.gru.csb>
 <2023081410-railroad-overbill-cb05@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081410-railroad-overbill-cb05@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:46:39PM +0200, Greg KH wrote:
> On Mon, Aug 14, 2023 at 05:31:30PM -0300, Alexon Oliveira wrote:
> > On Mon, Aug 14, 2023 at 10:17:10PM +0200, Greg KH wrote:
> > > On Mon, Aug 14, 2023 at 04:33:11PM -0300, Alexon Oliveira wrote:
> > > > Fixed all CHECK: Blank lines aren't necessary after an open brace '{'
> > > > and CHECK: Blank lines aren't necessary before a close brace '}'
> > > > as reported by checkpatch to adhere to the Linux kernel
> > > > coding-style guidelines.
> > > > 
> > > > Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
> > > > ---
> > > >  drivers/staging/vme_user/vme.c | 5 -----
> > > >  1 file changed, 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> > > > index 5eb0d780c77f..c7c50406c199 100644
> > > > --- a/drivers/staging/vme_user/vme.c
> > > > +++ b/drivers/staging/vme_user/vme.c
> > > > @@ -308,7 +308,6 @@ struct vme_resource *vme_slave_request(struct vme_dev *vdev, u32 address,
> > > >  		if (((slave_image->address_attr & address) == address) &&
> > > >  		    ((slave_image->cycle_attr & cycle) == cycle) &&
> > > >  		    (slave_image->locked == 0)) {
> > > > -
> > > >  			slave_image->locked = 1;
> > > >  			mutex_unlock(&slave_image->mtx);
> > > >  			allocated_image = slave_image;
> > > > @@ -510,7 +509,6 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
> > > >  		    ((master_image->cycle_attr & cycle) == cycle) &&
> > > >  		    ((master_image->width_attr & dwidth) == dwidth) &&
> > > >  		    (master_image->locked == 0)) {
> > > > -
> > > >  			master_image->locked = 1;
> > > >  			spin_unlock(&master_image->lock);
> > > >  			allocated_image = master_image;
> > > > @@ -682,10 +680,8 @@ ssize_t vme_master_read(struct vme_resource *resource, void *buf, size_t count,
> > > >  		count = length - offset;
> > > >  
> > > >  	return bridge->master_read(image, buf, count, offset);
> > > > -
> > > >  }
> > > >  EXPORT_SYMBOL(vme_master_read);
> > > > -
> > > 
> > > This line needs to be there, checkpatch should not have complained about
> > > it.
> > > 
> > 
> > Hmm, ACK. It complained, as below:
> > 
> > CHECK: Blank lines aren't necessary after an open brace '{'
> > #311: FILE: drivers/staging/vme_user/vme.c:311:
> > +		    (slave_image->locked == 0)) {
> > +
> > --
> > CHECK: Blank lines aren't necessary after an open brace '{'
> > #513: FILE: drivers/staging/vme_user/vme.c:513:
> > +		    (master_image->locked == 0)) {
> > +
> > --
> > CHECK: Blank lines aren't necessary before a close brace '}'
> > #684: FILE: drivers/staging/vme_user/vme.c:684:
> > +
> > +}
> > --
> > CHECK: Blank lines aren't necessary before a close brace '}'
> > #686: FILE: drivers/staging/vme_user/vme.c:686:
> > +
> > +}
> > --
> > CHECK: Blank lines aren't necessary after an open brace '{'
> > #890: FILE: drivers/staging/vme_user/vme.c:890:
> > +		    (dma_ctrlr->locked == 0)) {
> > +
> > --
> > 
> > Should I keep them then and forget this patch?
> 
> No, those are all valid warnings.  You removed a line that checkpatch
> did not complain about, and should not be removed :(
> 

Oh, I see it now. My bad. Keyboard issues. Fixing it now and re-submitting it.

> thanks,
> 
> greg k-h

Thank you.

Alexon Oliveira
