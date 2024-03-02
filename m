Return-Path: <linux-kernel+bounces-89363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E906186EF6B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CFA281BD5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 08:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68812B9F;
	Sat,  2 Mar 2024 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar6BLWrf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CDF11C82;
	Sat,  2 Mar 2024 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709366632; cv=none; b=ZjVMCVmVjHEiVVZF1GOrk+g4FYoaBn8Kv/kr3nOLWtONa0QskbP4cV5nKG6YdZ5bUTj6VQXqSLazX7dzmUAvcDupE4CkofwLsECjHKr8NK1UtG36BLNO9eH+343M8RRqFhk6I9/9sXU/Qp8XA6k3yufRdtIoJe+LAHy071sJnDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709366632; c=relaxed/simple;
	bh=iLkoAAFp9B+Iiazgd42bfbnBTX49YWjdJO2wLKJivbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giuaeobuBwZ1LmeMsjNvB4JukrDzgqJ+raTdavjATvZFvMN60zNxHzJgU186xV91tecdkYGLKYnPcqWdVmaP2TT3N/i+Mb92lnVPLEsU/aASqULHK8Y6shqONgX7fEqcrUgrR2uZ2AP9XAKHU/bv+I11mnqExaG3N8OGNeL24nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar6BLWrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA68C433F1;
	Sat,  2 Mar 2024 08:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709366631;
	bh=iLkoAAFp9B+Iiazgd42bfbnBTX49YWjdJO2wLKJivbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ar6BLWrfx01/2OynHfhCsdnHlK2Ew2UYQQu/PYWV9edoumn1NCcH0l81eYVcGqDL1
	 cnYR5OKILRLmuUtQnDLuOqOSkISMlLiE4KJRQkMSBFPnukTF9Lw+2YmvNX/Jbq3PAJ
	 qXWqCqXaVwF0yv9F4EXOahoYo8HxSScSoPSf38rRDiPD09oIZK0Dm/tTSnuL4TQajW
	 Y+8CO+kThPe7PN+Pfdt1JeRvQcIytf2kGOzdtpqacH2pRXUd47fnQHJbHMnZAJTy2A
	 riSp+PVmpjBxg3hkrmntxm1XdAO8Qj2cQjUxSvMnxk4e9WBdBlHacHGvw9eA/xcw23
	 yHHgMsm4V2aVg==
Date: Sat, 2 Mar 2024 00:03:49 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-api@vger.kernel.org,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/5] misc: mlx5ctl: Add info ioctl
Message-ID: <ZeLdZbB02OcuoWku@x130>
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207072435.14182-4-saeed@kernel.org>
 <bb259840-35b6-4483-8e76-8046cae1269b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bb259840-35b6-4483-8e76-8046cae1269b@oracle.com>

On 29 Feb 12:47, Vegard Nossum wrote:
>
>On 07/02/2024 08:24, Saeed Mahameed wrote:
>>+static int mlx5ctl_info_ioctl(struct file *file,
>>+			      struct mlx5ctl_info __user *arg,
>>+			      size_t usize)
>>+{
>>+	struct mlx5ctl_fd *mfd = file->private_data;
>>+	size_t ksize = sizeof(struct mlx5ctl_info);
>>+	struct mlx5ctl_dev *mcdev = mfd->mcdev;
>>+	struct mlx5_core_dev *mdev = mcdev->mdev;
>>+	struct mlx5ctl_info *info;
>>+	int err = 0;
>>+
>>+	if (usize < ksize)
>>+		return -EINVAL;
>>+
>>+	info = kzalloc(ksize, GFP_KERNEL);
>>+	if (!info)
>>+		return -ENOMEM;
>
>struct mlx5ctl_info is small, why not put it on the stack or even copy
>it directly from the original object, assuming it has no holes/padding?
>

There's no original object, but yes storing it on the stack should work.

>>+
>>+	info->dev_uctx_cap = MLX5_CAP_GEN(mdev, uctx_cap);
>>+	info->uctx_cap = mfd->uctx_cap;
>>+	info->uctx_uid = mfd->uctx_uid;
>>+	info->ucap = mfd->ucap;
>>+
>>+	if (copy_to_user(arg, info, ksize))
>>+		err = -EFAULT;
>>+
>>+	kfree(info);
>>+	return err;
>>+}
>
>Is there even a remote possibility of extending this structure in the
>future? If so the size check will not allow you to be backwards
>compatible. Should there be a version field in there or would you
>just add a new ioctl altogether? Adding linux-api@vger.kernel.org to Cc.
>

This was my original implementation, but Greg's preference is to allow no
extension to the ioctl structures, in case of extension required, new IOCTL
and structure should be introduced.

>>diff --git a/include/uapi/misc/mlx5ctl.h b/include/uapi/misc/mlx5ctl.h
>>new file mode 100644
>>index 000000000000..9be944128025
>>--- /dev/null
>>+++ b/include/uapi/misc/mlx5ctl.h
>>@@ -0,0 +1,20 @@
>>+/* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0 WITH Linux-syscall-note */
>>+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
>>+
>>+#ifndef __MLX5CTL_IOCTL_H__
>>+#define __MLX5CTL_IOCTL_H__
>>+
>>+struct mlx5ctl_info {
>>+	__u16 uctx_uid; /* current process allocated UCTX UID */
>>+	__u16 reserved1; /* explicit padding must be zero */
>>+	__u32 uctx_cap; /* current process effective UCTX cap */
>>+	__u32 dev_uctx_cap; /* device's UCTX capabilities */
>>+	__u32 ucap; /* process user capability */
>>+};
>>+
>>+#define MLX5CTL_IOCTL_MAGIC 0x5c
>>+
>>+#define MLX5CTL_IOCTL_INFO \
>>+	_IOR(MLX5CTL_IOCTL_MAGIC, 0x0, struct mlx5ctl_info)
>>+
>>+#endif /* __MLX5CTL_IOCTL_H__ */
>
>Should you add anything to Documentation/ABI/ ? (Or add other
>documentation for this driver?)
>

The driver doesn't expose any sysfs other than the IOCTLs, but yes
a documentation might be useful to make sure ABI is stable, most of the
other drivers point out to the uapi header for documentation.


