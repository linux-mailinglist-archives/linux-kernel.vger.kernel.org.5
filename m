Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BC377D88D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241359AbjHPCsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241356AbjHPCsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:48:31 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1EF212B;
        Tue, 15 Aug 2023 19:48:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-565f24a24c4so313138a12.1;
        Tue, 15 Aug 2023 19:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692154110; x=1692758910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9Y1n4TS1Y6Do4F8PHiwqNs+Js7vfbAjeIDiq81kb8s=;
        b=QLhWZIOspEl732ekLaCdA19UH7yOdGcAFxp16IGO3bFbjr3uj8v7xFeCWx3Mzm3tnr
         CyCWWgDoaFXLefhchPrCqu9bnPOpqWQvFdxyGu57qK1tsqVhTzPuEAhGMdMbju7v5RPF
         4mxpXaZ+tDYtX+jraONcl+qKNVjeUJQKbR3r8pk74LyXF8YpP3I9aW3cBACvQsjG4F8u
         pJUm6+IzW+TzvohdZMTipXOuOTBKNpOMj10KukOfU30+Im4fmLFUN/Zubrq52IZnRbHf
         g47GBnhRaQTxDPyEOcT4EEQkmuZBBaDJdO7qEnQ5nd+CqIyuOupNcD6OwWpkTniki5xX
         TMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692154110; x=1692758910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9Y1n4TS1Y6Do4F8PHiwqNs+Js7vfbAjeIDiq81kb8s=;
        b=RGJI3dj9DT013M7r5Dc6sopeb93572LaRPgqV1GCcDOQg95z0hRF8UVuv0zy2DA0jz
         PtIsALvLz856IXeu7to+HuRLaQDaobgBYopZ46RhbXKWKfadG/BB1DgGlmCz4gAZnwNw
         IuqBFCNdxQsNk8UskpmXlknhBWLLx4vsxDeK4Zq6as4odqP5O6LtpCKxPjDRAe/hnlSH
         +FYflgK+yIa5tBXAN6KA9DCEvlfmn4CpKMRYOQf/qBYswtDRCYIi7dUcwqEXeHjkrZkV
         bK62uh8xg02DCVxuBeKfUvB9tXzjNbVAnSb9fd139CdUtVkA9RC3NLB5ut/GAjT/3KEA
         hz6w==
X-Gm-Message-State: AOJu0YzXkD7EyesUFdVeIZM1CAHDhwX4lNOdUQs4HuH9Kr8/9R51e+nq
        mvlbkrlxYpdCq7Icy7+9GwA=
X-Google-Smtp-Source: AGHT+IE6B4UTIFe/WUeygSs5rGL14Yci8DouHBdnvYq2eCv+q4GoVVtyZwvzd66N4FkXNlVH0T16UA==
X-Received: by 2002:a17:903:22c2:b0:1bd:ec9e:59fe with SMTP id y2-20020a17090322c200b001bdec9e59femr663162plg.68.1692154110136;
        Tue, 15 Aug 2023 19:48:30 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:58e9:6a8f:3187:b8c8:1572])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001b9de2b905asm11753356plf.231.2023.08.15.19.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 19:48:29 -0700 (PDT)
Date:   Wed, 16 Aug 2023 08:18:24 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] kernel: usb: Adds space, removes trailing whitespace
 and fixes pointer declaration.
Message-ID: <20230816024824.GB57274@atom0118>
References: <20230815204841.52600-1-atulpant.linux@gmail.com>
 <2023081533-require-pastor-d432@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023081533-require-pastor-d432@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:04:52PM +0200, Greg KH wrote:
> On Wed, Aug 16, 2023 at 02:18:41AM +0530, Atul Kumar Pant wrote:
> > This patch fixes following checkpatch.pl issue:
> > ERROR: space required before the open parenthesis '('
> > ERROR: trailing whitespace
> > ERROR: space required after that ','
> > ERROR: "foo * bar" should be "foo *bar"
> > 
> > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > ---
> >  drivers/usb/class/cdc-acm.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
> > index 11da5fb284d0..638c9cdaa041 100644
> > --- a/drivers/usb/class/cdc-acm.c
> > +++ b/drivers/usb/class/cdc-acm.c
> > @@ -203,7 +203,7 @@ static int acm_wb_is_avail(struct acm *acm)
> >  	n = ACM_NW;
> >  	spin_lock_irqsave(&acm->write_lock, flags);
> >  	for (i = 0; i < ACM_NW; i++)
> > -		if(acm->wb[i].use)
> > +		if (acm->wb[i].use)
> >  			n--;
> >  	spin_unlock_irqrestore(&acm->write_lock, flags);
> >  	return n;
> > @@ -1006,7 +1006,7 @@ static int wait_serial_change(struct acm *acm, unsigned long arg)
> >  		}
> >  	} while (!rv);
> >  
> > -	
> > +
> >  
> >  	return rv;
> >  }
> > @@ -1257,7 +1257,7 @@ static int acm_probe(struct usb_interface *intf,
> >  
> >  	if (control_interface == data_interface) {
> >  		/* some broken devices designed for windows work this way */
> > -		dev_warn(&intf->dev,"Control and data interfaces are not separated!\n");
> > +		dev_warn(&intf->dev, "Control and data interfaces are not separated!\n");
> >  		combined_interfaces = 1;
> >  		/* a popular other OS doesn't use it */
> >  		quirks |= NO_CAP_LINE;
> > @@ -1428,7 +1428,7 @@ static int acm_probe(struct usb_interface *intf,
> >  		goto err_free_write_urbs;
> >  
> >  	if (h.usb_cdc_country_functional_desc) { /* export the country data */
> > -		struct usb_cdc_country_functional_desc * cfd =
> > +		struct usb_cdc_country_functional_desc *cfd =
> >  					h.usb_cdc_country_functional_desc;
> >  
> >  		acm->country_codes = kmalloc(cfd->bLength - 4, GFP_KERNEL);
> > -- 
> > 2.25.1
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
> - Your patch did many different things all at once, making it difficult
>   to review.  All Linux kernel patches need to only do one thing at a
>   time.  If you need to do multiple things (such as clean up all coding
>   style issues in a file/driver), do it in a sequence of patches, each
>   one doing only one thing.  This will make it easier to review the
>   patches to ensure that they are correct, and to help alleviate any
>   merge issues that larger patches can cause.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,

	Sure, I'll do these cleanup in seperate patches.

> 
> greg k-h's patch email bot
