Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9567846E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjHVQTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjHVQS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:18:58 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B851CCF4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:18:52 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79244dd2e49so36042939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692721132; x=1693325932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SulyxFur075YhW3hAscwkd5r4FiasHvTrmXcovxkOoY=;
        b=NODJe+35KV76IszU638IPl21pwzJOPZG4QIc7K4tcqVwvan4l3NbEl0Q9JGQJQ9Voo
         Kx7BksaPUy5e5jj2z3g2c+6WeW1vqNSEckNS0XKCPNYw+3S3k1bosIt/86obRsKiia00
         p+oyLPsKPXK7lY/6NIFK2vA0R7Jz2QUvYVyxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692721132; x=1693325932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SulyxFur075YhW3hAscwkd5r4FiasHvTrmXcovxkOoY=;
        b=L5oQYg6PfWDkLIVyPugptOtFl5PWP6l0RRqXtJqb/o/zs9o9Qoa3RPLyy9O4aLb6Ld
         bVUpDhnExlwVpQ0eKK7Q/GzHL21bC72yMNh1aPbeb4CLxH8pRodZygZqitFd/gL16npr
         suELZg6zS1xiHnqbPoCN1x5Jmm7Q4PA2GRWJSf4dMy0/jKdb6Ji08cdgMVqhkLLz2zcm
         wcupJXdrfHbLnZ/2zRdOCmBjDSrwaSJmkIRj9ZoQC5HSN9ENn29rH0nnwgCOxnmzXAJq
         /l4VM9nga4LoPML0CQ+2IQCGKhCUq9O1jZIccSOGC60wfylUlRWXaulJqkKst6xbUwzx
         t2GA==
X-Gm-Message-State: AOJu0YzlqG7uxzFwjsZvpuX+kORnTGU0lhR06HWAxW6vzTJOf4MODDMc
        zQn04XNUrAjAiVKgMEnAXzAkJPTNkicO5gmEhwk=
X-Google-Smtp-Source: AGHT+IGtoYgpuSBlwU3oK2wWbcLMsHG7ycm346mQ9H6kR0VvrxjyU/tan1KIQGxT+qrWIyci4+dkbQ==
X-Received: by 2002:a5e:c108:0:b0:786:2878:9593 with SMTP id v8-20020a5ec108000000b0078628789593mr237361iol.0.1692721131941;
        Tue, 22 Aug 2023 09:18:51 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id q16-20020a02a310000000b0042b21e8853bsm3080471jai.36.2023.08.22.09.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 09:18:51 -0700 (PDT)
Date:   Tue, 22 Aug 2023 16:18:50 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Question on __torture_rt_boost() else clause
Message-ID: <20230822161850.GB74437@google.com>
References: <1393d18f-4928-45da-b504-7e5b6a681e51@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1393d18f-4928-45da-b504-7e5b6a681e51@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Mon, Aug 21, 2023 at 08:12:50PM -0700, Paul E. McKenney wrote:
> Hello, Joel!
> 
> A quick question for you...
> 
> I am doing catch-up additions of locktorture module parameters
> to kernel-parameters.txt, and came across rt_boost_factor.  The
> multiplication by cxt.nrealwriters_stress in the !rt_task(current)
> then-clause makes sense:  No matter how many writers you have, the
> number of boost operations per unit time remains roughly constant.

> But I am having some difficulty rationalizing a similar multiplication
> in the else-clause.  That would seem to leave boosting in effect for
> longer times the more writers there were.

But the number of de-boost operations per-unit time should also remain a
constant? I think you (or the original authors) wanted it to boost at every
50k ops at deboost at 500k ops originally.

> Is that the intent?

The original change before my patch to make boosting possible for non-rtmutex
types already had that multiplication, see below for diff from my patch. My
patch just kept the same thing to make the logic consistent (i.e. deboost
less often).

> Also, I am rationalizing the choice of 2 as default for rt_boost by
> noting that "mutex" and "ww_mutex_lock" don't do boosting and that
> preemption-disabling makes non-RT spinlocks immune from priority
> inversion.  Is this what you had in mind, or am I off in the weeds here?

The 2 was just to make sure that we don't deboost as often as we boost, which
is also what the old logic was trying to do.

What is the drawback of keeping the boost active for longer than not? It will
trigger the PI-boosting (and in the future proxy exec) more often.

Also by making the factor configurable, I allow it to control how often we
boost and deboost. IIRC, it was boosting much less often before I did that.

> I am putting my best guess in the patch, and am including you on CC.

Ok, thanks,

 - Joel


-static void torture_rtmutex_boost(struct torture_random_state *trsp)
-{
-       const unsigned int factor = 50000; /* yes, quite arbitrary */
-
-       if (!rt_task(current)) {
-               /*
-                * Boost priority once every ~50k operations. When the
-                * task tries to take the lock, the rtmutex it will account
-                * for the new priority, and do any corresponding pi-dance.
-                */
-               if (trsp && !(torture_random(trsp) %
-                             (cxt.nrealwriters_stress * factor))) {
-                       sched_set_fifo(current);
-               } else /* common case, do nothing */
-                       return;
-       } else {
-               /*
-                * The task will remain boosted for another ~500k operations,
-                * then restored back to its original prio, and so forth.
-                *
-                * When @trsp is nil, we want to force-reset the task for
-                * stopping the kthread.
-                */
-               if (!trsp || !(torture_random(trsp) %
-                              (cxt.nrealwriters_stress * factor * 2))) {
-                       sched_set_normal(current, 0);
-               } else /* common case, do nothing */
-                       return;
-       }
-}
-
