Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C51B7DE593
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344667AbjKARoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjKARol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:44:41 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B6210E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:44:37 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7a68b87b265so230418139f.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698860675; x=1699465475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsnVrs+xNv4YSUuZr1i/w8nQzHDiyAXV+cc71MWu4hE=;
        b=O8+TwbgOAcCNgZTkXfCQWd+LCGarWSu+8PiE/RwG0Gmeu3yn7XM4vHndhnG3f410BH
         VKVdryyEbKF0+BPhJR3Fb3m2WnEqtZKgYwHphjOG3UNDQUvHKaUwxOGDI+hfHc69+SZY
         u54QWzKBeBfv61XNXuud1DcAtIQLkiuBWbVnQKWKWE49DY+yJncFRpPfFTkLy7H2wWx9
         2Wp1WsoEwBE6OSmCDbPN7/SrAM+geKduKuRI3cI7Lr5N9UZnmWFYMfnKHxptejEQ6d06
         n9BqnjDPRD/ErvitZNQpgLQmlnYEQgmwY5b/DqYj4y4sHfhos4+2ALuWSehgYoQMyjbS
         csPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698860675; x=1699465475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsnVrs+xNv4YSUuZr1i/w8nQzHDiyAXV+cc71MWu4hE=;
        b=gBdTqL5Viox6SZ1EnZoTPEyNv3M4FfGM+wq9Ddl5S7fMCmakBdsWxDb5rEh6TOZL83
         hAVJOEMwQR900xc7KJ7J4q6bw5+553pp3xR0UUW9loSHPASREXhYsPpbmeePO6twA6mN
         ejGcPKxaSgJZz8GXB/0xvfe5LwJTqxSEmTyaU3WVY/tT3xxVToGQRDCfoJ4FxFX57Ae3
         Rw+ZCI9OTgtCwwZNyCt+OooxOR2n15fJfw5pd/lHtUlmV2tI+qJZLwgx94NdoPkXV0iy
         szbmHVhRVpoUKFp6TTEhkNa7EzXXFwbyc2oOOnLlN+69yaXLrkefJicJMniDzlTrv4tt
         R+JQ==
X-Gm-Message-State: AOJu0YzaobU0A0BdH4lkt3MbbzfP2rDBcyYqvHOHmfSKeqvTgAQSv++D
        wfAAUDFp0yOkO56LaIxeYonxLo7Xdw+lV8/PRElJ71NShKmJMQ==
X-Google-Smtp-Source: AGHT+IEy9HFmOUO7eHQ+lgpM8WJTzxOVZ89EiemOtxM1+WutKjomhq5xBxoo9OJVYaxQ2+g28FNt+8N8zWizgz6mg/o=
X-Received: by 2002:a6b:7f48:0:b0:7a6:a3b1:b45c with SMTP id
 m8-20020a6b7f48000000b007a6a3b1b45cmr17207486ioq.14.1698860674977; Wed, 01
 Nov 2023 10:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231024203302.1920362-3-nphamcs@gmail.com> <20231101012614.186996-1-nphamcs@gmail.com>
 <B0D87683-DD13-4787-8188-98CEBF561B99@linux.dev>
In-Reply-To: <B0D87683-DD13-4787-8188-98CEBF561B99@linux.dev>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 1 Nov 2023 10:44:23 -0700
Message-ID: <CAKEwX=PmLSKpmv3zpGhka-JaJoTk7Se4bo6D8r5s6HhPmkpEng@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] zswap: make shrinking memcg-aware
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cerasuolodomenico@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Li <chrisl@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        kernel-team@meta.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 8:07=E2=80=AFPM Muchun Song <muchun.song@linux.dev>=
 wrote:
>
>
>
> > On Nov 1, 2023, at 09:26, Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > cc-ing Johannes, Roman, Shakeel, Muchun since you all know much more
> > about memory controller + list_lru reparenting logic than me.
> >
> > There seems to be a race between memcg offlining and zswap=E2=80=99s
> > cgroup-aware LRU implementation:
> >
> > CPU0                            CPU1
> > zswap_lru_add()                 mem_cgroup_css_offline()
> >    get_mem_cgroup_from_objcg()
> >                                    memcg_offline_kmem()
> >                                        memcg_reparent_objcgs()
> >                                        memcg_reparent_list_lrus()
> >                                            memcg_reparent_list_lru()
> >                                                memcg_reparent_list_lru_=
node()
> >    list_lru_add()
> >                                                memcg_list_lru_free()
> >
> >
> > Essentially: on CPU0, zswap gets the memcg from the entry's objcg
> > (before the objcgs are reparented). Then it performs list_lru_add()
> > after the list_lru entries reparenting (memcg_reparent_list_lru_node())
> > step. If the list_lru of the memcg being offlined has not been freed
> > (i.e before the memcg_list_lru_free() call), then the list_lru_add()
> > call would succeed - but the list will be freed soon after. The new
>
> No worries.  list_lru_add() will add the object to the lru list of
> the parent of the memcg being offlined, because the ->kmemcg_id of the
> memcg being offlined will be changed to its parent's ->kmemcg_id before m=
emcg_reparent_list_lru().
>

Ohhh that is subtle. Thanks for pointing this out, Muchun!

In that case, I think Yosry is right after all! We don't even need to get
a reference to the memcg:

rcu_read_lock();
memcg =3D obj_cgroup_memcg(objcg);
list_lru_add();
rcu_read_unlock();

As long as we're inside this rcu section, we're guaranteed to get
an un-freed memcg. Now it could be offlined etc., but as Muchun has
pointed out, the list_lru_add() call will still does the right thing - it w=
ill
either add the new entry to the parent list if this happens after the
kmemcg_id update, or the child list before the list_lru reparenting
action. Both of these scenarios are fine.

> Muchun,
> Thanks
>
> > zswap entry as a result will not be subjected to future reclaim
> > attempt. IOW, this list_lru_add() call is effectively swallowed. And
> > worse, there might be a crash when we invalidate the zswap_entry in the
> > future (which will perform a list_lru removal).
> >
> > Within get_mem_cgroup_from_objcg(), none of the following seem
> > sufficient to prevent this race:
> >
> >    1. Perform the objcg-to-memcg lookup inside a rcu_read_lock()
> >    section.
> >    2. Checking if the memcg is freed yet (with css_tryget()) (what
> >    we're currently doing in this patch series).
> >    3. Checking if the memcg is still online (with css_tryget_online())
> >    The memcg can still be offlined down the line.
> >
> >
> > I've discussed this privately with Johannes, and it seems like the
> > cleanest solution here is to move the reparenting logic down to release
> > stage. That way, when get_mem_cgroup_from_objcg() returns,
> > zswap_lru_add() is given an memcg that is reparenting-safe (until we
> > drop the obtained reference).
>
