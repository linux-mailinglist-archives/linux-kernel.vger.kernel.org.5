Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66667808E50
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjLGRBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjLGRBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:01:30 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAA010EB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:01:36 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d0aaa979f0so8564755ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701968496; x=1702573296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zD2jPgn9YZsHnKOdKt2RP0gGZZORaADKGh8IdYyE8xQ=;
        b=A2wuqRv/gue2wtS7ikes6ve2kRez/sTuaZOdcvTstV5uld/1yu8r4G8Bof+pV1Qrm0
         tC93GreRKphb83iyLWiYhA6kVl09YAiVx1Qhz8hJ8v2lyY+7mNJVc8AhWkahMiwPjrbh
         YXRgX8s5eAqfgx5SCEbBGc9Mlg9g7OLAl/zCHZtW9MV4mcmz/J2XUyW+wbWe9+v9fAJX
         GfpQQwVfNqYwXpPoWMdyjLrO7CmzQwqUfBxB+8vLIDTXkVm/4osj+FGLTnu9iiBTXca1
         zLi3tF1bjHxQ7cFsi3L2gZ/QhuTaPkTpE93xmwXwmAYFLgC2+ww2iuRIPi3GTr04hbsE
         U5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701968496; x=1702573296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD2jPgn9YZsHnKOdKt2RP0gGZZORaADKGh8IdYyE8xQ=;
        b=m2EvAza5xOvpanV7A6OtYiuBfenQwSbFQsoIMLYNDJ5S8Ly3jSOd+P6Ig/8d/8QRFW
         5ymROL72tQBF7Twz2JJAx18GBFVoFDpbl25AbUbj0C1AlV+y9Gdv7tfeLv9FLF6rxirm
         12PoDKj0m0o6vJJBaM88Ono9mb5VhgWI1NMx1GBMeR/lERBeuFb5F/6m7sYDjwvowSnG
         ukkObwkcCPlKP/bpkvxRE/4Np1JJjMheetSPHtMVZrDgb3VJI2ruiY8VYaLEabZpVHxz
         WDafzV0HBBGoiJ1mXJ5AhmL11F9+S4V3USs8mpwCsx/kDIJ1BaOHzaNq+DokBkDNiEsO
         KYIg==
X-Gm-Message-State: AOJu0Yyir7gN9zFrm1TH0lnw72FdKPW7jYfzA36NzGQa3/c/ILphhrbp
        E5jYQpnVeJ03K97zVxbi5WE=
X-Google-Smtp-Source: AGHT+IGBY+Lz6f6+SVBybRfhgTvgZJQlO1fw80ux4IcrO2YcpLd1Rn5pd4/L/cz6whZM+OYUPbgwjQ==
X-Received: by 2002:a17:902:daca:b0:1d0:69d5:57da with SMTP id q10-20020a170902daca00b001d069d557damr3122779plx.67.1701968495532;
        Thu, 07 Dec 2023 09:01:35 -0800 (PST)
Received: from DESKTOP-IM4PCEA.localdomain ([49.206.132.94])
        by smtp.gmail.com with ESMTPSA id d3-20020a170903230300b001d08bbcf78bsm42325plh.74.2023.12.07.09.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 09:01:35 -0800 (PST)
Date:   Thu, 7 Dec 2023 22:31:30 +0530
From:   "<Mintu Patel>" <mintupatel89@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     badolevishal1116@gmail.com, chinmoyghosh2001@gmail.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rostedt@goodmis.org, vimal.kumar32@gmail.com, will@kernel.org
Subject: Re: [PATCH v2] rt_spin_lock: To list the correct owner of
 rt_spin_lock
Message-ID: <20231207170130.GA78@DESKTOP-IM4PCEA.localdomain>
References: <20220619142038.1274-1-mintupatel89@gmail.com>
 <20220627161136.3468-1-mintupatel89@gmail.com>
 <20231206185837.GB9899@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206185837.GB9899@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_MISSP_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 07:58:37PM +0100, Peter Zijlstra wrote:
> On Mon, Jun 27, 2022 at 09:41:38PM +0530, Mintu Patel wrote:
> >    rt_spin_lock is actually mutex on RT Kernel so it goes for contention
> >    for lock. Currently owners of rt_spin_lock are decided before actual
> >    acquiring of lock. This patch would depict the correct owner of
> >    rt_spin_lock. The patch would help in solving crashes and deadlock
> >    due to race condition of lock
> > 
> > acquiring rt_spin_lock        acquired the lock       released the lock
> >                     <-------->                <------->
> >                     contention period         Held period
> > 
> > Thread1                             Thread2
> > _try_to_take_rt_mutex+0x95c+0x74    enqueue_task_dl+0x8cc/0x8dc
> > rt_spin_lock_slowlock_locked+0xac+2 rt_mutex_setprio+0x28c/0x574
> > rt_spin_lock_slowlock+0x5c/0x90     task_blocks_rt_mutex+0x240/0x310
> > rt_spin_lock+0x58/0x5c              rt_spin_lock_slowlock_locked+0xac/0x2
> > driverA_acquire_lock+0x28/0x56      rt_spin_lock_slowlock+0x5c/0x90
> > 				    rt_spin_lock+0x58/0x5c
> >                                     driverB_acquire_lock+0x48/0x6c
> > 
> > As per above call traces sample, Thread1 acquired the rt_spin_lock and
> > went to critical section on the other hand Thread2 kept trying to acquire
> > the same rt_spin_lock held by Thread1 ie contention period is too high.
> > Finally Thread2 entered to dl queue due to high held time of the lock by
> > Thread1. The below patch would help us to know the correct owner of
> > rt_spin_lock and point us the driver's critical section. Respective
> > driver need to be debugged for longer held period of lock.
> > 
> >    ex: cat /sys/kernel/debug/tracing/trace
> > 
> >    kworker/u13:0-150   [003] .....11   202.761025: rt_spinlock_acquire:
> > Process: kworker/u13:0 is acquiring lock: &kbdev->hwaccess_lock
> >    kworker/u13:0-150   [003] .....11   202.761039: rt_spinlock_acquired:
> > Process: kworker/u13:0 has acquired lock: &kbdev->hwaccess_lock
> >    kworker/u13:0-150   [003] .....11   202.761042: rt_spinlock_released:
> > Process: kworker/u13:0 has released lock: &kbdev->hwaccess_lock
> > 
> 
> The above is word salad and makes no sense. No other lock has special
> tracing like this, so rt_lock doesn't need it either.
> 
Hi Peter,

As per current implementation of rt_spin_lock tracing mechanism on RTLinux, 
if more than one threads are trying to acquire a rt_spin_lock,
then multiple threads are assigned as owners of the same lock, more over
only one thread is actual owner of lock and others are still
contending for the same lock. Such trace logs can mislead the developers
during debugging of critical issues like deadlock, crashes etc

The above patch would generate rt_spin_lock locking traces which would
depict correct owner of the lock and other thread details which 
are trying to acquire the lock.

Regards,
Mintu Patel 
