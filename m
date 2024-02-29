Return-Path: <linux-kernel+bounces-86109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DED86BFBC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1C41F249F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2751B37719;
	Thu, 29 Feb 2024 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iUryPJt+"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F25D376E1;
	Thu, 29 Feb 2024 04:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709179347; cv=none; b=FBXN7cI2vigU9HWToyuOfE5CB/R5zskdX9d9FH1Nkl1/Kn8hFzaRfwRahplOw2JR/Makmo9kipdZCBHeNEr2Xk/Q3F/UlOsliZPI3ZA/gJ3tXYgmCjYP8LJuz+jixT/kVBzj+lrkBmXMSbqqm/FC3OgBzYNGHnQKCUsfdMdYmmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709179347; c=relaxed/simple;
	bh=SNJwfg1tCer5bwynJe0otSI9bMprHgn4ovdKCtXmcfQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=uHmF/kSqNg/jThTW7hSceF6QtyxsvTzB0sURio6/jpC0Q4gz59jgDpKuLT4F70FXk5npNYzJeVbKkKpTz9U7fP2QtU+a9LMQxZ6sTFR4TJcK7ILFdyqR6oLmw3h/dnfwpjV/1XmV62IZTalxI9v6ux69Ye3Em1na6d/AiFN4J8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iUryPJt+; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709179341; h=Message-ID:Subject:Date:From:To;
	bh=qddl43JU3SFmVs7NY1GN/mCezcwGFQMX8A60Zl2vNvw=;
	b=iUryPJt+YDBFPS2TqqlJjzZmy0q9ikdoXvHnh3EpRVLFErGwiZhOuz2xLB65PD2RfTJvfDI8KNBLcBu0+ZjRyyuffb9S03+QJOxZ+WQSIRXpekUUSHq/KTK1Hsb70jrkQ5NfyipJvt5tI4+NlxosDiBNFJi3391f6Kq1/uEYvhM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W1Rdkwc_1709179340;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1Rdkwc_1709179340)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 12:02:21 +0800
Message-ID: <1709179304.522055-1-xuanzhuo@linux.alibaba.com>
Subject: Re: linux-next: build failure after merge of the vhost tree
Date: Thu, 29 Feb 2024 12:01:44 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240229145531.7f7369cb@canb.auug.org.au>
In-Reply-To: <20240229145531.7f7369cb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Thu, 29 Feb 2024 14:55:31 +1100, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the vhost tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> drivers/virtio/virtio_pci_modern.c: In function 'vp_modern_create_avq':
> drivers/virtio/virtio_pci_modern.c:755:34: warning: passing argument 5 of 'vp_dev->setup_vq' makes integer from pointer without a cast [-Wint-conversion]
>   755 |                               avq->name, NULL, VIRTIO_MSI_NO_VECTOR);
>       |                               ~~~^~~~~~
>       |                                  |
>       |                                  char *
> drivers/virtio/virtio_pci_modern.c:755:34: note: expected 'u16' {aka 'short unsigned int'} but argument is of type 'char *'
> drivers/virtio/virtio_pci_modern.c:754:14: error: too many arguments to function 'vp_dev->setup_vq'
>   754 |         vq = vp_dev->setup_vq(vp_dev, &vp_dev->admin_vq.info, avq->vq_index, NULL,
>       |              ^~~~~~
>
> Caused by commit
>
>   4cceb2591a87 ("virtio: find_vqs: pass struct instead of multi parameters")
>
> I have used the vhost tree from next-20240228 for today.

I will post new version for powerpc soon.

Thanks.


>
> --
> Cheers,
> Stephen Rothwell
>

