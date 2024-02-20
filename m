Return-Path: <linux-kernel+bounces-72221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D283185B0EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33922284D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7142E3E1;
	Tue, 20 Feb 2024 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YB6NFOq7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA258C04;
	Tue, 20 Feb 2024 02:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708396749; cv=none; b=k1EAe3TTLxCG8TWOlPipgX4McivJf+Y/Csbd3OWF0P7EjzEoRW7nruwhVoXmykBiIPwsYhNlptBzwclge7jVVe3ZUpINrKXe1WQ5ee57NxM2mqM98Q7aq4aP/3HlFuUYzLUp2+XckyIeUaDWZSXqMv36IlaBxbqmsK/8hjHDMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708396749; c=relaxed/simple;
	bh=IMwzauYZetrMijGUdyA3fsIO45z89hM65VuA1iwSV/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7JzoGLADWYHkhf+PFpSgAE7Xea2rtcGfBYgZIJ9v3vm8/vOsbZfg9svoS1/pYBb8JU0Db+lPvH797aJxxAT3vMyfBgQJYzDSnzCGTtqe3v5OgFXBdznKMgJ4TRae+Nw86UfWfXPGHLT0BJVq0Gu7QOGATF/shg7QPxrgWeTg2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YB6NFOq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C98C433F1;
	Tue, 20 Feb 2024 02:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708396748;
	bh=IMwzauYZetrMijGUdyA3fsIO45z89hM65VuA1iwSV/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YB6NFOq76aBrk1UjP07/9OTebNduLf+HeewS19UjQ16nt8QoxeiQhyW8vrJMGwxDN
	 wF4BoSSpTb1418jqu29RqMJACKjPDmd045ibXmEppdhRjcR0GiZ/UJUrROONjoJV+8
	 UAuTHquJ9kkq+/FAuuLjcip0UOTGfHqC/4GPhCOTar28LXFqX+c4NgGD0sngUkUNPW
	 tLA1+XwXHVMASPoJRiva6tIBUDDHTdEPYn0GntilA8MdJBhrtng/WvMpGi6jyTZYVg
	 fsp+y4gjM3PA9Xgh55LBrGmLVRAILHITbuQx/x/XkJDj/JlO4mRGwLGitqnStBCDR8
	 Vb3EOsri+ab7w==
Message-ID: <2247088a-aed0-4120-93a5-cf52a829db26@kernel.org>
Date: Tue, 20 Feb 2024 10:39:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression 6.1.y] f2fs: invalid zstd compress level: 6
Content-Language: en-US
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Dhya <dhya@picorealm.net>, 1063422@bugs.debian.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
References: <170736382774.1975.1861975122613668970.reportbug@tsuga.picorealm.net>
 <ZcU3VCrt9VOpuFUq@eldamar.lan>
 <6d14ea70-ac1c-46f2-af1d-ba34ea0165aa@kernel.org>
 <ZdOx73kckFXADcol@eldamar.lan>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZdOx73kckFXADcol@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/20 3:54, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Mon, Feb 19, 2024 at 10:35:13AM +0800, Chao Yu wrote:
>> On 2024/2/9 4:19, Salvatore Bonaccorso wrote:
>>> Hi Jaegeuk Kim, Chao Yu,
>>>
>>> In Debian the following regression was reported after a Dhya updated
>>> to 6.1.76:
>>>
>>> On Wed, Feb 07, 2024 at 10:43:47PM -0500, Dhya wrote:
>>>> Package: src:linux
>>>> Version: 6.1.76-1
>>>> Severity: critical
>>>> Justification: breaks the whole system
>>>>
>>>> Dear Maintainer,
>>>>
>>>> After upgrade to linux-image-6.1.0-18-amd64 6.1.76-1 F2FS filesystem
>>>> fails to mount rw.  Message in the boot journal:
>>>>
>>>>     kernel: F2FS-fs (nvme0n1p6): invalid zstd compress level: 6
>>>>
>>>> There was recently an f2fs patch to the 6.1 kernel tree which might be
>>>> related: https://www.spinics.net/lists/stable-commits/msg329957.html
>>>>
>>>> Was able to recover the system by doing:
>>>>
>>>> sudo mount -o remount,rw,relatime,lazytime,background_gc=on,discard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,extent_cache,mode=adaptive,active_logs=6,alloc_mode=default,checkpoint_merge,fsync_mode=posix,compress_algorithm=lz4,compress_log_size=2,compress_mode=fs,atgc,discard_unit=block,memory=normal /dev/nvme0n1p6 /
>>>>
>>>> under the running bad 6.1.0-18-amd64 kernel, then editing
>>>> /etc/default/grub:
>>>>
>>>>     GRUB_DEFAULT="Advanced options for Debian GNU/Linux>Debian GNU/Linux, with Linux 6.1.0-17-amd64"
>>>>
>>>> and running 'update-grub' and rebooting to boot the 6.1.0-17-amd64
>>>> kernel.
>>>
>>> The issue is easily reproducible by:
>>>
>>> # dd if=/dev/zero of=test.img count=100 bs=1M
>>> # mkfs.f2fs -f -O compression,extra_attr ./test.img
>>> # mount -t f2fs -o compress_algorithm=zstd:6,compress_chksum,atgc,gc_merge,lazytime ./test.img /mnt
>>>
>>> resulting in
>>>
>>> [   60.789982] F2FS-fs (loop0): invalid zstd compress level: 6
>>
>> Hi Salvatore,
>>
>> Can you please try below fixes:
>>
>> [PATCH 6.1] f2fs: add helper to check compression level
>> https://lore.kernel.org/linux-f2fs-devel/20240212160530.1017205-1-chao@kernel.org
> 
> Confirmed that this fixes the reported issue as it was reported to us
> in Debian in https://bugs.debian.org/1063422 . Thanks a lot!
> (note just tested with the first commit as it landed in 6.1.78 to
> confirm the immediate regression).
> 
> #regzbot fixed-by: cf3d57ad6ff8b566deba3544b9ad3384781fb604

Hi,

Thank you for confirmation.

Thanks,

> 
> Regards,
> Salvatore

