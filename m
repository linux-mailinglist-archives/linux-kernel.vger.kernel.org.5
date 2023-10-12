Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D01D7C7351
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379519AbjJLQnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379320AbjJLQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:43:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA05EC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:43:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692779f583fso955792b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697129013; x=1697733813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FheJ03zTB1r9h7STvwuIv4tGnbOBTf52Cw7EqZS0/H8=;
        b=nTHBI++d5+Qn9gfJqO2AOra/gPHc//57WHEi8CYbo2HWijiGgnFA8NngeOJfhjZ8cT
         Ao7kVhZvgL+SD/oYRSdQYZcnlciebeIsmhPpY3sceCBwJEBQOA87fuC/VRMLXnJmoSJH
         MqcyGdNbi4/eXb4lPQuCxZseaa/OsDjchqcW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697129013; x=1697733813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FheJ03zTB1r9h7STvwuIv4tGnbOBTf52Cw7EqZS0/H8=;
        b=E6PgRFRPo7NzyYwVYoAw3WE2+YJ95S7gxhr1lWboKOxRsu8vxtcdf6KnaNoam5tEeq
         TbNzXSDliUeW3oJglY22cg7UpSVdsE+oE+h0KOAOgE0ChROm+VYeTJWBycRnzXW03V8s
         jUj0kcaTbolg5/yTRAyCTzQu5jpmvGgXaBxOBuNVbI0THTppxiksA7CeAEi8u3nvQEFW
         FZcwiLHx1rtGUFLo6HjxdexcoFixYECGQVfFzBOJmwm+hQEfdSCBsIKm0v/X5C1u4AcA
         Qr2zge0z66Upd2GvVT3Mf9+yG5dgrOhO7kivSLKCeEfbOJlYJgcky9Fwi2H/vI7pgweQ
         wL+A==
X-Gm-Message-State: AOJu0Yx+Lpq0424FmsPEkxzdc4gZLlTMMgwig38iyTbwzn8js2koYEbE
        TXsIbqf4oYcph+IwSnckuXURmw==
X-Google-Smtp-Source: AGHT+IHNYLYRAliVe1HCl7LxICrQAgkMgrh+0+zSF1yj3orms0Aj5ljjNrvRX7iZPDkay63VVPiNgw==
X-Received: by 2002:a05:6a20:4287:b0:16b:aad0:effe with SMTP id o7-20020a056a20428700b0016baad0effemr19212702pzj.62.1697129013159;
        Thu, 12 Oct 2023 09:43:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k10-20020a637b4a000000b0059d8ecb79dcsm1970301pgn.20.2023.10.12.09.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:43:32 -0700 (PDT)
Date:   Thu, 12 Oct 2023 09:43:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/slub: disable slab merging in the default
 configuration
Message-ID: <202310120935.E066A3FE4@keescook>
References: <20230627132131.214475-1-julian.pidancet@oracle.com>
 <48bd9819-3571-6b53-f1ad-ec013be742c0@google.com>
 <ZJxjgy/Mkh20WpXv@P9FQF9L96D.corp.robot.car>
 <d7962a66-12e9-6225-1e74-ccdfc9891da9@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7962a66-12e9-6225-1e74-ccdfc9891da9@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 09:21:14AM +0200, Vlastimil Babka wrote:
> On 6/28/23 18:44, Roman Gushchin wrote:
> > On Tue, Jun 27, 2023 at 12:32:15PM -0700, David Rientjes wrote:
> >> On Tue, 27 Jun 2023, Julian Pidancet wrote:
> >> 
> >> > Make CONFIG_SLAB_MERGE_DEFAULT default to n unless CONFIG_SLUB_TINY is
> >> > enabled. Benefits of slab merging is limited on systems that are not
> >> > memory constrained: the overhead is negligible and evidence of its
> >> > effect on cache hotness is hard to come by.
> >> > 
> >> 
> >> I don't have an objection to this, I think it makes sense.
> > 
> > +1
> > 
> > I believe the overhead was much larger when we had per-memcg slab caches,
> > but now it should be fairly small on most systems.
> > 
> > But I wonder if we need a new flag (SLAB_MERGE?) to explicitly force merging
> > on per-slab cache basis.
> 
> Damn, we just tried to add SLAB_NO_MERGE, that is if Linus pulls the PR, as
> I've just found out that the last time he hated the idea [1] :) (but at the
> same time I think the current attempt is very different in that it's not
> coming via a random tree, and the comments make it clear that it's not for
> everyone to enable in production configs just because they think they are
> special).
> 
> But SLAB_MERGE, I doubt it would get many users being opt-in. People would
> have to consciously opt-in to not being special.
> 
> As for changing the default, we definitely need to see the memory usage
> results first, as was mentioned. It's not expected that disabling merging
> would decrease performance, so no wonder the test didn't find such decrease,
> but the expected downside is really increased memory overhead.

Did this analysis happen? Apologies if I missed it...

> But then again it's just a default and most people would use a distro config
> anyway, and neither option seems to be an obvious winner to me? As for the
> "security by default" argument, AFAIK we don't enable freelist
> hardening/randomization by default, and I thought (not being the expert on
> this) the heap spraying attacks concerned mainly generic kmalloc cache users
> (see also [2]) and not some specific named caches being merged?
> 
> [1] https://lore.kernel.org/all/CA+55aFyepmdpbg9U2Pvp+aHjKmmGCrTK2ywzqfmaOTMXQasYNw@mail.gmail.com/
> [2] https://lore.kernel.org/all/20230626031835.2279738-1-gongruiqi@huaweicloud.com/

I'm a fan of turning on any of these "by default", as that's been the
historical approach, which tends to span years:

- security feature introduced, default off in the kernel
- distros enable it by default
- kernel makes it default on

So perhaps we're better off making the other hardening features on by
default since distros have been shipping with them for years now?

-Kees

-- 
Kees Cook
