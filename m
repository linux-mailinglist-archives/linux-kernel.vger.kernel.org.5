Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F697FEBE9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjK3Jei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3Jeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:34:36 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056C0D54
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:34:18 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bce42295eso490543e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701336855; x=1701941655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eIvDGUerrfda7PffkFuPcobBVIOmFzTvv07SzDnFxE=;
        b=f0K8D4b6Oe8iOmMUicT+5Lv91ypLRKyglr/Pzb7avwoiUeeCkjczQlgrFzZ/XAFEUg
         eQh2jlq+UR19sNECrQK1HQasRgZHvBpFaFMRPBySOzM4EjPiJA37j34bVlNCIsfDboSE
         10YgyhnL0w2u+rDqn4QocWquSeCJyvOfDQAm/KCRQzbTInSEFlltVT2+zU4ayaBxSVWs
         epNVPNHTtRESZlipG3S9DqKQvjX9t+GwcrAGv0/rYEF8D4W9L37SB/hvZwp9xXlWOqWD
         L5Famg7t7l2X+DbzGABtg78fiKeCIbKuNbDspI1nDNUXPgLTliwPi0xErbSTewndabNY
         Lg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701336855; x=1701941655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eIvDGUerrfda7PffkFuPcobBVIOmFzTvv07SzDnFxE=;
        b=spCa8f1d5dWNiJ95/S0fkM6AwA5H5d0kcccxKmxACh36XsW8JE40ioxp8Jd9pbUACg
         +vnAELL3KvtFM+2y98WBnjhZzDq0nl6YYIYGC5Kuwh/4e96kNW932IbsPyZhQglka66t
         IU2arbSSWI3l2aWRWD6WoOleNYm2RjAiE0iMtYi3uctBZOO9+BUG9TVm/cjKqYAVOzy5
         O8Yw77AwbUePT9uvOc579e9XKrltv9sNz0gImoPyfG36s3oXhHkknoc29y3N5Fpm/7tS
         oCy6Xhqe8gHkOi/h9PPD07o8yKx1GQneqvE7zLV8AcxXss8A5MIhdqMRaf3Cj8j9b2Dj
         14aA==
X-Gm-Message-State: AOJu0Yyl1tlWkYgqYkVRmCdNgjm0yVAPeoxeUaKPnsIp7tw3V53ZZTJ/
        mz02Tn2yQUwEkYPwo3rNHhhCDFdyVHBshFJLstYsEQ==
X-Google-Smtp-Source: AGHT+IGEdQGMBIjZ7uHMEFe3IpSrNio2BkAzOv5Ena+HIB7yN6xBdJSwPKwJFx2hI5uAUVFYg1O06Q8AZ2TzKuVz+uU=
X-Received: by 2002:a19:a40a:0:b0:50b:c7e3:a1e6 with SMTP id
 q10-20020a19a40a000000b0050bc7e3a1e6mr2293027lfc.44.1701336855608; Thu, 30
 Nov 2023 01:34:15 -0800 (PST)
MIME-Version: 1.0
References: <ZV5zGROLefrsEcHJ@r13-u19.micron.com> <CACSyD1OFjROw26+2ojG37eDBParVg721x1HCROMiF2pW2aHj8A@mail.gmail.com>
 <ZV/HSFMmv3xwkNPL@memverge.com>
In-Reply-To: <ZV/HSFMmv3xwkNPL@memverge.com>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
Date:   Thu, 30 Nov 2023 17:34:04 +0800
Message-ID: <CACSyD1MrCzyV-93Ov07NpV3Nm3u0fYExmD1ShE_e2tapW6a6HA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregory, sorry for the late reply.

I tried pidfd_set_mempolicy(suggested by michal) about a year ago.
There is a problem here that may need attention.

A mempolicy can be either associated with a process or with a VMA.
All vma manipulation is somewhat protected by a down_read on
mmap_lock.In process context(in alloc_pages()) there is no locking
because only the process accesses its own state.

Now  we need to change the process context mempolicy specified
in pidfd. the mempolicy may about to be freed by
pidfd_set_mempolicy() while alloc_pages() is using it,
The race condition appears.

Say something like the following=EF=BC=9A

pidfd_set_mempolicy()        target task stack:
                                               alloc_pages:
                                             mpol =3D p->mempolicy;
  task_lock(task);
  old =3D task->mempolicy;
  task->mempolicy =3D new;
  task_unlock(task);
  mpol_put(old);
                                           /*old mpol has been freed.*/
                                           policy_node(...., mpol)
                                          __alloc_pages();

To reduce the use of locks and atomic operations(mpol_get/put)
in the hot path, there are no references or lock protections here
for task mempolicy.

It would be great if your refactoring has a good solution.

Thanks.

On Sat, Nov 25, 2023 at 4:09=E2=80=AFAM Gregory Price
<gregory.price@memverge.com> wrote:
>
> On Fri, Nov 24, 2023 at 04:13:41PM +0800, Zhongkun He wrote:
> >
> > Per my understanding,  the process_mbind() is implementable without
> > many difficult challenges=EF=BC=8C
> > since it is always protected by mm->mmap_lock. But task mempolicy does
> > not acquire any lock
> > in alloc_pages().
>
> per-vma policies are protected by the mmap lock, while the task
> mempolicy is protected by the task lock on replacement, and
> task->mems_allowed (protected by task_lock).
>
> There is an update in my refactor tickets that enforces the acquisition
> of task_lock on mpol_set_nodemask, which prevents the need for
> alloc_pages to do anything else.  That's not present in this patch.
>
> Basically mems_allowed deals with the majority of situations, and
> mmap_lock deals with per-vma mempolicy changes and migrations.
>
> ~Gregory
