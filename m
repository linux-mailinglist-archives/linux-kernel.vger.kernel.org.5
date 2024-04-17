Return-Path: <linux-kernel+bounces-148272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B2C8A8019
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC93AB21535
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBDE136E1B;
	Wed, 17 Apr 2024 09:49:48 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE96132807;
	Wed, 17 Apr 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347387; cv=none; b=hY/Y0p/hCstqfX/2kReFzM865ooyM2oqrDp/rvlweDJuEfHQIsYl7L7zqolx4vSNJfHPlbYN2UdBLxCLtYXWpNyQVdlVLhyWru6SwhjS4jn8dN1OIiBTnLCxegGu9vkAyaQ284KadP+QgTuVm7924gBDj27yuLKq8mEfBywu4rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347387; c=relaxed/simple;
	bh=plntP41Bw89KrCuZnohgRitGb2UlB4IujMdB/ywEKbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IxM8NLRUI7O1zsEFM8sShvGQywTB/mQTr9NEfpgDgh464RMbvg53IMDL1ZSlXrPpqXpOsxxMQY2P0yRoU8IDxIUMEv9KgMjb0FXpInQDt1fGnydVpHVRR+GbDNEas8u3i9XDr1mieU+eigtlv+LmLO+kKEplajxF2FnXGKOvgUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VKGJh1Z6pz1RDCb;
	Wed, 17 Apr 2024 17:46:44 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 970BE1A016C;
	Wed, 17 Apr 2024 17:49:42 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 17:49:42 +0800
Message-ID: <72e1b795-7219-41dd-83f2-10a3be2680b2@huawei.com>
Date: Wed, 17 Apr 2024 17:49:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bcachefs: Align the display format of
 `btrees/inodes/keys`
Content-Language: en-US
To: Youling Tang <youling.tang@linux.dev>, Kent Overstreet
	<kent.overstreet@linux.dev>
CC: <linux-bcachefs@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Youling
 Tang <tangyouling@kylinos.cn>
References: <20240417015448.84294-1-youling.tang@linux.dev>
 <toosz4pt2la6wf2575vwe6efebcbzsy735cq7exmlqhzrgicrf@s7g3rrbvge2l>
 <66ecea56-e4d3-4241-a1dc-378d70555321@linux.dev>
 <fpvnushjgr5txyduvpihevvghv64sdso4p6t3nhhddcjimqh2k@ehzpswsmnxin>
 <d17de3df-a3f2-4317-92cc-1fd02641328b@huawei.com>
 <29d5ea19-21b5-4076-9acc-8286a050c33f@huawei.com>
 <63d9540f-61bc-4eba-819c-c05d2e486bdb@linux.dev>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <63d9540f-61bc-4eba-819c-c05d2e486bdb@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/4/17 13:51, Youling Tang wrote:
> Hi, Kent & Hongbo
> On 17/04/2024 11:21, Hongbo Li wrote:
>>
>>
>> On 2024/4/17 11:16, Hongbo Li wrote:
>>>
>>>
>>> On 2024/4/17 10:59, Kent Overstreet wrote:
>>>> On Wed, Apr 17, 2024 at 10:50:10AM +0800, Youling Tang wrote:
>>>>> Hi, Kent
>>>>> On 17/04/2024 10:20, Kent Overstreet wrote:
>>>>>> On Wed, Apr 17, 2024 at 09:54:48AM +0800, Youling Tang wrote:
>>>>>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>>>>>
>>>>>>> Before patch:
>>>>>>> ```
>>>>>>>    #cat btrees/inodes/keys
>>>>>>>    u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0: mode=40755
>>>>>>>      flags= (16300000)
>>>>>>> ```
>>>>>>>
>>>>>>> After patch:
>>>>>>> ```
>>>>>>>    #cat btrees/inodes/keys
>>>>>>>    u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:
>>>>>>>      mode=40755
>>>>>>>      flags= (16300000)
>>> The flags also with the space after "=". Is it reseonable?
>> Sorry, I misspell. I mean whether it is reasonable.
>>>>>> This would print a newline for keys that don't have a value...
>>>>> The original intention was to make the display of the printed 
>>>>> content in
>>>>> '__bch2_inode_unpacked_to_text ()' consistent, without considering 
>>>>> other
>>>>> callbacks.
>>>>>
>>>>> Or just modify it in the following way?
>>>>
>>>> Yeah, that's better
>>>>
>>>> Do it off my master branch though, there's some printbuf 
>>>> imprevements in
>>>> there.
>>>>
>>>> https://evilpiepirate.org/git/bcachefs.git
> I will make the following changes based on the master branch,
> 
> --- a/fs/bcachefs/inode.c
> 
> +++ b/fs/bcachefs/inode.c
> @@ -534,12 +534,13 @@ int bch2_inode_v3_invalid(struct bch_fs *c, struct 
> bkey_s_c k,
>   static void __bch2_inode_unpacked_to_text(struct printbuf *out,
>                                            struct bch_inode_unpacked 
> *inode)
>   {
> +       prt_printf(out, "\n");
>          printbuf_indent_add(out, 2);
>          prt_printf(out, "mode=%o\n", inode->bi_mode);
> 
>          prt_str(out, "flags=");
>          prt_bitflags(out, bch2_inode_flag_strs, inode->bi_flags & ((1U 
> << 20) - 1));
> -       prt_printf(out, " (%x)\n", inode->bi_flags);
> +       prt_printf(out, "(%x)\n", inode->bi_flags);
I think it's ok. Maybe use prt_newline(out) is better than 
prt_printf(out, "\n");
>>>>
>>>>> --- a/fs/bcachefs/inode.c
>>>>> +++ b/fs/bcachefs/inode.c
>>>>> @@ -534,6 +534,8 @@ int bch2_inode_v3_invalid(struct bch_fs *c, struct
>>>>> bkey_s_c k,
>>>>>   static void __bch2_inode_unpacked_to_text(struct printbuf *out,
>>>>> struct bch_inode_unpacked *inode)
>>>>>   {
>>>>> +       prt_newline(out);
>>>>> +
>>>>>          printbuf_indent_add(out, 2);
>>>>>          prt_printf(out, "mode=%o", inode->bi_mode);
>>>>>          prt_newline(out);
>>>>>
>>>>>
>>>>> Thanks,
>>>>> Youling.
>>>>
>>>

