Return-Path: <linux-kernel+bounces-48020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7A6845656
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5001C240EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C78F15D5B4;
	Thu,  1 Feb 2024 11:37:32 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2015D5A7;
	Thu,  1 Feb 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787451; cv=none; b=qRKrzDXDQpTqqfcv8hs5eOVSiUy8fFBo9Hju4i3b6MMRpaoErAyqMwc09Ix8vXVM1etS7YR+FriOQneCSdg1alwfQ9uS014mNzSOPg1uyRApCJUTc9uD4nM7M4N9NBDU+ufqlIj6l9wzBMrSwadXBaeYEEuUKBPlzXUbHqsCTn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787451; c=relaxed/simple;
	bh=WK2M+igzvkFNxwmmkFufPf/3i1QW4p0L5XQuTx6V0R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ub7Yi5HHY9MAEGth9jiL9c+t1Kt3ULEgPNf2sqcihpeaU8EuEupbJtB650KR3/KgMCSj5XJ0xNyJyAZbYsU715qej+c7qkdhLm0o114GbY4GQ94AbZecGsOIunKAb2FrVEuVTNXt1F2c3zVN08hT8kLrgEWEAX9NNn4lfJT4ufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TQcKM5THLz29kYk;
	Thu,  1 Feb 2024 19:35:35 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E78A14040D;
	Thu,  1 Feb 2024 19:37:27 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 19:37:25 +0800
Message-ID: <3009aadd-69d6-c797-20b4-95cf926b6dd9@huawei.com>
Date: Thu, 1 Feb 2024 19:37:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to
 MCE_IN_KERNEL_COPY_MC
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	<wangkefeng.wang@huawei.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck
	<tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Naoya
 Horiguchi <naoya.horiguchi@nec.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-mm@kvack.org>, Guohanjun
	<guohanjun@huawei.com>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <20240111135548.3207437-3-tongtiangen@huawei.com>
 <20240131070258.GGZbnwov0g918F-FGz@fat_crate.local>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20240131070258.GGZbnwov0g918F-FGz@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)



在 2024/1/31 15:02, Borislav Petkov 写道:
> On Thu, Jan 11, 2024 at 09:55:47PM +0800, Tong Tiangen wrote:
>> Currently, there are some kernel memory copy scenarios is also mc safe
>> which use copy_mc_to_kernel() or copy_mc_user_highpage().
> 
> Both of those end up in copy_mc_enhanced_fast_string() which does
> EX_TYPE_DEFAULT_MCE_SAFE.

OK, how about this commit msg change? :)

Currently, there are some kernel memory copy scenarios is also mc safe
which use copy_mc_to_kernel() or copy_mc_user_highpage(), **both of 
those end up in copy_mc_enhanced_fast_string() or copy_mc_fragile() 
which does EX_TYPE_DEFAULT_MCE_SAFE.**

In these scenarios, posion pages need to be isolated too. Therefore, a
macro similar to MCE_IN_KERNEL_COPYIN is required. For this reason, we
can rename MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC, the new macro
can be applied to both user-to-kernel mc safe copy and kernel-to-kernel
mc safe copy.

Thanks.
Tong.

> 

