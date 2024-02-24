Return-Path: <linux-kernel+bounces-79724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3888625D4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6130F283338
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3A546548;
	Sat, 24 Feb 2024 15:40:09 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC44502D;
	Sat, 24 Feb 2024 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708789208; cv=none; b=OR8fkuziGL3IqsRv7djaWp7w6R8R/u3DfomVBQWXwZA1ud/4jUGTK6WWhFSiwGNy2Nlo0qdNHbz2lSzJnBRPthvOEvuKKKPsLkF1mabH8E9vqXLGEZaDWuXjPh/x+lhSOXSf9KpwDorNVh5Mx88nbPLuAfLrSnT3lEOX2Gqyvf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708789208; c=relaxed/simple;
	bh=2QsB1KpBd61cgHOYRP5jSDlOoH+9ldqZeWNm3QRlRKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRcZTUM13P6KvawKr2Gvl3Ib0F/JxsRXPR1O7FIsBpfdGsqoGysIt7jMzdVjnmSxBHCiM6mjU0Qxymmlj/3JRAwytY24hh0tvWz9D8RJ7Tcn3Unxf/QVoSdrQx6Ss6IVwwOY4z6Zk301ZOW8C4gM7YkJf3pdvBTeTrZJNnGN5Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 7F40582ECB;
	Sat, 24 Feb 2024 16:31:14 +0100 (CET)
Message-ID: <499911fc-71fb-4ee6-a121-c8698daf31e3@skole.hr>
Date: Sat, 24 Feb 2024 16:31:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] leds: expresswire: Don't use "proxy" headers
To: Pavel Machek <pavel@ucw.cz>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lee Jones <lee@kernel.org>
References: <20240223203010.881065-1-andriy.shevchenko@linux.intel.com>
 <ZdkGmE2HFxXpIonR@duo.ucw.cz>
Content-Language: en-US
From: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
In-Reply-To: <ZdkGmE2HFxXpIonR@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/2024 9:56 PM, Pavel Machek wrote:
>> -#include <linux/gpio/consumer.h>
>> +#include <linux/types.h>
>> +
>> +struct gpio_desc;
> 
> If include tweak means you need to declare struct, is it ian
> improvement?

In this case I'd say yes, the header in question has numerous other 
declarations (which are not used in leds-expresswire.h) and itself 
declares gpio_desc like this anyway.

Regards,
--
Duje


