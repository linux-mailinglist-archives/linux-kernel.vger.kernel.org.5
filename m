Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58817DEFE8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346515AbjKBK1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346371AbjKBK1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE26C131
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698920808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cHxlEPIDbvrN3Wa2WIuH++2PNSEmRnJ4aw0+ivxO1Y=;
        b=TKQus1RueitYYbkRWV1QNkb990bm4rhPCV2v/x/qXAMm/3ttlxx0z4Q20WZrNDnAcz2UXT
        jUNl3ytb5bFAMbrnkPK4hGE1dIbJ0lK2cGwE8k2TiWjkdUGVLBxiFg5A0g5O2gMXYn33gl
        v0C5Oo+70bHYVBxZNvUEtoDT/mXgpo0=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-cR6ail7iMJerGA1-vxtFOA-1; Thu, 02 Nov 2023 06:26:46 -0400
X-MC-Unique: cR6ail7iMJerGA1-vxtFOA-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6ce322bbb63so817798a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 03:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698920806; x=1699525606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cHxlEPIDbvrN3Wa2WIuH++2PNSEmRnJ4aw0+ivxO1Y=;
        b=SoAgvEYl3wyb6X9eDxYqjg2lODojtd/U7+TEqjVefiNz3wgpxGD0xuPaOAPgK+Pt4C
         ji2Vv9XTOUVi4xr3QT1x62sPN94z3jpP/efUo/gtlDeeNWMRrtpTmMHWrt29YNFkJqzc
         fDhScB8jYB8tLxWDrIKAyifpd0rD61tu5Yrr4cEk8u39hJw+l5xQuSZ8iZ4yU9boNqXb
         8sPyrCApcMpcaeeOP8JrVhNwz+R+9NJuMfh2EpcFcYo70MJiHunnMJS9ffVY1cym9N6d
         4PuA1G4my0PrtBFtzlhoJegA9Utt6iOg0JkzNRV2ZX23LQLGY8ADtanx/gwI54ZfaTrY
         cmnQ==
X-Gm-Message-State: AOJu0Yw1lG9ub3zW6UXqW1dbvDrM6KbEkb9wCfrIJCrHI/ypri53SL4a
        nlEOQb4G1QMcplSjcyyyWeBfUDfibUqZqNQO761aHgY1nAclXGnT6HfRb/bbzLVMaB8yZSANEdw
        14l4+KAX/iHcSFz6dhnqX1s84
X-Received: by 2002:a05:6830:2703:b0:6bd:a47:7bb6 with SMTP id j3-20020a056830270300b006bd0a477bb6mr18573850otu.14.1698920806124;
        Thu, 02 Nov 2023 03:26:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYGVhNLb1tTHfRerVfK7RRNSLAZHWweQKR7mRKblGTqXiT4x6O9uTLdQsSnxv7n/dD76I9fA==
X-Received: by 2002:a05:6830:2703:b0:6bd:a47:7bb6 with SMTP id j3-20020a056830270300b006bd0a477bb6mr18573840otu.14.1698920805849;
        Thu, 02 Nov 2023 03:26:45 -0700 (PDT)
Received: from localhost.localdomain ([151.29.57.115])
        by smtp.gmail.com with ESMTPSA id fg8-20020a05622a580800b0040399fb5ef3sm2172854qtb.0.2023.11.02.03.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:26:45 -0700 (PDT)
Date:   Thu, 2 Nov 2023 11:26:39 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xia Fukun <xiafukun@huawei.com>
Subject: Re: [PATCH v2] cgroup/cpuset: Change nr_deadline_tasks to an
 atomic_t value
Message-ID: <ZUN5XyOs3pWcJBo2@localhost.localdomain>
References: <20231024141834.4073262-1-longman@redhat.com>
 <rzzosab2z64ae5kemem6evu5qsggef2mcjz3yw2ieysoxzsvvp@26mlfo2qidml>
 <8e1b5497-d4ca-50a0-7cb1-ffa098e0a1c2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e1b5497-d4ca-50a0-7cb1-ffa098e0a1c2@redhat.com>
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

On 01/11/23 13:59, Waiman Long wrote:
> On 11/1/23 12:34, Michal Koutný wrote:
> > On Tue, Oct 24, 2023 at 10:18:34AM -0400, Waiman Long <longman@redhat.com> wrote:
> > > The nr_deadline_tasks field in cpuset structure was introduced by
> > > commit 6c24849f5515 ("sched/cpuset: Keep track of SCHED_DEADLINE task
> > > in cpusets"). Unlike nr_migrate_dl_tasks which is only modified under
> > > cpuset_mutex, nr_deadline_tasks can be updated under two different
> > > locks - cpuset_mutex in most cases or css_set_lock in cgroup_exit(). As
> > > a result, data races can happen leading to incorrect nr_deadline_tasks
> > > value.
> > The effect is that dl_update_tasks_root_domain() processes tasks
> > unnecessarily or that it incorrectly skips dl_add_task_root_domain()?
> The effect is that dl_update_tasks_root_domain() may return incorrectly or
> it is doing unnecessary work. Will update the commit log to reflect that.
> > 
> > > Since it is not practical to somehow take cpuset_mutex in cgroup_exit(),
> > > the easy way out to avoid this possible race condition is by making
> > > nr_deadline_tasks an atomic_t value.
> > If css_set_lock is useless for this fields and it's going to be atomic,
> > could you please add (presumably) a cleanup that moves dec_dl_tasks_cs()
> > from under css_set_lock in cgroup_exit() to a (new but specific)
> > cpuset_cgrp_subsys.exit() handler?
> 
> But css_set_lock is needed for updating other css data. It is true that we
> can move dec_dl_tasks_cs() outside of the lock. I can do that in the next
> version.

Not sure if you had a chance to check my last question/comment on your
previous posting?

https://lore.kernel.org/lkml/ZSjfBWgZf15TchA5@localhost.localdomain/

Thanks,
Juri

