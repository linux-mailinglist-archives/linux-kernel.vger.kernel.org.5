Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C307C601C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376431AbjJKWBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjJKWBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:01:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716E2BA;
        Wed, 11 Oct 2023 15:01:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo616298a12.3;
        Wed, 11 Oct 2023 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697061676; x=1697666476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU8zTHkK4NxAcOXX++G5NAy250/pC8Kb9DQsWsU8U40=;
        b=bfmF/5bC/jj06bALqbAG1W6+Vo3cQ0bvh3D0rSvV4JsRCmu1nxaEVjPc2fXtWv0iI0
         D5cTM/Ns5Sq/1JPA6kdgndVPqOSbns9XkB3wbfrrkld/i9ACbDRmxbJvI4R5oUCH+XYl
         sR/Aj+Uhxd6lkM4Xw/PunmYOuEmRN7JgH1jrhauI90wabG3YDHhQzx/qM7SmKom8BY9Y
         dS7YFp3zBuRmOf630HMf31nQo3oVKASpvhYZrgMuIkNcvhKqiDfeD4pCWAF8ZXofPiGA
         ideQI/Tr+GXeBhsijnHVtFBCYtDb9w0bM6fQiK/H2dnMKT3SQtKmEOB6g5TxtIlRrlcD
         sLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697061676; x=1697666476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU8zTHkK4NxAcOXX++G5NAy250/pC8Kb9DQsWsU8U40=;
        b=LfluOxH/QU9P+CaEInTkhXEDesvenhpUGd5Bg1lY0r4DTW6WEo9C8QfB15/+l2FSgm
         9vGDUoZ3PtEX36BAJFKKXt70ArdSziRcUD5FrLO6ILIrDBeBbGAX41/hgNCv90cXpJvk
         FEuP2+zl4qDI9u8k5fmhkBKD2R6DktXPCyLwHjLxZSIfB6sIjg34Lz2kwGKu1x7JPKQA
         CVA8l+q2Xp28Ev8loOy7zrnLmtsO4PUhomgqzv28FJ6FVSFIrPLQbxuaM9xXgU3hw7+x
         yz5UWO2wjyuVozaKMHunh05L+xpY8+XOEQfznD8IbqmxqYYeILkWfLk5RcQFR37T8TpW
         IYUg==
X-Gm-Message-State: AOJu0Ywz0DlmusSK1jOqmSJ1CAvs8SAr0oFo1xi/JDYf3lB53nxbKxJ7
        fQSUhhA4LUTzHKDaEra27Cg=
X-Google-Smtp-Source: AGHT+IFaePyh0Rs/o6lwENjIO5ItRfbHskJy31RDjSUG/NssW7pcb8kI7XHPcWbV0kWtFwvx7YLaxg==
X-Received: by 2002:a05:6402:3c1:b0:533:2449:7a59 with SMTP id t1-20020a05640203c100b0053324497a59mr20378065edw.11.1697061675822;
        Wed, 11 Oct 2023 15:01:15 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id eg42-20020a05640228aa00b0053daf92f0easm1805319edb.97.2023.10.11.15.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:01:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Oct 2023 00:01:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Sohil Mehta <sohil.mehta@intel.com>
Subject: Re: linux-next: manual merge of the block tree with the asm-generic
 tree
Message-ID: <ZScbKPQur2qao5Gf@gmail.com>
References: <20231009123118.4487a0e1@canb.auug.org.au>
 <20231009084812.GB14330@noisy.programming.kicks-ass.net>
 <cb4bb8e2-7dfe-4ca4-aa70-060f7b2f8f95@app.fastmail.com>
 <20231009141351.GD14330@noisy.programming.kicks-ass.net>
 <b7c57f03-4606-4190-98c5-344c49656f9c@kernel.dk>
 <66e09ad5-2dcf-4159-9c98-f37ac739a445@kernel.dk>
 <20231011175407.GG6307@noisy.programming.kicks-ass.net>
 <ZScUhud9eqKIQJjC@gmail.com>
 <bf5ecd2d-06a7-4c51-a762-6fe3753044b6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf5ecd2d-06a7-4c51-a762-6fe3753044b6@kernel.dk>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jens Axboe <axboe@kernel.dk> wrote:

> >>> Peter, what's the verdict - do you want to rebase it, or leave it 
> >>> as-is?
> >>
> >> Ah, I looked into doing this, but tip/locking/core has since grown a 
> >> bunch of patches and has a merge commit -- I talked to Ingo yesterday 
> >> and he proposed just queueing a fix on top instead of doing a full 
> >> rebase.
> >>
> >> Ingo, that still your preferred solution?
> > 
> > Yeah, that would be the best solution IMO - it's not like there's any 
> > real prospect of someone bisecting futex2 patch-enablement commits on 
> > Alpha ... and the bisection distance isn't particularly large either in 
> > any case.
> 
> OK, works for me. I'll keep my branch as-is, and just ensure it gets sent 
> out after locking/core has been pulled by Linus.

Thank you!

	Ingo
