Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36E57BB5C4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjJFLBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjJFLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:01:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC1AC5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:01:11 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9936b3d0286so365129866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 04:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696590070; x=1697194870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54GkJ799T1y0yQUmcVNhrGWVDiHwsfgV5Ye0eDD6kMM=;
        b=L5URv1hxGhe+vr9xPGmasb2vDF52hAG8J6qzKAIatXBelzL3M2yt2WEg2KkSjlZvYm
         kI+OBWfaClkHQhoekVyRpXvp2tNt6ka3P2peqi24EpQwpdSW1LoehGxE60NyTL2v59hB
         Gd9zthQBFnaBhlBdpNGWe+S6GUxRtc2rQaU8U9iBV6lkVmai/SUiiARonHTwaAU7Xbod
         hVEaoAUMEBZxTx+fDMniz9CaNqgZyQY4T5fEqO+W21TRQlh508T5eaCGNzVRh/a1SKuW
         YhHVi40nJ3V0bamhisPix5L+s+GG2PFFD+xr56Uj6kuA50P4FaGcyzd5O7WZaDs/UhD0
         q5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696590070; x=1697194870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=54GkJ799T1y0yQUmcVNhrGWVDiHwsfgV5Ye0eDD6kMM=;
        b=I0xaFDJoYoJkZDo8OKLOKuPqlD/pGcTopFrhHMuJzDnjg48Tm7oi/KAe2Ed1r+b+hU
         qH9pJHZ7Bc2/Q5BZ+4bQASGl78WkAdGkBtapW4Ixa6J/9ygpNVzEeBVa+ea21g68rqx/
         +LOTKmMF47xJW+oXRHk61k7jFdi3RYjx2doqG3o/3k1GiFPc2963mnqH0BzzyFRPG+7D
         0R1WsN3BFjSU/w2ZJIN7bWlmbQEiFENyMqFZf9feKmupK42iQGPb7dFc7bXcANdL8fjd
         EwzkExMIQQ1zi3QwLHynDTfUrkeBz+w3koCu2Xadr03hWEfEhVFjnQLIQ6MXKn1NbtA8
         mDxw==
X-Gm-Message-State: AOJu0YwGRSQTQ+HN0mIZtxLkDM8f47tq/6M/Kqp47C4UsuF2YVBRWmhL
        1eUs2YVe53m1ei0EiB7lJVg=
X-Google-Smtp-Source: AGHT+IEzctO4NB8thofuFABzr3/LWrWW5+fSf5Jn5YY19q6Ys1j2Yfhhr7kGjGjDYKjLNqxKVgbXCA==
X-Received: by 2002:a17:906:5357:b0:9ae:7681:f62a with SMTP id j23-20020a170906535700b009ae7681f62amr7734306ejo.44.1696590070024;
        Fri, 06 Oct 2023 04:01:10 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090629cb00b009ad829ed144sm2687815eje.130.2023.10.06.04.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 04:01:09 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 6 Oct 2023 13:01:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/3] sched/nohz: Remove weird error handling from
 find_new_ilb()
Message-ID: <ZR/o8+EJGLMi3uPr@gmail.com>
References: <20231006102518.2452758-1-mingo@kernel.org>
 <20231006102518.2452758-4-mingo@kernel.org>
 <20231006103858.GB36277@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006103858.GB36277@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Oct 06, 2023 at 12:25:18PM +0200, Ingo Molnar wrote:
> > find_new_ilb() returns nr_cpu_ids on failure - which is a weird
> > choice in itself: not only is it a global variable, it is
> > a +1 out of bounds CPU index...
> 
> FWIW this is what all the cpumask bitops return when they've exhausted
> the mask. Eg. no bits left set etc..

yeah, which then results in type-forcing uglies like:

   kernel/events/core.c:	if ((unsigned)cpu >= nr_cpu_ids) {
   kernel/events/core.c:   if ((unsigned)cpu >= nr_cpu_ids) {
   kernel/smp.c:	   if ((unsigned)cpu >= nr_cpu_ids || !cpu_online(cpu)) {

:-/

So I don't think this is a particularly well thought-out interface.

Thanks,

	Ingo
