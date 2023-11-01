Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169897DE183
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbjKANdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344315AbjKANdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:33:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50064F4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:33:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cacde97002so51335165ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698845617; x=1699450417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ppla82jXl+t7SLtnqV4J5gUeWoqBYeNU2h7XlmpBP+Q=;
        b=d59Sh70haFeyj89SSq4B971tZM5qKGWftSazri2Z7fAEtyWeHnQH0k3HnR7LqQC+jt
         gzM7PC+FB2dQJBSEeHx0z11bgDJtRm/IqVw7ss/ovcYefO0Mz7uSU4ca+ewGl0jxWNgU
         zUPTZ3xxVL2iU5LHYwLtYVnvdAFaNw0DnTh/fBhv10apAyYDuRNJfZfYQcVvjoMBcPAL
         7MB65L7M5csjbzgTKZvCelJbPQjMOIpYcGw4emc3KWhy2ibVBLs+5aZuGuWu2vROzesi
         NZWAtPdU32xvBJS6uOQaaFnrBwSfIZqAnW/VlBS2ZPoMivj7O+6jHviPn8itdi5C1ARm
         Hp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698845617; x=1699450417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppla82jXl+t7SLtnqV4J5gUeWoqBYeNU2h7XlmpBP+Q=;
        b=m2bnHNxy1zki5VSasWl6Wer35jC4UoFETglYiLsLJYBTZp0zilcihhOWnq6l5zd8AR
         NPq9TQCsk912HDZsqwUG6cz2WIw2/5o7TEDat23Bf33QG+f7BDuO7+MSkI2GcfABo9Mg
         ConhDQfII0UabvFnG1Mn1+l75F6m9LLjf14qhVueR6HE607nU3gvfcgog/s4/GjpGesz
         TOxlQJhB2+xvjcYYAgaPfqQwnxDhIWdgShat11JQZ5wfeo/bIxmbKAYmPehdwLBajXmm
         khRgSkqL05hczxSK3cJW/qC4Mb2enYuvyx/qwznkK49uz1K8SXW0C/8tFjM4Jejs/AXk
         bo8Q==
X-Gm-Message-State: AOJu0YwUf94vXdhcRJrOpxP0g0WzifvhMfPbLQq2TjBmf/99ekGzJHMn
        FG9KK5O6+MWnTjn0IdY2fRo=
X-Google-Smtp-Source: AGHT+IGTvl/hR/hWdrmGmksscbujB9udae+yOgkkEeiomkqbrTUOFDLrbrF54stNHBPGVdbvIPx+GA==
X-Received: by 2002:a17:902:6acb:b0:1ca:2c3b:7747 with SMTP id i11-20020a1709026acb00b001ca2c3b7747mr11968247plt.20.1698845616441;
        Wed, 01 Nov 2023 06:33:36 -0700 (PDT)
Received: from fedora ([1.245.179.104])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902f1d300b001bbb25dd3a7sm1348539plc.187.2023.11.01.06.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 06:33:35 -0700 (PDT)
Date:   Wed, 1 Nov 2023 22:33:29 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     chengming.zhou@linux.dev
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        willy@infradead.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [RFC PATCH v4 0/9] slub: Delay freezing of CPU partial slabs
Message-ID: <ZUJTiGgWrkYQPwaf@fedora>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031140741.79387-1-chengming.zhou@linux.dev>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 02:07:32PM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Changes in RFC v4:
>  - Reorder patches to put the two cleanup patches to the front.
>  - Move slab_node_partial flag functions to mm/slub.c.
>  - Fix freeze_slab() by using slab_update_freelist().
>  - Fix build error when !CONFIG_SLUB_CPU_PARTIAL.
>  - Add a patch to rename all *unfreeze_partials* functions.
>  - Add a patch to update inconsistent documentations in the source.
>  - Some comments and changelog improvements.
>  - Add Reviewed-by and Suggested-by tags. Many thanks!
>  - RFC v3: https://lore.kernel.org/all/20231024093345.3676493-1-chengming.zhou@linux.dev/

Hi,
This series passed (yeah, v3 was broken as reported by the bot)
hackbench + a set of MM tests on 30 different SLUB configs [1] [2]

For the series, feel free to add:
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

[1] https://jenkins.kerneltesting.org/job/slab-experimental/21/
[2] https://lava.kerneltesting.org/scheduler/alljobs

-- 
Hyeonggon
