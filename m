Return-Path: <linux-kernel+bounces-111405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB593886BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08413B22AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAED93FBA4;
	Fri, 22 Mar 2024 12:10:23 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239241EF12
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109423; cv=none; b=iW+B78AUCk7mlec70agt4bb0E+SBtPC3iFqPEIeTwwRrJVN8CS42k5z4sylMEHC1VeTaofcBAj/plvgun6IcLVzYBmDJoZWoNlPagbBnVkPmJURobYi/V1SOU9ViybZGIPmHxgcywRG52C4hmCzqCrIn3UYMcPV7FKUjSZVSy38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109423; c=relaxed/simple;
	bh=fzHpYpqoTDIMku6jNCaWzH3Jusb3SuDQiK7r1jXcAsU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=W1T1BqqJU5i7KDSfGVYtnhmt4D1EQjtq3XHTBe19tzINPUGOdeDTeacewW2MwicySgw4VCPSKJoU8KhACJsWeV25IVGBEmJ/9KO/hh0ta1rR9nN7NRtyQ8o6xXalvtjN8VbUbV1k9JrE8V93DkgionQmp3ERoxq6ky+s9jMnAhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V1Ljm15h3z1GCkx;
	Fri, 22 Mar 2024 20:09:48 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id A03C614013B;
	Fri, 22 Mar 2024 20:10:13 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 20:10:12 +0800
Subject: Re: [RFC PATCH 4/5] ubifs: Introduce ACLs mount options
To: Li Zetao <lizetao1@huawei.com>, <richard@nod.at>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
References: <20240319161646.2153867-1-lizetao1@huawei.com>
 <20240319161646.2153867-5-lizetao1@huawei.com>
 <c3d5f06e-bdc4-4312-19a1-17a7a64e8795@huawei.com>
 <b91ebdb0-bcca-18f9-6f0f-5eef6c72b42c@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <4c30c8e4-92fe-9935-b2ee-7b5728f261fc@huawei.com>
Date: Fri, 22 Mar 2024 20:10:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b91ebdb0-bcca-18f9-6f0f-5eef6c72b42c@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/3/22 20:05, Li Zetao 写道:
> Hi,
> 
> On 2024/3/21 14:49, Zhihao Cheng wrote:
>> 在 2024/3/20 0:16, Li Zetao 写道:
>>> Implement the ability to enable or disable the ACLs feature through
>>> mount options. "-o acl" option means enable and "-o noacl" means disable
>>> and it is enable by default.
>>>
>>> Signed-off-by: Li Zetao <lizetao1@huawei.com>

[...]
>>> @@ -2011,12 +2041,17 @@ static int ubifs_remount_fs(struct 
>>> super_block *sb, int *flags, char *data)
>>>       sync_filesystem(sb);
>>>       dbg_gen("old flags %#lx, new flags %#x", sb->s_flags, *flags);
>>> +    c->mount_opts.acl = 0;
>>>       err = ubifs_parse_options(c, data, 1);
>>
>> 1. mount -onoacl /dev/ubi0_0 /mnt # After that, mount will show 
>> 'noacl' option
>> 2. mount -oremount,xxx /dev/ubi0_0 /mnt
>> If 'xxx' has nothing to do with acl, c->mount_opts.acl is set as '0'. 
>> Then superblock flag is assigned with 'SB_POSIXACL' and mount will not 
>> display 'nocal'. Will it make user confused?
> I have tested this use case and it works fine. This is because the mount 
> options will be re-parsed during remount, just like the last mount. But 
> this is indeed redundant. I adjusted it to make it more reasonable.

Yes, parameter 'data' carries old mount information. Removing the 
redundant assignment is fine.

