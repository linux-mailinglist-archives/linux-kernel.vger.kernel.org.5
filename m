Return-Path: <linux-kernel+bounces-77398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CCB8604BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311C21C221BD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8A212D202;
	Thu, 22 Feb 2024 21:24:50 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908E77174E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637090; cv=none; b=rsuXawY/AFTHekcgmQXB9vJtzFu/3NplRCilLcFrkDBHVa+/0PSDiyNX1BdGUYkjc26QPaMCMMWhJHagPvvHLwuAm/duodI7sUtX2oP+2KxGDxtq/2CSiVdUGXWVIK9yhvsLioPOqryqD1DvJ3A/Zy42BNGR5M0l6jBsFoBH+DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637090; c=relaxed/simple;
	bh=tXUpcTAJY+vi3vE9MWTEQBL5LoTKxp5Sis2ipx0eQX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhVABh97w5zOSZ4E+e6hUmLTlPSQQ5KTUreGP/NCC32BSfwodn9s2a5doybX5B2arnpom5LGZBwyqJ3/0mwbU5RW0OhtxC2BPwz8QXhUaLgsD6CUyoN1pLbexlAc08mVCPG1rrqJIytkV2uap9r+ErvVEjEbjHFjZ0JAawRLHrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6818f3cf00aso1632146d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708637087; x=1709241887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eq0QwZQY3YjWZ+VtYPNkWvBuXSdkd0s0ToaLbM0Gyng=;
        b=omhrgrzSsSfm8Qrv7yEMxDfyVKgj3xACeBCrsUvUAoUpLJc0ypuRX+1O/mBAUsAS30
         tSwXQiSRdV37Hza/qRHjC6NuY/7FLN+aj2EyzF/ERlKblCCt+drpVclqDlE9bD0HljiF
         F9JeAhASl5iTv0hDfDk0zWeY/LpszT9RKV2cvofIgJZY2OjJKwfDUfycwoG5vgby1JPT
         5l2DJrnyzK2aG7MUyfSaLUuunhPdGHCYLO/mr5VcMsgbQhnc+Tkv2s3PZb4//k+lhoaf
         luXtASHTEp3kPqOHrkTCRWaGOV2m6j6vzbJzqrvtlQrR880JAunzDwWNNgnrbXsbUjPU
         idqg==
X-Forwarded-Encrypted: i=1; AJvYcCWjiTKLkQ5N8fXTVuTq4WviVAp91mJBCrpFbVdV/3TMyNSU62NWC81HqIV5Rn/hOMIUbEMoJXomAff5Np6zPy0fE/bJkWJ3q9MFJgSR
X-Gm-Message-State: AOJu0YzxgtsAqJ5DnSHIb2HSbcwLI4aKE+RQhOkMOdXzq97PDLv+o7LY
	k+JS9BPr3HilK6A6vf3b55e6CMXdCmf9YzuPmr3vfTzdcwng821c8vSaSsFzyw==
X-Google-Smtp-Source: AGHT+IGN01XI6hb44wNpdqumjqu4HGrAUjLE3qm5ShySTrAHxjvJp1IxMDc5obZgXCmLdXewj8STng==
X-Received: by 2002:a0c:f38c:0:b0:68f:2e24:615a with SMTP id i12-20020a0cf38c000000b0068f2e24615amr399836qvk.12.1708637087556;
        Thu, 22 Feb 2024 13:24:47 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id qm18-20020a056214569200b0068c88a31f1bsm1802546qvb.89.2024.02.22.13.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 13:24:46 -0800 (PST)
Date: Thu, 22 Feb 2024 16:24:45 -0500
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
Message-ID: <Zde7nXVx8oFepINV@redhat.com>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-9-tj@kernel.org>
 <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com>
 <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
 <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>
 <ZbrgCPEolPJNfg1x@slm.duckdns.org>
 <ZbrjhJFMttj8lh3X@redhat.com>
 <ZdUBHQQEN5-9AHBe@redhat.com>
 <ZdUGFqLCpWez42Js@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdUGFqLCpWez42Js@slm.duckdns.org>

On Tue, Feb 20 2024 at  3:05P -0500,
Tejun Heo <tj@kernel.org> wrote:

> Hello, Mike.
> 
> On Tue, Feb 20, 2024 at 02:44:29PM -0500, Mike Snitzer wrote:
> > I'm not sure where things stand with the 6.9 workqueue changes to add
> > BH workqueue.  I had a look at your various branches and I'm not
> > seeing where you might have staged any conversion patches (like this
> > dm-verity one).
> 
> Yeah, the branch is for-6.9-bh-conversions in the wq tree but I haven't
> queued the DM patches yet. Wanted to make sure the perf signal from TCP
> conversion is okay first. FWIW, while Eric still has concerns, the initial
> test didn't show any appreciable regression with production memcache
> workload on our side.
> 
> > I just staged various unrelated dm-verity and dm-crypt 6.8 fixes from
> > Mikulas that I'll be sending to Linus later this week (for v6.8-rc6).
> > Those changes required rebasing 'dm-6.9' because of conflicts, here is
> > the dm-6.9 branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.9
> > 
> > So we'll definitely need to rebase your changes on dm-6.9 to convert
> > dm-crypt and dm-verity over to your BH workqueue.  Are you OK with
> > doing that or would you prefer I merge some 6.9 workqueue branch that
> > you have into dm-6.9? And then Mikulas and I work to make the required
> > DM target conversion changes?
> 
> Oh, if you don't mind, it'd be best if you could pull wq/for-6.9 into dm-6.9
> and do the conversions there.
> 
> Thank you.

I've rebased and made the changes available in this dm-6.9-bh-wq branch:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=dm-6.9-bh-wq

I left them both DM conversion commits attributed to use despite the
rebase (and churn of renames I did in the dm-verity commit); hopefully
you're fine with that but if not I can split the renames out.

I successfully tested using the cryptsetup testsuite ('make check').
And I've also added these changes to linux-next, via linux-dm.git's
'for-next':
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/log/?h=for-next

Mikulas, feel free to review/test and possibly add another patch for
dm-verity that only uses a single work_struct in struct dm_verity_io

Thanks,
Mike

