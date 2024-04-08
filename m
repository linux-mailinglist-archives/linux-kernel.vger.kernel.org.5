Return-Path: <linux-kernel+bounces-135262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB4A89BE11
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346F71F2279C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFE4657CD;
	Mon,  8 Apr 2024 11:24:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37465524DE;
	Mon,  8 Apr 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575442; cv=none; b=Cu1jjIamem7FMMy1r+MLmQIGO53sX0VwuxkQvySbsbYcKONaadTFv9jKQMCvz9FLYcEDGTXbCeZsFBTu5LkcBz9ZFDVi9iRX+MWv8/Cwf5+byJc8VjSwC8cAU4XHz9JGbUg7LR9NZO/zixpi1JnTL9UNT7mmQtgqYIgf3TWBvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575442; c=relaxed/simple;
	bh=yLlPAbcO7sAzkQT4sLFDTnZOcPu50LAWWkbb3smBAps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpDe4TN/2pZ/QNhrVchKyZsPFFuH8kuUehsG5xYmTrbK69vW8yM2t0rj0FxX4W2mUsu6JZcYyO+tJjfiNCxplR5SvnDCzU1HGsTPjWOeUMEhbPVGy/T4Kc+j5Ii6zblaANacZF2EucsW+d7wIGZMwSVd6+BsT5+4p9viEgfvTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5654FC433C7;
	Mon,  8 Apr 2024 11:24:00 +0000 (UTC)
Message-ID: <3a480ef5-f222-4a0d-b236-6587cd276631@xs4all.nl>
Date: Mon, 8 Apr 2024 13:23:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: dvbdev: make dvb_class constant
Content-Language: en-US, nl
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Young <sean@mess.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240305-class_cleanup-media-v1-0-53e1538973cd@marliere.net>
 <20240305-class_cleanup-media-v1-1-53e1538973cd@marliere.net>
 <ae5840f3-7e19-4d60-bd87-567068a3f813@xs4all.nl>
 <iduap7j36flhvmmsbvm6kzormftqi2xxfpndf62jp5lveljo3k@zgpxyqwckuuz>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <iduap7j36flhvmmsbvm6kzormftqi2xxfpndf62jp5lveljo3k@zgpxyqwckuuz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 12:47, Ricardo B. Marliere wrote:
> Hi Hans!
> 
> On  8 Apr 11:47, Hans Verkuil wrote:
>> On 05/03/2024 14:26, Ricardo B. Marliere wrote:
>>> Since commit 43a7206b0963 ("driver core: class: make class_register() take
>>> a const *"), the driver core allows for struct class to be in read-only
>>> memory, so move the dvb_class structure to be declared at build time
>>> placing it into read-only memory, instead of having to be dynamically
>>> allocated at boot time.
>>>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
>>> ---
>>>  drivers/media/dvb-core/dvbdev.c | 23 +++++++++++++----------
>>>  1 file changed, 13 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
>>> index 733d0bc4b4cc..dcbf68b00240 100644
>>> --- a/drivers/media/dvb-core/dvbdev.c
>>> +++ b/drivers/media/dvb-core/dvbdev.c
>>> @@ -78,7 +78,13 @@ static const u8 minor_type[] = {
>>>  #define MAX_DVB_MINORS		(DVB_MAX_ADAPTERS * 64)
>>>  #endif
>>>  
>>> -static struct class *dvb_class;
>>> +static int dvb_uevent(const struct device *dev, struct kobj_uevent_env *env);
>>> +static char *dvb_devnode(const struct device *dev, umode_t *mode);
>>
>> Forward references are typically something you want to avoid.
>>
>> Looking at the code, I think it makes sense to just move those two functions
>> to just before this dvb_class.
> 
> Ack.
> 
>>
>>> +static const struct class dvb_class = {
>>> +	.name = "dvb",
>>> +	.dev_uevent = dvb_uevent,
>>> +	.devnode = dvb_devnode,
>>> +};
>>>  
>>>  static struct dvb_device *dvb_minors[MAX_DVB_MINORS];
>>>  static DECLARE_RWSEM(minor_rwsem);
>>
>> Also move the dvb_class (+ the two functions) to after this line. I think that's
>> a more suitable place for this.
> 
> Ack.
> 
>>
>>> @@ -561,7 +567,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
>>>  		return ret;
>>>  	}
>>>  
>>> -	clsdev = device_create(dvb_class, adap->device,
>>> +	clsdev = device_create(&dvb_class, adap->device,
>>>  			       MKDEV(DVB_MAJOR, minor),
>>>  			       dvbdev, "dvb%d.%s%d", adap->num, dnames[type], id);
>>>  	if (IS_ERR(clsdev)) {
>>> @@ -600,7 +606,7 @@ void dvb_remove_device(struct dvb_device *dvbdev)
>>>  
>>>  	dvb_media_device_free(dvbdev);
>>>  
>>> -	device_destroy(dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
>>> +	device_destroy(&dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
>>>  
>>>  	list_del(&dvbdev->list_head);
>>>  }
>>> @@ -1096,13 +1102,10 @@ static int __init init_dvbdev(void)
>>>  		goto error;
>>>  	}
>>>  
>>> -	dvb_class = class_create("dvb");
>>> -	if (IS_ERR(dvb_class)) {
>>> -		retval = PTR_ERR(dvb_class);
>>> +	retval = class_register(&dvb_class);
>>> +	if (retval != 0)
>>
>> This can just be 'if (retval)'.
> 
> But then it would be on a different style than the rest of the function:

Ah, I hadn't noticed that. Let's keep it as you proposed then.

Regards,

	Hans

> 
> static int __init init_dvbdev(void)
> {
> 	int retval;
> 	dev_t dev = MKDEV(DVB_MAJOR, 0);
> 
> 	retval = register_chrdev_region(dev, MAX_DVB_MINORS, "DVB");
> 	if (retval != 0) {
> 		pr_err("dvb-core: unable to get major %d\n", DVB_MAJOR);
> 		return retval;
> 	}
> 
> 	cdev_init(&dvb_device_cdev, &dvb_device_fops);
> 	retval = cdev_add(&dvb_device_cdev, dev, MAX_DVB_MINORS);
> 	if (retval != 0) {
> 		pr_err("dvb-core: unable register character device\n");
> 		goto error;
> 	}
> 
> 	retval = class_register(&dvb_class);
> 	if (retval != 0)
> 		goto error;
> 
> 	return 0;
> 
> error:
> 	cdev_del(&dvb_device_cdev);
> 	unregister_chrdev_region(dev, MAX_DVB_MINORS);
> 	return retval;
> }
> 
> 
>>
>>>  		goto error;
>>> -	}
>>> -	dvb_class->dev_uevent = dvb_uevent;
>>> -	dvb_class->devnode = dvb_devnode;
>>> +
>>>  	return 0;
>>>  
>>>  error:
>>> @@ -1115,7 +1118,7 @@ static void __exit exit_dvbdev(void)
>>>  {
>>>  	struct dvbdevfops_node *node, *next;
>>>  
>>> -	class_destroy(dvb_class);
>>> +	class_unregister(&dvb_class);
>>>  	cdev_del(&dvb_device_cdev);
>>>  	unregister_chrdev_region(MKDEV(DVB_MAJOR, 0), MAX_DVB_MINORS);
>>>  
>>>
>>
>> Regards,
>>
>> 	Hans


