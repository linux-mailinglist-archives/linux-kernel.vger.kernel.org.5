Return-Path: <linux-kernel+bounces-125613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B1C8929A5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 08:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA052283692
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 07:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A05B79EA;
	Sat, 30 Mar 2024 07:10:21 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A829B7FB;
	Sat, 30 Mar 2024 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711782621; cv=none; b=sLVUoNhemXUF3SqdS0UKOvPLPwVDzqr8ea0lgFcIrND2ojig2D2ENOpqmX1F6NtUb+ZCcdJXl112j9r+K+MqRDC3sQoiwR94/dKvTBy/FJU0ME3cO43NRwbw7SoMUgNXx/sV5T++T9CtmZl5rdDO9bgP230bDSSCaZzY635+epI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711782621; c=relaxed/simple;
	bh=r4Oy+hqcgYLrYbY0rLIagGI+zMskFwfr1KTW2NYfuyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bFUOqHscGoQX5QLi+WgIL9sCpgSU6WHC7q27XESWGWVD5HMqNeFoUP0Enmz2tpMoEjCXzyW95N5Y6zrwD5hpJ8pxNH4qPYwBVx4eGjmdWwcSKDWd11W8mslP6Ojk71M6KDF2aETf1GGDetJrVWd79Iez7acvN0NxrwK5SeFesRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4V67f256PbzNmnP;
	Sat, 30 Mar 2024 15:08:10 +0800 (CST)
Received: from dggpemd200003.china.huawei.com (unknown [7.185.36.122])
	by mail.maildlp.com (Postfix) with ESMTPS id B1FD514010C;
	Sat, 30 Mar 2024 15:10:14 +0800 (CST)
Received: from [10.67.120.171] (10.67.120.171) by
 dggpemd200003.china.huawei.com (7.185.36.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 30 Mar 2024 15:10:14 +0800
Message-ID: <2251e63b-01f9-415f-bae3-9c64b7d7a7ac@huawei.com>
Date: Sat, 30 Mar 2024 15:10:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: uacce - add the null check for the input pointer
 and its pointer members
To: Greg KH <gregkh@linuxfoundation.org>
CC: <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>,
	<linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <shenyang39@huawei.com>, <liulongfang@huawei.com>,
	<qianweili@huawei.com>
References: <20240329062655.3055646-1-huangchenghai2@huawei.com>
 <2024032946-supernova-unstaffed-63ec@gregkh>
 <d6890b98-2f75-4077-b7bc-e995e9901574@huawei.com>
 <2024033032-catalyze-clip-cc53@gregkh>
From: huangchenghai <huangchenghai2@huawei.com>
In-Reply-To: <2024033032-catalyze-clip-cc53@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd200003.china.huawei.com (7.185.36.122)


在 2024/3/30 15:01, Greg KH 写道:
> On Sat, Mar 30, 2024 at 11:34:24AM +0800, huangchenghai wrote:
>> On Fri, Mar 29, 2024 at2:34PM, Greg KH wrote:
>>
>>> On Fri, Mar 29, 2024 at 02:26:55PM +0800, Chenghai Huang wrote:
>>>> The uacce_alloc() is the member of the EXPORT_SYMBOL_GPL. Therefore, null
>>>> pointer verification is added on the pointer type input parameter and its
>>>> pointer members.
>>> I do not understand, why does the export type matter?  Just fix any
>>> callers to use this properly and send proper parameters.  What in-tree
>>> caller needs this?
>>>
>>> thanks,
>>>
>>> greg k-h
>> The interface defined by the export type seems important and the input
>> parameters need to be verified.
> The export type does not matter at all.
>
>> But I understand from your mail that this is the job of the caller.
> Exactly.
>
>> By the way, I still have a confusion. Interfaces like ioctrl, debugfs, read,
>> or write require parameter validation. so what kind of kernel interfaces require
>> parameter validation? Is there a definition?
> Some do, some do not, it depends on the situation.  If data comes from
> an untrusted source (i.e. outside the kernel), then it MUST be validated
> (remember "all input is evil"), but if it's from within the kernel,
> usually it does not.
>
> thanks,
>
> greg k-h

I get it, thank you very much.

thanks,

Chenghai


