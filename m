Return-Path: <linux-kernel+bounces-147969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEC48A7BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FDD1C21400
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8776F53389;
	Wed, 17 Apr 2024 05:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Geqoz+z6"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624C652F6A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713333116; cv=none; b=dyv2jYhUkT2VUHg1SEbsYO77V9j7KfGsa7mRIOCd4ykamVdZvHOstUPnK4sIAtjwbQuSHRK6HCkr9zRrVL4P5wIF7NNDxU84NIef/gAC+FRNb99WNCMbhky3fHzuq1mns4r8GDim6F8zQxJSB+awTWmUthQd97AxuaggfQDQ+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713333116; c=relaxed/simple;
	bh=w7HryCv2MkFLy3CMuRvGthJHQXfYUYmVwkRRMXWvh3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhBLcIlgdQm1/ffGMWHLUjgwrZx8AQlOD1LfF55o9wgs38NrI0pMBjHdrAPSsTYotBbFSGob3yKjVmeH1v/rhrKr3xyV3AeTEbOqYXMVMzSe9LG8nXPVmgIcqC201wnr7P+HA0rQeIMwP0gieBz6ypazElMIR0rF+VC/4OPW/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Geqoz+z6; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <63d9540f-61bc-4eba-819c-c05d2e486bdb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713333111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2Dby/WRTliM9FBH5twXlHiebzbOlY7PIwOVs26Z0d0=;
	b=Geqoz+z6jqUXVuY2jrltHv4ffLMCgMmQ5/OMLSqlm9R29FRjsuVrVOk8debuq6epazkYIF
	kNWWCF2RSkhdmQjMptPX4z8XOuIRuHQaKCGs1mZYANfT6ZE6A32ckgCjrlxdnVNWieugbm
	GyMhxz+TukJmLpRd4GGzCu6ZXDVY2ug=
Date: Wed, 17 Apr 2024 13:51:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bcachefs: Align the display format of
 `btrees/inodes/keys`
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20240417015448.84294-1-youling.tang@linux.dev>
 <toosz4pt2la6wf2575vwe6efebcbzsy735cq7exmlqhzrgicrf@s7g3rrbvge2l>
 <66ecea56-e4d3-4241-a1dc-378d70555321@linux.dev>
 <fpvnushjgr5txyduvpihevvghv64sdso4p6t3nhhddcjimqh2k@ehzpswsmnxin>
 <d17de3df-a3f2-4317-92cc-1fd02641328b@huawei.com>
 <29d5ea19-21b5-4076-9acc-8286a050c33f@huawei.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <29d5ea19-21b5-4076-9acc-8286a050c33f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi, Kent & Hongbo
On 17/04/2024 11:21, Hongbo Li wrote:
>
>
> On 2024/4/17 11:16, Hongbo Li wrote:
>>
>>
>> On 2024/4/17 10:59, Kent Overstreet wrote:
>>> On Wed, Apr 17, 2024 at 10:50:10AM +0800, Youling Tang wrote:
>>>> Hi, Kent
>>>> On 17/04/2024 10:20, Kent Overstreet wrote:
>>>>> On Wed, Apr 17, 2024 at 09:54:48AM +0800, Youling Tang wrote:
>>>>>> From: Youling Tang <tangyouling@kylinos.cn>
>>>>>>
>>>>>> Before patch:
>>>>>> ```
>>>>>>    #cat btrees/inodes/keys
>>>>>>    u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0: mode=40755
>>>>>>      flags= (16300000)
>>>>>> ```
>>>>>>
>>>>>> After patch:
>>>>>> ```
>>>>>>    #cat btrees/inodes/keys
>>>>>>    u64s 17 type inode_v3 0:4096:U32_MAX len 0 ver 0:
>>>>>>      mode=40755
>>>>>>      flags= (16300000)
>> The flags also with the space after "=". Is it reseonable?
> Sorry, I misspell. I mean whether it is reasonable.
>>>>> This would print a newline for keys that don't have a value...
>>>> The original intention was to make the display of the printed 
>>>> content in
>>>> '__bch2_inode_unpacked_to_text ()' consistent, without considering 
>>>> other
>>>> callbacks.
>>>>
>>>> Or just modify it in the following way?
>>>
>>> Yeah, that's better
>>>
>>> Do it off my master branch though, there's some printbuf 
>>> imprevements in
>>> there.
>>>
>>> https://evilpiepirate.org/git/bcachefs.git
I will make the following changes based on the master branch,

--- a/fs/bcachefs/inode.c

+++ b/fs/bcachefs/inode.c
@@ -534,12 +534,13 @@ int bch2_inode_v3_invalid(struct bch_fs *c, struct 
bkey_s_c k,
  static void __bch2_inode_unpacked_to_text(struct printbuf *out,
                                           struct bch_inode_unpacked *inode)
  {
+       prt_printf(out, "\n");
         printbuf_indent_add(out, 2);
         prt_printf(out, "mode=%o\n", inode->bi_mode);

         prt_str(out, "flags=");
         prt_bitflags(out, bch2_inode_flag_strs, inode->bi_flags & ((1U 
<< 20) - 1));
-       prt_printf(out, " (%x)\n", inode->bi_flags);
+       prt_printf(out, "(%x)\n", inode->bi_flags);
>>>
>>>> --- a/fs/bcachefs/inode.c
>>>> +++ b/fs/bcachefs/inode.c
>>>> @@ -534,6 +534,8 @@ int bch2_inode_v3_invalid(struct bch_fs *c, struct
>>>> bkey_s_c k,
>>>>   static void __bch2_inode_unpacked_to_text(struct printbuf *out,
>>>> struct bch_inode_unpacked *inode)
>>>>   {
>>>> +       prt_newline(out);
>>>> +
>>>>          printbuf_indent_add(out, 2);
>>>>          prt_printf(out, "mode=%o", inode->bi_mode);
>>>>          prt_newline(out);
>>>>
>>>>
>>>> Thanks,
>>>> Youling.
>>>
>>

