Return-Path: <linux-kernel+bounces-159974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F54C8B3705
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B84D1C219A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E868145B11;
	Fri, 26 Apr 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="Jt1MzgHk"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016192E413
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133944; cv=none; b=VsFAZmutH84VF83Wdt+oYYcvm7JekNab4fzbXXtD1+fTXdVnHiXCpbuPsD1floI6W2UqoiZ6eH0tT/g5MshoSPQcaSDZxphLuXLz+ExiKEfrnaS990lTZr4MZTDbvxsfjhFP7FPRsawI9GihZ3b5YLnrdaKhk11j88mAz8t/BLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133944; c=relaxed/simple;
	bh=uSnneEQaaEvjfipQDh1p/g1ZPcENc4X6wosSYwggC0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oj7TA14LMIq8HEmvme4xvv/bgrU1vBeB4zcouNfL4W1oiNQatsdv6ECbKVvNqqS7UnkEOZQEswzoYZrpSe9NgXgAQ7VYU2ti4j046szY96JtqTfgFDH7VBAf7t6+FsQP8x2exeBTB7YWC1/cUC308baAUfe4aFNqzAjjoHLGEws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=Jt1MzgHk; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E047E000C;
	Fri, 26 Apr 2024 12:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1714133939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZPHEVK48lvSJdqJRvIFmii+wGsux+HVonA01m3gj4g=;
	b=Jt1MzgHk6RoMZ1d10ptxOGXqjAJ/pfY2ZSPUApNXoGzXWymEZGPqkPxSUVIFqc5g/NeXpP
	zLEUrphD89Ic5FwXn8PnnyItzylS5ZYjJAtV43sJ6IbLlX2xwPIsxDlWKlzF6dBCeVZQCJ
	gn3qzrpHSuYyGUEJBiHKgiJlNQBh1XaiSDx1X3zkF/KKll6/BTFzfviTkz4AMg4xyaP94E
	tlXN5vnbXBTB0QeJR8z8E9VuQGVuNsYEoecS8ipfEAAQqZHUG3KLV9AqGDDLyzYZKaw3gp
	Bn93Z1AIeNnwm6EUdDSCfMswEFth5xOLHTrXCH6vNdmQ8KNZJJem9xOafvZNtQ==
Message-ID: <47011bf2-4000-4fd8-9dd3-4c6b6a1c4a80@clip-os.org>
Date: Fri, 26 Apr 2024 14:18:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: Fixes freepointer encoding for single free
To: Xiongwei Song <sxwjean@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cl@linux.com,
 penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com
References: <Zij_fGjRS_rK-65r@archlinux>
 <CAEVVKH8Oagbih8E8YNPpNhyh75fWnBLdod+eEGQm9i8ciNv7sQ@mail.gmail.com>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <CAEVVKH8Oagbih8E8YNPpNhyh75fWnBLdod+eEGQm9i8ciNv7sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org

On 4/26/24 11:20, Xiongwei Song wrote:
> On Wed, Apr 24, 2024 at 8:48 PM Nicolas Bouchinet
> <nicolas.bouchinet@clip-os.org> wrote:
>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>
>> Commit 284f17ac13fe ("mm/slub: handle bulk and single object freeing
>> separately") splits single and bulk object freeing in two functions
>> slab_free() and slab_free_bulk() which leads slab_free() to call
>> slab_free_hook() directly instead of slab_free_freelist_hook().
>>
>> If `init_on_free` is set, slab_free_hook() zeroes the object.
>> Afterward, if `slub_debug=F` and `CONFIG_SLAB_FREELIST_HARDENED` are
>> set, the do_slab_free() slowpath executes freelist consistency
>> checks and try to decode a zeroed freepointer which leads to a
>> "Freepointer corrupt" detection in check_object().
>>
>> Object's freepointer thus needs to be properly set using
>> set_freepointer() after init_on_free.
>>
>> To reproduce, set `slub_debug=FU init_on_free=1 log_level=7` on the
>> command line of a kernel build with `CONFIG_SLAB_FREELIST_HARDENED=y`.
>>
>> dmesg sample log:
>> [   10.708715] =============================================================================
>> [   10.710323] BUG kmalloc-rnd-05-32 (Tainted: G    B           T ): Freepointer corrupt
>> [   10.712695] -----------------------------------------------------------------------------
>> [   10.712695]
>> [   10.712695] Slab 0xffffd8bdc400d580 objects=32 used=4 fp=0xffff9d9a80356f80 flags=0x200000000000a00(workingset|slab|node=0|zone=2)
>> [   10.716698] Object 0xffff9d9a80356600 @offset=1536 fp=0x7ee4f480ce0ecd7c
> If init_on_free is set,  slab_free_hook() zeros the object first, then
> do_slab_free() calls
> set_freepointer() to set the fp value, so there are 8 bytes non-zero
> at the moment?
> Hence, the issue is not related to init_on_free?
>
> The fp=0x7ee4f480ce0ecd7c here is beyond kernel memory space, is the issue from
> CONFIG_SLAB_FREELIST_HARDENED enabled?

My understanding of the bug is that slab_free_hook() indeed zeroes the 
object and its metadata first, then calls do_slab_free() and directly 
calls __slab_free(), head an tail parameters being set to the object.

If `slub_debug=F` (SLAB_CONSISTENCY_CHECKS) is set, the following call 
path can be executed :

free_to_partial_list() ->

free_debug_processing() ->

free_consistency_checks() ->

check_object() ->

check_valid_pointer(get_freepointer())

When check_valid_pointer() is called, its object parameter is first 
decoded by get_freepointer(), if CONFIG_SLAB_FREELIST_HARDENED is 
enabled, zeroed data is then decoded by freelist_ptr_decode() using the 
(ptr.v ^ s->random ^ swab(ptr_addr)) operation.


Does that makes sense to you or do you think I'm missing something ?


Best regards,

Nicolas

> Xiongwei
>
>> [   10.716698]
>> [   10.716698] Bytes b4 ffff9d9a803565f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>> [   10.720703] Object   ffff9d9a80356600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>> [   10.720703] Object   ffff9d9a80356610: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>> [   10.724696] Padding  ffff9d9a8035666c: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>> [   10.724696] Padding  ffff9d9a8035667c: 00 00 00 00                                      ....
>> [   10.724696] FIX kmalloc-rnd-05-32: Object at 0xffff9d9a80356600 not freed
>>
>> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>> ---
>>   mm/slub.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 3aa12b9b323d9..71dbff9ad8f17 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -4342,10 +4342,16 @@ static __fastpath_inline
>>   void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>>                 unsigned long addr)
>>   {
>> +       bool init = false;
>> +
>>          memcg_slab_free_hook(s, slab, &object, 1);
>> +       init = slab_want_init_on_free(s);
>>
>> -       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
>> +       if (likely(slab_free_hook(s, object, init))) {
>> +               if (init)
>> +                       set_freepointer(s, object, NULL);
>>                  do_slab_free(s, slab, object, object, 1, addr);
>> +       }
>>   }
>>
>>   static __fastpath_inline
>> --
>> 2.44.0
>>
>>

