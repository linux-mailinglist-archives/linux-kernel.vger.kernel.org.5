Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CEF7C7DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjJMGko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjJMGkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:40:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389D7BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:40:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50433d8385cso2396382e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697179236; x=1697784036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gReBOXvZ3tuzSCoKI6cwvDchpAXHJGanFh39+fsImug=;
        b=gOMyAWh2shS+DBwfApP7OObdhXCH+pI4SXXX5EfyY4xLjPFumxyijxn6VxSEAAKXYu
         fb9+2dBHuXoX66EsP9Spzef5Q0GIS3WqiyptZKfTMZue3rJJP74nWltcCJYwzZfJhxki
         uzMfekkbPHFnzgdjOWWwzpm+iuTT/u4uXVxx92Ttw0o+Q6bg0ND2B/jKTpQHq7pGOODc
         szNBeve1uZ0YB9fxHFlI3dHE1vPsehT3rBuGZSmrV54fVj0yFG+nQBi99kVZ4qx7hM3i
         liMVXOxbCBhe+gUJDNB+xjxcFH06pFdjOUP+xyxkjnp+g9d7pz+2OkSdMxBzCMxEOtGH
         fC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697179236; x=1697784036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gReBOXvZ3tuzSCoKI6cwvDchpAXHJGanFh39+fsImug=;
        b=vf/9S6f7iY6M7aFTW2Eoaz/jvBPyXbk2vSOyv5aMAzl54CpsszfypYkgPVswSr1bLR
         oEbgtowVU6Z7D56V2gV21TEFLVrphjWnqDLeFVnbOff4XUhk/MmPdN6gJct5QxbWv3f5
         uMcToxig9QRihGBRIoYPMFFA/1VYrS/mUawzrg3anCsn4q7G12TpHTCXTgFpc56mk4BP
         8N2rSXH/T//tkvOEhPcB/zSYQEbvO5VsONEj2wxAWR7ROrF6nj4uy24otGX1YuCF2NlV
         mU/wptvA+zGg+4c5wM7emt+AYyzA3eXeobZS8l8t1kdwLPBnltAc7VG3AR0fYJ4qoRyA
         OuRg==
X-Gm-Message-State: AOJu0YwXGFWOvyP0jYTpZmVtw45AUdK0J6soSfAex/mRclleBDwsq/O8
        lpsc9c3tzWJrZn8Z6ibaqQnn5r4uP9ob5Q1j
X-Google-Smtp-Source: AGHT+IEEXZNj7gA9pKyGp3kB1cpwy2NNSwDJ2ysQiG/gLgoNU99nw4a5RYfrqfMblrudyHiEknDiTQ==
X-Received: by 2002:a05:6512:944:b0:500:ac71:f26a with SMTP id u4-20020a056512094400b00500ac71f26amr16947450lft.57.1697179236002;
        Thu, 12 Oct 2023 23:40:36 -0700 (PDT)
Received: from GK0179 ([91.199.127.174])
        by smtp.gmail.com with ESMTPSA id o11-20020ac2434b000000b004ff9ecbf158sm3194203lfl.74.2023.10.12.23.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 23:40:35 -0700 (PDT)
Date:   Fri, 13 Oct 2023 08:40:38 +0200
From:   =?utf-8?Q?Bart=C5=82omiej?= Konecki <bartekkonecki97@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: Alignment should match open
 parenthesis
Message-ID: <ZSjmZpxVwsB7c3Mo@localhost.localdomain>
References: <ZSfi8nPauVatDm3E@localhost.localdomain>
 <2023101250-shading-skintight-28f7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023101250-shading-skintight-28f7@gregkh>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Thu, Oct 12, 2023 at 02:20:04PM +0200, Greg KH napisał(a):
> On Thu, Oct 12, 2023 at 02:13:38PM +0200, Bartłomiej Konecki wrote:
> > Fix 2 checks reported by checkpatch.pl in axis-fifo.c
> > for alignment should match open parenthesis
> > 
> > Signed-off-by: Bartłomiej Konecki <bartekkonecki97@gmail.com>
> > ---
> >  drivers/staging/axis-fifo/axis-fifo.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Any specific reason you didn't cc: the staging mailing list like
> scripts/get_maintainer.pl suggested you do?
> 
> > 
> > diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> > index 727b956aa231..ab758a527261 100644
> > --- a/drivers/staging/axis-fifo/axis-fifo.c
> > +++ b/drivers/staging/axis-fifo/axis-fifo.c
> > @@ -381,8 +381,8 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
> >  		 */
> >  		mutex_lock(&fifo->read_lock);
> >  		ret = wait_event_interruptible_timeout(fifo->read_queue,
> > -			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> > -			read_timeout);
> > +						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> > +						       read_timeout);
> 
> Does this now go over the max line length limit?  Does this patch pass
> checkpatch.pl?
> 
> thanks,
> 
> greg k-h

I have no reason to not include staging mailing list.
I fixed my mistake.

Patch lines do not have more than 54 characters, but one of line ends at column 100 and other at col 99.

After this patch there are no more 'Alignment should match open parenthesis' errors from checkpatch.pl.
checkpatch.pl gives one more error connected to documentation in this file, but it should be treated in separate commit and I am not sure how to resolve it:

WARNING: DT compatible string "xlnx,axi-fifo-mm-s-4.1" appears un-documented -- check ./Documentation/devicetree/bindings/
#916: FILE: drivers/staging/axis-fifo/axis-fifo.c:916:
+	{ .compatible = "xlnx,axi-fifo-mm-s-4.1", },

Thank you
Bart

