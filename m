Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503E27CEF2C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbjJSFlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjJSFlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:41:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC1D130
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:41:05 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507c5249d55so2912150e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697694063; x=1698298863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j7kAytioghDE6xyX4BghBa8cMFVr3L8tOR2ZoNefZ9k=;
        b=ShZvUG+1JR3qVMpEfH65avvEMaqfjUGfzA7Tw9k+nhDlNjbBKWUx6EnqXuTBj1qhy0
         R5HuGQjlfC0H4abtWZnLN2l2WJZ/HuN55vDAEk/aWIqhefiod4fMjj1hF6IdKpc25vgV
         sJs7+ISghdHMCTaT/uXZ4sKngFAiU8tW5gBYZ1NYubbFx8HREk/3vO+F3/xapT3B2iIt
         XaqOVN5FlLb4B6nxnQewwuTK17AS+5w0W3hoIiBKYETzLEyLpwcFYYIcXcrTI7CJZuKE
         Xp3Ip6H6WVe2u8sudTjgJ3JQlHRXZFGi6SIYOKW8uSyYq6jry77XgHJiPqxx8pZ++0Rx
         nTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697694063; x=1698298863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7kAytioghDE6xyX4BghBa8cMFVr3L8tOR2ZoNefZ9k=;
        b=O8mL/372UcAgtdHyDaCdOw0XDOmt912ffdx7cWrwKD1TQvbKxfZG08aHtmzwgOLqRw
         RGXgMtC+Qgsl+tSSv+qkJPpMPCgP9v50rBFDdiuEVdTb//XliFUsIGAdB2r1ZjXcE6G6
         qYrSF804b1TaJ/qLJZaRFU9DICzrlBPfDXSHKvEY8OFzFb0CBwYjjkHwoipgdbs/L+B4
         EuGqZzm+sIE0sFSF6oV76x4WlMyZx4kC6Try7lJpstHS/HnruVPj5ovOHhkqH6m+W/yg
         GZhLXRqmOCIhAgCaUFPP/4aE6u0JX3ore50columbEZtgAU9mj/0IblIq/ZWGxz9kv8V
         mWnA==
X-Gm-Message-State: AOJu0YzJhNIWTgncN38QHwju7rQryA8A/cnccIQZLmnDceNku3kjSbpB
        U6B9wMyg9UER/1RCYqbZdO3JZw==
X-Google-Smtp-Source: AGHT+IG5EtVlCxnFhKx6/IWeIkVIlcJyQiopIMW7380LSHeSu/QzSQA6+QwuSQOi3ZAsfzcZcIDbKg==
X-Received: by 2002:a19:5011:0:b0:503:388f:30a3 with SMTP id e17-20020a195011000000b00503388f30a3mr677846lfb.26.1697694063124;
        Wed, 18 Oct 2023 22:41:03 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i6-20020adfe486000000b0032415213a6fsm3580699wrm.87.2023.10.18.22.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 22:41:02 -0700 (PDT)
Date:   Thu, 19 Oct 2023 08:40:59 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Philip Li <philip.li@intel.com>, oe-kbuild@lists.linux.dev,
        Lorenzo Stoakes <lstoakes@gmail.com>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm'
 could be null (see line 3667)
Message-ID: <0eddb8b4-47a1-4d94-ae44-707addae77c8@kadam.mountain>
References: <f82be227-bfde-439a-b339-1b4ee370d59a@kadam.mountain>
 <ZS+dSd9Z6/2wU0Eg@MiWiFi-R3L-srv>
 <89caf59a-d3b9-409d-b1ae-9e370cb9ee7d@kadam.mountain>
 <ZS/LrhcxcMOgiiX5@MiWiFi-R3L-srv>
 <ZS/TVMT9ed7OdyNy@rli9-mobl>
 <ZS/2k6DIMd0tZRgK@MiWiFi-R3L-srv>
 <20231018085248.6f3f36101cbdfe0990c8b467@linux-foundation.org>
 <ZTCURc8ZQE+KrTvS@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTCURc8ZQE+KrTvS@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 10:28:21AM +0800, Baoquan He wrote:
> On 10/18/23 at 08:52am, Andrew Morton wrote:
> > On Wed, 18 Oct 2023 23:15:31 +0800 Baoquan He <bhe@redhat.com> wrote:
> > 
> > > From: Baoquan He <bhe@redhat.com>
> > > Date: Wed, 18 Oct 2023 22:50:14 +0800
> > > Subject: [PATCH] mm/vmalloc: fix the unchecked dereference warning in vread_iter()
> > > Content-type: text/plain
> > > 
> > > LKP reported smatch warning as below:
> > > 
> > > ===================
> > > smatch warnings:
> > > mm/vmalloc.c:3689 vread_iter() error: we previously assumed 'vm' could be null (see line 3667)
> > > ......
> > > 06c8994626d1b7  @3667 size = vm ? get_vm_area_size(vm) : va_size(va);
> > > ......
> > > 06c8994626d1b7  @3689 else if (!(vm->flags & VM_IOREMAP))
> > >                                  ^^^^^^^^^
> > > Unchecked dereference
> > > =====================
> > > 
> > > So add checking on whether 'vm' is not null when dereferencing it in
> > > vread_iter(). This mutes smatch complaint.
> > > 
> > > ...
> > >
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3813,7 +3813,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
> > >  
> > >  		if (flags & VMAP_RAM)
> > >  			copied = vmap_ram_vread_iter(iter, addr, n, flags);
> > > -		else if (!(vm->flags & VM_IOREMAP))
> > > +		else if (!(vm && (vm->flags & VM_IOREMAP)))
> > >  			copied = aligned_vread_iter(iter, addr, n);
> > >  		else /* IOREMAP area is treated as memory hole */
> > >  			copied = zero_iter(iter, n);
> > 
> > So is this not a real runtime bug?  We're only doing this to suppress a
> > smatch warning?
> > 
> > If so, can we please include a description of *why* this wasn't a bug? 
> > What conditions ensure that vm!=NULL at this point?
> 
> I think this is not a real runtime bug. The only chance it can hapen is
> when (flags == VMAP_BLOCK) is true. That has been warned and could never
> happen. I updated patch log and paste v2 here. 
> 
>                 /*
>                  * VMAP_BLOCK indicates a sub-type of vm_map_ram area, need
>                  * be set together with VMAP_RAM.
>                  */
>                 WARN_ON(flags == VMAP_BLOCK);
>  
>                 if (!vm && !flags)
>                         continue;
> 
> 

Thanks.  If you want you could just ignore the warning.  It's a one time
warning so we won't send the mail again and if people have questions
about it, they can just look it up on lore.

The truth is when I was reviewing this code the first time I got mixed
up between flags and vm->flags so that's part of why I reported it.

Smatch ignores the WARN_ON().  Historically WARN_ON() has been useless
for indicating whether something can happen or not.  These days,
WARN_ON() is treated as a syzkaller bug so we prefer pr_warn() if
something can actually happen.  We still see a lot of WARN_ON()s
happening in real life so I'm not eager to make Smatch treat them like a
BUG_ON().

Also, sadly, even if we changed the WARN_ON() to a BUG_ON() it still
wouldn't silence the warning because Smatch is not quite clever enough
to parse that.

regards,
dan carpenter


