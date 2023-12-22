Return-Path: <linux-kernel+bounces-10059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D3D81CF49
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C74287034
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9283B1DDF4;
	Fri, 22 Dec 2023 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gs8cgKY2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E91DDC7;
	Fri, 22 Dec 2023 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=d7QzHzQubTw/J2Vv4sL3sCznUgGAbYvGHSLBpAThAx8=; b=Gs8cgKY24ebqdeLqwvgFsYBf3g
	kCeLEWq+qeLFBM6coYlVFsufSHmIurZGhVao7IwlNFfO7Z1frmKfbk/Ec4pKBJL+kN+AqLMztGuX0
	k9VEQd/1nyaVBkuHqz719MH65kKTUuUGrg5d7kybm8M+YptTgblrMAx0vRkDYzzYfUYwaFljbruk3
	rWbBobL7/ss0khthn79Vx9GL+XDJWf7XGhR/sHQVEVVPB9xZ8ImuqdzLbJRVDgwtmlQeVtO6UrVjd
	LsS7LuhBWbAQE7/3+1eQJYyg/SmeoRtIvlR3f+9u0/6uUfRkZZVD12CGw8B3SxmJY0RdX2hXp/vTV
	2CNKyLrw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGmAw-006oz8-2F;
	Fri, 22 Dec 2023 20:31:18 +0000
Message-ID: <a0945bf2-72a4-4ad9-ad94-74d539555862@infradead.org>
Date: Fri, 22 Dec 2023 12:31:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: media: atomisp: pci: Fix spelling mistake in
 ia_css_acc_types.h
Content-Language: en-US
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: hdegoede@redhat.com, mchehab@kernel.org, sakari.ailus@linux.intel.com,
 gregkh@linuxfoundation.org, hpa@redhat.com, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231222200350.2024-1-kdipendra88@gmail.com>
 <b4ad9a64-53cf-449a-aa18-d19ff3c72c52@infradead.org>
 <CAEKBCKO4uGKxXPZHO9iqYZ_8ibgY3HS3C8Rsogcv1XU+qGkudA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAEKBCKO4uGKxXPZHO9iqYZ_8ibgY3HS3C8Rsogcv1XU+qGkudA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/22/23 12:29, Dipendra Khadka wrote:
> On Sat, 23 Dec 2023 at 01:57, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Hi--
>>
>> On 12/22/23 12:03, Dipendra Khadka wrote:
>>> The script checkpatch.pl reported a spelling error
>>> in ia_css_acc_types.h as below:
>>>
>>> '''
>>> WARNING: 'cummulative' may be misspelled - perhaps 'cumulative'?
>>>         u32 padding_size;       /** total cummulative of bytes added due to section alignment */
>>>                                           ^^^^^^^^^^^
>>> '''
>>>
>>> This patch corrects a spelling error,
>>> changing "cummulative" to "cumulative".
>>>
>>
>> 'codespell' reports this one as well:
>>
>> drivers/staging/media/atomisp/pci/ia_css_acc_types.h:411: descibes ==> describes
>>
>> Thanks.
>>
> 
> Thanks for the reply. Do you want the spelling mistakes reported by
> codespell in the same patch with this change as well or you will
> consider
> it in the next patch?

That's up to some maintainers, but I would prefer to see all of the
spelling errors fixed in one patch.

Thanks.

> 
>>> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
>>> ---
>>>  drivers/staging/media/atomisp/pci/ia_css_acc_types.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
>>> index d6e52b4971d6..ac6fb0eb990a 100644
>>> --- a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
>>> +++ b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
>>> @@ -84,7 +84,7 @@ struct ia_css_blob_info {
>>>               memory_offsets;  /** offset wrt hdr in bytes */
>>>       u32 prog_name_offset;  /** offset wrt hdr in bytes */
>>>       u32 size;                       /** Size of blob */
>>> -     u32 padding_size;       /** total cummulative of bytes added due to section alignment */
>>> +     u32 padding_size;       /** total cumulative of bytes added due to section alignment */
>>>       u32 icache_source;      /** Position of icache in blob */
>>>       u32 icache_size;        /** Size of icache section */
>>>       u32 icache_padding;/** bytes added due to icache section alignment */
>>
>> --
>> #Randy
>> https://people.kernel.org/tglx/notes-about-netiquette
>> https://subspace.kernel.org/etiquette.html

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

