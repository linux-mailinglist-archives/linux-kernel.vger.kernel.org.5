Return-Path: <linux-kernel+bounces-30368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA754831DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936E8289CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE402C6A6;
	Thu, 18 Jan 2024 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWJfHint"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2CD2C1AA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596641; cv=none; b=rus30xj6jX+fRtDsFJe+R/aeKC2G2Yom01k2G/x1ZWON4VYaID807Y+q77BFbsTaN3FtTjBQ403NzfDFcs7HczVOz/V4OqoO3tKes+Ry874JpgKkKcfDLRU/7/RqpXApD/2B7OqAhqeCg6jYmsQCfViEGOJs3zFutM5vLrObe2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596641; c=relaxed/simple;
	bh=GoSnJvbInhUneOcpIMpG6PO4wGt94pP9zivRHcpW51o=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=OJiXJjn3ghRf4uUCRl7VfTnnHBubTS623S0SvZI08YPnnDyIP1ukMmRvLvTSayRFQtq4P++qNRmNm9SeWa9W7p/jj+uhwDD/ebqr7n57vyeBfd8UBnsxu8dlEPOyh6jCGpTpNU6ec7sbR+MlOqKI9Hs9ecKndUovk7dhbQpTsZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWJfHint; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68155fca099so3865806d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705596639; x=1706201439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s8NzZFNxh2baIGiQbA9hgRxIhE+RRKnrU1sqWVerRcs=;
        b=cWJfHintpXlrbYHCYzXBEpVW1sAHo17l3mIgSXmlumPMRgNb8yqdrbATUXvS4V1VcB
         w2+NIsckGCgN+pNordYuXCDXkjRCT85Ni1KDcf+UuuGEn7Xh0XEu8XGrEZyB1r+hzmJZ
         IsW2gyEyDOCdkQVW6HOjIbX60RYTmtkq8SngAxEWMKsXkMtOo+tzkwJX8sCGXcxyiKm8
         88DJh305lXLg1xhNvT17XcjOOSYa6DkhFkS4CiPqIAGTm454fh2SdQiB/nsn+jFfOxno
         xtxoSzStlft3esjPMga1VOUDLaoe5CDFFYOWgnQe36uuql7hURLz2ZKjbWhgCxz3n8BG
         mn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705596639; x=1706201439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8NzZFNxh2baIGiQbA9hgRxIhE+RRKnrU1sqWVerRcs=;
        b=TxLBIbKpPqWiWKnZFfW8OBmkridyC0YfiAqf43EVdcL3asV1qdIy7JsHeCPpOF79IO
         qD2iJeDdLRTOwsN/ZQZj3Qb+hMJK7js02rz/Xfg4btl3dya2a1aq/NeJTsTHk+6dvJrg
         BKIBm2KCSHtM69a3tWeJ/seFAZKJbkeYkIedf9wJiBkUuBl4ZAJ52I09bMVaoL6IRdG+
         Rs/UOAMem3a0QW1NYhdlNmyBSGwB0qyAR8bv7VOHUmmWHdXJ2cnSt3NelPrMPQyWKrlO
         /1WcjsNQFe/ps8NUvN7yKWji9+M4MqAiFCO+d8nkjtAarGC+mVaLSFkAAqssqnxEHr1r
         YgLg==
X-Gm-Message-State: AOJu0Yxcuva8hERq98r0r4oySNH/dqCL6JL1tMMLNxKiAqSGY5gCQymd
	MoWcUzQUB1FDeiyXNuvdoNDhnCylnz+lYeeZwxk/xRoU0aQQOGs+
X-Google-Smtp-Source: AGHT+IGLoi6AJacYTFUutdPDIxXBhjkd7tv7QpRB+NoK37GloZywG2v+3j4HUZ2urt0NpPQVD6fioA==
X-Received: by 2002:a05:6214:5184:b0:681:86fd:33c1 with SMTP id kl4-20020a056214518400b0068186fd33c1mr1994344qvb.4.1705596639180;
        Thu, 18 Jan 2024 08:50:39 -0800 (PST)
Received: from [192.168.1.157] (pool-74-98-201-227.pitbpa.fios.verizon.net. [74.98.201.227])
        by smtp.gmail.com with ESMTPSA id w20-20020a0562140b3400b006817d42eac6sm1441776qvj.53.2024.01.18.08.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 08:50:38 -0800 (PST)
Message-ID: <5a60b50d-34f5-42a2-8112-f988b89f1e7f@gmail.com>
Date: Thu, 18 Jan 2024 11:50:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] staging: rts5208: Add more details to Kconfig help
To: Randy Dunlap <rdunlap@infradead.org>, gregkh@linuxfoundation.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240118160901.71756-1-jklott.git@gmail.com>
 <3f4582ac-8180-417b-a83a-0b9f362cc5a0@infradead.org>
Content-Language: en-US
From: Jacob Lott <jklott.git@gmail.com>
In-Reply-To: <3f4582ac-8180-417b-a83a-0b9f362cc5a0@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/18/24 11:47 AM, Randy Dunlap wrote:
> Hi--
>
> On 1/18/24 08:09, Jacob Lott wrote:
>> The current help text is short and triggers a
>> warning from checkpatch.pl. This patch adds more
>> details to the help text which should provide better
>> information for whether or not to enable the driver.
>>
>> Signed-off-by: Jacob Lott <jklott.git@gmail.com>
>> ---
>>   drivers/staging/rts5208/Kconfig | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/rts5208/Kconfig b/drivers/staging/rts5208/Kconfig
>> index b864023d3ccb..4f9cc3f00e1a 100644
>> --- a/drivers/staging/rts5208/Kconfig
>> +++ b/drivers/staging/rts5208/Kconfig
>> @@ -3,7 +3,11 @@ config RTS5208
>>   	tristate "Realtek PCI-E Card Reader RTS5208/5288 support"
>>   	depends on PCI && SCSI
>>   	help
>> -	  Say Y here to include driver code to support the Realtek
>> -	  PCI-E card reader rts5208/rts5288.
>> +      Choose Y here to enable support for the Realtek PCI-E card reader
> Above line is indented with spaces. It should be on tab + 2 spaces.
>
>> +	  RTS5208/5288. This driver facilitates communication between the Linux
>> +	  kernel and the Realtek PCI-E card reader.
>>   
>> -	  If this driver is compiled as a module, it will be named rts5208.
>> +	  If you opt to compile this driver as a module, it will be named rts5208.
>> +	  Selecting N will exclude this driver from the kernel build. Choose option
>> +	  Y if your system includes the Realtek PCI-E card reader rts5208/rts5288.
>> +	  When in doubt, it is generally safe to select N.
> That's not incorrect, but it is verbose IMO.
> More than we usually say.
>
>> \ No newline at end of file
> Please add a newline at the end of the file.
>
> thanks.
In general is there an option/additional check I can run besides 
checkpatch.pl to catch issues with tabs, newlines, col width, etc?

