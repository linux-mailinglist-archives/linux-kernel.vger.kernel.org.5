Return-Path: <linux-kernel+bounces-9553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0647881C774
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D321F2606E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB47711727;
	Fri, 22 Dec 2023 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZhci2aW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD62111BB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:42:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6976AC433C9;
	Fri, 22 Dec 2023 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703238134;
	bh=p+9roaFx+Oo4gZM40YyRYFkahWCjHc9Sy1wNuH0y9WM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iZhci2aWpuaGAaOrTNKMieA4iw4G+bU6RH4UA2qo4oDdTfD/j+jKG6p4AsJ51A75v
	 hEJPNrB90XPZ6s+vgV8PTBHBN8aLfgRUdJ1Mlb5GcMyBZQVCW7V4pTuOnWsMsSDr7c
	 2ohYD5EROTkO5KgoeovDgtNHdTrqyrPODDSG3W3sxZlxwG6nx2h6g32czwbrT5ZpGd
	 goSfbv4BqXDhMnDfwhHvy+I2P0Dm/dHIeyjDMiLk2D4DkH/ch+/otn1TfhDZ2b3BEc
	 MGo0ZtyKKVJfNaVT0LFVhJQPuvrym+Q8PAUf6B0eBenqE1SQYc3ATj9lRIjjOsBdn7
	 Aqg6EOBVlvD/Q==
Message-ID: <4d173489-a950-4af2-8ec0-fd9ace4f3370@kernel.org>
Date: Fri, 22 Dec 2023 17:42:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] f2fs: Constrain the modification range of dir_level
 in the sysfs
Content-Language: en-US
To: Yongpeng Yang <yangyongpeng1@oppo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20231222032901.3861649-1-yangyongpeng1@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231222032901.3861649-1-yangyongpeng1@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/12/22 11:29, Yongpeng Yang wrote:
> The {struct f2fs_sb_info}->dir_level can be modified through the sysfs
> interface, but its value range is not limited. If the value exceeds
> MAX_DIR_HASH_DEPTH and the mount options include "noinline_dentry",
> the following error will occur:
> [root@fedora ~]# mount -o noinline_dentry /dev/sdb  /mnt/sdb/
> [root@fedora ~]# echo 128 > /sys/fs/f2fs/sdb/dir_level
> [root@fedora ~]# cd /mnt/sdb/
> [root@fedora sdb]# mkdir test
> [root@fedora sdb]# cd test/
> [root@fedora test]# mkdir test
> mkdir: cannot create directory 'test': Argument list too long
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

