Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04017DFBBC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjKBUy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBUy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:54:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FA6195
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 13:54:53 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so2280875a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698958492; x=1699563292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c63Npi10wJWosRhm9gjhF9hBJGybG/sFGWhVUImu6vc=;
        b=0zPgF+xyV7AAUoCzotxUr4INrjKwsIw0s3dJ90M7jizN6NQ9qLMlqkAC8vSrnIQSOm
         fvjumTs8+15sOMajx9qzDrIFroPxLvjWvUVWoG8vhm0NpJCQsoVkw+KVIHLWGwnsnh/4
         anfFq7ZbC6xaWisAb2v+CO5TZPO989D4A1d22ePTcIHlcIc/8cf4PQbpcY+f2B669pnC
         CgI9ChlflwV71lpyUcxfQ3r3BASwUK7RMM8Q+jMFA8c4Q5kwe3sKRvpKD1rLMhLJKEk8
         qvih+FjJqxB2jmoy/tjz66caNOcsQ//OlxAdn91M0eDrib4p6SfFnhI+b7WLloUgbOB3
         qvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698958492; x=1699563292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c63Npi10wJWosRhm9gjhF9hBJGybG/sFGWhVUImu6vc=;
        b=sIcaaYFjuWfjOA7wch2C5a/uAoWcEY5dsCYpV3Cu8DgPLdTKOGZRLfl3ze9QULlBgI
         ivC8A8hJkSz+EabmhIVrN/n+KEd8CcaTut+5ng6uB6igPtPijZmFDl2XT9hHYw8u9l0J
         /LgFe0MLz/sHVLsmJaV4XA/91lvOshJnEIHxgDWpYjWvE58aweDfjDw8Ca/vWXs9amaN
         8FT7w7kPp713YdQJqk3xqv8zka52xlHyhfexQasu2Om31t/ks//kZXO0dDmtEkNs9/TA
         bMK7ydmljtNneJsZuPX5WQZzSJA1FDPOUU9ewGD1tQnrSjLqFnAEZy2hNpIyMdRdLYmY
         5OuQ==
X-Gm-Message-State: AOJu0YyYqrCSdbpMlR9KtrsQHggraeedwgSsAmYewnaTxmNMnDZZYvsj
        WWkMKkrqneSjznf2P7p6QOxoy25jxdtS5xx6GwDIIQ==
X-Google-Smtp-Source: AGHT+IHLJLU+8CiChQllqKrDRluL6dH+cwOBHxVpM9opxi6ovqxvubfE++DRFh5SrqxT4kgbnkaxPOOFS6WfTLf12lE=
X-Received: by 2002:a17:906:7309:b0:9c8:f128:2fdb with SMTP id
 di9-20020a170906730900b009c8f1282fdbmr5328519ejc.13.1698958491500; Thu, 02
 Nov 2023 13:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231102200202.920461-1-nphamcs@gmail.com> <CAJD7tkY8iPBo99+1gdsSRMNDu4jkVKz8rb=W+xk9=GE0y=kSuw@mail.gmail.com>
 <20231102205022.GA3265934@cmpxchg.org>
In-Reply-To: <20231102205022.GA3265934@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 2 Nov 2023 13:54:12 -0700
Message-ID: <CAJD7tkacw52fwr6bUk5frepaRN071mmCeGke4s-jMwAXjKqSPg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] zswap: memcontrol: implement zswap writeback disabling
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        tj@kernel.org, lizefan.x@bytedance.com,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 1:50=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Thu, Nov 02, 2023 at 01:27:24PM -0700, Yosry Ahmed wrote:
> > On Thu, Nov 2, 2023 at 1:02=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> > > @@ -201,6 +201,12 @@ int swap_writepage(struct page *page, struct wri=
teback_control *wbc)
> > >                 folio_end_writeback(folio);
> > >                 return 0;
> > >         }
> > > +
> > > +       if (!mem_cgroup_zswap_writeback_enabled(folio_memcg(folio))) =
{
> > > +               folio_mark_dirty(folio);
> > > +               return AOP_WRITEPAGE_ACTIVATE;
> > > +       }
> > > +
> >
> > I am not a fan of this, because it will disable using disk swap if
> > "zswap_writeback" is disabled, even if zswap is disabled or the page
> > was never in zswap. The term zswap_writeback makes no sense here tbh.
> >
> > I am still hoping someone else will suggest better semantics, because
> > honestly I can't think of anything. Perhaps something like
> > memory.swap.zswap_only or memory.swap.types which accepts a string
> > (e.g. "zswap"/"all",..).
>
> I had suggested the writeback name.
>
> My thinking was this: from a user pov, the way zswap is presented and
> described, is a fast writeback cache that sits on top of swap. It's
> implemented as this lookaside thing right now, but that's never how it
> was sold. And frankly, that's not how it's expected to work, either.
>
> From the docs:
>
>   Zswap is a lightweight compressed cache for swap pages.
>
>   Zswap evicts pages from compressed cache on an LRU basis to the
>   backing swap device when the compressed pool reaches its size limit.
>
> When zswap is enabled, IO to the swap device is expected to come from
> zswap. Everything else would be a cache failure. There are a few cases
> now where zswap rejects and bypasses to swap. It's not a stretch to
> call them accelerated writeback or writethrough. But also, these
> represent failures and LRU inversions, we're working on fixing them.
>
> So from a user POV it's reasonable to say if I have zswap enabled and
> disable writeback, I don't expect swapfile IO.

Makes sense (although now you had me thinking whether
memory.zswap.writethrough is a better name).

>
> But yes, if zswap isn't enabled at all, this shouldn't prevent pages
> from going to swap.

Right, at least mem_cgroup_zswap_writeback_enabled() should always
return true if zswap is disabled.

One more unrelated thing,  I think we should drop the
cgroup_subsys_on_dfl() check there. I understand the interface is only
exposed in v2, but I don't see any reason why it wouldn't work in v1.
Let's not make it harder for anyone who tries to expose this in v1
(whether upstream or in an internal patch).
