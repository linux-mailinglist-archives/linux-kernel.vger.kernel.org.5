Return-Path: <linux-kernel+bounces-101423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CC387A6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BDE28723A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50DD3EA83;
	Wed, 13 Mar 2024 11:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gxodk2EI"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1693EA6C;
	Wed, 13 Mar 2024 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328344; cv=none; b=Wu9EnL6ncNDMSn3xqPzZ1/kG06ls8F6rg9vmWQ85O8il50uHQglsE/SgYcY0lk62+j6tIpIos4wYGsGCkvf1SDwwWuqXbFnONTArn71fHscm3PJMYds+Sisotq5OUMC1JUqC6pvXnmZ8Blvy4jDs5B2Xy9mPUA2+7imdsUT4hEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328344; c=relaxed/simple;
	bh=QRcCAIIgMh2jYQYsK66leYgGBqgJ9NaFN8yK5PCXZOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qslYi2253YoBfHtbyQZU8SkL43jB+Q2029QO5Bi1qNYqciNFKWBE/az0UFNqpCeOT2eCmCw/c29YKCcqCnYl1P836uugYfI6dC/2Oe12RE4lJgAGcoWmBtCwMOElcsSHNQPgbniTQEcyqwwsbR/Hw7aR7j7L/Aqyle+L2bGABVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gxodk2EI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.104] (unknown [103.251.226.70])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CB34E720;
	Wed, 13 Mar 2024 12:11:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1710328317;
	bh=QRcCAIIgMh2jYQYsK66leYgGBqgJ9NaFN8yK5PCXZOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gxodk2EI0pjdrje5j2/uhsRCu/PjBYPkYpycOEpKnsk9L7S4h2A3PvmjFUiH8WSWN
	 EVnkQVVGbd9YFWSfZs673eCO4HIVErTVr1NMF+X47oNST5JQL3ZrfjauV4fi8ijD21
	 ybNMvuHVQ7R6TcRtLsHatWLFzN4lR1lahHtof1t4=
Message-ID: <d32c985d-7610-4838-a37c-2b455d4e421e@ideasonboard.com>
Date: Wed, 13 Mar 2024 16:42:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] media: i2c: Add imx283 camera sensor driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-media@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 willl will <will@willwhang.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, tomi.valkeinen@ideasonboard.com,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans de Goede
 <hdegoede@redhat.com>, Alain Volmat <alain.volmat@foss.st.com>,
 Paul Elder <paul.elder@ideasonboard.com>,
 Mehdi Djait <mehdi.djait@bootlin.com>, Bingbu Cao <bingbu.cao@intel.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20240313070705.91140-1-umang.jain@ideasonboard.com>
 <20240313070705.91140-3-umang.jain@ideasonboard.com>
 <CAHp75VcdcQbF76=j=xTtDRgkQNwVdCJ+0oD7KX4TbTfndX_5fA@mail.gmail.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <CAHp75VcdcQbF76=j=xTtDRgkQNwVdCJ+0oD7KX4TbTfndX_5fA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Andy,

On 13/03/24 2:25 pm, Andy Shevchenko wrote:
> On Wed, Mar 13, 2024 at 9:08 AM Umang Jain <umang.jain@ideasonboard.com> wrote:
>> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
>>
>> Add a v4l2 subdevice driver for the Sony IMX283 image sensor.
>>
>> The IMX283 is a 20MP Diagonal 15.86 mm (Type 1) CMOS Image Sensor with
>> Square Pixel for Color Cameras.
>>
>> The following features are supported:
>> - Manual exposure an gain control support
>> - vblank/hblank/link freq control support
>> - Test pattern support control
>> - Arbitrary horizontal and vertical cropping
>> - Supported resolution:
>>    - 5472x3648 @ 20fps (SRGGB12)
>>    - 5472x3648 @ 25fps (SRGGB10)
>>    - 2736x1824 @ 50fps (SRGGB12)
> I have got only this patch and there is no word about changes. Please,

Sorry about that. I should have cc'ed your explicitly or perhaps there 
is a way to cc all recipients just for the cover.

I have
     `cccmd ="`pwd`/scripts/get_maintainer.pl"`

in my .gitconfig but I think I need to do extra to make sure everyone 
receives the cover-letter atleast.

The changelog here:
https://lore.kernel.org/linux-media/20240313070705.91140-1-umang.jain@ideasonboard.com/T/#m550b44ee8769b84e0c1419dc5bfd9a51414468d9

> either make sure you Cc'ed people in cover letter to all reviewers,
> and/or use a comment area (after '---' line to list the changes
> related to this patch).
>


