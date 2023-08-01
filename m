Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A8176B5E6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjHANcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjHANcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:32:39 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6885B173F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:32:38 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63ce8bea776so31176266d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 06:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690896757; x=1691501557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iYKt01xNs8lKsq/e/azafAqVWryO+ACS/uiUEILtBaY=;
        b=KXZzpdfi6/4bWorYLvW0k2NQagRN1jBmK3wxldJ9gh8zvXztK8RdCu1tWfVjnLCZnx
         EqQhTIve89Mkr/R7dGqe3f1j4pW4DIxQMBmpKyWMapIqqyl1qSXIIBYwNowEpQJ5mJbg
         E5y5HCLjIjSaopyi/AmgfMNPSiXh8S9kKhdC6K+Uqeu9LOJSA4dFhyOELgbcM5rwMsNH
         OtVbW9O5XIZoi6QoI5iU7dhoDe3IugRppraE8q0Jb4oK60JQsdj4WDXLW/ApFe6G5d5x
         5JGXOpvzy0J7qkgpsj70a0NCZ4roZOitewX+SxRVZON7I1B6VUwNlg5sb2P8xTby1hf8
         VNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690896757; x=1691501557;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iYKt01xNs8lKsq/e/azafAqVWryO+ACS/uiUEILtBaY=;
        b=HzNRzed91aUOEpAMZqTlQoAKQzT4QkvHyk5Ug4cNYIJhAle/mvFpxb/sQNl/o2XIrx
         pVKcNd8xpLuPH67q54YlH1XY62Xn6bGOnwRLcQC9OxmVe5Oh5hmsoylyELFkd0yZOquV
         Kr1v+owXzzfqi0k1ko2fGDYDVhVhYGHcRxstvHxxnrc3qI/QoIc+/M8QEDQCws6oft2S
         QevqZuPiCNymZg3To7NoySfL2bwj+fFhwjp3Nnzl5xOGA5Qlsj7sVkjLttTj9S+a9emg
         C1bwrTI4C+NSOX/gMxc4cI48azVtVmCPuaUBsMGvuNN33zIDhOLRJwjQCTjBt7mWJ8Qu
         06zA==
X-Gm-Message-State: ABy/qLafSXwzjA6hN+18Khdqnyy4cF78knMSU83cTEP7RIopdtoxIQwK
        G5ZBUeV5LMbe5y7oA47HTrplEg==
X-Google-Smtp-Source: APBJJlE6OUTwslsBvWYdh6eMYGkPuBDQCm7yMaM4xkorOAUhCMJWW6NJ6LtUTBw76Jx9HymfsnU4xA==
X-Received: by 2002:a05:6214:5a13:b0:63c:da03:1c12 with SMTP id lu19-20020a0562145a1300b0063cda031c12mr11965162qvb.60.1690896757519;
        Tue, 01 Aug 2023 06:32:37 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id h18-20020a0cf212000000b0063007ccaf42sm4621429qvk.57.2023.08.01.06.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 06:32:37 -0700 (PDT)
Date:   Tue, 1 Aug 2023 09:32:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ramazan Safiullin <ram.safiullin2001@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add documentation to PSI section
Message-ID: <20230801133235.GA1766885@cmpxchg.org>
References: <20230728120909.234244-1-ram.safiullin2001@gmail.com>
 <CAJuCfpGyV5nM+4t_RTxDgvgZ_VhjpdoZ4TJZBn7RgxSHC6+Hyw@mail.gmail.com>
 <CAJuCfpEjozCfqfPPttcnWdzhQBCGnr+MzWGN8FT40YObZf_mGA@mail.gmail.com>
 <20230801103936.GA79828@hirez.programming.kicks-ass.net>
 <CAKXUXMwJk2bB-mPpeAj8dU3DVhdX-TRRV6eXSjMVO16Xsivj3g@mail.gmail.com>
 <20230801130301.GB11704@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230801130301.GB11704@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:03:01PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 01, 2023 at 01:07:09PM +0200, Lukas Bulwahn wrote:
> > On Tue, Aug 1, 2023 at 12:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Jul 31, 2023 at 04:12:00PM -0700, Suren Baghdasaryan wrote:
> > > > On Mon, Jul 31, 2023 at 4:10 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > > >
> > > > > On Fri, Jul 28, 2023 at 5:09 AM Ramazan Safiullin
> > > > > <ram.safiullin2001@gmail.com> wrote:
> > > > > >
> > > > > > While creating a patch for the psi documentation I noticed that
> > > > > > MAINTENERS was missing an entry in psi.
> > > > > >
> > > > > > Add entry for psi documentation.
> > > > > >
> > > > > > Signed-off-by: Ramazan Safiullin <ram.safiullin2001@gmail.com>
> > > > >
> > > > > Acked-by: Suren Baghdasaryan <surenb@google.com>
> > > >
> > > > CC'ing Peter to pick up into his tree.
> > >
> > > Well, I'd need the actual patch email, otherwise I can't apply. Either
> > > bounce the thread or have it be resent.
> > >
> > 
> > Speaking on behalf of Ramazan, who I am working with:
> > 
> > Suren, Peter, should we actually better just add you, Peter, as a
> > reviewer to PSI in MAINTAINERS, so that you get all the patches to psi
> > stuff in your mailbox and you just need to wait for an Ack from Suren
> > or Johannes?
> 
> Well, mostly psi patches touch kernel/sched/psi.c and then I should get
> it anyway (throught the kernel/sched/ glob). But sure, one more copy of
> my email address in that file isn't going to hurt..

From f00cd5986718e7ff435444523305d480b54e34e8 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Tue, 1 Aug 2023 09:18:21 -0400
Subject: [PATCH] MAINTAINERS: add Peter explicitly to the psi section

Peter is kind enough to route the low-volume psi patches through the
scheduler tree, but he is frequently not CC'd on them.

While he is matched through the SCHEDULER maintainers and reviewers on
kern/sched/*, that list is long, and mostly not applicable to psi
code. Thus, patch submitters often just CC the explicit PSI entries.

Add him to that section, to make sure he gets those patches.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..b68f3ab368c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17037,6 +17037,7 @@ F:	drivers/net/ppp/pptp.c
 PRESSURE STALL INFORMATION (PSI)
 M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Suren Baghdasaryan <surenb@google.com>
+R:	Peter Ziljstra <peterz@infradead.org>
 S:	Maintained
 F:	include/linux/psi*
 F:	kernel/sched/psi.c
-- 
2.41.0
