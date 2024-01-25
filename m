Return-Path: <linux-kernel+bounces-38171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE04183BBED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C26B29682
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F51D1B285;
	Thu, 25 Jan 2024 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UO4C8Izy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37491AAB9;
	Thu, 25 Jan 2024 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171167; cv=none; b=un3Lparikwn5mLKt0x8HgfkuyEYfA5i9KE0NWwuJHgod6nCTpYzyoMLD8TJNIYmAGq5sMwbZuz8W0vuKwQRtkgQcQtOnUqtdo86urH69DjC+3k7j6cAY0y3ikXQorrRDUZ+R9DVUWIl5ihI0exqbogFAl56i2QFGRZ4DrlMjo2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171167; c=relaxed/simple;
	bh=S++Kr7Po8qJLVAtw1D+w2iPEltryaY+8VaTiQB/HUJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Toue9iiQvN1MQxmI+NP3F7Cd9U7swVz/9RK+yUSZEsS9fgwBZnyJ0BcgBgQwOOzvH8MxS5xUDeQFOgzVp2lxHDDKNbHxaaBbxjWX1BhbR67Lqab7E6ni+5PA7FLQVT1215p7NQLDXF3UNZ14xvo7XUxw8a1Llai6R+rYzny5QXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UO4C8Izy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8533FC433F1;
	Thu, 25 Jan 2024 08:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706171167;
	bh=S++Kr7Po8qJLVAtw1D+w2iPEltryaY+8VaTiQB/HUJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UO4C8Izy9u84DfkwYm+3ZIgR7mzD9wS9sVPRG8Jt3s2rPceyeYM9K418n8iRZOtvH
	 GAbspxbi725F7lEfBPrrLPegamFbHDL8TYlkufmMa+zhhBz/8bAIfcis1ET9aYPt4g
	 h3XRUK/olxbyLsd7F9ujP4MQjdjfXFEWQPGjfHurqOPErXhVeX0Ow/MuQ8j08JMrSg
	 nusCXHxlZyoFoA14ODqy5MjnyWoelY3ES9aWmx4AAKJ3QqGw4Ri+c9hMgIuvY7eqZB
	 lr6amDjml/fJjFPFPU4eYl2icHfYVHa/ySMhTJPym0+xq6kSCB21cjFsjd8ucyuLYg
	 TmzAt1XmhVT0w==
Message-ID: <95082224-a61d-4f4b-bc96-1beea8aa93a9@kernel.org>
Date: Thu, 25 Jan 2024 17:26:04 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/1] block: introduce content activity based ioprio
Content-Language: en-US
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Yu Zhao <yuzhao@google.com>, Niklas Cassel <niklas.cassel@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-mm@kvack.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, steve.kang@unisoc.com
References: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
 <6b2d5694-f802-43a4-a0fd-1c8e34f8e69a@kernel.org>
 <CAGWkznHK5UPajY2PG24Jm7+A0c9q+tyQzrPdd=n3tp0dgX+T0w@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAGWkznHK5UPajY2PG24Jm7+A0c9q+tyQzrPdd=n3tp0dgX+T0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/25/24 16:52, Zhaoyang Huang wrote:
> On Thu, Jan 25, 2024 at 3:40 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 1/25/24 16:19, zhaoyang.huang wrote:
>>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>>>
>>> Currently, request's ioprio are set via task's schedule priority(when no
>>> blkcg configured), which has high priority tasks possess the privilege on
>>> both of CPU and IO scheduling.
>>> This commit works as a hint of original policy by promoting the request ioprio
>>> based on the page/folio's activity. The original idea comes from LRU_GEN
>>> which provides more precised folio activity than before. This commit try
>>> to adjust the request's ioprio when certain part of its folios are hot,
>>> which indicate that this request carry important contents and need be
>>> scheduled ealier.
>>>
>>> This commit is verified on a v6.6 6GB RAM android14 system via 4 test cases
>>> by changing the bio_add_page/folio API in ext4 and f2fs.
>>
>> And as mentioned already by Chrisoph and Jens, why don't you just simply set
>> bio->bi_ioprio to the value you want before calling submit_bio() in these file
>> systems ? Why all the hacking of the priority code for that ? That is not
>> justified at all.
>>
>> Furthermore, the activity things reduces the ioprio hint bits to the bare
>> minimum 3 bits necessary for command duration limits. Not great. But if you
>> simply set the prio class based on your activity algorithm, you do not need to
>> change all that.
> That is because bio->io_prio changes during bio grows with adding
> different activity pages in. I have to wrap these into an API which
> has both of fs and block be transparent to the process.

Pages are not added to BIOs on the fly. The FS does bio_add_page() or similar
(it can be a get user pages for direct IOs) and then calls bio_submit(). Between
these 2, you can set your IO priority according to how many pages you have.

You can even likely do all of this based on the iocb (and use iocb->ki_ioprio to
set the prio), so before one starts allocating and setting up BIOs to process
the user IO.

-- 
Damien Le Moal
Western Digital Research


