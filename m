Return-Path: <linux-kernel+bounces-112192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C248876C4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8DB1C228D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0732115A4;
	Sat, 23 Mar 2024 02:55:35 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8AA372;
	Sat, 23 Mar 2024 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711162534; cv=none; b=mdChYaJuV9ocdhRp60zGs3LF4mMfFEa7tn27UkCugklcdKw0pj7d4kQcPabF/V1TOjyaBPlcYGUexrFdydkbOYEp46LgdN5kwDMrjSZZTz0eK9UkYcEt7L/ez8fiLkc+uW1r5p5juMYr3qCetZCwuqCvEp9ZVB/NMl/Sst7ZfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711162534; c=relaxed/simple;
	bh=FV29HYD57w+vLBsKMe0bPwW2xX/lvZ3FV0v/LpPLoC0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jnd+SDuMKknsE3/fWR2GwAPJt7Ri3Q7tFABCyb24/mhtULeRD70oHEu3wt1v65j3x724EmEAYjH8wAOJQ5ID5B5/JkTUgfEU+TowaFPhSC6UFpXosqpnAKBfImtTPqTVnzgpudm4NY7ic0EaVSjcAGVYgwkoNoMB/+NWfgJNNp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V1kLn1J3hz1vx4F;
	Sat, 23 Mar 2024 10:54:41 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 93D79140258;
	Sat, 23 Mar 2024 10:55:28 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 23 Mar 2024 10:55:27 +0800
Subject: Re: [RFC PATCH v2 5/5] ubifs: Introduce ACLs mount options
To: Li Zetao <lizetao1@huawei.com>, <richard@nod.at>, <corbet@lwn.net>,
	<kent.overstreet@linux.dev>, <agruenba@redhat.com>
CC: <linux-mtd@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240322154812.215369-1-lizetao1@huawei.com>
 <20240322154812.215369-6-lizetao1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e10b4182-a6b6-25f5-b04d-92bc20fa56d4@huawei.com>
Date: Sat, 23 Mar 2024 10:55:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240322154812.215369-6-lizetao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/22 23:48, Li Zetao Ð´µÀ:
> Implement the ability to enable or disable the ACLs feature through
> mount options. "-o acl" option means enable and "-o noacl" means disable
> and it is enable by default.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
> v1 -> v2:
>    * Remove redundant assignments to mount.acl.
>    * Added the description of acl mount options in ubifs.rst.
> 
> v1: https://lore.kernel.org/all/20240319161646.2153867-5-lizetao1@huawei.com/
> 
>   Documentation/filesystems/ubifs.rst |  4 +++
>   fs/ubifs/super.c                    | 41 +++++++++++++++++++++++++++++
>   fs/ubifs/ubifs.h                    |  2 ++
>   3 files changed, 47 insertions(+)
> 
> diff --git a/Documentation/filesystems/ubifs.rst b/Documentation/filesystems/ubifs.rst
> index ced2f7679ddb..f9615104d7a3 100644
> --- a/Documentation/filesystems/ubifs.rst
> +++ b/Documentation/filesystems/ubifs.rst
> @@ -105,6 +105,10 @@ auth_key=		specify the key used for authenticating the filesystem.
>   auth_hash_name=		The hash algorithm used for authentication. Used for
>   			both hashing and for creating HMACs. Typical values
>   			include "sha256" or "sha512"
> +noacl			This option disables POSIX Access Control List support. If ACL support
> +			is enabled in the kernel configuration (CONFIG_EXT4_FS_POSIX_ACL), ACL
> +			is enabled by default on mount. See the acl(5) manual page for more
> +			information about acl.
Also add acl description?
Split documentation into a new patch?

