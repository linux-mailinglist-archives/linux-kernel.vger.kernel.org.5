Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096E3800C9A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379075AbjLANxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379044AbjLANxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:53:31 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059E110FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:53:36 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bd928b13cso1028059e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701438814; x=1702043614; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B2gDIyfWC+W4ytDLyZ1ApFFOSpObEoeppni2yotM7Sk=;
        b=Yk573CjBNOA4iH35REuCAlz0xcvrPdhovdZ10G+9ct9/82MJ2VUkatWF5ob7pNDWHA
         quWrakx+4FF5/3XxvR9LtyfIDhm487E0vDDSXGnyFHtYI6mDH0TY6fk/h/3gmV1C23gR
         u+j36SCyGcOQ6ubn8/4hNrahVAFCc3S6xZJ7yYv2HkoAaRGWKI7xwDI1Farhm0gLIuG8
         w0y0Ix375m7LdTFa20D2Cd7XERlNahb3EAJ9mSeSu3MSKb5MmvJJmbEikY+vNDgLL2E4
         BwlqV0QaZcYNaGlMM5nWO8nalNRO1MUptzEi0wUC7rWJ8FgsQNWGbd3WwOgSVDDkcvIi
         cj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701438814; x=1702043614;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2gDIyfWC+W4ytDLyZ1ApFFOSpObEoeppni2yotM7Sk=;
        b=cJBJcHWmJGFh148L47Em6B/xfk8c28JV7aG5+uGwZhxeC8WPhuYVw6QYylahwJ8Ycc
         RZJZc+hG1a5hWrtaf2dzlPV5SGEvZQAUqNoPj5c8lFlADTjTofq5FI6bZDNlpr3/4OE/
         NNiBg0SzPStihzdECqSr8Xs9wXungb294NQge5lmQbTMl1n5jdaUGfJ7Lafj4NyquC4H
         iaIm/fJ2Ih5A1A2LqiQjT0vkOpTlnc1HA+PvdPnoJ3TxSGYGbjvoLcLFgdTKcyy5H9Ru
         YcZDcZB6pnDprlP/jZIIlJhrXd4wgWmx0OSG6cFwrdmYLC8vwrN6vF+IwHVwthjShlyC
         JevQ==
X-Gm-Message-State: AOJu0Yw6a7VslHeF4To6VOrn7NOh20cGHJ9x+zO3hJOZEjXN2+DVTZRf
        pPtzAFHLVOg+2/HDveQ47+6VxIxAqacIYd6/3YAU4w==
X-Google-Smtp-Source: AGHT+IEWbDp/BHTI35lHYKJahi0bZ7EApCyKw47RGLaZzY7863jjC5lW9Ntg2R4fr5oj1AbZZjB53QPWww4cZ5h4s3o=
X-Received: by 2002:a2e:8783:0:b0:2c9:c22e:31eb with SMTP id
 n3-20020a2e8783000000b002c9c22e31ebmr611668lji.22.1701438814214; Fri, 01 Dec
 2023 05:53:34 -0800 (PST)
MIME-Version: 1.0
References: <ZV5zGROLefrsEcHJ@r13-u19.micron.com> <CACSyD1OFjROw26+2ojG37eDBParVg721x1HCROMiF2pW2aHj8A@mail.gmail.com>
 <ZV/HSFMmv3xwkNPL@memverge.com> <CACSyD1MrCzyV-93Ov07NpV3Nm3u0fYExmD1ShE_e2tapW6a6HA@mail.gmail.com>
 <ZWizUEd/rsxSc0fW@memverge.com>
In-Reply-To: <ZWizUEd/rsxSc0fW@memverge.com>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
Date:   Fri, 1 Dec 2023 21:53:23 +0800
Message-ID: <CACSyD1PCjPEwPCVXKVULjbNwxUG89DZUUfiDLg+wFyJRJXAPzA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/mbind: Introduce process_mbind() syscall for
 external memory binding
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Vinicius Petrucci <vpetrucci@gmail.com>, akpm@linux-foundation.org,
        linux-mm@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, minchan@kernel.org,
        dave.hansen@linux.intel.com, x86@kernel.org,
        Jonathan.Cameron@huawei.com, aneesh.kumar@linux.ibm.com,
        ying.huang@intel.com, dan.j.williams@intel.com, fvdl@google.com,
        surenb@google.com, rientjes@google.com, hannes@cmpxchg.org,
        mhocko@suse.com, Hasan.Maruf@amd.com, jgroves@micron.com,
        ravis.opensrc@micron.com, sthanneeru@micron.com,
        emirakhur@micron.com, vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hi ZhongKun!
>
> I actually just sent out a more general RFC to mempolicy updates that
> discuss this more completely:
>
> https://lore.kernel.org/linux-mm/ZWezcQk+BYEq%2FWiI@memverge.com/
>

OK.

> and another post on even more issues with pidfd modifications to vma
> mempolicies:
>
> https://lore.kernel.org/linux-mm/ZWYsth2CtC4Ilvoz@memverge.com/
>
> We may have to slow-walk the changes to vma policies due to there being
> many more hidden accesses to (current) than expected. It's a rather
> nasty rats nest of mempolicy-vma-cpusets-shmem callbacks that obscure
> these current-task accesses, it will take time to work through.
>

Got it, thanks. It's more complicated than I thought.

> As for hot-path reference counting - we may need to change the way
> mempolicy is managed, possibly we could leverage RCU to manage mempolicy
> references in the hot path, rather than using locks.  In this scenario,
> we would likely need to change the way the default policy is applied
> (maybe not, I haven't fully explored it).
>

RCU may have a long time in the read-side critical section.

We should probably replace the atomic_t refcnt with percpu_ref in
mempolicy(also suggested by Michal), but refactoring work involves
a lot of code.

A simple way is to use task_work to release the mempolicy which may
be used by alloc_pages(). But it doesn't have a direct result.

> Do you have thoughts on this?  Would very much like additional comments
> before I go through the refactor work.
>
> Regards,
> Gregory
