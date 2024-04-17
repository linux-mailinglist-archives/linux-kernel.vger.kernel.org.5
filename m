Return-Path: <linux-kernel+bounces-148923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8848B8A890A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B98051C22C53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EC5171063;
	Wed, 17 Apr 2024 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/AWQjr4"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801CA147C8D;
	Wed, 17 Apr 2024 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371980; cv=none; b=PHdWjka8UTXuu9FQa8GQ01AwXWEX71PHOCmv/jqHLl0fKwvId9DSJ924TPtOzGlfNoqUKSNdn9gUsi8cZZ86ZSIIMmU8WXWVj5NCVwhrfar1D/uYbk7CJIzpChALkeAin9BCZhfboE1CmyHJY7UuWwPMnF4XHBJkuli+jjdEheQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371980; c=relaxed/simple;
	bh=aWTPDq9p7jQ/4H76/mW9C1YBC1szIVSw3Mc/rYRFAek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOsrvk5Ee0KxtzuQxUU7zScMDWsAjWQ5Jl8MWyzVGo396kX/hBa4hkAPJVVHqZ47ygdxxgE8ZywgoBYh8OcINB1jUBNYBayYGtdmWuhyiPHi51e6mAr7S7n2iBWj5JO0LylizyxD5E7XPBMt9uqv35CJm5HNI+Asz+37suxfgcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/AWQjr4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d3907ff128so4575668a12.3;
        Wed, 17 Apr 2024 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713371979; x=1713976779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I7Zh42cClUUxS34CpnuDLFTWaHNT2a1g8mM8QHZw6C8=;
        b=g/AWQjr4sjil5Es/t8rl7gS7pSKKLHW/RzJ1zfqyNVKJ/zZkLWCKvdEp0DchKCfJc1
         4weUsfQ8OfYWlL0C9GNDhrCsSPVnG2BWSoJ4441DXE7dBDRpKy/SObfu/qMbyiI9Cf8P
         Oe859fgN/FCQ1l7yxYGRyPc2tDt8rQt+PEixRjsKzCZFXX3DE8TJtty4q+8iS/Ac+Ly3
         M1n3DmlDOUkRMN23vDGKWzftlxV8V52NAFdDm1CxDk5ntUOnxyvdo9UvjnH+x+ugrlYT
         r+ZAgLNxWksPuwgHp74hrSdEIS4XibmwiZPoXX5x0H+q2do8+LYZoI3l09XJuA+g/WLo
         sImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713371979; x=1713976779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7Zh42cClUUxS34CpnuDLFTWaHNT2a1g8mM8QHZw6C8=;
        b=OjnPZ6E+0EUhmbin/Dyg0LfLSc4w9wzjJYI1QZkBmgQjsF1HWvEZCKVGRcF01B/0P6
         +cOgoDn0UhC1vuF14o7ihxHoF9a0WOqW647tz4af2y2eiZ5FAgsSVkBmdNNka0shTCvU
         eziadnaxcKBZvI4dmRaIJRjATZ5YuDNrEIM1lkJC6bIJPuLw96CIAVilvPlduxXCJH6W
         VYjjEdZ9vCH6yxYr5B0LjaSGJU4aLoz1rgFaG1+mYJbiqYC+YHu7QzrVdkr/BsHPd9EA
         VnQTz9yGZE4cKcdfjuPWFn8pU3oj2nWmYxAG+3BDB9EdcjA2/uICQDkEna25FyN5XtmZ
         DGGw==
X-Forwarded-Encrypted: i=1; AJvYcCVUA4LCFF62sI1CtVSUDzB0Rgv5RYLCtScuuE6+D0fNLhOGjuzw+IsuvBhXsVnxMis7mmlej918MoVe8FmoHAALZzVrOEzaawegCxyJRrqZ9kSVOcfniIsKUqCIZbUw1Tc15rcywBqXgNF1nG1zXxpHqPODtQKZYmt6pK+nHtyd31+LacDcPz6mdg==
X-Gm-Message-State: AOJu0Yz9CUwpStCuhpUXbbckhCK4JRtzMFWPqC6/L0EO3Sj+niTUjcL1
	Vgz03AcLIgjGGQjvQiDiCPA4C03+98uomjHIdXjsh51REENKrieRIbMrUtJMuBg=
X-Google-Smtp-Source: AGHT+IFsgpgKF4MpNGRI12HFX8X1jR4fq2uA3v5uQF83Vql6HROO8gtLkEMXQdJU4OMr5Az/Juz0QQ==
X-Received: by 2002:a17:90a:886:b0:2ab:99d5:ae11 with SMTP id v6-20020a17090a088600b002ab99d5ae11mr658653pjc.20.1713371978710;
        Wed, 17 Apr 2024 09:39:38 -0700 (PDT)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id t1-20020a17090aae0100b002a2d8d34009sm1577329pjq.27.2024.04.17.09.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 09:39:38 -0700 (PDT)
Message-ID: <1b8f0217-5c4b-4436-88d4-ec3c88ae7179@gmail.com>
Date: Thu, 18 Apr 2024 00:39:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 0/3] SCSI: Fix issues between removing device and error
 handle
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>,
 Julia Lawall <julia.lawall@inria.fr>, linux-scsi@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "James E. J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Wenchao Hao <haowenchao2@huawei.com>, LKML <linux-kernel@vger.kernel.org>
References: <20240307144311.73735-1-haowenchao2@huawei.com>
 <99598b98-8550-4dca-beea-4c2d61d46f78@web.de>
 <b55da065-dbbb-4d8e-8baf-50807b507cc4@gmail.com>
 <173b55ca-cde-ab3-be92-d9c8b4b6b5c@inria.fr>
 <799944de-dcee-46a8-b43b-8876177c61a2@gmail.com>
 <4b9a14d0-b4bd-4b91-8466-5f8849b0c08e@web.de>
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <4b9a14d0-b4bd-4b91-8466-5f8849b0c08e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/17/24 11:48 PM, Markus Elfring wrote:
>>> Search in process/submitting-patches.rst for Fixes:
>>
>> These issues are introduced at first version of git record, which is
>> 1da177e4c3f4 ("Linux-2.6.12-rc2"). I think "Fixes" tag should not added
>> for this commit.
> 
> I suggest to take also another look at information in a table
> like “Releases fixed in v6.8” from the article “Development statistics for 6.8”
> by Jonathan Corbet.
> https://lwn.net/Articles/964106/
> 

Thank you, I found some Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") in this article.
Then I searched in git log and found these "Fixes" tag too. 

> Regards,
> Markus


