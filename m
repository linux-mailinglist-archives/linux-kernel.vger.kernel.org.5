Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060837BD9B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346408AbjJIL1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346375AbjJIL1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:27:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CCB2694
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:26:43 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40535597f01so41458885e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696850801; x=1697455601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qgsa4jFUUu75o7T4bTgZwNIym2nMH8ZI7QeLhKa9YdM=;
        b=Tt2vKXrk049eusdwik3EBxnGFPtuW2lJ6+SvULp0wACQMNWD9JiZBBa+/wZVvnllsw
         flQByhs8cwBo7hTDCry/ZZQLwNumwbbL1Gx2/bT2UXEUxU9Ih4XBNR1wUayOBInUIXE3
         IZtCh7QDZVs2k5RJ3zmxPnyQDlTun/Zc353v3rT6CpSq3f+JqZNCStr3VTT4Tqvfs0It
         M/kSr3EZM4OIZYT+nG+p4i12fIUhUVz2pfwB24oZAtgfkRw1TjttfV0OJykbnjiDgqwR
         nOpCXsi2EpE2NTBIAKao1+Qe90F0kU1z9lAU2Fyy1tplzGmo6EoN7hXVZbHuIAD4ms+W
         Pubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696850801; x=1697455601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qgsa4jFUUu75o7T4bTgZwNIym2nMH8ZI7QeLhKa9YdM=;
        b=IVK6AvUJ26V+O61MLUeKteFsPVg2yM/P6usSyU1489Bgeih2l+uCAwgtN/eR7uK/j9
         AadNKDHcfLuhTsEuOtqbgITWVs5MwY3FwdISx7KpTR2mWZsf2hYodZBkF430K23JvtH9
         JmrgB3AVkC83p0/qTVX67jg/g9to5Pc53RbkDKIg4DjrxgD0BQum32gadyDBRYS0HW6G
         QCBwOt4GbGmn2lxEE2ECBDTAy82T3PPj9Mqfj7jWY+UcIbsx0u8ivUT9stEk+ilGdg+S
         QBhS/KnJ5klzVxZGpboBiNXjl3AbrOpvQnlO5CuTg4yX+gvJoCMLziBmaAnlSjYMPtuP
         Qpmg==
X-Gm-Message-State: AOJu0YzwZW9Ed+UGYq4eKVu3dlcVno717u4MYeCed5Q2zxWAJdX7GVRm
        xjBSfyBqvwOhGD7+FbNE19g=
X-Google-Smtp-Source: AGHT+IGSje1UqZOyf2Lbpr9lCuklH9XjVGwURqyo1Ns7oEG6uWlCeIjeLl4fO8nt992XU66Qr1Ombg==
X-Received: by 2002:a1c:7212:0:b0:401:bdd7:499d with SMTP id n18-20020a1c7212000000b00401bdd7499dmr13839684wmc.25.1696850800548;
        Mon, 09 Oct 2023 04:26:40 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id k14-20020a05600c0b4e00b003fe1fe56202sm10964095wmr.33.2023.10.09.04.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:26:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 13:26:38 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/rt: Move sched_rt_entity::back to under the
 CONFIG_RT_GROUP_SCHED block
Message-ID: <ZSPjbjPPMeafHbjU@gmail.com>
References: <20231005162317.3343678-1-yajun.deng@linux.dev>
 <20231005162317.3343678-3-yajun.deng@linux.dev>
 <ZSPS+jMcJEd+ZR28@gmail.com>
 <5a3342ef-f14f-173c-630f-6b474bded257@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a3342ef-f14f-173c-630f-6b474bded257@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yajun Deng <yajun.deng@linux.dev> wrote:

> 
> On 2023/10/9 18:16, Ingo Molnar wrote:
> > * Yajun Deng <yajun.deng@linux.dev> wrote:
> > 
> > > The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
> > > So move sched_rt_entity::back to under the CONFIG_RT_GROUP_SCHED block. It
> > > will save a few bytes.
> > > 
> > > Also, init child when parent isn't NULL in init_tg_rt_entry().
> > > 
> > > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > > ---
> > >   include/linux/sched.h |  2 +-
> > >   kernel/sched/rt.c     | 18 +++++++++---------
> > >   2 files changed, 10 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 292c31697248..d0fe56603e60 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -597,8 +597,8 @@ struct sched_rt_entity {
> > >   	unsigned short			on_rq;
> > >   	unsigned short			on_list;
> > > -	struct sched_rt_entity		*back;
> > >   #ifdef CONFIG_RT_GROUP_SCHED
> > > +	struct sched_rt_entity		*back;
> > >   	struct sched_rt_entity		*parent;
> > >   	/* rq on which this entity is (to be) queued: */
> > >   	struct rt_rq			*rt_rq;
> > Title claims this change - the rest of the changes should be in a separate
> > patch:
> 
> 
> Okay. I will send v2.

It's ~v7 already by my count, isn't it?

Thanks,

	Ingo
