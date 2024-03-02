Return-Path: <linux-kernel+bounces-89364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8613886EF6C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2639D1F22D80
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 08:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861F71428E;
	Sat,  2 Mar 2024 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV4Z1F9D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6851426A
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709366693; cv=none; b=uYCiDu1lAWv3Y3ys5eVfc/pZo9BYDQmFZUa3oB+xfJrm8YfM0+ZrRrQo+n6VVz8LX7gqE8F2cr0w3dXiam2NePPn4Sj+CnWfmJ6W6ogTrYBKhV03cib20LNKE6d1ZBtoiu0vMeA4Q7I4UVTzp7bUxcT7iK63b0/qEltJ2VGFiI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709366693; c=relaxed/simple;
	bh=H/YJZEDdXlIWQCIEC0J6BtWB1k5oNc1HPmB0ABvqoJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XU2NSS1GNgbM30pVHLgHzA4x1Lh85EAxzm4K1+2i3Du5aJZOjUxipAWAByWMq4wmjaJl9mPLPK4wrnVMdrbQpl5BZNiKjyPCx3Xv0is3ri40wPfZEPh/NPa/zRTAjTH1Zw5Uu5hGQi5sQhph5hw+uZoXovNA2eVrcE9vdBGhppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV4Z1F9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28717C433C7;
	Sat,  2 Mar 2024 08:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709366693;
	bh=H/YJZEDdXlIWQCIEC0J6BtWB1k5oNc1HPmB0ABvqoJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mV4Z1F9D4w8meE9LccOD7Cm77nWZ24nQRBkgVqvyFDqVxPV44YqymRMj/aWQs8BRP
	 65aB7Vwj2zKFhZNPQN3gG87Z15gh3pgz60HdHr9a0blwqvT+zu+kqWksdFVi5uKaii
	 Of1eIhGtIdqixjuFmR2znd7oBUwl9KBSf7yJ6Wf/0f/fOtH4M1GVHO8sG3z4X2o81R
	 uYRAmoj7NY/14W3X2iWBwCkHzJ5Alc5mCqLKdwrEZTuGIzIFptSuOSXiVFC9TLUeNO
	 sU7yNfLOz4Y9v38Ll7/lPcoZdoz3XDxt5uGjbfv5by52P5VYjyPTRpJv9YEESK/HEI
	 GYVFvy7dgwAEg==
Date: Sat, 2 Mar 2024 00:04:52 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <ZeLdpNGXqkDlU3MU@x130>
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207072435.14182-3-saeed@kernel.org>
 <14aca96c-7525-486c-8f7c-accaddd41456@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <14aca96c-7525-486c-8f7c-accaddd41456@oracle.com>

On 29 Feb 12:44, Vegard Nossum wrote:
>
>On 07/02/2024 08:24, Saeed Mahameed wrote:
>>+static int mlx5ctl_open(struct inode *inode, struct file *file)
>>+{
>>+	struct mlx5_core_dev *mdev;
>>+	struct mlx5ctl_dev *mcdev;
>>+	struct mlx5ctl_fd *mfd;
>>+	int err = 0;
>>+
>>+	mcdev = container_of(file->private_data, struct mlx5ctl_dev, miscdev);
>>+	mcdev_get(mcdev);
>>+	down_read(&mcdev->rw_lock);
>>+	mdev = mcdev->mdev;
>>+	if (!mdev) {
>>+		err = -ENODEV;
>>+		goto unlock;
>>+	}
>>+
>>+	mfd = kzalloc(sizeof(*mfd), GFP_KERNEL_ACCOUNT);
>>+	if (!mfd)
>>+		return -ENOMEM;
>
>goto unlock?
>
>Or why not reorder so you always allocate this before doing anything else?

Good catch !, thanks I will reorder.


