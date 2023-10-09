Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0D7BDA57
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346353AbjJILyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346348AbjJILyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:54:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4CAF7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:54:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40566f8a093so40953795e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696852457; x=1697457257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsXSAz8UwMqpX7LGDxRG7soPkv+HU3a1mUHRtcMadhY=;
        b=f2p0TT7rNPT7qvSEYuc9EGoA8OkzS6vd3EPvA3qi2TtnWZJFERnJ2RJgPCmlPSuWIW
         edu+EbLy0/41k1EyMCzldgiHyCBDTOlIUrF+9eL9AX2GsfovadfbtW3h5j+P8jR/5uBr
         zWj8gNjv+BhwYwIof577MEzDsgqZu85Egfy294GPHCz5owWzQkeK0pAWW6i7tk5tnR2p
         SzvFvR8HMMeyt6sG1A9TQA3ob1J/25XEuvqSZUzHVg0i6fXb+eyNnHqrVVbK1Lfjn84M
         aNADdoZ9hbic/Uwsy7UKyKWSOJKfqHpuKTJ/iTYyzRiKCr2y4FFQSSLzTalMYq+z0ICf
         6iig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696852457; x=1697457257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FsXSAz8UwMqpX7LGDxRG7soPkv+HU3a1mUHRtcMadhY=;
        b=JhTsu7BpLvKjhUs0yxdF+HyAmXl6K9haO1Ce2Cb/d6g3AkFc5CF9l84NrxE+j/dJCb
         Q3ojT/e0tloOqa9x+Z5sB/cm7WdO+cJsyo/sCOJYHFyqb2gPQCKC5489rjTguKqYI5zP
         2ZhgIOdNI/OUzMASd9alRbhYn/sFu01d/tW6qTaieJq7q9PbZONiCIiOlBy9jav7Vsg1
         UaJ2j2W6XgVuWy5besKDHK/Ro+/bTK5w6RQ6dc84Cue27jKDiF4s5SLMyQipPT+nVR1B
         5OQTD1oxeZuzqm+az41kfznGYx2pp28T7bC5mFpmSMlb9qR6pt4IYbwA3Yf+Ei7Eaxgb
         TmsQ==
X-Gm-Message-State: AOJu0YzuuWNE38xNCM7Le5UcQfkcXGJoHF+DX/DzKy2qILwYyjmmr3jI
        dq8ax0gpIbmSBoyCzpCgn68=
X-Google-Smtp-Source: AGHT+IGwNeouZtTRFX+s4/VTxNEFugSAg+20IibBDZLJhiavF1HcCoPx9hhe3bobqkD/IdOnM43JGg==
X-Received: by 2002:a1c:740d:0:b0:405:1ba2:4fd1 with SMTP id p13-20020a1c740d000000b004051ba24fd1mr14127970wmc.24.1696852457355;
        Mon, 09 Oct 2023 04:54:17 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c024c00b0040531f5c51asm11112782wmj.5.2023.10.09.04.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 04:54:16 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 13:54:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/rt: Move sched_rt_entity::back to under the
 CONFIG_RT_GROUP_SCHED block
Message-ID: <ZSPp5rKmgdO+8PZS@gmail.com>
References: <20231005162317.3343678-1-yajun.deng@linux.dev>
 <20231005162317.3343678-3-yajun.deng@linux.dev>
 <ZSPS+jMcJEd+ZR28@gmail.com>
 <5a3342ef-f14f-173c-630f-6b474bded257@linux.dev>
 <ZSPjbjPPMeafHbjU@gmail.com>
 <af176171-7c06-700d-c885-b63f44a0443d@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af176171-7c06-700d-c885-b63f44a0443d@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yajun Deng <yajun.deng@linux.dev> wrote:

> 
> On 2023/10/9 19:26, Ingo Molnar wrote:
> > * Yajun Deng <yajun.deng@linux.dev> wrote:
> > 
> > > On 2023/10/9 18:16, Ingo Molnar wrote:
> > > > * Yajun Deng <yajun.deng@linux.dev> wrote:
> > > > 
> > > > > The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
> > > > > So move sched_rt_entity::back to under the CONFIG_RT_GROUP_SCHED block. It
> > > > > will save a few bytes.
> > > > > 
> > > > > Also, init child when parent isn't NULL in init_tg_rt_entry().
> > > > > 
> > > > > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > > > > ---
> > > > >    include/linux/sched.h |  2 +-
> > > > >    kernel/sched/rt.c     | 18 +++++++++---------
> > > > >    2 files changed, 10 insertions(+), 10 deletions(-)
> > > > > 
> > > > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > > > index 292c31697248..d0fe56603e60 100644
> > > > > --- a/include/linux/sched.h
> > > > > +++ b/include/linux/sched.h
> > > > > @@ -597,8 +597,8 @@ struct sched_rt_entity {
> > > > >    	unsigned short			on_rq;
> > > > >    	unsigned short			on_list;
> > > > > -	struct sched_rt_entity		*back;
> > > > >    #ifdef CONFIG_RT_GROUP_SCHED
> > > > > +	struct sched_rt_entity		*back;
> > > > >    	struct sched_rt_entity		*parent;
> > > > >    	/* rq on which this entity is (to be) queued: */
> > > > >    	struct rt_rq			*rt_rq;
> > > > Title claims this change - the rest of the changes should be in a separate
> > > > patch:
> > > 
> > > Okay. I will send v2.
> > It's ~v7 already by my count, isn't it?
> 
> 
> May be. If we count from the earliest.

Yes, of course we count from the earliest this series was sent, why 
wouldn't we? Having new patches or removing patches doesn't really reset 
the counter.

Thanks,

	Ingo
