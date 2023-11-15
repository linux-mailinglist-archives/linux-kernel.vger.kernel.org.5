Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6017ED1D6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344324AbjKOUNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKOUNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:13:21 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEE519E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:13:17 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c3aec5f326so251789466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700079195; x=1700683995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l44iogGkycFObP7ldrLRFPDR8OL/5GpOZwnm3btFsOA=;
        b=GOcgKw+Nc0l9Gz+kN8hpw7Vc3VmMDHuLSXXNqFEIQpOSLvWHUfqDtcgPB05sCFEckq
         7SDWF7yPW+TIKOMeai9G59YE+jAJy/JiAQIdPKPxr+nuDua7iYvun+YIog4GN0w50OQ/
         fdYsCG59j7NekeWDEf+9XUypRCSEwTbh+HRmBkzHxW4g/QbHrkHiwH56HbDTt8BK4ZHl
         b/Xq5P/pi3K715r3mxNy2tq9QICz0Y15Cg4b3aQJu74Af7tfTi8cxFtqKcYeuiKhp+EV
         6kZNqxayx6WtQLh0A0OQgAq/et+chwZvDRIqauOTp+UlARFFe0bMh+FspICNUXLtonGT
         nmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700079195; x=1700683995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l44iogGkycFObP7ldrLRFPDR8OL/5GpOZwnm3btFsOA=;
        b=LSwY9jSZkh/mt16agcCnoAXcf1HhTVOYbRaVasPxLKdT4zWfD4JDRna9ESHFFS3fvg
         UORtOP/cWaYVSVC6tv0YJmE6aBLEc7P0wf7az84jrR4hc6NWq/d9o6K8d4J69wMfJ4hQ
         O7ASzw7ezyQwhdLHw7Aaj3cPN4OGxukV8AEA+XOLqhFewrMs0J9o8GyUD8rU4qfRH92o
         Rq4jFXzFu5ak9OdWyhHXU6azaA/XCfhRnrNPtXgRHrR9Rbsltsm4NOL9wFiMoVddK28z
         nclR1lvPcY1PmFxwfZkCqg3iNCV+p76YGtDs8JeY/fEk73yPB3l2PopXXlqqMytzakzL
         VzVw==
X-Gm-Message-State: AOJu0Yz3/EmBuAFn1RQzLgv2ZPiblrYhvRTgaYLgDAwC3j0cKmK4lF/U
        1hCRy8eJnSPSwu0jB8FBOnnPf9qPiQr1cegcfsKL1g==
X-Google-Smtp-Source: AGHT+IFiuslHc5GoYPVTg55zJ6Hp9XqFP3VtNmMulCWUAvsjgsNcTOeJSsiXri+rcjv2D49T/xj/VqlOLdtl0G8jS3o=
X-Received: by 2002:a17:906:3c04:b0:9ae:614e:4560 with SMTP id
 h4-20020a1709063c0400b009ae614e4560mr6301269ejg.29.1700079195532; Wed, 15 Nov
 2023 12:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com> <CACSyD1P6RwjWpKhvNWEo77LKpTrnKOzT-+TV+GnQu_g-ADYbcQ@mail.gmail.com>
In-Reply-To: <CACSyD1P6RwjWpKhvNWEo77LKpTrnKOzT-+TV+GnQu_g-ADYbcQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 15 Nov 2023 12:12:36 -0800
Message-ID: <CAJD7tkbkPZ-Fiyz_4CKNQmufCpWSF330xK3bc7aHNML_cPi2sA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 4:53=E2=80=AFAM =E8=B4=BA=E4=B8=AD=E5=9D=A4 <hezhon=
gkun.hzk@bytedance.com> wrote:
>
> > For case (1), I think a cleaner solution would be to move the
> > zswap_invalidate() call from swap_range_free() (which is called after
> > the cached slots are freed) to __swap_entry_free_locked() if the usage
> > goes to 0. I actually think conceptually this makes not just for
> > zswap_invalidate(), but also for the arch call, memcg uncharging, etc.
> > Slots caching is a swapfile optimization that should be internal to
> > swapfile code. Once a swap entry is freed (i.e. swap count is 0 AND
> > not in the swap cache), all the hooks should be called (memcg, zswap,
> > arch, ..) as the swap entry is effectively freed. The fact that
> > swapfile code internally batches and caches slots should be
> > transparent to other parts of MM. I am not sure if the calls can just
> > be moved or if there are underlying assumptions in the implementation
> > that would be broken, but it feels like the right thing to do.
>
> Good idea,  This is indeed a clear solution.  I'll try it in another
> patch later.
>
> >
> > For case (2), I don't think zswap can just decide to free the entry.
> >
> > In that case, the page is in the swap cache pointing to a swp_entry
> > which has a corresponding zswap entry, and the page is clean because
> > it is already in swap/zswap, so we don't need to write it out again
> > unless it is redirtied. If zswap just drops the entry, and reclaim
> > tries to reclaim the page in the swap cache, it will drop the page
> > assuming that there is a copy in swap/zswap (because it is clean). Now
> > we lost all copies of the page.
> >
> > Am I missing something?
> >
>
> Ah, my bad.  Missed the step of marking the page as dirty.
> Please have a look,  just like zswap_exclusive_loads_enabled,
> set page dity so that it can be pageout again.
>        if (!page_was_allocated) {
>               if (!count) {
>                        set_page_dirty(page);
>                        ret =3D 0;
>                } else
>                        ret =3D -EEXIST;
>                put_page(page);
> }

I think we may need to try to lock the folio. Otherwise we may race
with reclaim reading the dirty bit before we set it.

Taking a step back, this seems like we are going behind exclusive
loads. We "should" keep the page in zswap as exclusive loads are
disabled and the page is not yet invalidated from zswap (the swap
entry is still in use). What you are trying to do here is sneakily
drop the page from zswap as if we wrote it back, but we didn't. We
just know that it was already loaded from zswap. We are essentially
making the previous load exclusive retroactively.

Is there a reason why exclusive loads cannot be enabled to achieve the
same result in the (arguably) correct way?

> Thanks  for your feedback, Yosry.
