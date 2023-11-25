Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416687F8CE7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjKYRrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjKYRrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:47:39 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3531C133
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:47:45 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5be3799791fso3640158a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700934464; x=1701539264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9pQvrE1VjbnX/y6ByGIqcRM35RSO1PuZh7mCElTQgyQ=;
        b=k1hQ6ZJB1bmgJmzfADagmXFnKtyI3Fwya/qNFf4Gc8YrLkkmHr0Rxm31cII4p8d4li
         loEQpBJs/RAXM2iJJI09Pl+VKEHeSD9G68EjF8UZAwQb0MoCxr94pVXiW3hWkwE+8g2A
         oR+zKUeUcuaPnsCgzJEMDJEqBvu67m9qF3j7KwAbT5l80gc0GcgVwo/bTrGO6EIh+uUN
         FCuUcTvY1Pnh4lqFy6eDHiF5lfwFPn82iHpHeboLDXv1xlLcrYKJ3wUGRDp05gvZ4h3P
         Pa/5O6yDWC0ebIt8htKbVbcJAnC4In3OH+xGnIOgtKWun5hqTKQ5ASAKmFDIoSFqX3M9
         uFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700934464; x=1701539264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pQvrE1VjbnX/y6ByGIqcRM35RSO1PuZh7mCElTQgyQ=;
        b=bQ49PseHbLjaw4uTfpFbwI5nKfisFGCtJ8x86sm2Xe+VZMnJfATFox4USk1zJiCYm2
         /MGmEXyxiUqq1GSmtGv7fS72lVnPVh3G/26DBEuRfWIUTrNBXw2A+7OkrLEjbQYNfKox
         JHmaI5lhWZ/lYyKypGg+jLzdp+8R18HqFh7Ms0OD0+2y5k/wFylwAkydGVtz4cTa0zU2
         HB520R6P77CP8iVyCBthTxj5A0ZeBkje1RkwIkYyc1thS6DcUSkGQnCNZ4uEXfYuTV5v
         f2fAOxAka866Sj0B+OXLww2W2j2r0V51qvDw4lO76EqRiwmOELx7mOZSrOJ908EBlXZu
         V2Pw==
X-Gm-Message-State: AOJu0YxLFv/Br65aiwTWz7sxldnRkZtodDMhwA18Mnqb+lb4dNd5cNw1
        invtw92rMMm2c/sQgoQWoIYbo4WrdxVefw==
X-Google-Smtp-Source: AGHT+IFflWgX+Gg7h8fTMTF6SpzYKnQOYwGbJCZ4v+j1BmllVH1kpuMX3VxlWRmMPr/i4NyYau2+euR5tvKkyw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:d209:0:b0:5be:1194:9c0b with SMTP id
 a9-20020a63d209000000b005be11949c0bmr1039251pgg.3.1700934464725; Sat, 25 Nov
 2023 09:47:44 -0800 (PST)
Date:   Sat, 25 Nov 2023 17:47:42 +0000
In-Reply-To: <20231123193937.11628-3-ddrokosov@salutedevices.com>
Mime-Version: 1.0
References: <20231123193937.11628-1-ddrokosov@salutedevices.com> <20231123193937.11628-3-ddrokosov@salutedevices.com>
Message-ID: <20231125174742.n3ybfum53yd27bo7@google.com>
Subject: Re: [PATCH v3 2/2] mm: memcg: introduce new event to trace shrink_memcg
From:   Shakeel Butt <shakeelb@google.com>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        mhocko@suse.com, akpm@linux-foundation.org, kernel@sberdevices.ru,
        rockosov@gmail.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 10:39:37PM +0300, Dmitry Rokosov wrote:
> The shrink_memcg flow plays a crucial role in memcg reclamation.
> Currently, it is not possible to trace this point from non-direct
> reclaim paths. However, direct reclaim has its own tracepoint, so there
> is no issue there. In certain cases, when debugging memcg pressure,
> developers may need to identify all potential requests for memcg
> reclamation including kswapd(). The patchset introduces the tracepoints
> mm_vmscan_memcg_shrink_{begin|end}() to address this problem.
> 
> Example of output in the kswapd context (non-direct reclaim):
>     kswapd0-39      [001] .....   240.356378: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356396: mm_vmscan_memcg_shrink_end: nr_reclaimed=0 memcg=16
>     kswapd0-39      [001] .....   240.356420: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356454: mm_vmscan_memcg_shrink_end: nr_reclaimed=1 memcg=16
>     kswapd0-39      [001] .....   240.356479: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356506: mm_vmscan_memcg_shrink_end: nr_reclaimed=4 memcg=16
>     kswapd0-39      [001] .....   240.356525: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356593: mm_vmscan_memcg_shrink_end: nr_reclaimed=11 memcg=16
>     kswapd0-39      [001] .....   240.356614: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.356738: mm_vmscan_memcg_shrink_end: nr_reclaimed=25 memcg=16
>     kswapd0-39      [001] .....   240.356790: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
>     kswapd0-39      [001] .....   240.357125: mm_vmscan_memcg_shrink_end: nr_reclaimed=53 memcg=16
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
