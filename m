Return-Path: <linux-kernel+bounces-161885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D758B52AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80CFB209D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD5F15E86;
	Mon, 29 Apr 2024 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="ZVb+L3fw"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B5614AA3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377369; cv=none; b=LRPAV+8GZsvZCmeDeCHBouU+GSIGtjp1bj9ab4WTL95342QptGSNXvbLxf3v3uDuqrBlTE05ZcYUu3C8XLMCC8aD57fUJ3QsAzM+fS/rVp2E+NnJiJbDgS/VObw7y5Qt9Qc+yLoWaznaRqjwfSrq+piYTbeHLpPym7HVH9uamkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377369; c=relaxed/simple;
	bh=eWilt8G5gLl7+AXu+4/dX6hli8GN8Nanfu09syNcIdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxLNg3xq2u5QJtSvcJbvIAzKbperFjPFvLH/MnOWgqqp0JScAwhfD966IutCbJoej7lhqoVZzKK1MFBSToP7+rrzpYEkd1o7GwOxCcRWIaM2oCEff+jn7T+ANIR3B06NOY7878tQElxJuYHSJ/3JFiu9KB3qJ/TKQt6xrm9gQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=ZVb+L3fw; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F26160005;
	Mon, 29 Apr 2024 07:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1714377358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRFrm6wJpTdJo02mNwFpZgTYCwsjhC4CDet4zevy5n8=;
	b=ZVb+L3fwl4phMyrApv6CGFbaRYimX1adE0s/u893Huzsi1cR9O/9q8yOIyvqdp+yDwWoFv
	abkLETToqKRrwLM1ecrEyLXs6IJDiDu/ajqjfNntI6qLAk9KHd6nE6TRZqMHHKexLQmy3g
	Pdrfkdr8CjpBqmdzcThNs2fTAn4oCrC4eUPVyP5r9/uMGt6ObZXo4UEGElZD268RBXgSwr
	B4v1XR7mPz6LBsGtgTrkveLfhTK5BjXYZHdWu1Otpr8egk9e2jLtpQeafik03iC+unr5N/
	pg8fIe1yMk4DN0xjO+fOTi4lTM3rUaV0m73eQ5W5jRzwPvvjLS/SFEjwUn3+fQ==
Message-ID: <1136cf64-c1b6-4909-b64e-0c754276024c@clip-os.org>
Date: Mon, 29 Apr 2024 09:55:55 +0200
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
 <47011bf2-4000-4fd8-9dd3-4c6b6a1c4a80@clip-os.org>
 <CAEVVKH9rwS6vR5_AjHyjS0vknyZvHabooE+c+k_5XNn2Rdac6w@mail.gmail.com>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <CAEVVKH9rwS6vR5_AjHyjS0vknyZvHabooE+c+k_5XNn2Rdac6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org


On 4/26/24 15:14, Xiongwei Song wrote:
> On Fri, Apr 26, 2024 at 8:18 PM Nicolas Bouchinet
> <nicolas.bouchinet@clip-os.org> wrote:
>> On 4/26/24 11:20, Xiongwei Song wrote:
>>> On Wed, Apr 24, 2024 at 8:48 PM Nicolas Bouchinet
>>> <nicolas.bouchinet@clip-os.org> wrote:
>>>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>>>
>>>> Commit 284f17ac13fe ("mm/slub: handle bulk and single object freeing
>>>> separately") splits single and bulk object freeing in two functions
>>>> slab_free() and slab_free_bulk() which leads slab_free() to call
>>>> slab_free_hook() directly instead of slab_free_freelist_hook().
>>>>
>>>> If `init_on_free` is set, slab_free_hook() zeroes the object.
>>>> Afterward, if `slub_debug=F` and `CONFIG_SLAB_FREELIST_HARDENED` are
>>>> set, the do_slab_free() slowpath executes freelist consistency
>>>> checks and try to decode a zeroed freepointer which leads to a
>>>> "Freepointer corrupt" detection in check_object().
>>>>
>>>> Object's freepointer thus needs to be properly set using
>>>> set_freepointer() after init_on_free.
>>>>
>>>> To reproduce, set `slub_debug=FU init_on_free=1 log_level=7` on the
>>>> command line of a kernel build with `CONFIG_SLAB_FREELIST_HARDENED=y`.
>>>>
>>>> dmesg sample log:
>>>> [   10.708715] =============================================================================
>>>> [   10.710323] BUG kmalloc-rnd-05-32 (Tainted: G    B           T ): Freepointer corrupt
>>>> [   10.712695] -----------------------------------------------------------------------------
>>>> [   10.712695]
>>>> [   10.712695] Slab 0xffffd8bdc400d580 objects=32 used=4 fp=0xffff9d9a80356f80 flags=0x200000000000a00(workingset|slab|node=0|zone=2)
>>>> [   10.716698] Object 0xffff9d9a80356600 @offset=1536 fp=0x7ee4f480ce0ecd7c
>>> If init_on_free is set,  slab_free_hook() zeros the object first, then
>>> do_slab_free() calls
>>> set_freepointer() to set the fp value, so there are 8 bytes non-zero
>>> at the moment?
>>> Hence, the issue is not related to init_on_free?
>>>
>>> The fp=0x7ee4f480ce0ecd7c here is beyond kernel memory space, is the issue from
>>> CONFIG_SLAB_FREELIST_HARDENED enabled?
>> My understanding of the bug is that slab_free_hook() indeed zeroes the
>> object and its metadata first, then calls do_slab_free() and directly
>> calls __slab_free(), head an tail parameters being set to the object.
>>
>> If `slub_debug=F` (SLAB_CONSISTENCY_CHECKS) is set, the following call
>> path can be executed :
>>
>> free_to_partial_list() ->
>>
>> free_debug_processing() ->
>>
>> free_consistency_checks() ->
>>
>> check_object() ->
>>
>> check_valid_pointer(get_freepointer())
> I understand the call path. I meant here the freepointer is not ZERO
> but an illegal
> value( fp=0x7ee4f480ce0ecd7c),


Yes this is the reason of this patch. The freepointer is an illegal 
value because the memory range where it sits has been overridden by 
zeroes, set_freepointer() is never called and thus the freepointer is 
never properly set.


  The illegal value is obtained after zeroes has been decoded by 
get_freepointer()->freelist_ptr_decode().


>   then check_valid_pointer return 1 with
> it's last line
> and then check_object() printed out the error message. I'm not sure if I
> misunderstood you.


check_valid_pointer() returns 0 since object < base, the object being 
the decoded fp (0x7ee4f480ce0ecd7c < 0xffff.* base addr), hence 
check_object() returns 0, not 1.

This is why the "Object at 0x%p not freed" slab_fix() is called in 
free_debug_processing().


>
> Thank,
> Xiongwei
>

