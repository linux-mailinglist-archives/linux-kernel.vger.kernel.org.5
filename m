Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1396477AABA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 21:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjHMTCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 15:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHMTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 15:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59C9BF
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 12:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691953293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CEt9jygVzQcGJ/r1YIvshQV5vep7vwd+a/V9X6Fi/+I=;
        b=FKtnZqiKsLqcpxq/Cr/mHiMBHoaGzVXFiNI9gmit6mfpo0pCPXswoHjlCCsdtV6833LEy3
        T0cv8iIDBP4tfvYrvS7BuH96FF8ZbrzKh2pChmbW08L7+4jiMmgj1CZko1BdR0CiDtpqTP
        YrUC5X12ZT6L6+Eq+nOEuy1Ws3ESZAo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-aUm9_rF8PCCvZWJhq2NEmQ-1; Sun, 13 Aug 2023 15:01:32 -0400
X-MC-Unique: aUm9_rF8PCCvZWJhq2NEmQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99388334de6so222926466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 12:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691953291; x=1692558091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEt9jygVzQcGJ/r1YIvshQV5vep7vwd+a/V9X6Fi/+I=;
        b=L23LO7hHZWKssksltr3AIbrqlW070SKEb8XSDjvSNjzw6ygLTFwzQraQLxDwh6kQZT
         EXmUt1M7Z7EuoxoZtosvOd8MwBehvyjUT+NV/bPvukvk3nE6D/CVCvHkp+hzPy9c3+9v
         Yim7F3dMp+Bdhk326L6pz2jWDI5gusiX2dxCbqshsPmd323gUPOhd7zj8zi0AXgCia9E
         mjARQxHhE35gJmCLAkeIo7mvLwFU5PXxzsMTC4OLRHE3d0pm0PTBoMC8qB1fs5JVbLz+
         CPhuS0N65aslsvIYjIwdve0u4+MbIjiFidZmgLAQ6x7pfzVfLrS4wXGM+8veUyq+aBb9
         AeIw==
X-Gm-Message-State: AOJu0Yx6nXDX3yfvwRFBhendV5OO//y/sJvCtOHbcaOBC0FmXjrbBvIa
        x5dDNJ1O+Wa2INRYhPI93nBdngs4LXxlT2KCmIFQRDvrHwOirIpTn/hAinLyOJ+qmdlpRtq2oAB
        tbJcRp3IriUhml5TgMkIVYcuw
X-Received: by 2002:a17:906:5db4:b0:99c:ac84:663a with SMTP id n20-20020a1709065db400b0099cac84663amr5775074ejv.65.1691953291059;
        Sun, 13 Aug 2023 12:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhMaFdsuzYAw2yinsIysYJSim9+L86qb9TO9hQl2qrKJMg5+Y+NMBiUqcJJQ0Gh9hAZ/5lTA==
X-Received: by 2002:a17:906:5db4:b0:99c:ac84:663a with SMTP id n20-20020a1709065db400b0099cac84663amr5775055ejv.65.1691953290645;
        Sun, 13 Aug 2023 12:01:30 -0700 (PDT)
Received: from redhat.com ([2.55.27.97])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090622ce00b00992ca779f42sm4825074eja.97.2023.08.13.12.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 12:01:28 -0700 (PDT)
Date:   Sun, 13 Aug 2023 15:01:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
Message-ID: <20230813145936-mutt-send-email-mst@kernel.org>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <20230720090415-mutt-send-email-mst@kernel.org>
 <dcd74064-7617-c895-4f78-cb46ef1d582b@oracle.com>
 <20230810145528-mutt-send-email-mst@kernel.org>
 <b2b02526-913d-42a9-9d23-59badf5b96db@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b02526-913d-42a9-9d23-59badf5b96db@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:51:36PM -0500, Mike Christie wrote:
> On 8/10/23 1:57 PM, Michael S. Tsirkin wrote:
> > On Sat, Jul 22, 2023 at 11:03:29PM -0500, michael.christie@oracle.com wrote:
> >> On 7/20/23 8:06 AM, Michael S. Tsirkin wrote:
> >>> On Thu, Feb 02, 2023 at 05:25:17PM -0600, Mike Christie wrote:
> >>>> For vhost workers we use the kthread API which inherit's its values from
> >>>> and checks against the kthreadd thread. This results in the wrong RLIMITs
> >>>> being checked, so while tools like libvirt try to control the number of
> >>>> threads based on the nproc rlimit setting we can end up creating more
> >>>> threads than the user wanted.
> >>>>
> >>>> This patch has us use the vhost_task helpers which will inherit its
> >>>> values/checks from the thread that owns the device similar to if we did
> >>>> a clone in userspace. The vhost threads will now be counted in the nproc
> >>>> rlimits. And we get features like cgroups and mm sharing automatically,
> >>>> so we can remove those calls.
> >>>>
> >>>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> >>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >>>
> >>>
> >>> Hi Mike,
> >>> So this seems to have caused a measureable regression in networking
> >>> performance (about 30%). Take a look here, and there's a zip file
> >>> with detailed measuraments attached:
> >>>
> >>> https://bugzilla.redhat.com/show_bug.cgi?id=2222603
> >>>
> >>>
> >>> Could you take a look please?
> >>> You can also ask reporter questions there assuming you
> >>> have or can create a (free) account.
> >>>
> >>
> >> Sorry for the late reply. I just got home from vacation.
> >>
> >> The account creation link seems to be down. I keep getting a
> >> "unable to establish SMTP connection to bz-exim-prod port 25 " error.
> >>
> >> Can you give me Quan's email?
> >>
> >> I think I can replicate the problem. I just need some extra info from Quan:
> >>
> >> 1. Just double check that they are using RHEL 9 on the host running the VMs.
> >> 2. The kernel config
> >> 3. Any tuning that was done. Is tuned running in guest and/or host running the
> >> VMs and what profile is being used in each.
> >> 4. Number of vCPUs and virtqueues being used.
> >> 5. Can they dump the contents of:
> >>
> >> /sys/kernel/debug/sched
> >>
> >> and
> >>
> >> sysctl  -a
> >>
> >> on the host running the VMs.
> >>
> >> 6. With the 6.4 kernel, can they also run a quick test and tell me if they set
> >> the scheduler to batch:
> >>
> >> ps -T -o comm,pid,tid $QEMU_THREAD
> >>
> >> then for each vhost thread do:
> >>
> >> chrt -b -p 0 $VHOST_THREAD
> >>
> >> Does that end up increasing perf? When I do this I see throughput go up by
> >> around 50% vs 6.3 when sessions was 16 or more (16 was the number of vCPUs
> >> and virtqueues per net device in the VM). Note that I'm not saying that is a fix.
> >> It's just a difference I noticed when running some other tests.
> > 
> > 
> > Mike I'm unsure what to do at this point. Regressions are not nice
> > but if the kernel is released with the new userspace api we won't
> > be able to revert. So what's the plan?
> > 
> 
> I'm sort of stumped. I still can't replicate the problem out of the box. 6.3 and
> 6.4 perform the same for me. I've tried your setup and settings and with different
> combos of using things like tuned and irqbalance.
> 
> I can sort of force the issue. In 6.4, the vhost thread inherits it's settings
> from the parent thread. In 6.3, the vhost thread inherits from kthreadd and we
> would then reset the sched settings. So in 6.4 if I just tune the parent differently
> I can cause different performance. If we want the 6.3 behavior we can do the patch
> below.
> 
> However, I don't think you guys are hitting this because you are just running
> qemu from the normal shell and were not doing anything fancy with the sched
> settings.
> 
> 
> diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> index da35e5b7f047..f2c2638d1106 100644
> --- a/kernel/vhost_task.c
> +++ b/kernel/vhost_task.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (C) 2021 Oracle Corporation
>   */
> +#include <uapi/linux/sched/types.h>
>  #include <linux/slab.h>
>  #include <linux/completion.h>
>  #include <linux/sched/task.h>
> @@ -22,9 +23,16 @@ struct vhost_task {
>  
>  static int vhost_task_fn(void *data)
>  {
> +	static const struct sched_param param = { .sched_priority = 0 };
>  	struct vhost_task *vtsk = data;
>  	bool dead = false;
>  
> +	/*
> +	 * Don't inherit the parent's sched info, so we maintain compat from
> +	 * when we used kthreads and it reset this info.
> +	 */
> +	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
> +
>  	for (;;) {
>  		bool did_work;
>  
> 
> 

yes seems unlikely, still, attach this to bugzilla so it can be
tested?

and, what will help you debug? any traces to enable?

Also wasn't there another issue with a non standard config?
Maybe if we fix that it will by chance fix this one too?

> 
> 

