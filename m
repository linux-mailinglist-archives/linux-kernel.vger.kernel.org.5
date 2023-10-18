Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE87CE130
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjJRP3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjJRP33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:29:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363B8F7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:29:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9c145bb5bso164925ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697642966; x=1698247766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvT/F9M12lZm/f3D1aGMmIgwqCpKkP/1Cg2t3T9TAg4=;
        b=z6aYIKakDK0zZ+my+nT/6QBknKhZPN6T7+WGlks0Yh69R2SCffuYOlDTeuSRSYrDmM
         1qkxjGfIL2R3BWMHRkl8R/ACth44bf/D5tE4gGfuuJhAcAgnE0Uvp3yVYI27CnLFFBGO
         NF5ZXmTNgrhsb0Wa6ZLzuiLYYEcuDenQlY7OQbT0fbpXO/p753QpVeW1sc0DHNWVAFrb
         UfHx7yWkcX44elcSFAoSnY7xkKF1WkxFHt0IhrR2Dndx+6emfK5bFePHJm/TC1kBM3uW
         tJmAJKrk4XzFKd5Sr/Oixb7gaogrmaP5M7mv0rCZjm7u40UAifd6yJ0jtxereoe0LK/m
         viWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697642966; x=1698247766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nvT/F9M12lZm/f3D1aGMmIgwqCpKkP/1Cg2t3T9TAg4=;
        b=guKTco6qL1njFXq2KE7h6FIIfqMw0SkAdiplBsafaLXvTdFrh/YI4Evw2ZYX7jLa4c
         yO+sNgwJ0wUgjnXXw/7hQ87HPe2fQ/WBIOMwIAwzsLlkZk8NH8mu6A9iyQRo6fA+gZER
         sqCaOSPv/m6usntj5jYrmd5n4kRbSej2zj5NqXw0D9gPEbdyc5AaO7au4YH2aps8sQF+
         +JboEGery+zp3zqgvJ2BSntGTq1Iw/+HEfi9Yjzj8nnjFoITkRA4AWbx7GvFHl4NdKS7
         3h1hJ+wXfRmoS6KC8gJfe5vevYO11Q+csRfMKMPES2yRvydsuKNWbmXN38+ozXQI7cNZ
         1rnw==
X-Gm-Message-State: AOJu0YxnaAGJOHTOr4OOr8Zx7fNcTrmPZl06qmQCccVizW52eagIqZ+T
        HlFH1aviWQGjw9BBcTZa+ElWgAe8XpoX6P7x3kpplw==
X-Google-Smtp-Source: AGHT+IF5hViTClBnqdxspegkUBq7qYbfY2Qcm/p4LWyxEptN20AcF3AhGkl61K5wm8lJmebJ8cI2NX4VWFszp3sJFL4=
X-Received: by 2002:a17:903:1446:b0:1c6:112f:5ceb with SMTP id
 lq6-20020a170903144600b001c6112f5cebmr205416plb.25.1697642966371; Wed, 18 Oct
 2023 08:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231016221900.4031141-1-roman.gushchin@linux.dev>
 <20231016221900.4031141-3-roman.gushchin@linux.dev> <d698b8d0-1697-e336-bccb-592e633e8b98@suse.cz>
In-Reply-To: <d698b8d0-1697-e336-bccb-592e633e8b98@suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 18 Oct 2023 08:29:14 -0700
Message-ID: <CALvZod5bxWQ8nwxyxv=ySN-75FEgtCKWussyNyFeDadURQ2XYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm: kmem: add direct objcg pointer to task_struct
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 2:52=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
[...]
> >
> > +static struct obj_cgroup *current_objcg_update(void)
> > +{
> > +     struct mem_cgroup *memcg;
> > +     struct obj_cgroup *old, *objcg =3D NULL;
> > +
> > +     do {
> > +             /* Atomically drop the update bit. */
> > +             old =3D xchg(&current->objcg, NULL);
> > +             if (old) {
> > +                     old =3D (struct obj_cgroup *)
> > +                             ((unsigned long)old & ~CURRENT_OBJCG_UPDA=
TE_FLAG);
> > +                     if (old)
> > +                             obj_cgroup_put(old);
> > +
> > +                     old =3D NULL;
> > +             }
> > +
> > +             /* Obtain the new objcg pointer. */
> > +             rcu_read_lock();
> > +             memcg =3D mem_cgroup_from_task(current);
> > +             /*
> > +              * The current task can be asynchronously moved to anothe=
r
> > +              * memcg and the previous memcg can be offlined. So let's
> > +              * get the memcg pointer and try get a reference to objcg
> > +              * under a rcu read lock.
> > +              */
> > +             for (; memcg !=3D root_mem_cgroup; memcg =3D parent_mem_c=
group(memcg)) {
> > +                     objcg =3D rcu_dereference(memcg->objcg);
> > +                     if (likely(objcg && obj_cgroup_tryget(objcg)))
>
> So IIUC here we increase objcg refcount.
>
> > +                             break;
> > +                     objcg =3D NULL;
> > +             }
> > +             rcu_read_unlock();
> > +
> > +             /*
> > +              * Try set up a new objcg pointer atomically. If it
> > +              * fails, it means the update flag was set concurrently, =
so
> > +              * the whole procedure should be repeated.
> > +              */
> > +     } while (!try_cmpxchg(&current->objcg, &old, objcg));
>
> And if this fails we throw objcg away and try again, but we should do
> obj_cgroup_put(objcg) first, as otherwise it would cause a leak?
>

Indeed there is a reference leak here.
