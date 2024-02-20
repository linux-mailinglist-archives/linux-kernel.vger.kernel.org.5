Return-Path: <linux-kernel+bounces-73609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086FA85C516
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094131C22457
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ECD14A4D2;
	Tue, 20 Feb 2024 19:44:34 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E6F6A8D5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458274; cv=none; b=HNMrUTrlSaZk6Bd0RFzAf5vfHudRpmnm1Ze0H+vIK4dXPQa8n3Pvr0vcLNL3NpSiJ9GlYv0UhACFkaJh7vOY7vXgjej1T7QWjctYX4FFaDx+RoX2r5Zyve8FcOZf5RXU8hEQ8i2CYnHu3Gs22o2nElJHDA/3Kmp+/bsjljOAFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458274; c=relaxed/simple;
	bh=egCrOOr50znuDik3a84ddfinZziKeyqdeCwPLOkPRHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgcFsoelzF8iez43c47CLZvbO/1XimWaAwHz21wts5ePNZsHqnG6FF5QGVBX1BPxOMg4dVllyQsdsA+cdWTQJ2lV+xipL98GhKuRwnTOICcm5r5vqXAvXbbukvA+AZ0TbtskTgsbZBOpGuiOvOQAg6QInPWrhY2jd4fi6V/2WWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7876f2a2e62so94751585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:44:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708458271; x=1709063071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tf7nxv/yoeRZAIg/mVYOoRIe0Oc63BJnhI64NvPgd3U=;
        b=LbBX+hYblUZfSeu32q/M4Rzz05R9cw0ruddz8AforqKewmL2A4bXF7PevPu47O8dHQ
         LhH+SAinLkDBfy4Pd0JXRyYJN4V+MvyiYz+oKtbrPCmdTM9InciN9JSWAiAVAnTKov28
         XAFY6itU6cRpAPLQ9Lv6p2BkLrg7Z83iuYTQDEoVRytGr0x2B0UW8qkVKfuFQsOeGp3O
         io949UZdUz5bcReJsCrO2wsLrmnt4U9Kc1zOxMKtjkRN+79C27YgXyAVv3e9VmV+5l+C
         OBo5FraX6ZTsGfNMtp2zGvBIDY2dsqfefGSBvzcVuaeFgfe8jXE5DQVmje3yeX77/GZj
         oM7g==
X-Forwarded-Encrypted: i=1; AJvYcCWX8JhTyxbeRqYko8P8zu31cF9hP0b9quL4ETwvVah2HbbNmKM6PPxdnSJCz+3JaoUyhH9jzevIR7gcUd6PSG8KKbkLaL6R1Vq00hyX
X-Gm-Message-State: AOJu0YyuB9alUKyDJWQ+XGdE5pdd8/WOMylL4esRMhLrS6Yzgny5lbg5
	uvgCid0oc1EFhZVf6so0QsfEq+Q35snbio2xXP0O5bI+RiEu8LuQ6ug5pCkU9w==
X-Google-Smtp-Source: AGHT+IEegqxXmIvsjTN0+qK/zSYbjr1IoWgnZe1NVExgdR7HP3eQ5gheVb9ulNmXqL4KYReh+e0t+w==
X-Received: by 2002:a05:620a:201c:b0:787:6c11:7d76 with SMTP id c28-20020a05620a201c00b007876c117d76mr6064988qka.10.1708458271439;
        Tue, 20 Feb 2024 11:44:31 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id x1-20020ae9f801000000b007873c82f0easm2905146qkh.113.2024.02.20.11.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:44:30 -0800 (PST)
Date: Tue, 20 Feb 2024 14:44:29 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mikulas Patocka <mpatocka@redhat.com>, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com,
	damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com,
	peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com,
	Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 8/8] dm-verity: Convert from tasklet to BH workqueue
Message-ID: <ZdUBHQQEN5-9AHBe@redhat.com>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-9-tj@kernel.org>
 <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com>
 <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
 <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>
 <ZbrgCPEolPJNfg1x@slm.duckdns.org>
 <ZbrjhJFMttj8lh3X@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbrjhJFMttj8lh3X@redhat.com>

On Wed, Jan 31 2024 at  7:19P -0500,
Mike Snitzer <snitzer@kernel.org> wrote:

> On Wed, Jan 31 2024 at  7:04P -0500,
> Tejun Heo <tj@kernel.org> wrote:
> 
> > Hello, Linus.
> > 
> > On Wed, Jan 31, 2024 at 03:19:01PM -0800, Linus Torvalds wrote:
> > > On Wed, 31 Jan 2024 at 13:32, Tejun Heo <tj@kernel.org> wrote:
> > > >
> > > > I don't know, so just did the dumb thing. If the caller always guarantees
> > > > that the work items are never queued at the same time, reusing is fine.
> > > 
> > > So the reason I thought it would be a good cleanup to introduce that
> > > "atomic" workqueue thing (now "bh") was that this case literally has a
> > > switch between "use tasklets' or "use workqueues".
> > > 
> > > So it's not even about "reusing" the workqueue, it's literally a
> > > matter of making it always just use workqueues, and the switch then
> > > becomes just *which* workqueue to use - system or bh.
> > 
> > Yeah, that's how the dm-crypt got converted. The patch just before this one.
> > This one probably can be converted the same way. I don't see the work item
> > being re-initialized. It probably is better to initialize the work item
> > together with the enclosing struct and then just queue it when needed.
> 
> Sounds good.
>  
> > Mikulas, I couldn't decide what to do with the "try_verify_in_tasklet"
> > option and just decided to do the minimal thing hoping that someone more
> > familiar with the code can take over the actual conversion. How much of user
> > interface commitment is that? Should it be renamed or would it be better to
> > leave it be?
> 
> cryptsetup did add support for it, so I think it worthwhile to
> preserve the option; but it'd be fine to have it just be a backward
> compatible alias for a more appropriately named option?

Hey Tejun,

I'm not sure where things stand with the 6.9 workqueue changes to add
BH workqueue.  I had a look at your various branches and I'm not
seeing where you might have staged any conversion patches (like this
dm-verity one).

I just staged various unrelated dm-verity and dm-crypt 6.8 fixes from
Mikulas that I'll be sending to Linus later this week (for v6.8-rc6).
Those changes required rebasing 'dm-6.9' because of conflicts, here is
the dm-6.9 branch:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.9

So we'll definitely need to rebase your changes on dm-6.9 to convert
dm-crypt and dm-verity over to your BH workqueue.  Are you OK with
doing that or would you prefer I merge some 6.9 workqueue branch that
you have into dm-6.9? And then Mikulas and I work to make the required
DM target conversion changes?

However you'd like to do it: please let me know where you have the
latest 6.9 code the adds BH workqueue (and if you have DM target
conversion code that reflects your latest).

Thanks,
Mike

