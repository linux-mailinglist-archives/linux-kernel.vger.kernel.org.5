Return-Path: <linux-kernel+bounces-141594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54418A2074
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FF21F26061
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E340B2941C;
	Thu, 11 Apr 2024 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G65oDiQ6"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0C17C8D;
	Thu, 11 Apr 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712868761; cv=none; b=AeQpvsqLfR1z21NmX6CC85ahcfW+oik9uI5s3AwsXVN/fd8XJFLbqJK/cTiwBDShhSrXKD7MdpJjwn0GqjbpygON6Rr4XzaQ2nL+3CwKJNu+LHGm1zxErb6LFFSDPprbo6f+QzXz0w6G5BXmJ8b3OFlvgkZXe5gVsh+Ibh26QhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712868761; c=relaxed/simple;
	bh=JrvX8um+EbICvWw9zskL/ERHC4Vwe09tGcMdO/xTJqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNPMKHTDtilQyzBNZ+RG5XLZlfwCucxZi4wE7Zpm9X94YHOGiIROKYg11GlUkp8VMQ2wUKZ2TnRmKR8unCC2YejEVE9Q1dAZqdM9CFbtrn1Rk1GBqQbHJnI0igLm+r5At4UClHpacfK657rRCoohgmPm/XoQwbHC9xM407/Avmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G65oDiQ6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso215816a12.0;
        Thu, 11 Apr 2024 13:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712868758; x=1713473558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5dGfMryEizOv053XWps+n251C26VsvIA27q5i2uHTk=;
        b=G65oDiQ6RFRV6x+hSkpJIJgTE4VvTRNnauWGb0oPpqBp4nUJyU+pY7h+7IbxuH5gSm
         qfC1CHE6zmvkUU7A4kMX/t6V+tF5MkS/JOVu5q4y0Btm20mE1V4KGZZxZ07SN77j+JAL
         RXeSDsa8LX7TvQbDQPfTWRzW7rI1kjX2h/W2CSp9HIXECNU0oeoNyFf1GoIC8n7yEkV3
         +b6v+4pRe03KBEC+vMArhzre7E4dbjzTEU90ugb8JjRVcLYr9tyL2PxVa3HzsSXBl7Eh
         sXsOKpMqsCl7oge2dByExIFm137VKSFcTpfTbYPZeVWngKeg0nyN2jxWiUoVB9k+6oi3
         tXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712868758; x=1713473558;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5dGfMryEizOv053XWps+n251C26VsvIA27q5i2uHTk=;
        b=lhaaHtwapIAyurkk4aaafEl0CLwYFARgliWxdbMRP1TdX2k3cI/fkN2DrncJD50Kdi
         +Lb4wIWNSip9pIPc6Z58c59XJ+mEn/+2/zs+q/HNwUDo1nOFkWOx4WVNjTqNozC/a6xD
         AuKWboHDbJVZryLCSQF45QKQ3OYZEFD3qbbF96ZHghcbATjgwrkxfeARAvZ8oqQsfuDU
         s9Ve2KuqiSmO19+NmelzntyT1aen4GNeQKBA8pkT5OkxrKISxLUoOLAcggbua1Wg/QOn
         oySiqqeVblXGe2vl5J3HDsNXi5AVOaCgms4RDWPmma93GjaddBND9H0jzFNZIJeEyuRD
         NM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuSydR7bBqJYIw7AU4kNjvL4o4pDcjRsX9r0Yt8nIiTSc2uXxr6px/9PR52pQJgckbEsCM2WbMlPfR+AV/wpgfjZyoyJ+XzSXG0S22z9qCuViHtb3OCHSnAsAuPHgFMCXHkbf2ViK7
X-Gm-Message-State: AOJu0Yz496tqoO2JZPAku4i5lt9o1BAr4LL4qFtdUVcmReL5a//Teg0/
	XwjQwbgZUzCfw+c+N4MHnXYev4CFwAT5LDNW2LySu7lwo+feUNb8
X-Google-Smtp-Source: AGHT+IG9nklzDlm92gTikTbMEzvGUGjm/+Eaxbb+zHBFu1HWuSV7SmGpbYFZpjHIjIeVZU1aI9TwpA==
X-Received: by 2002:a50:9317:0:b0:56e:2add:12eb with SMTP id m23-20020a509317000000b0056e2add12ebmr492478eda.13.1712868757791;
        Thu, 11 Apr 2024 13:52:37 -0700 (PDT)
Received: from ?IPV6:2a02:a466:68ed:1:56f0:b227:d4c1:42e7? (2a02-a466-68ed-1-56f0-b227-d4c1-42e7.fixed6.kpn.net. [2a02:a466:68ed:1:56f0:b227:d4c1:42e7])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640204d200b0056fed8e7817sm620670edw.20.2024.04.11.13.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 13:52:37 -0700 (PDT)
Message-ID: <be8904bd-71ea-4ae1-b0bc-9170461fd0d9@gmail.com>
Date: Thu, 11 Apr 2024 22:52:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: gadget: u_ether: Replace netif_stop_queue with
 netif_device_detach
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc: gregkh@linuxfoundation.org, s.hauer@pengutronix.de, jonathanh@nvidia.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_linyyuan@quicinc.com, paul@crapouillou.net, quic_eserrao@quicinc.com,
 erosca@de.adit-jv.com
References: <20231006153808.9758-1-hgajjar@de.adit-jv.com>
 <20231006155646.12938-1-hgajjar@de.adit-jv.com>
 <ZaQS5x-XK08Jre6I@smile.fi.intel.com>
 <20240115132720.GA98840@vmlxhi-118.adit-jv.com>
 <f25283fc-4550-4725-960b-2ea783fd62e1@gmail.com>
 <aeee83d8-dee3-42ed-b705-988b17800721@gmail.com>
 <20240405113855.GA121923@vmlxhi-118.adit-jv.com>
 <321e908e-0d10-4e36-8dc4-6997c73fe2eb@gmail.com>
 <ZhbOZsp-XHemVhQz@smile.fi.intel.com>
 <20240411142637.GA110162@vmlxhi-118.adit-jv.com>
 <ZhgSPCq6sVejRjbj@smile.fi.intel.com>
Content-Language: en-US
From: Ferry Toth <fntoth@gmail.com>
In-Reply-To: <ZhgSPCq6sVejRjbj@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

Op 11-04-2024 om 18:39 schreef Andy Shevchenko:
> On Thu, Apr 11, 2024 at 04:26:37PM +0200, Hardik Gajjar wrote:
>> On Wed, Apr 10, 2024 at 08:37:42PM +0300, Andy Shevchenko wrote:
>>> On Sun, Apr 07, 2024 at 10:51:51PM +0200, Ferry Toth wrote:
>>>> Op 05-04-2024 om 13:38 schreef Hardik Gajjar:
> ...
>
>>>> Exactly. And this didn't happen before the 2 patches.
>>>>
>>>> To be precise: /sys/class/net/usb0 is not removed and it is a link, the link
>>>> target /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/net/usb0 no
>>>> longer exists
>> So, it means that the /sys/class/net/usb0 is present, but the symlink is
>> broken. In that case, the dwc3 driver should recreate the device, and the
>> symlink should become active again

Yes, on first enabling gadget (when device mode is activated):

root@yuna:~# ls /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
driver  net  power  sound  subsystem  suspended  uevent

Then switching to host mode:

root@yuna:~# ls /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
ls: cannot access 
'/sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/': No such 
file or directory

Then back to device mode:

root@yuna:~# ls /sys/devices/pci0000:00/0000:00:11.0/dwc3.0.auto/gadget.0/
driver  power  sound  subsystem  suspended  uevent

net is missing. But, network functions:

root@yuna:~# ping 10.42.0.1
PING 10.42.0.1 (10.42.0.1): 56 data bytes

Mass storage device is created and removed each time as expected.

>> I have the dwc3 IP base usb controller, Let me check with this patch and
>> share result here.  May be we need some fix in dwc3
Would have been nice if someone could test on other controller as well. 
But another instance of dwc3 is also very welcome.
> It's quite possible, please test on your side.
> We are happy to test any fixes if you come up with.
>

