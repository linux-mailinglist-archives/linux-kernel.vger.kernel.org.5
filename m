Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351E577FD93
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354219AbjHQSMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354242AbjHQSMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248872D59
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692295912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rTErNomPttgl/viRXoYlofNYirDpLy640wteux782+8=;
        b=YNK5dy8uH35jY42ykJTHL3vk6ecyuqc4Odixp3qIjbUzypaoZPVSfjTVvHxSTGHcDhGmcd
        i61T8KwQGkX5YzdSJMdtpjrd0jQa42BALyqyV7yA58fOgKXFLwqFj2aJGmAzzDWOkai+vH
        fvRwBs2kBKciR1q6GKnBxdoLAegD3Ls=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-jry5-4i4O3a1PI5AwoN3Dg-1; Thu, 17 Aug 2023 14:11:49 -0400
X-MC-Unique: jry5-4i4O3a1PI5AwoN3Dg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-56cff6fe7edso167691eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692295908; x=1692900708;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTErNomPttgl/viRXoYlofNYirDpLy640wteux782+8=;
        b=Y6CNkOZ6fNf3ap+xMG579Pab/LaAg97h8xe0G0+pzZ77vY5/wKr9RAWE5eKwgftRS1
         4dILyFzqyw02bfUwbRLM2Zvo5F/2BpTUIvtt0ilqBoqERPi+N2OydhXjqfPoZ0ZlSgyz
         7h3Cua+k3lPyrviB6ZnbsE2CTKNSxr0/L8e2VJuMoiqJM+/gH7XoK1+cz5LBIbG6C/PF
         8UXw3JS/mZNtwItWNPViN72BSiohd09nIe/oQihBOKoD8Wd/YQn99SBSeaYjNhpbiwsB
         EHOA94GWxntzl5OPgYn1t6zZZrJz0Fg3qDF4EEADWc46/AcLl0V2B/vwDaAC0qMnXVMC
         ciuQ==
X-Gm-Message-State: AOJu0YwMFwS/O1fGLydaonptzZIdCzF/OzOzYpNyVwjvjZfb5GMoNwfw
        yXjhR8US3BMOrJ3w4+ECDRFINKsosCSrzn0AazjVxRlon0krmR7RTOnBAKs9fQTdkzauB+vGuk/
        psONtE+dRYnWa8kKtByxKRHW1
X-Received: by 2002:a05:6870:210f:b0:1ba:c622:3d5a with SMTP id f15-20020a056870210f00b001bac6223d5amr221686oae.18.1692295908799;
        Thu, 17 Aug 2023 11:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwERhgiG8BQEbAQpSqEJpeljF8hq9akQQFNWC+aNaxzMmCXPlOlMxrBacbtRCH+3VoEl22qg==
X-Received: by 2002:a05:6870:210f:b0:1ba:c622:3d5a with SMTP id f15-20020a056870210f00b001bac6223d5amr221663oae.18.1692295908583;
        Thu, 17 Aug 2023 11:11:48 -0700 (PDT)
Received: from fedora ([174.89.37.104])
        by smtp.gmail.com with ESMTPSA id p15-20020a0cf54f000000b0064721cf1535sm50551qvm.62.2023.08.17.11.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:11:48 -0700 (PDT)
Date:   Thu, 17 Aug 2023 14:11:38 -0400
From:   Lucas Karpinski <lkarpins@redhat.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: cgroup: fix test_kmem_memcg_deletion
 kernel mem check
Message-ID: <nnxvxk23hrbr2rj2g5upbks6w766cgubhltfamvsto3mxidcxa@iovra4ubeq35>
References: <jnyjalhg43mdnn6su2a2kmwzqasdyjsfdvipim2i2hvqo7w6y2@st57sbo4bkxf>
 <20230817170702.mwem4nsy2ka4gj7n@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817170702.mwem4nsy2ka4gj7n@google.com>
User-Agent: NeoMutt/20230517
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 05:07:02PM +0000, Shakeel Butt wrote:
> On Thu, Aug 17, 2023 at 08:47:26AM -0400, Lucas Karpinski wrote:
> > The combination of using slab, anon, file, kernel_stack, and percpu is
> > not accurate for total kernel memory utilization. Checking kernel within
> > memory.stat provides a more accurate measurement.
> > 
> > Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
> > ---
> >  v1: https://lore.kernel.org/all/eex2vdlg4ow2j5bybmav73nbfzuspkk4zobnk7svua4jaypqb5@7ie6e4mci43t/
> > 
> >  tools/testing/selftests/cgroup/test_kmem.c | 25 +++++-----------------
> >  1 file changed, 5 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
> > index ed2e50bb1e76..3ef979ee0edf 100644
> > --- a/tools/testing/selftests/cgroup/test_kmem.c
> > +++ b/tools/testing/selftests/cgroup/test_kmem.c
> > @@ -166,7 +166,7 @@ static int cg_run_in_subcgroups(const char *parent,
> >   */
> >  static int test_kmem_memcg_deletion(const char *root)
> >  {
> > -	long current, slab, anon, file, kernel_stack, pagetables, percpu, sock, sum;
> > +	long current, kernel;
> >  	int ret = KSFT_FAIL;
> >  	char *parent;
> >  
> > @@ -184,30 +184,15 @@ static int test_kmem_memcg_deletion(const char *root)
> >  		goto cleanup;
> >  
> >  	current = cg_read_long(parent, "memory.current");
> > -	slab = cg_read_key_long(parent, "memory.stat", "slab ");
> > -	anon = cg_read_key_long(parent, "memory.stat", "anon ");
> > -	file = cg_read_key_long(parent, "memory.stat", "file ");
> > -	kernel_stack = cg_read_key_long(parent, "memory.stat", "kernel_stack ");
> > -	pagetables = cg_read_key_long(parent, "memory.stat", "pagetables ");
> > -	percpu = cg_read_key_long(parent, "memory.stat", "percpu ");
> > -	sock = cg_read_key_long(parent, "memory.stat", "sock ");
> > -	if (current < 0 || slab < 0 || anon < 0 || file < 0 ||
> > -	    kernel_stack < 0 || pagetables < 0 || percpu < 0 || sock < 0)
> > +	kernel = cg_read_key_long(parent, "memory.stat", "kernel ");
> > +	if (current < 0 || kernel < 0)
> >  		goto cleanup;
> >  
> > -	sum = slab + anon + file + kernel_stack + pagetables + percpu + sock;
> > -	if (abs(sum - current) < MAX_VMSTAT_ERROR) {
> > +	if (abs(kernel - current) < MAX_VMSTAT_ERROR) {
> 
> I don't think this is what you want. Since slab, kernel_stack,
> pagetables and percpu are included in the kmem stats, you just want to
> replace those with kmem. Basically keep the anon, file and sock stats.
>

Will fix and send new patch version.

Thanks,
Lucas

