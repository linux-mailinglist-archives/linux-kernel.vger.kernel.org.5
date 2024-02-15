Return-Path: <linux-kernel+bounces-67445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC49856BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2FE1F21212
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DDF137C3C;
	Thu, 15 Feb 2024 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="BbxUrQq6"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD386341F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019583; cv=none; b=nGHywzz2GvqMm9EELQ/2mr+uf5jUjveyfEbc4oS/3mq8quMYTczdjtNIfoN42q6uaBhN4YGB0+OwNJYcXRiL6I7VnFtyiR0POivAmPkG9zT0CfSKoAFwdtR6ySO0M91Vwm0tX4E3hvcWz7FqJPDQ0sDYBCczNA+5wDsh5JcQjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019583; c=relaxed/simple;
	bh=dShU+zKhEn8TUMvERT6bCyDUiF702q2NY0wemkvuqo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIQ4OxDCksm0RIA2EDAvk/oUm/P/03451ItkrExloRi6aUm0pE4aBSzJsK3C4LPyMg6OUYo3Q6ZAWGeQ4w0ubCkIdS7sGw99b0qh+StQtlqAFaT7nkzHcLA5i+ohUQkaaNIM1czYGmih/1PqBekYT5AU/y6v6P1DJRINyPuWk70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=BbxUrQq6; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4TbMqY2ryZzDqsT
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1708019020; bh=dShU+zKhEn8TUMvERT6bCyDUiF702q2NY0wemkvuqo8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BbxUrQq6qsn8++GWqSv5/LpJDm+CeiXHMS6DeZfdwuaOfFc3mPa5ydXeFWZm5L7gq
	 Rm265hUYh5JSkUFTBkqz38CN99Fp05PZ0xojRS6B2mks4F0BWRGOoWFW7AHPkKSZBz
	 rejASkhfjrhSFrOQG60fGoqG7EFvba4e++cYDuzw=
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4TbMqQ5p9lz9vgB;
	Thu, 15 Feb 2024 17:43:30 +0000 (UTC)
X-Riseup-User-ID: A00BBA88894CF67C8D32FC7FC9899674BFF2F70200F8AC36704AEA4A925813AB
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4TbMqD3jhHzFq7K;
	Thu, 15 Feb 2024 17:43:19 +0000 (UTC)
Message-ID: <7af45547-1f51-4933-b226-08b462d9f539@riseup.net>
Date: Thu, 15 Feb 2024 14:43:17 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] drm/vkms: Use a simpler composition function
Content-Language: en-US
To: Pekka Paalanen <pekka.paalanen@haloniitty.fi>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: miquel.raynal@bootlin.com, mripard@kernel.org,
 rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com, mairacanal@riseup.net,
 hamohammed.sa@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, airlied@gmail.com, marcheu@google.com,
 seanpaul@google.com, nicolejadeyee@google.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com
References: <20240205121913.379e28a4@eldfell>
 <ZcOmpInszAOVeKes@localhost.localdomain> <20240208113951.1f5f9f40@eldfell>
From: Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <20240208113951.1f5f9f40@eldfell>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/02/24 06:39, Pekka Paalanen wrote:
> On Wed, 7 Feb 2024 16:49:56 +0100
> Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> 
>> Hello Pekka, Arthur, Maxime,
> 
> Hi all
> 
>>>>>>>>>>> Change the composition algorithm to iterate over pixels instead of lines.
>>>>>>>>>>> It allows a simpler management of rotation and pixel access for complex formats.
>>>>>>>>>>>
>>>>>>>>>>> This new algorithm allows read_pixel function to have access to x/y
>>>>>>>>>>> coordinates and make it possible to read the correct thing in a block
>>>>>>>>>>> when block_w and block_h are not 1.
>>>>>>>>>>> The iteration pixel-by-pixel in the same method also allows a simpler
>>>>>>>>>>> management of rotation with drm_rect_* helpers. This way it's not needed
>>>>>>>>>>> anymore to have misterious switch-case distributed in multiple places.            
>>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> there was a very good reason to write this code using lines:
>>>>>>>>>> performance. Before lines, it was indeed operating on individual pixels.
>>>>>>>>>>
>>>>>>>>>> Please, include performance measurements before and after this series
>>>>>>>>>> to quantify the impact on the previously already supported pixel
>>>>>>>>>> formats, particularly the 32-bit-per-pixel RGB variants.
>>>>>>>>>>
>>>>>>>>>> VKMS will be used more and more in CI for userspace projects, and
>>>>>>>>>> performance actually matters there.
>>>>>>>>>>
>>>>>>>>>> I'm worrying that this performance degradation here is significant. I
>>>>>>>>>> believe it is possible to keep blending with lines, if you add new line
>>>>>>>>>> getters for reading from rotated, sub-sampled etc. images. That way you
>>>>>>>>>> don't have to regress the most common formats' performance.          
>>
>> I tested, and yes, it's significant for most of the tests. None of them 
>> timed out on my machine, but I agree that I have to improve this. Do you 
>> know which tests are the more "heavy"?
> 
> I don't, but considering that various userspace projects (e.g. Wayland
> compositors) want to use VKMS more and more in their own CI, looking
> only at IGT is not enough. Every second saved per run is a tiny bit of
> data center energy saved, or developers waiting less for results.
> 
> I do have some expectations that for each KMS property, Wayland
> compositors tend to use the "normal" property value more than any other
> value. So if you test different pixel formats, you probably set
> rotation to normal, since it's completely orthogonal in userspace. And
> then you would test different rotations with just one pixel format.
> 
> At least I would personally leave it to IGT to test all the possible
> combinations of pixel formats + rotations + odd sizes + odd positions.
> Wayland compositor CI wants to test the compositor internals, not VKMS
> internals.
> 
>>>>>>>>> While I understand performance is important and should be taken into
>>>>>>>>> account seriously, I cannot understand how broken testing could be
>>>>>>>>> considered better. Fast but inaccurate will always be significantly
>>>>>>>>> less attractive to my eyes.          
>>>>>>>>
>>>>>>>> AFAIK, neither the cover letter nor the commit log claimed it was fixing
>>>>>>>> something broken, just that it was "better" (according to what
>>>>>>>> criteria?).        
>>
>> Sorry Maxime for this little missunderstanding, I will improve the commit 
>> message and cover letter for the v2.
>>
>>>>>>> Today's RGB implementation is only optimized in the line-by-line case
>>>>>>> when there is no rotation. The logic is bit convoluted and may possibly
>>>>>>> be slightly clarified with a per-format read_line() implementation,
>>>>>>> at a very light performance cost. Such an improvement would definitely
>>>>>>> benefit to the clarity of the code, especially when transformations
>>>>>>> (especially the rotations) come into play because they would be clearly
>>>>>>> handled differently instead of being "hidden" in the optimized logic.
>>>>>>> Performances would not change much as this path is not optimized today
>>>>>>> anyway (the pixel-oriented logic is already used in the rotation case).  
>>
>> [...]
>>
>>>>>> I think it would, if I understand what you mean. Ever since I proposed
>>>>>> a line-by-line algorithm to improve the performance, I was thinking of
>>>>>> per-format read_line() functions that would be selected outside of any
>>>>>> loops.  
>>
>> [...]
>>
>>>>>> I haven't looked at VKMS in a long time, and I am disappointed to find
>>>>>> that vkms_compose_row() is calling plane->pixel_read() pixel-by-pixel.
>>>>>> The reading vfunc should be called with many pixels at a time when the
>>>>>> source FB layout allows it. The whole point of the line-based functions
>>>>>> was that they repeat the innermost loop in every function body to make
>>>>>> the per-pixel overhead as small as possible. The VKMS implementations
>>>>>> benchmarked before and after the original line-based algorithm showed
>>>>>> that calling a function pointer per-pixel is relatively very expensive.
>>>>>> Or maybe it was a switch-case.      
>>
>> [...]
>>
>>>>> But, I agree with Miquel that the rotation logic is easier to implement
>>>>> in a pixel-based way. So going pixel-by-pixel only when rotation occurs
>>>>> would be great.    
>>>>
>>>> Yes, and I think that can very well be done in the line-based framework
>>>> still that existed in the old days before any rotation support was
>>>> added. Essentially a plug-in line-getter function that then calls a
>>>> format-specific line-getter pixel-by-pixel while applying the rotation.
>>>> It would be simple, it would leave unrotated performance unharmed (use
>>>> format-specific line-getter directly with lines), but it might be
>>>> somewhat less performant for rotated KMS planes. I suspect that might
>>>> be a good compromise.
>>>>
>>>> Format-specific line-getters could also be parameterized by
>>>> pixel-to-pixel offset in bytes. Then they could directly traverse FB
>>>> rows forward and backward, and even FB columns. It may or may not have
>>>> a penalty compared to the original line-getters, so it would have to
>>>> be benchmarked.  
>>>
>>> Oh, actually, since the byte offset depends on format, it might be
>>> better to parametrize by direction and compute the offset in the
>>> format-specific line-getter before the loop.
>>>   
>>
>> I'm currently working on this implementation. The algorithm would look 
>> like:
>>
>>     void blend(...) {
>>         for(int y = 0; y < height; y++) {
>> 		for(int plane = 0; plane < nb_planes; plane++) {
>> 			if(planes[plane].read_line && planes[plane].rotation == DRM_ROTATION_0) {
> 
> I would try to drop the rotation check here completely. Instead, when
> choosing the function pointer to call here, outside of *all* loops, you
> would check the rotation property. If rotation is a no-op, pick the
> read_line function directly. If rotation/reflection is needed, pick a
> rotation function that will then call read_line function pixel-by-pixel.
> 
> So planes[plane] would have two vfuncs, one with a plain read_line that
> assumes normal orientation and can return a line of arbitrary length
> from arbitrary x,y position, and another vfunc that this loop here will
> call which is either some rotation handling function or just the same
> function as the first vfunc.
> 
> The two function pointers might well need different signatures, meaning
> you need a simple wrapper for the rotation=normal case too.
> 
> I believe that could result in cleaner code.
> 
>> 				[...] /* Small common logic to manage REFLECT_X/Y and translations */
>> 				planes[plane].read_line(....);
>> 			} else {
>> 				[...] /* v1 of my patch, pixel by pixel read */
>> 			}
>> 		}
>> 	}
>>     }
>>
>> where read_line is:
>>   void read_line(frame_info *src, int y, int x_start, int x_stop, pixel_argb16 *dts[])
>>  - y is the line to read (so the caller need to compute the correct offset)
>>  - x_start/x_stop are the start and stop column, but they may be not 
>>    ordered properly (i.e DRM_REFLECT_X will make x_start greater than 
>>    x_stop)
>>  - src/dst are source and destination buffers
> 
> This sounds ok. An alternative would be something like
> 
> enum direction {
>         RIGHT,
>         LEFT,
>         UP,
>         DOWN,
> };
> 
> void read_line(frame_info *src, int start_x, int start_y, enum direction dir,
>                int count_pixels, pixel_argb16 *dst);
> 
> Based on dir, before the inner loop this function would compute the
> byte offset between the pixels to be read. If the format is multiplanar
> YUV, it can compute the offset per plane. And the starting pointers per
> pixel plane, of course, and one end pointer for the loop stop condition
> maybe from dst.
> 
> This might make all the other directions than RIGHT much faster than
> calling read_line one pixel at a time to achieve the same.
> 
> Would need to benchmark if this is significantly slower than your
> suggestion for dir=RIGHT, though. If it's roughly the same, then it
> would probably be worth it.
> 
> 
>> This way:
>> - It's simple to read for the general case (usage of drm_rect_* instead of 
>>   manually rewriting the logic)
>> - Each pixel format can be quickly implemented with "pixel-by-pixel" 
>>   methods
>> - The performances should be good if no rotation is implied for some 
>>   formats
>>
>> I also created some helpers for conversions between formats to avoid code 
>> duplication between pixel and line algorithms (and also between argb and 
>> xrgb variants).
>>
>> The only flaw with this, is that most of the read_line functions will 
>> look like:
>>
>>     void read_line(...) {
>> 	int increment = x_start < x_stop ? 1: -1;
>> 	while(x_start != x_stop) {
>> 		out += 1;
>> 		[...] /* color conversion */
>> 		x_start += increment;
>> 	}
>>     }
>>
>> But as Pekka explained, it's probably the most efficient way to do it.
> 
> Yes, I expect them to look roughly like that. It's necessary for moving
> as much of the setup computations and real function calls out of the
> inner-most loop as possible. The middle (over KMS planes) and outer
> (over y) loops are less sensitive to wasted cycles on redundant
> computations.
> 
>> Is there a way to save the output of vkms to a folder (something like 
>> "one image per frame")? It's a bit complex to debug graphics without 
>> seeing them.
>>
>> I have something which (I think) should work, but some tests are failing 
>> and I don't find why in my code (I don't find the reason why the they are 
>> failing and the hexdump I added to debug seems normal).
>>
>> I think my issue is a simple mistake in the "translation managment" or 
>> maybe just a wrong offset, but I don't see my error in the code. I think a 
>> quick look on the final image would help me a lot.
> 
> I don't know anything about the kernel unit testing frameworks, maybe
> they could help?
> 
> But if you drive the test through UAPI from userspace, use a writeback
> connector to fetch the resulting image. I'm sure IGT has code doing
> that somewhere, although many IGT tests rely on CRC instead because CRC
> is more widely available in hardware.
> 
> Arthur's new benchmark seems to be using writeback, you just need to
> make it save to file:
> https://lore.kernel.org/all/20240207-bench-v1-1-7135ad426860@riseup.net/

Hi,

I just found that the IGT's test kms_writeback has a flag '--dump' that
does that, maybe you can use it or copy the logic to the benchmark.

Best Regards,
~Arthur Grillo

> 
> 
> Thanks,
> pq

