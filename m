Return-Path: <linux-kernel+bounces-139731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1698A06F3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB752284E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D20613BC15;
	Thu, 11 Apr 2024 03:53:54 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211713BAEE;
	Thu, 11 Apr 2024 03:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712807633; cv=none; b=Jo7e0aJ6kQbVliBjGS/R5MePboJ6/jMR/NLUriMKGAwsUV8wXDkOtDDmZJBHg9gSeLZwHX8q42zgSczywNWXzSmcCTQYETgOT2tSJZBzUdlKr0XM/KdqP0qgjwrzIE7DK9qLHY9pkIYpByPLpkC9IO67ax+5LXyLMAV9b9QawMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712807633; c=relaxed/simple;
	bh=FVyR68JT0BJ5g/rYpVWIA+Myr4JZBiOdIaa4guWz5DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZK75vt3s1d71cd0BS5nOG6dd1+zDtE1BDnzTgpuib72BEE/JXzou/03TzRceEBf9WUQ1ESEfcKuVgjLLK3gVpqd0onoWcmx/PgcX33PmHziylCgB06lVtta1G6zzTPvfZV3RQ7oacsYUy27VDhaKwwkjmMd7Fdx9/SK8sj+lNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51f9ad7684so157427766b.2;
        Wed, 10 Apr 2024 20:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712807630; x=1713412430;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wBSb+Go7UkZ8oXAsWUONI9r/P8/lvasBUHoLZKWqilY=;
        b=EUtiyOY567dRtE6ZL9mBB/RPIufZxk0pCgQI0i0yUbZqdUgxtMPVKc1y981bEeQ1wn
         X2w9KNtUivGEky3MyPCu3KOuZDZLEBTF+8rPATjdHqcGJX+J/fDBPau+d+GexsirrJZC
         uqUn0nmeAdHKfYn1xmqKEZuze8qCfW9cNAOgL853Ipc0KTNf4F3wML/smJx6KD5Np9Gw
         bjr4N963hn21XTrIcpHcAVVOZ7Z86zgcEvnRM2Y23UE1510ZlkCnMm3bY8a71FRgReq/
         NVUZGtFlWl0Zu4qjbP1IFfHVj+touyhz6VUrV4Ady2jyawARDLXmu8nhOR1wPL+bRS+n
         Ldww==
X-Forwarded-Encrypted: i=1; AJvYcCWArsmIqgeAHE3x6yhESp/VPjld1p2kMiw/aB/Phg5+/TYqSuT7uVScYgwAveIPNQYai0p1nacs+JjG5+ijCy/sbNlTB5LslfM4JUDdgNhpc9i3omf3pnMtF04cdf6n4uZGXzY2ZMPKsC0BPvbuhkLx5kDCDUXKo8piaVI9N89kZkzl5HCM0YIzJ7mJTblemybWtyOiR66UL6Mw+t3ttYgqZUA=
X-Gm-Message-State: AOJu0YxWd0pneB8x+ztJp1aX+rsZ1TaAm1i0mSn+Yn75623uMZO7iUea
	261+3eQ/MA2QFd1AlPGJp0fS+8KFFRIaoF7TnxBl8HiXUKSaPPU7
X-Google-Smtp-Source: AGHT+IHdCOlOxpB/6/pnU1MpS8cTFQwWBKKNftvVi0VDPlA623fsb6ZcsgAzrSgUJDjkOHcdkwQiOQ==
X-Received: by 2002:a50:d79a:0:b0:568:aa14:37a9 with SMTP id w26-20020a50d79a000000b00568aa1437a9mr3728219edi.24.1712807630223;
        Wed, 10 Apr 2024 20:53:50 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id t13-20020a056402240d00b00568afb0e731sm280775eda.63.2024.04.10.20.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 20:53:49 -0700 (PDT)
Message-ID: <79bc6166-8a6c-4329-86a0-2f150c60aed6@kernel.org>
Date: Thu, 11 Apr 2024 05:53:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] VT: Add KDFONTINFO ioctl
To: Alexey Gladkov <legion@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
 linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-serial@vger.kernel.org, Helge Deller <deller@gmx.de>
References: <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org>
 <cover.1712080158.git.legion@kernel.org>
 <7cd32f988a147d7617742c9e074c753de0c6bc1f.1712080158.git.legion@kernel.org>
 <211f3c45-7064-475b-b9e1-f6adbbba8879@kernel.org>
 <Zha_-zPHCW8iYT_4@example.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <Zha_-zPHCW8iYT_4@example.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10. 04. 24, 18:36, Alexey Gladkov wrote:
> On Wed, Apr 03, 2024 at 07:05:14AM +0200, Jiri Slaby wrote:
>> First, there was no need to send this v4 so quickly. Provided we have
>> not settled in v3... This makes the review process painful.
>>
>> And then:
>>
>> On 02. 04. 24, 19:50, Alexey Gladkov wrote:
>>> Each driver has its own restrictions on font size. There is currently no
>>> way to understand what the requirements are. The new ioctl allows
>>> userspace to get the minimum and maximum font size values.
>>>
>>> Acked-by: Helge Deller <deller@gmx.de>
>>> Signed-off-by: Alexey Gladkov <legion@kernel.org>
>> ...
>>> --- a/drivers/tty/vt/vt_ioctl.c
>>> +++ b/drivers/tty/vt/vt_ioctl.c
>>> @@ -479,6 +479,17 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
>>>    		break;
>>>    	}
>>>    
>>> +	case KDFONTINFO: {
>>> +		struct console_font_info fnt_info;
>>> +
>>> +		ret = con_font_info(vc, &fnt_info);
>>> +		if (ret)
>>> +			return ret;
>>> +		if (copy_to_user(up, &fnt_info, sizeof(fnt_info)))
>>
>> sizeof, I already commented.
> 
> I'm not sure I understand. sizeof(*up), but 'up' is 'void __user *up'.

I don't know what I saw/was thinking previously, ignore this one :).

thanks,
-- 
js
suse labs


