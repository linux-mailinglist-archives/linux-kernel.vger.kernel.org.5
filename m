Return-Path: <linux-kernel+bounces-47499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA45844EAD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5C729672A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175946B3;
	Thu,  1 Feb 2024 01:29:49 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 077FAC2DB
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706750989; cv=none; b=H5COzuKZWVB0SEO3Is2i1tlgn3Zs+SI82/xGsP3Mgw/XdMSzYwo05VRZ4373qAdBPZxLNI3jJTd6+MQ+yYAe7Mbgn5eMRixCsylXbO1VeuLvmYzISvwCv8kMmGNiV25tpwD55uoIcz4rsPzdd91s23OE6kq4ODadvbK9QdoxMIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706750989; c=relaxed/simple;
	bh=nZD3LuJaWSFHpqmqiJ25akrbol3IuhUCS5Xy5nd0ISY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:From:In-Reply-To:
	 Content-Type; b=aPbBSXPJFZJ/hkNUns/zIf8x1/UmZ2V8/fIQy9CFDc6mLPg3LJ2w7ZVTtV/EYdehfOQdziWk9y5/R6rbvtS3OeuRD8o602s5q8+HUIw8gfKnv2xD9lx3Yne8w9cTrA6wuHjjcNA7fU++u3H4DoetQn/IfeI4ByJB5kTIkaXvzEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=didichuxing.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=didichuxing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.64.13])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 98CBF18660130F;
	Thu,  1 Feb 2024 09:29:36 +0800 (CST)
Received: from [172.24.140.10] (10.79.71.101) by
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 09:29:36 +0800
Message-ID: <cb384fac-0de0-4c11-8690-ec12c46da34c@didichuxing.com>
Date: Thu, 1 Feb 2024 09:29:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [sched/eevdf] 2227a957e1:
 BUG:kernel_NULL_pointer_dereference,address
To: Oliver Sang <oliver.sang@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, <aubrey.li@linux.intel.com>,
	<yu.c.chen@intel.com>, Tiwei Bie <tiwei.btw@antgroup.com>, Abel Wu
	<wuyun.abel@bytedance.com>
Content-Language: en-US
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 10.79.64.13
From: Honglei Wang <wanghonglei@didichuxing.com>
In-Reply-To: <ZbkDIlIR7qzPt7Vk@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZJY02-PUBMBX-01.didichuxing.com (10.79.65.31) To
 ZJY01-ACTMBX-03.didichuxing.com (10.79.64.13)



On 2024/1/30 22:09, Oliver Sang wrote:
> hi, Abel,
> 
> On Tue, Jan 30, 2024 at 06:13:32PM +0800, Abel Wu wrote:
>> On 1/30/24 3:24 PM, kernel test robot Wrote:
>>>
>>>
>>> Hello,
>>>
>>> (besides a previous performance report),
>>> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
>>>
>>> commit: 2227a957e1d5b1941be4e4207879ec74f4bb37f8 ("sched/eevdf: Sort the rbtree by virtual deadline")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>
>>> [test failed on linus/master 3a5879d495b226d0404098e3564462d5f1daa33b]
>>> [test failed on linux-next/master 01af33cc9894b4489fb68fa35c40e9fe85df63dc]
>>>
>>> in testcase: trinity
>>> version: trinity-i386-abe9de86-1_20230429

Hi Oliver,

I'm a bit curious, did the problem happen on i386 only? Did you hit it 
on x86_64 or other platform with the same trinity testcases?

Thanks,
Honglei

