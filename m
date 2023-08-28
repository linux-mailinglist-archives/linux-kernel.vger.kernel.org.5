Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26D078B672
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjH1RaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjH1R3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:29:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F81419A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:29:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98377c5d53eso445843366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693243761; x=1693848561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GK5Myctzb4HCvCqui3EYmx9STCukfjOIgPFjIqcI5UM=;
        b=hgb9hJyvPYXJPFVPXQqoDWYVcBGpnGf2FfMAOzQMsAjShJbPiYdKARkA/T4RsZyIiW
         DkLK54mV+iphr8e0TC+RidGAq3nyCQtFP1jkkeZ5QS1GkcHP7JCWL2isYlIBj8q9gwJ/
         tFwTFkCvysffsiw2k8NhzcxM8PGuuMnaMcSJ1LnpxpFd6DpCZXLUq1QjT1NYN2IKDCwO
         fyyKyjgCPP48aYY7Ct4QuKsTtvFQItIJDW+Kp80EyaAenhkpa0VtBX7iQGK346tsXq7t
         zbzjBwftI8myJAR8xiT43UZul7aJsbYAQgQudc0Sz5PBDSRBxytVH35F+CmNNr/5wNPp
         7/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693243761; x=1693848561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GK5Myctzb4HCvCqui3EYmx9STCukfjOIgPFjIqcI5UM=;
        b=l6Mz+xuRKBsNGwXP8OszUKDgDq5kSN+fwgV0440mNndNUtHquBo0ZUq1T1dhdQEj8o
         wMw8Be6Y+TwBYzDbKph8JPvR7myl6kfJRUrvTDMDen0yIOlkEF4eQgYTyfBRC49qMSyS
         8L90KNIqdzWJPdMo9jo11DCPbZW5TYJfUnc1wECzzY9UngLKbu7e4HcCUtokOuuvGHXw
         hkT4XZAhh1AyrMUGynFOQN+eZxBq9RzwOUZbjuyUBP/7OgRW7UwrQ9AbUkHYIOutt0y4
         PrxQ/M5acS+/sn17DLcGCw9acUjPjeKSw8/X/51K6puBJvb+pSfb5gNAXiYOrxvYW9lC
         5RPw==
X-Gm-Message-State: AOJu0YwhjWga7QRzSjaEy4scGhxt51mhPB8xfykxQK/xUoj/nRW6EvT0
        5ncnt9IkLml0wRWNI0jJhOG1F5TU3LIJ71caH/WrSQ==
X-Google-Smtp-Source: AGHT+IF7p8K/15NW6DWBo5dN4NE6PUk/BmthEXsve98YJTlNw5JJgf2XsjAOD1w+LBXrdgb6cSqz0ymGya0/FKC+1xY=
X-Received: by 2002:a17:906:3d29:b0:992:bc8:58e4 with SMTP id
 l9-20020a1709063d2900b009920bc858e4mr20462536ejf.20.1693243760628; Mon, 28
 Aug 2023 10:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230821205458.1764662-4-yosryahmed@google.com>
 <ZOR6eyYfJYlxdMet@dhcp22.suse.cz> <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz> <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz> <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz> <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
 <ZOzBgfzlGdrPD4gk@dhcp22.suse.cz> <CAJD7tkakMcaR_6NygEXCt6GF8TOuzYAUQe1im+vu2F3G4jtz=w@mail.gmail.com>
 <CALvZod7uxDd3Lrd3VwTTC-SDvqhdj2Ly-dYVswO=TBM=XTnkcg@mail.gmail.com>
 <CAJD7tkbnvMCNfQwY_dmVe2SWR5NeN+3RzFhsVyimM1ATaX0D5A@mail.gmail.com> <599b167c-deaf-4b92-aa8b-5767b8608483@redhat.com>
In-Reply-To: <599b167c-deaf-4b92-aa8b-5767b8608483@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 28 Aug 2023 10:28:44 -0700
Message-ID: <CAJD7tkZsGfYXkWM5aa67v3JytTO04LS7_x+ooMDK82cBZ-C8eQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Waiman Long <longman@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Aug 28, 2023 at 10:27=E2=80=AFAM Waiman Long <longman@redhat.com> w=
rote:
>
>
> On 8/28/23 13:07, Yosry Ahmed wrote:
> >
> >> Here I agree with you. Let's go with the approach which is easy to
> >> undo for now. Though I prefer the new explicit interface for flushing,
> >> that step would be very hard to undo. Let's reevaluate if the proposed
> >> approach shows negative impact on production traffic and I think
> >> Cloudflare folks can give us the results soon.
> > Do you prefer we also switch to using a mutex (with preemption
> > disabled) to avoid the scenario Michal described where flushers give
> > up the lock and sleep resulting in an unbounded wait time in the worst
> > case?
>
> Locking with mutex with preemption disabled is an oxymoron. Use spinlock
> if you want to have preemption disabled. The purpose of usiing mutex is
> to allow the lock owner to sleep, but you can't sleep with preemption
> disabled. You need to enable preemption first. You can disable
> preemption for a short time in a non-sleeping section of the lock
> critical section, but I would not recommend disabling preemption for the
> whole critical section.

I thought using a mutex with preemption disabled would at least allow
waiters to sleep rather than spin, is this not correct (or doesn't
matter) ?

>
> Cheers,
> Longman
>
