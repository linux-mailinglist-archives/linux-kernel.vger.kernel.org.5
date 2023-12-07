Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC3F807DE8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442036AbjLGBaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjLGBax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:30:53 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11966CA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 17:30:59 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-423f28ae2d0so78751cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 17:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701912658; x=1702517458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2zo2U+sNI4+OgaTjf0Valql9hDrUGd6ADOT6fl9bdQ=;
        b=A3DEEADx8FbmpvN2b+z+eAvQw3wbeYnoqPIhaO1uT2AIsKQIiiWz+B5A8EGUroU3RI
         QQ39JIH3hDo4pbhXmOdNc4ZEppczJr24T/Mh/+bM9asw1a/jHeg7C61jM4bEUmmzfN+Z
         xtzkXvX583x38yiofMlJZY1YXydFzpAvzeE3QGSLmc/vYWUuhJCdo+tQrfnX3f4DUYEe
         eZKM8h/Z+tlGMmWfb9QWRKPWsgCpuFsBerS39MGxtWg7skQ+ga5cyaggEcDxCWzQQkz7
         AM6h833XIwY/QhvCE4QXovBVLpOzVPUXOZn+6IJ1Hyz/Z2uorPGJ//TnRC1Xxi523Mqr
         NR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701912658; x=1702517458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2zo2U+sNI4+OgaTjf0Valql9hDrUGd6ADOT6fl9bdQ=;
        b=gFoRydVv9msrOnsIie/uvvMaY63umicqj+Hr3T/NLzvWzNxbG6RMu0xT7axeSG90zx
         GZhz0Su9UiH7/uwJ5nrPx7Gk1Mncn0kgDsIchBhYbom5YsxFB4STcbpe5M+Kb/D+wK+C
         n/pqQ71B4i1KtDrRM6svfmi3yaKgyyaUcZlc0KFjyktkCDpYZqMZmed9Flda4FGrg9ds
         /85+1sNkIV/gGEb45LHacFaQsWVEU3Fo2GNGyOsjzxyHCZ+Vl20w4aQT5sMSRUcvPvlZ
         AIMWhng95DfuY7qM0836dNF/2lw+Cd8so+xNGaDLhTpDQdvgGCNtZX+DoSvMtFtdq0aj
         ERgw==
X-Gm-Message-State: AOJu0YxHjlwl9oWXRTWf/oV0JAy3y2xtRz1AtC2mPT1po9dRLkAdq1Ey
        gWf5gNq5wfap1L0HYQI3x3xClVF3kYPi+YtIObDJVL0YYBZiDEy+Gmr77g==
X-Google-Smtp-Source: AGHT+IHL8E/hDTudTK8Hyu22QQModhzXxymgzYmfFYZyb8GWrpnpPUX7eVad5IWdC7skobooAJrUoQ17vEC3gBx1osc=
X-Received: by 2002:ac8:4255:0:b0:425:75cf:90e9 with SMTP id
 r21-20020ac84255000000b0042575cf90e9mr382422qtm.22.1701912657893; Wed, 06 Dec
 2023 17:30:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701853894.git.henry.hj@antgroup.com> <951fb7edab535cf522def4f5f2613947ed7b7d28.1701853894.git.henry.hj@antgroup.com>
In-Reply-To: <951fb7edab535cf522def4f5f2613947ed7b7d28.1701853894.git.henry.hj@antgroup.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 6 Dec 2023 18:30:20 -0700
Message-ID: <CAOUHufZeADNp_y=Ng+acmMMgnTR=ZGFZ7z-m6O47O=CmJauWjw@mail.gmail.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
To:     Henry Huang <henry.hj@antgroup.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>,
        =?UTF-8?B?5pyx6L6JKOiMtuawtCk=?= <teawater@antgroup.com>,
        akpm@linux-foundation.org
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

On Wed, Dec 6, 2023 at 5:51=E2=80=AFAM Henry Huang <henry.hj@antgroup.com> =
wrote:
>
> Multi-Gen LRU page-table walker clears pte young flag, but it doesn't
> clear page idle flag. When we use /sys/kernel/mm/page_idle/bitmap to chec=
k
> whether one page is accessed, it would tell us this page is idle,
> but actually this page has been accessed.
>
> For those unmapped filecache pages, page idle flag would not been
> cleared in folio_mark_accessed if Multi-Gen LRU is enabled.
> So we couln't use /sys/kernel/mm/page_idle/bitmap to check whether
> a filecache page is read or written.
>
> What's more, /sys/kernel/mm/page_idle/bitmap also clears pte young flag.
> If one page is accessed, it would set page young flag. Multi-Gen LRU
> page-table walker should check both page&pte young flags.
>
> how-to-reproduce-problem
>
> idle_page_track
>    a tools to track process accessed memory during a specific time
> usage
>    idle_page_track $pid $time
> how-it-works
>    1. scan process vma from /proc/$pid/maps
>    2. vfn --> pfn from /proc/$pid/pagemap
>    3. write /sys/kernel/mm/page_idle/bitmap to
>       mark phy page idle flag and clear pte young flag
>    4. sleep $time
>    5. read /sys/kernel/mm/page_idle/bitmap to
>       test_and_clear pte young flag and
>       return whether phy page is accessed
>
> test ---- test program
>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <fcntl.h>
>
>  int main(int argc, const char *argv[])
>  {
>      char *buf =3D NULL;
>      char pipe_info[4096];
>      int n;
>      int fd =3D -1;
>
>      buf =3D malloc(1024*1024*1024UL);
>      memset(buf, 0, 1024*1024*1024UL);
>      fd =3D open("access.pipe", O_RDONLY);
>      if (fd < 0)
>          goto out;
>      while (1) {
>          n =3D read(fd, pipe_info, sizeof(pipe_info));
>          if (!n) {
>              sleep(1);
>              continue;
>          } else if (n < 0) {
>              break;
>          }
>          memset(buf, 0, 1024*1024*1024UL);
>          puts("finish access");
>       }
>  out:
>      if (fd >=3D0)
>          close(fd);
>      if (buf)
>          free(buf);
>
>      return 0;
>  }
>
> prepare:
> mkfifo access.pipe
> ./test
> ps -ef | grep test
> root       4106   3148  8 06:47 pts/0    00:00:01 ./test
>
> We use /sys/kernel/debug/lru_gen to simulate mglru page-table scan.
>
> case 1: mglru walker break page_idle
> ./idle_page_track 4106 60 &
> sleep 5; echo 1 > access.pipe
> sleep 5;  echo '+ 8 0 6 1 1' > /sys/kernel/debug/lru_gen
>
> the output of idle_page_track is:
> Est(s)     Ref(MB)
> 64.822        1.00
> only found 1MB were accessed during 64.822s, but actually 1024MB were
> accessed.
>
> case 2: page_idle break mglru walker
> echo 1 > access.pipe
> ./idle_page_track 4106 10
> echo '+ 8 0 7 1 1' > /sys/kernel/debug/lru_gen
> lru gen status:
> memcg     8     /user.slice
>  node     0
>           5     772458       1065        9735
>           6     737435     262244          72
>           7     538053       1184         632
>           8      59404       6422           0
> almost pages should be in max_seq-1 queue, but actually not.
>
> Signed-off-by: Henry Huang <henry.hj@antgroup.com>

It's never intended for MGLRU to support page_idle/bitmap or
PG_idle/young because:
1. page_idle/bitmap isn't a capable interface at all -- yes, Google
proposed the idea [1], but we don't really use it anymore because of
its poor scalability.
2. PG_idle/young, being a boolean value, has poor granularity. If
anyone must use page_idle/bitmap for some specific reason, I'd
recommend exporting generation numbers instead.

[1] https://lore.kernel.org/cover.1426706637.git.vdavydov@parallels.com/
