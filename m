Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C493080D2A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbjLKQqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:46:20 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A9991
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:46:26 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1fae88e66eso97879666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702313185; x=1702917985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=noVxPYQYTouWSdFR1RAszjBhMSmcJiRgz0SE80oZI+g=;
        b=hwxyLHl0Cez4tO9u9ZpXAejMyxXvO18jh1SysXrcZzNEqRfZ3NJwJEHXpVCpD59G2O
         BEZzpHcq5mvUOyGi+cgukrOyAViBxt7AeZozqUKJhY3dUAONpyzvF5Z35UqrUgSwNwGK
         rNFwIZVqclLQ5myZdsufkF8BOV0zEsmvRDH3pE3ZoL9kOQf3MXMQdG0K0gwa8J4wEczd
         F5VERA2RQ+qTt1avUqZWJGvUo8D3bItGkhunBQzxsLfGDv3ffUgiTQm0+9iZJVBJrXi7
         a8cU+z33BeKTASGRW8+SxticiuP1Jezdyb7YMStYEnCnM5z4jYJXfKLjCHKNbVhLv4BG
         TRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702313185; x=1702917985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noVxPYQYTouWSdFR1RAszjBhMSmcJiRgz0SE80oZI+g=;
        b=PqRZ4oBGxwo2DohZOlufj/eXw21P+1KxBzusoosEZ03xikD80dhHwJOiNigfT536V/
         A9/SzVB/ACPasO+5DGCteGlt2DKUCijv1SejZBGZqfpW+JSxCtuL9F2T93hoeN/QMFAR
         ajlWvkx4lGPLbH/O7zD3fT6gniqi9Ruq02aXR1fF6I26JPZ39vQH7vxbLjqVCKxQlSVd
         oVx44yyQmuxZ3vHvYiZ6dx48CcvMNPQQVfzcpf9g1m7NyZVf4qViGXuJdAdzAv1o1FiM
         BgNvjHr9eZDVupXMlpmXW5ti9F8zd3As8g6CfM8npOUTeeZ5638w2ZYDnvcV4mD84kRa
         oong==
X-Gm-Message-State: AOJu0YzYvC0CAIp3ah8XfSBSxzDI4haSxQ5IKbVBdjphAoWPdkbFlfrB
        mVGiR5hR4DhksRQ7T8aJLsg=
X-Google-Smtp-Source: AGHT+IHIneeEguymyNcX7Q5AOfOUbwInZrHPEts5XP3rQK5DpGrJG0kvyF/FPoQxuvGsAv7Nno8OtA==
X-Received: by 2002:a17:907:e8f:b0:a18:b240:915f with SMTP id ho15-20020a1709070e8f00b00a18b240915fmr2571288ejc.69.1702313184563;
        Mon, 11 Dec 2023 08:46:24 -0800 (PST)
Received: from andrea ([31.189.124.152])
        by smtp.gmail.com with ESMTPSA id rd12-20020a170907a28c00b00a11b2677acbsm5008366ejc.163.2023.12.11.08.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:46:24 -0800 (PST)
Date:   Mon, 11 Dec 2023 17:46:19 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     paulmck@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mmaas@google.com, hboehm@google.com,
        striker@us.ibm.com, charlie@rivosinc.com, rehn@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] membarrier: riscv: Provide core serializing
 command
Message-ID: <ZXc82331D+qWufsL@andrea>
References: <20231211094414.8078-1-parri.andrea@gmail.com>
 <20231211094414.8078-4-parri.andrea@gmail.com>
 <fc29a938-c34a-45ee-8c6e-3aa71964c873@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc29a938-c34a-45ee-8c6e-3aa71964c873@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >   	/*
> >   	 * The membarrier system call requires a full memory barrier
> >   	 * after storing to rq->curr, before going back to user-space.
> > +	 *
> > +	 * The barrier is also needed for the SYNC_CORE command when
> > +	 * switching between processes; in particular, on a transition
> > +	 * from a thread belonging to another mm to a thread belonging
> > +	 * to the mm for which a membarrier SYNC_CORE is done on CPU0:
> > +	 *
> > +	 *   - [CPU0] sets all bits in the mm icache_stale_mask.
> > +	 *
> > +	 *   - [CPU1] store to rq->curr (by the scheduler).
> > +	 *
> > +	 *   - [CPU0] loads rq->curr within membarrier and observes
> > +	 *     cpu_rq(1)->curr->mm != mm, so the IPI is skipped on
> > +	 *     CPU1; this means membarrier relies on switch_mm() to
> > +	 *     issue the sync-core.
> > +	 *
> > +	 *   - [CPU1] switch_mm() loads icache_stale_mask; if the bit
> > +	 *     is zero, switch_mm() may incorrectly skip the sync-core.
> > +	 *
> > +	 * Matches the full barrier in membarrier_private_expedited().
> 
> There are two full barriers in membarrier_private_expedited(). We
> should clearly state which one it matches, and update the associated
> barrier to state that it matches this barrier as well.

Agreed, will do.

  Andrea
