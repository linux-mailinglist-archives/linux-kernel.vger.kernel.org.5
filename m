Return-Path: <linux-kernel+bounces-86235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBB186C288
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68814281882
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEA2481AD;
	Thu, 29 Feb 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hManudXJ"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764D44C7A;
	Thu, 29 Feb 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191840; cv=none; b=I3s8goIADXxog0YVwrXDgo31Ks7uBaWz0DKSs4fRVRImVWK+SF1Q8mOhVwDvZo1BeKfdiVLlvabFRZxRoMWWVsHb1a/boZAlgnNHyDsxgnDQdhTUXCKOkVvdRxm1o//ydX2oC7pUOxFvL00wp1M7tVWwShO2Lpth9u46tqyjf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191840; c=relaxed/simple;
	bh=qQphN+sqW5YE4b5rl2f3FHHx7OKKlN9smis0Dk0DJDA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=pXbQa/CzK+1Cj5s3Y178XMSbOMMo1xTKQd67zDAy5pGv1QWAXLsC3CKaFyshDwV1GgQdLzD4uSMlqspDsw+b2c96FoUbzePq7oYzT2cxdGVIQQscDyH8J82BZlEXgK9aR53kxk0Ysn/2keMqGZmnf0/AgWb0jzc09LUuZoqlUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hManudXJ; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709191835; h=Message-ID:Subject:Date:From:To;
	bh=fY81VLSpIMYe2pZ+dvGpRY8n4fDqoWg+ECmGm/R8l7Q=;
	b=hManudXJTnYJ5uyzatUIB9LJkVBYOGik/9+msLe1wbvsPMxD8Jrm6pWP94E6hWRk3LL6mts8+IrUKEWW5q3wLMv0lqVQhIILO2jmJFj0edP6THtGJYSWvuCqL1p5l9kUp5HJQ7z1ZomExzFPnEARY3vgob2YD1Gpbm1ZCSDxceg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1SHVCt_1709191834;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1SHVCt_1709191834)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 15:30:35 +0800
Message-ID: <1709191267.7473843-1-xuanzhuo@linux.alibaba.com>
Subject: Re: linux-next: build failure after merge of the vhost tree
Date: Thu, 29 Feb 2024 15:21:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20240229145531.7f7369cb@canb.auug.org.au>
 <1709179304.522055-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1709179304.522055-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Thu, 29 Feb 2024 12:01:44 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> On Thu, 29 Feb 2024 14:55:31 +1100, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi all,
> >
> > After merging the vhost tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >
> > drivers/virtio/virtio_pci_modern.c: In function 'vp_modern_create_avq':
> > drivers/virtio/virtio_pci_modern.c:755:34: warning: passing argument 5 of 'vp_dev->setup_vq' makes integer from pointer without a cast [-Wint-conversion]
> >   755 |                               avq->name, NULL, VIRTIO_MSI_NO_VECTOR);
> >       |                               ~~~^~~~~~
> >       |                                  |
> >       |                                  char *
> > drivers/virtio/virtio_pci_modern.c:755:34: note: expected 'u16' {aka 'short unsigned int'} but argument is of type 'char *'
> > drivers/virtio/virtio_pci_modern.c:754:14: error: too many arguments to function 'vp_dev->setup_vq'
> >   754 |         vq = vp_dev->setup_vq(vp_dev, &vp_dev->admin_vq.info, avq->vq_index, NULL,
> >       |              ^~~~~~
> >
> > Caused by commit
> >
> >   4cceb2591a87 ("virtio: find_vqs: pass struct instead of multi parameters")
> >
> > I have used the vhost tree from next-20240228 for today.
>
> I will post new version for powerpc soon.


This is not a bug on the powerpc. This is due to a conflict with the admin
queue commit. Because my patch set contains files for many other platforms. So I
have to check each file manually. Maybe when I do rebase I missed
checking the code again and my automated script didn't work because some files
can not compile on x86.

But the good news is that this patch set contains the ability to add new virtio
features without impacting files on other platforms.

The new version is sent.

	http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alibaba.com

Thanks.


>
> Thanks.
>
>
> >
> > --
> > Cheers,
> > Stephen Rothwell
> >
>

