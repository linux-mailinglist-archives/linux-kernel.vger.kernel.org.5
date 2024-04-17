Return-Path: <linux-kernel+bounces-147886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D39E8A7AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD0A1F237E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ACA8820;
	Wed, 17 Apr 2024 03:16:23 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0E79D8;
	Wed, 17 Apr 2024 03:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323783; cv=none; b=Emc5V/4ICAuXOmgnWt5yTo+HIFYqzx9A6dKcN/+/yOe2z/YIeKVqUGoNzAgc8q9ZIWvfeMiO25qoY4OcQPF9usJGvuMC9XHPGLc+s2dTioI0fnOgK4yK9rceVCP08nRxOuz385ZLzZdatjVTN0LnPRvwCxigFggMn2hJQqNLaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323783; c=relaxed/simple;
	bh=BRTuqyo8jhn3CXNmr8weMV6W1aXeEygb4gtcGGj6QBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lh2drkKzxpl+owMitjaNAfirRJ9FZBW4DEdZF3NsV4jNXY5qv7JgF/Q9+q1BcIKZ9aRzL0iYcJ2uNok5CFQkeDYXR5PRPV7FrB0rY+F1sCkuXJxYC6lEpihf/oiGaqLBlErjc6CVrTvMc6VM3/3AxA8NilU16oVtf3Bjsqb0kdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VK5Zk2CH9z2CcRJ;
	Wed, 17 Apr 2024 11:13:18 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 2041D18002F;
	Wed, 17 Apr 2024 11:16:16 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 11:16:15 +0800
Message-ID: <d17de3df-a3f2-4317-92cc-1fd02641328b@huawei.com>
Date: Wed, 17 Apr 2024 11:16:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcachefs: Align the display format of
 `btrees/inodes/keys`
To: Kent Overstreet <kent.overstreet@linux.dev>, Youling Tang
	<youling.tang@linux.dev>
CC: <linux-bcachefs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Youling
 Tang <tangyouling@kylinos.cn>
References: <20240417015448.84294-1-youling.tang@linux.dev>
 <toosz4pt2la6wf2575vwe6efebcbzsy735cq7exmlqhzrgicrf@s7g3rrbvge2l>
 <66ecea56-e4d3-4241-a1dc-378d70555321@linux.dev>
 <fpvnushjgr5txyduvpihevvghv64sdso4p6t3nhhddcjimqh2k@ehzpswsmnxin>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <fpvnushjgr5txyduvpihevvghv64sdso4p6t3nhhddcjimqh2k@ehzpswsmnxin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/4/17 10:59, Kent Overstreet wrote:
> On Wed, Apr 17, 2024 at 10:50:10AM +0800, Youling Tang wrote:
>> Hi, Kent
>> On 17/04/2024 10:20, Kent Overstreet wrote:
>>> On Wed, Apr 17, 2024 at 09:54:48AM +0800, Youling Tang wrote:
>>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>>
>>>> Before patch:
>>>> ```
>>>>    #cat btrees/inodes/keys
>>>>    u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:   mode=40755
>>>>      flags= (16300000)
>>>> ```
>>>>
>>>> After patch:
>>>> ```
>>>>    #cat btrees/inodes/keys
>>>>    u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:
>>>>      mode=40755
>>>>      flags= (16300000)
The flags also with the space after "=". Is it reseonable?
>>> This would print a newline for keys that don't have a value...
>> The original intention was to make the display of the printed content in
>> '__bch2_inode_unpacked_to_text ()' consistent, without considering other
>> callbacks.
>>
>> Or just modify it in the following way?
> 
> Yeah, that's better
> 
> Do it off my master branch though, there's some printbuf imprevements in
> there.
> 
> https://evilpiepirate.org/git/bcachefs.git
> 
>> --- a/fs/bcachefs/inode.c
>> +++ b/fs/bcachefs/inode.c
>> @@ -534,6 +534,8 @@ int bch2_inode_v3_invalid(struct bch_fs *c, struct
>> bkey_s_c k,
>>   static void __bch2_inode_unpacked_to_text(struct printbuf *out,
>> struct bch_inode_unpacked *inode)
>>   {
>> +       prt_newline(out);
>> +
>>          printbuf_indent_add(out, 2);
>>          prt_printf(out, "mode=%o", inode->bi_mode);
>>          prt_newline(out);
>>
>>
>> Thanks,
>> Youling.
> 

