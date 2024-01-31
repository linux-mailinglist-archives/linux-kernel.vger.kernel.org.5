Return-Path: <linux-kernel+bounces-46305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE6843DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACFC81F23F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3FA7868D;
	Wed, 31 Jan 2024 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emfend.at header.i=@emfend.at header.b="OWy2bbyt"
Received: from lx20.hoststar.hosting (lx20.hoststar.hosting [168.119.41.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D3A78679;
	Wed, 31 Jan 2024 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.41.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699056; cv=none; b=MSrfOtasRYjG+wsH+dRS+rQUfC20OAt6NxQ1/t4wU9PQhj29BQD5YOVmTV5uTmHUdkkJqcsaJvTXPQx5X8QEyT1+XDuowzyZDO4fc++XhIeWR9d0JoKZDhEgucxbLV6cK0t4j4dBYJyrKhGUy0KX3PQSxmisaTCbhuqtavZyDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699056; c=relaxed/simple;
	bh=g4bNDFrpsoSNokjJPA4eIkfgG2JQLINcpNqZGcL3YUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrBzxOzN3j03eZAjfEO+h2/PaBiKMs1JA4cD2yS4tqfxFRivbQno3CpzsIhidpsvd7SxONu6paeUQ+bn/ZpNpycTwD+x5dsGffB5QmufLQmctf0nhMnGxhQoRtnZHmXYwMImOPcLXSUIn36ELXnlJ7pbBCP32RzwLh9xSzcnNX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emfend.at; spf=pass smtp.mailfrom=emfend.at; dkim=pass (1024-bit key) header.d=emfend.at header.i=@emfend.at header.b=OWy2bbyt; arc=none smtp.client-ip=168.119.41.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=emfend.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emfend.at
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=emfend.at;
	 s=mail; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=n5YQ/Ki++xPpgaCaf3kRbjcoNi+Wkj8sI8UeDv77yKw=; b=OWy2bbyt+jrhTzb8iYpvHatuNA
	rARt/7impr2pJtDopSlhS/cfPTTxhLxOtyYCebSabV8M16JcDc2BljdHsL8sXr1vmkv6287MfVXUi
	urx0SSbIFqShLypX09COaSvWOcyTSjUZH6iXYjSl+F98GBqdujHVyNhrsY3GLSdd9aII=;
Received: from 194-208-208-245.tele.net ([194.208.208.245]:57732 helo=[192.168.0.218])
	by lx20.hoststar.hosting with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.93)
	(envelope-from <matthias.fend@emfend.at>)
	id 1rV7to-00ENGD-QX; Wed, 31 Jan 2024 11:32:57 +0100
Message-ID: <d3abce5f-5e99-4a8b-a45b-29b706bc8481@emfend.at>
Date: Wed, 31 Jan 2024 11:32:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] media: i2c: imx335: Drop setting of 0x3a00
 register
Content-Language: de-DE
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20240131055208.170934-1-umang.jain@ideasonboard.com>
 <20240131055208.170934-2-umang.jain@ideasonboard.com>
 <170669477439.1011926.18210850208916698098@ping.linuxembedded.co.uk>
From: Matthias Fend <matthias.fend@emfend.at>
In-Reply-To: <170669477439.1011926.18210850208916698098@ping.linuxembedded.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 
X-Spam-Bar: 
X-Spam-Report: 

Hi Kieran,

Am 31.01.2024 um 10:52 schrieb Kieran Bingham:
> Hi Umang,
> 
> + Cc: Matthias
> 
> Quoting Umang Jain (2024-01-31 05:52:04)
>> Register 0x3a00 is a reserved field as per the IMX335 datasheet,
>> hence shouldn't be set by the driver.
> 
> We still need to explain more about why we're dropping this register
> write, and what effects it causes.
> 
> Matthias - I believe this stemmed from the work you did, and I think I
> recall that you stated this register write broke the CSI2 configuration?
> 
> Can you clarify anything here for us please?

yes, that's correct.

Since this driver originally did not work in my setup, I came across 
this register while searching for differences to my working reference 
configuration.
With the default value of this register (0x00), the driver works 
perfectly. With the value previously written to it by the driver (0x01), 
I cannot receive any frames.
The problem may depend on the link frequency used.
I can only use and test a frequency of 445.5MHz on my hardware. Since 
only link frequencies of 594MHz were supported so far, this may not have 
been a problem.

Unfortunately I do not have a description of this register, so I can 
only speculate about the exact cause.

~Matthias

> 
> --
> Kieran
> 
> 
>>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
>> ---
>>   drivers/media/i2c/imx335.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
>> index 7a37eb327ff4..927b4806a5d7 100644
>> --- a/drivers/media/i2c/imx335.c
>> +++ b/drivers/media/i2c/imx335.c
>> @@ -249,7 +249,6 @@ static const struct imx335_reg mode_2592x1940_regs[] = {
>>          {0x3794, 0x7a},
>>          {0x3796, 0xa1},
>>          {0x37b0, 0x36},
>> -       {0x3a00, 0x01},
>>   };
>>   
>>   static const struct imx335_reg raw10_framefmt_regs[] = {
>> -- 
>> 2.41.0
>>

