Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6415D7C42BF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344152AbjJJVj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344145AbjJJVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:39:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE0498
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:39:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53b962f09e0so5664123a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696973987; x=1697578787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsPRHA98FhrwhRKg+R8NI3J52+4rr5kRhI+cS2n4Rj0=;
        b=Iqv56Z5QIP4quk2rUjGH3GUYXkDAXWLPNw6EpEiFKOYZJFlRp7K3EU5Ldnel5rFjFk
         ozBQCpENyiHY9c+0tu6m8ZjZ5L7mOW4qbRlO6mI4UvgLVwTHurchwyQeicYI1JSfTsKA
         igRbtbr2KOTcSVe5J1SSdMVz2RLH1ZYS7LciKzEhjRTluZK1yTPfRFoTFQhlw3/stLSI
         3tr/xAEyWf4yBto8996AYXqI0Ad0sDJNLEAnPEKTHX4taYuOeykta48lnlpfvA6785ax
         5uvgZDY4MC70z98GpxxFihEpx2WBQLEWnry/MKmKMW0swPtsAZR282UzAepTCEDO+/ky
         RTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696973987; x=1697578787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsPRHA98FhrwhRKg+R8NI3J52+4rr5kRhI+cS2n4Rj0=;
        b=SVfKM1n/hmEHe1EePNI9hFHUGdkV2KSC+ebpEANuaTYWIFaTrFEJrypVXcNRidh/OQ
         KczNmIjks2/nDaw9MwZ7XxVquyVNbHe/vnWzohIR9uC5sbj+UA7Fz2d3f2KXGL3bQlWl
         dXoXElwl/o63A4PIPbn4KLeYriAwGPNbpYyACZ/800jAdfpcU3uj75UmPTPwyHiVSGru
         FzQoZt3DdxLwzUgtpMFFuc/yuMH7QIjUcuaopxS+TJ8CGYAuOT5u6Bhe7XNbG6QYt9r4
         A924pMxF8Nksh7JxHLYR9GmEVnEq07nl6bhKorh8Nl0RGM1H9LtdndTF12MC7dxD8Ypa
         mAPA==
X-Gm-Message-State: AOJu0Yz+yvT6jgDbL2zOJoOX3CH7nHrAcchFVJ+8M86+58ATJCd0istM
        qYjSjc8jZBscWFIJC1EXlICyOxlA5IU=
X-Google-Smtp-Source: AGHT+IGGegVLPyhh3h38JMNISW7SFnz5Uc1hNzxwqw75DDhB58/1C33hiGKqcE2q8nY6tpDhfEn4Vg==
X-Received: by 2002:a05:6402:60c:b0:531:35c4:8ca2 with SMTP id n12-20020a056402060c00b0053135c48ca2mr13383464edv.42.1696973987200;
        Tue, 10 Oct 2023 14:39:47 -0700 (PDT)
Received: from gmail.com (1F2EF9FF.nat.pool.telekom.hu. [31.46.249.255])
        by smtp.gmail.com with ESMTPSA id y20-20020aa7d514000000b00537708be5c6sm8191442edq.73.2023.10.10.14.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:39:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 10 Oct 2023 23:39:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Raghavendra K T <raghavendra.kt@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 6/6] sched/numa: Complete scanning of inactive VMAs when
 there is no alternative
Message-ID: <ZSXEoLzHhwhO1t3k@gmail.com>
References: <20231010083143.19593-1-mgorman@techsingularity.net>
 <20231010083143.19593-7-mgorman@techsingularity.net>
 <ZSUX9NLa+DDjFLnZ@gmail.com>
 <20231010095752.yueqcseg7p3xg5ui@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010095752.yueqcseg7p3xg5ui@techsingularity.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@techsingularity.net> wrote:

> > 64 (BITS_PER_LONG) feels a bit small, especially on larger machines running 
> > threaded workloads, and the kmalloc of numab_state likely allocates a full 
> > cacheline anyway, so we could double the hash size from 8 bytes (2x1 longs) 
                                                            ^--- 16 bytes
> > to 32 bytes (2x2 longs) with very little real cost, and still have a long 
> > field left to spare?
> > 
> 
> You're right, we could and it's relatively cheap. I would worry that as 
> the storage overhead is per-VMA then workloads for large machines may 
> also have lots of VMAs that are not necessarily using threads.

So I think there would be *zero* extra per-vma storage overhead, because 
vma->numab_state is a pointer, with the structure kmalloc() allocated, 
which should round the allocation to cacheline granularity anyway: 64 bytes 
on NUMA systems that matter.

So with the current size of 'struct vma_numab_state' of 36 bytes, we can 
extend it by 16 bytes with zero additional storage cost.

And since there's no cost, and less hash collisions are always good, the 
change wouldn't need any other justification. :-)

[ Plus the resulting abstraction for the definition of a larger bitmask 
  would probably make future extensions easier. ]

But ... it was just a suggestion.

Thanks,

	Ingo
