Return-Path: <linux-kernel+bounces-160440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFBA8B3D82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E1C1F20EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C478F15B0FB;
	Fri, 26 Apr 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0yt03ZE"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846F156F38;
	Fri, 26 Apr 2024 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150945; cv=none; b=hS6wjOVPWBmyszKvWIC7CSqC3P3TB+Z8k0EpLseip11Lx36HBLVcqlsW92l/sIK6P0/b9IIVoLz4JHbDcMb+4zDI4wx1q2UwgXhucCGPMOI4jYNkA7L4ja4nTGEC1kI0ZDxY9zR59PAvM6WOxePFHkBTP9dAMa8ChqATG2MVHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150945; c=relaxed/simple;
	bh=VhZ9zjZaO7LINR6YAIwrCSbyI2+ZARznckY9vuhthDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JW/fNqoPbWUIuxdlLHx1bmtxZpHvfTSkXO89kXadLJRG/KeRcjKWYNavs49y43KB1wwmUInOeIg+THV5y6EhiqkGFV68nT/KYeiV+wJqf7rPYsirmQxIVISLbEMQw6ae+2H4Nx3s0ZfL0BgAFKgMLgBLv17qbjKnkWw7fz9VWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0yt03ZE; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2db13ca0363so37979921fa.3;
        Fri, 26 Apr 2024 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714150941; x=1714755741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94b5nhJx7HeqEEQnpwKUjZGcBHBH+uVSAHwjzfZ5Zfk=;
        b=X0yt03ZE02zCwGqHwpcKR4+/edmITJG5IpAxSS4o8M3FgLF2U4WjoLvVi5qsBEEXmA
         oXKxBxWfTeSaApeB/KB/CfqxPS/lPKBxqoaFpwjg5rNpTrySgz8EBWfQVn/XtMoKY72k
         oh081R95b7pLpWGPej4OjBFhOKjWILxp2zidUK1Fd1dpGLRy9I6OakcJlJ5QAvG1iTKr
         biVJGyrg7rvGmaXF023GfzSZT4DPEep2AFEBuVBAonaZ0wFVEWhLMED/LrI+ccvDnso/
         9V7xebis840cbCehfP/dUQecH8dwQkSUWm1uGyGgDJE26spq2Fx15vlJn8cQUOfs3kLe
         V4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714150941; x=1714755741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94b5nhJx7HeqEEQnpwKUjZGcBHBH+uVSAHwjzfZ5Zfk=;
        b=ovkFNWexC1AD+8HjG6k5SHtGx6ZqI0FsaT6EOHrYzkC7ehh6E4klWgGqR3Hr5Rv2fY
         U/prPzi+/v8hXfvUc2BH/05iArdWc3QnM87COAV85pw8eVwun9A3k0s/gZRh+a+20igY
         TxmMhyr2YvLq2tbW9q0g/TA7QGZYyL7ndjSsRPx/LJ6vAfnf46UdvzJldj/8qEG1IcNH
         SAFKg2zJsJpGFc3NN2L/Sp4r/5gTmOec9g8rqtaCQYp1O62JkTI25by2AIwXR/sJtLw2
         XWCoj/2oriAKomBhxDv29ZClfES4FzE5l7aWJU9dbOsBSJCeFljoLiSBijO70J8Jk+5i
         SVkA==
X-Forwarded-Encrypted: i=1; AJvYcCXgfoO3+j31PNInFVvq5iQ7HQJ2ZsxMoW5xTJ/tKUBcr+ia7aCDRAJKghdS+tNnYO2qNdHY751M9gc0S1bvgWHsi0kdPA9zwtU3LWrpmA2v02S/QfTdTTZ5gphsKvDAMj56J0zDbQjdM905BS0=
X-Gm-Message-State: AOJu0Ywm4of2XIlkY66adjU2UrW0WpBHIwQBnBvbbb4JFX5rZA6bbevG
	N1/vn2xum4rW52W4UBqovTefh7Mik0WqtDozfqrJPEr9QhZ0Ub+u
X-Google-Smtp-Source: AGHT+IGz8Oca8uHRUytGyraY/KLQssW324dKwoaO9XtyQAowq9712KVvWGe5HoV42URlhp/rRoWYPA==
X-Received: by 2002:a2e:9a8d:0:b0:2d4:49d1:38e with SMTP id p13-20020a2e9a8d000000b002d449d1038emr2601582lji.28.1714150940972;
        Fri, 26 Apr 2024 10:02:20 -0700 (PDT)
Received: from shift.daheim (p200300d5ff467e0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff46:7e00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906705400b00a555ef55ab5sm10759607ejj.218.2024.04.26.10.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 10:02:20 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.97)
	(envelope-from <chunkeey@gmail.com>)
	id 1s0Pt6-00000000NXv-1VrT;
	Fri, 26 Apr 2024 19:02:19 +0200
Message-ID: <bef4b45b-ec56-4c6d-88c8-cdb943f42342@gmail.com>
Date: Fri, 26 Apr 2024 19:02:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: carl9170: add a proper sanity check for
 endpoints
To: Kalle Valo <kvalo@kernel.org>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, lvc-project@linuxtesting.org,
 syzbot+0ae4804973be759fa420@syzkaller.appspotmail.com
References: <20240422183355.3785-1-n.zhandarovich@fintech.ru>
 <ccbdc170-149d-442c-8167-2b05c8cf93b2@gmail.com> <8734r8sorx.fsf@kernel.org>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <8734r8sorx.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 6:58 AM, Kalle Valo wrote:
> Christian Lamparter <chunkeey@gmail.com> writes:
> 
>> On 4/22/24 8:33 PM, Nikita Zhandarovich wrote:
>>> Syzkaller reports [1] hitting a warning which is caused by presence
>>> of a wrong endpoint type at the URB sumbitting stage. While there
>>> was a check for a specific 4th endpoint, since it can switch types
>>> between bulk and interrupt, other endpoints are trusted implicitly.
>>> Similar warning is triggered in a couple of other syzbot issues [2].
>>> Fix the issue by doing a comprehensive check of all endpoints
>>> taking into account difference between high- and full-speed
>>> configuration.
>>> This patch has not been tested on real hardware.
>>
>> Oh, I've tested the original patch on real hardware ;). You can remove that line.
> 
> BTW I can remove that line, no need to resend because of this.
> 

finished testing v2 - it works, no surprise.

high-speed:
| [  188.470363] usb 3-14: new high-speed USB device number 4 using xhci_hcd
| [  188.661053] usb 3-14: New USB device found, idVendor=0846, idProduct=9010, bcdDevice= 1.06
| [  188.661056] usb 3-14: New USB device strings: Mfr=16, Product=32, SerialNumber=48
| [  188.661058] usb 3-14: Product: USB2.0 WLAN
| [  188.661059] usb 3-14: Manufacturer: ATHER
| [  188.661060] usb 3-14: SerialNumber: 12345
| [  188.783843] usb 3-14: reset high-speed USB device number 4 using xhci_hcd
| [  188.963408] usb 3-14: driver   API: 1.9.9 2016-02-15 [1-1]
| [  188.963412] usb 3-14: firmware API: 1.9.6 2012-07-07
| [  189.298218] ath: EEPROM regdomain: 0x0
| [  189.298221] ath: EEPROM indicates default country code should be used
| [  189.298222] ath: doing EEPROM country->regdmn map search
| [  189.298223] ath: country maps to regdmn code: 0x3a
| [  189.298224] ath: Country alpha2 being used: US
| [  189.298225] ath: Regpair used: 0x3a
| [  189.298290] ieee80211 phy2: Selected rate control algorithm 'minstrel_ht'
| [  189.301463] usb 3-14: Atheros AR9170 is registered as 'phy2'

full-speed:
| [  205.743314] usb 4-2: new full-speed USB device number 3 using ohci-pci
| [  205.990614] usb 4-2: not running at top speed; connect to a high speed hub
| [  206.029618] usb 4-2: New USB device found, idVendor=0cf3, idProduct=1002, bcdDevice= 1.06
| [  206.029621] usb 4-2: New USB device strings: Mfr=16, Product=32, SerialNumber=48
| [  206.029622] usb 4-2: Product: USB2.0 WLAN
| [  206.029623] usb 4-2: Manufacturer: ATHER
| [  206.029624] usb 4-2: SerialNumber: 12345
| [  206.209969] usb 4-2: reset full-speed USB device number 3 using ohci-pci
| [  206.471776] usb 4-2: driver   API: 1.9.9 2016-02-15 [1-1]
| [  206.471779] usb 4-2: firmware API: 1.9.6 2012-07-07
| [  206.885680] ath: EEPROM regdomain: 0x809c
| [  206.885684] ath: EEPROM indicates we should expect a country code
| [  206.885686] ath: doing EEPROM country->regdmn map search
| [  206.885687] ath: country maps to regdmn code: 0x52
| [  206.885689] ath: Country alpha2 being used: CN
| [  206.885691] ath: Regpair used: 0x52
| [  206.885794] ieee80211 phy3: Selected rate control algorithm 'minstrel_ht'
| [  206.888834] input: phy3 WPS Button as /devices/pci0000:00/0000:00:1c.3/0000:05:00.0/0000:06:01.0/usb4/4-2/4-2:1.0/ieee80211/phy3/input17
| [  206.892694] usb 4-2: Atheros AR9170 is registered as 'phy3'


Tested-by: Christian Lamparter <chunkeey@gmail.com>

