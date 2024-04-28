Return-Path: <linux-kernel+bounces-161404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 336FC8B4B93
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB38B281C6A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7651F5C904;
	Sun, 28 Apr 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="LhMYoc9Q";
	dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="BlwRuTRa"
Received: from smtp.ivitera.com (smtp.ivitera.com [88.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118C5B694;
	Sun, 28 Apr 2024 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.101.85.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714304953; cv=none; b=oxTQvEEwXqEGwehBO75KMI/SjPYmR6FjzDN7iKxBiBi6BvnpP/7C2fJA9TKAZhdO03zJRpL8lHjut7ViBvOQqgBoqjMlN0zguDqC8Mi/9CSN66efGb7g6m7KHFZTNkyzDlQ73+m+GyiODAScBiw7ZRd5BO+aVPdNkutvftB1DBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714304953; c=relaxed/simple;
	bh=a3jtrhFLmJsd3Ue/6VPSau0Q462286ZMvv6PDrJlj9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gn/8lbxbj2jg+aEOXiKzt5k/cwfTTbH2wvsOxm0cobXq88LuTicgcOnwC8Gn1VMg0ThsjrlpQf8Q6JFhdVk52IxFwaeHxWgwpLID4t8DfRgCrRkLemhiZz0WRkcgiSwLXWaPdsjzXR5ZjTbNUr/kacLWrvHN9DizDUzr9nolWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ivitera.com; spf=pass smtp.mailfrom=ivitera.com; dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b=LhMYoc9Q; dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b=BlwRuTRa; arc=none smtp.client-ip=88.101.85.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ivitera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ivitera.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.ivitera.com (Postfix) with ESMTP id 8B5E1160136;
	Sun, 28 Apr 2024 13:49:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
	t=1714304941; bh=a3jtrhFLmJsd3Ue/6VPSau0Q462286ZMvv6PDrJlj9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LhMYoc9QjBGMa5qc4n0OK2y6qZ4ouIg7wZCpeDpxR4Ax2y4qIttfughGcZbCTP+/Z
	 hve7yTUTctZdw0sKKVy/IZhhFe98yMEyPpAaaem01VpWjsD3lf3SwJ2KIylrpYBD6G
	 IksWcPdh+fyeDGSo4R5N/V70RikkvJO69k60xYa4=
Received: from smtp.ivitera.com ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VeLKYB4rjy5u; Sun, 28 Apr 2024 13:49:01 +0200 (CEST)
Received: from [192.168.105.22] (dustin.pilsfree.net [81.201.58.138])
	(Authenticated sender: pavel)
	by smtp.ivitera.com (Postfix) with ESMTPSA id B81331600E5;
	Sun, 28 Apr 2024 13:49:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
	t=1714304940; bh=a3jtrhFLmJsd3Ue/6VPSau0Q462286ZMvv6PDrJlj9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BlwRuTRaKZucHtdx16mb91suWp2Ulyzm4P2i1tN+LCpvVBARCqX0abSnkPhnhQqrD
	 glzY8MThjaSjbMKnOVMBqRfUgOIGaxsCs3RDCrbhnpEzXB3Gn+Sacw8TKv1d4XvbGt
	 mSuqhtNMsCXc8sauYYGRArdRpEw7XZa8158AHsmo=
Message-ID: <817d5f6c-0f9d-7f88-b5ca-26c3547730fb@ivitera.com>
Date: Sun, 28 Apr 2024 13:49:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] usb: gadget: f_uac2: Expose all string descriptors
 through configfs.
Content-Language: en-US
To: Chris Wulff <Chris.Wulff@biamp.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Gruber <jimmyjgruber@gmail.com>, Lee Jones <lee@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.de>
References: <CO1PR17MB54195BE778868AFDFE2DCB36E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
 <c9928edb-8b2d-1948-40b8-c16e34cea3e2@ivitera.com>
 <CO1PR17MB541989646698286B2B13CF23E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
 <9b40e148-f3eb-f8f5-bf2d-37a0a0629417@ivitera.com>
 <CO1PR17MB541942196F9A2F73CF8B5B14E1152@CO1PR17MB5419.namprd17.prod.outlook.com>
From: Pavel Hofman <pavel.hofman@ivitera.com>
In-Reply-To: <CO1PR17MB541942196F9A2F73CF8B5B14E1152@CO1PR17MB5419.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27. 04. 24 18:27, Chris Wulff wrote:
>> From: Pavel Hofman <pavel.hofman@ivitera.com>
>>>>> +             p_it_name               playback input terminal name
>>>>> +             p_ot_name               playback output terminal name
>>>>> +             p_fu_name               playback function unit name
>>>>> +             p_alt0_name             playback alt mode 0 name
>>>>> +             p_alt1_name             playback alt mode 1 name
>>>>
>>>> Nacked-by: Pavel Hofman <pavel.hofman@ivitera.com>
> ...
>> If the params in the upper level were to stand as defaults for the
>> altsettings (and for the existing altsetting 1 if no specific altset
>> subdir configs were given), maybe the naming xxx_alt1_xxx could become a
>> bit confusing. E.g. p_altx_name or p_alt_non0_name?
> 
> I've been prototyping this a bit to see how it will work. My current configfs
> structure looks something like:
> 
> (all existing properties)
> c_it_name
> c_it_ch_name
> c_fu_name
> c_ot_name
> p_it_name
> p_it_ch_name
> p_fu_name
> p_ot_name
> num_alt_modes (settable to 2..5 in my prototype)
> 
> alt.0
>   c_alt_name
>   p_alt_name
> alt.1 (for alt.1, alt.2, etc.)
>   c_alt_name
>   p_alt_name
>   c_ssize
>   p_ssize
>   (Additional properties here for other things that are settable for each alt mode,
>    but the only one I've implemented in my prototype so far is sample size.)
> 

Hats off to your speed, that's amazing. IMO this is a perfect config
layout, logical, extensible, easy to generate manually as well as with a
script.


> This brings up a few questions:
> 
> Is a property for setting the number of alt modes preferred, or being able to
> make directories like some other things (eg, "mkdir alt.5" would add alt mode 5)?
> The former is what I started with, but I am leaning towards the latter as it is a bit
> more flexible (you could create alt modes of any index, though I'm not entirely
> sure why you'd want to.) It does involve a bit more dynamic memory allocation,
> but nothing crazy.

I am not sure the arbitrary index of alt mode would be useful (is it
even allowed in USB specs?). But I may not have understood your question
properly.

The num_alt_modes property - can the number be perhaps aquired from the
number of created directories? Or would that number of alt modes be
created automatically (all same with default values), and the properties
in alt.X dirs would subsequently only modify their respective values?

> 
> And second, should the alt.x directories go back to the defaults if you remove
> and re-create them? I'm assuming it makes sense to do that, just putting it out
> there since my current prototype doesn't work that way.

IIUC just creating the alt.X directory would create the alt X mode, with
default properties from the top-level configs or with the source-code
defaults.

Thanks a lot,

Pavel.

