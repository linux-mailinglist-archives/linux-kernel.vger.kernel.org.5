Return-Path: <linux-kernel+bounces-129853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C044089714A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20743B21147
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88D11487C4;
	Wed,  3 Apr 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="UjXIGxpl"
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DC7143863;
	Wed,  3 Apr 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.177.23.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712151423; cv=none; b=IWT4vCsPkBq7xEvay72SCekFv2JRaFeY1DzZPEtxwcA5ynmg/iQys87xJ+d9TBInwWOPEBfwB8vA3eM3/AR3FLr4/CUcNpyISrmyJfNjLoKX+2z2jL8nUwasBzZtZyK6EZ4w5kiHC0UMVDsch/wtcwRHEQycDrsWog3YYADPS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712151423; c=relaxed/simple;
	bh=+F4Hbvp1IyArx78p/Dg0KT/m9+3bN5tBBIOYAx858GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdompYbX0fjHIQan5aMOMp8zl5FYixjau1m7lfglA1yc0KAk+ylNMX5Pa5NZDAbEMbogMzPqTDVzNQ1ttsteYHUvCqJUJLiJlUXwU8TB4ueIgLKTuC8nuVvNnau2KXdze/VavGHk0rOv3YDPXR6B3GkJaHjRwyHVcDaQAOUiEkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=UjXIGxpl; arc=none smtp.client-ip=89.177.23.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [10.0.0.200] (unknown [10.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 7C943165BA4;
	Wed,  3 Apr 2024 15:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1712150845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2ZW5YwM7LCMfQsqtCaAg0KPR2u5p7sL5BpamhWD0Zs=;
	b=UjXIGxplfEY9FH0fb8RMu4TKXmxLnAT/xg1bZEyy94n+G5PuNOUhFEw7xL9mrxlUHklnOq
	Ji/EjmqvynX8gm9Kzs6vGPmn6/7uQtTNzDlLDA6/clhmYEFOEW5iUT8QszLuAVd923mH72
	84udrN1HOT4tEU8tRkZvp+Mqr2LkNIE=
Message-ID: <a969570c-8cd0-4217-8281-46b879040e0b@ixit.cz>
Date: Wed, 3 Apr 2024 15:27:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v6 0/2] usb: serial: add support for CH348
To: Corentin LABBE <clabbe@baylibre.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc: gregkh@linuxfoundation.org, johan@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230628133834.1527941-1-clabbe@baylibre.com>
 <2595072.9XhBIDAVAK@archbook> <ZVtRNZmCMImCT9sN@Red>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
In-Reply-To: <ZVtRNZmCMImCT9sN@Red>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Corentin,

is there chance you find some time to upstream this?
In the worst case I would try to find some time to look into this, so it 
would have chance to get merged.

Thanks
David

On 20/11/2023 13:29, Corentin LABBE wrote:
> Le Wed, Aug 30, 2023 at 07:43:03PM +0200, Nicolas Frattaroli a écrit :
>> On Mittwoch, 28. Juni 2023 15:38:32 CEST Corentin Labbe wrote:
>>> Hello
>>>
>>> The CH348 is an octo serial to USB adapter.
>>> The following patch adds a driver for supporting it.
>>> Since there is no public datasheet, unfortunatly it remains some magic values.
>>>
>>> It was tested with a large range of baud from 1200 to 1500000 and used with
>>> success in one of our kernel CI testlab.
>>>
>>> Regards
>>>
>>> [...]
>> Hello,
>>
>> thank you for your work on this. I recently made myself a CH348
>> board and used this patchset with a small test application[1]
>> to see how it performs. Specifically, I ran this on an RK3566
>> single board computer, connecting one serial adapter to the
>> other, with the test as follows:
>>
>>   ./serialtest /dev/ttyUSB0 9600 # UART0 of 1st CH348 board
>>   ./serialtest /dev/ttyUSB8 9600 # UART0 of 2nd CH348 board
>>
>> One problem I've noticed is that writes to the tty fd never
>> seem to block. On two CH340 adapters I have, they do seem to
>> block, whereas here, you can see from the statistics at the
>> end that magnitudes more bytes were written than read, with
>> seemingly most of them being discarded. From my reading of
>> the termios parameters I set, this shouldn't be the case,
>> right?
>>
>> You can see from the error percentage that it gets less
>> bad as you increase the serial baudrate; I've tested up
>> to 6 mbaud like this. I assume that's because less written
>> bytes get discarded.
>>
>> Any ideas on whether I'm relying on weird driver behaviour
>> with the blocking here or if this driver actually has a
>> defect whereby it never signals to userspace that less
>> bytes were written than have been submitted?
>>
>> Kind regards,
>> Nicolas Frattaroli
>>
>> [1]: https://github.com/CounterPillow/serialtest
>>
> Hello
>
> Sorry for the very long delay of the answer.
> I have reproduced the problem on my board.
> My reproducer is https://github.com/montjoie/lava-tests/blob/master/test2a2.py
>
> This problem seems to be here since the v1 of my patchset.
> The vendor driver seems to work so it is not an hardware problem.
>
> I have no clue at the moment, it is hard to diff with vendor driver since it create tty directly and do not use usbserial.
>
> Regards

-- 
David Heidelberg


