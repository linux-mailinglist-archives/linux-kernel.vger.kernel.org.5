Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682907B366D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjI2PMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjI2PMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:12:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9947D6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:12:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991c786369cso1827378866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696000354; x=1696605154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iwwlqvaBxCwMsikVRLEIWQ+fldLakckoypjf/711hA=;
        b=WLn70OIkQJ4NzM2XZdkBYl2Dm5pzEEW0+f8l3kQAoTtGd8Dt17uSrgo+uGDEpAcdyZ
         B9hX0h1kdCG9eNCFLztk2dL1uJw+YdRik2l8AvFqcUnWJeaOPBZMG4/iCIphOxqVt92p
         l8uDDXt8pfafAkhms1ULQoI110LXaBSui0FubtpWrd1PAya5oW7dC0rNPFza+Txsii6l
         4RlQ6xbghic9bBAw6grFGbVHzaYZ7MKzTpV3iTUqvHBy/JZk/x8I53zR9wD3r3Tp5Hx6
         YEi27K5FDKheHnjGLlLoMPbp+lnDf/FLdMY15XOTWWsCvQpS9nLKHXeewxQ0IWW62FsD
         HoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696000354; x=1696605154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iwwlqvaBxCwMsikVRLEIWQ+fldLakckoypjf/711hA=;
        b=OyjngFNzN5TUFkbx+FB3NvX2dC0E1NR91FtD4hQjmlUxLlWMCWteXHmnoUDlQqT6CL
         vPeCQUGyaBQMd7ZXjCUJjX6ezjmnAFsEGHqY/ZwWwj2GHqhhw6JEYMC+9SXs6enmsZRq
         wdgoE9ssFY/cExmAPO7aowKmRrjZSNEuK3S9OX/w3ePh/ZgSBP96MyGZYXNlPuQWNabc
         M1B5fKV7aHv9BOnWbDiwCqOFNMmuEQ9spOCrMmgQSGdH2D66TWVsgjFylS3PYBA1jg4a
         /ZBN/ELKrmwHRqDbIFyRb+Dw9BPDNjzk4BTHsgJCTz5vhyhF3O+d7wBU93tCtogwA/mf
         1HOA==
X-Gm-Message-State: AOJu0YzRVh4SnHZtHYikBt8Iy3vo3BbSwiZBnU8zhpbwsmslmoKcXN0j
        nKkTdMgdPCC+y82U1htjm2VH/Z1XHsVXqgCufoTYzQ==
X-Google-Smtp-Source: AGHT+IE9nhh5YAWBRdZlHuUBiW239B7WmIyskiK8JhYc35cNDZz3QR5wJYtEmks78PHXuV04TR5vMLHpPqOHtRE6jKo=
X-Received: by 2002:a17:906:51db:b0:9b2:abda:2543 with SMTP id
 v27-20020a17090651db00b009b2abda2543mr4673191ejk.65.1696000354025; Fri, 29
 Sep 2023 08:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230928005723.1709119-1-nphamcs@gmail.com> <20230928005723.1709119-2-nphamcs@gmail.com>
 <CAJD7tkanr99d_Y=LefQTFsykyiO5oZpPUC=suD3P-L5eS=0SXA@mail.gmail.com>
 <CAKEwX=M=8KYqvBTz9z1csrsFUpGf2tgWj-oyu96dSpRjn3ZnUQ@mail.gmail.com>
 <CAKEwX=Npb4mwZ2ibJkmD5GyqXazr7PH8UGLu+YSDY8acf152Eg@mail.gmail.com>
 <CAJD7tkaeDBTHC3UM91O56yrp8oCU-UBO6i_5HJMjVBDQAw0ipQ@mail.gmail.com> <20230929150829.GA16353@cmpxchg.org>
In-Reply-To: <20230929150829.GA16353@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 29 Sep 2023 08:11:54 -0700
Message-ID: <CAJD7tkZ1NiMMvQhxGSGzsPqYfBpwzP6svPe17s2FTDoHY6jYWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        riel@surriel.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev, tj@kernel.org,
        lizefan.x@bytedance.com, shuah@kernel.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 8:08=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Sep 28, 2023 at 06:18:19PM -0700, Yosry Ahmed wrote:
> > My concern is the scenario where the memory controller is mounted in
> > cgroup v1, and cgroup v2 is mounted with memory_hugetlb_accounting.
> >
> > In this case it seems like the current code will only check whether
> > memory_hugetlb_accounting was set on cgroup v2 or not, disregarding
> > the fact that cgroup v1 did not enable hugetlb accounting.
> >
> > I obviously prefer that any features are also added to cgroup v1,
> > because we still didn't make it to cgroup v2, especially when the
> > infrastructure is shared. On the other hand, I am pretty sure the
> > maintainers will not like what I am saying :)
>
> I have a weak preference.
>
> It's definitely a little weird that the v1 controller's behavior
> changes based on the v2 mount flag. And that if you want it as an
> otherwise exclusive v1 user, you'd have to mount a dummy v2.
>
> But I also don't see a scenario where it would hurt, or where there
> would be an unresolvable conflict between v1 and v2 in expressing
> desired behavior, since the memory controller is exclusive to one.
>
> While we could eliminate this quirk with a simple
> !cgroup_subsys_on_dfl(memory_cgrp_subsys) inside the charge function,
> it would seem almost punitive to add extra code just to take something
> away that isn't really a problem and could be useful to some people.
>
> If Tejun doesn't object, I'd say let's just keep implied v1 behavior.

I agree that adding extra code to take a feature away from v1 is
probably too much, but I also think relying on a v2 mount option is
weird. Would it be too much to just have a v1-specific flag as well
and use cgroup_subsys_on_dfl(memory_cgrp_subsys) to decide which flag
to read?
