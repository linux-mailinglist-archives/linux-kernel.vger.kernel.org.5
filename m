Return-Path: <linux-kernel+bounces-99451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39F4878890
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CFF21F2155F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C954FA3;
	Mon, 11 Mar 2024 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCRElJ6y"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9554BFD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710184376; cv=none; b=uUPqJpv5833rrAiUr4dXR6ojX3rnT+5zh80odLxzkaNygWWXQsUnAzyqHIPvjIKQN2mECH8t7WPCq197Lvj/VcDWzHa9st350vYoJ/AJoQSxboPBmYfSEwN/qlq50wk/HPlJAcvke773KVNyntKAPTXCvxZDlMwfKcR5PUpA2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710184376; c=relaxed/simple;
	bh=vSPmOlLmSST5FDedii1lKp1ln0Krsn7NXYHxlkUi5kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hnkd3NAZScGhv7IHMdNrGoo5+ld6bueetksOpmm+yAkpDsxalyGt08KNi2JtHKgiZr60HDAFGY5IFs8p2dips5uPgogNIdDCtE6qU9xQudUpHDEHxmIO7BDi8ilExvc62+HLtu8zP0RmrdkDRTU/ihCIqMIqQGmtM6DLpbnJey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCRElJ6y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5685d26e1feso473540a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710184373; x=1710789173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yvc3n57sG/EgKjIvn90GbNi1fbIRTY1+trZI6eVmRkA=;
        b=UCRElJ6yyFAaGXTbZ8EW3Lt3zFyB01i0gFqUery/vD/1ZkKffLrWPUjlp17fCzofLu
         AZ3hulvUEAGjODW3oAUICLxuTZ9ezGK67bcyajiVvdmsSo1mGqRB6+VPsI18kvE6dsjp
         xELV3/nTikUcOUsHetJhkHd3LcmmH+C6C7+w8BjhLtju83+SS+ssMvqNZHgpzNnodQqv
         UrzMNMh10No81o3McKZPEH8QEgUozh7FF4eufHXkOJixCmJZj6FONNVZiiGDH9808bjH
         SNih3wYFAJaZ8dZkPg4rmgN98D4FsAiN+xW6mYvnhxnnK/oB0oK6zzU7Ota46sjFXb+Y
         BaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710184373; x=1710789173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yvc3n57sG/EgKjIvn90GbNi1fbIRTY1+trZI6eVmRkA=;
        b=ImMD00P9KoYztpsT/8jZ+GDX1W2YqvO6xw5V1m/757GFw0vnIJCN5O/wknI3s4gHT3
         Vzv0l0hASdCurhyooPjSEI9IocQdAFvUye5uDCujwDwk7YiBQrVCDf2AmXjN2Km6eHSr
         VThOZkzZqvXkZ66iQgSUOIKPzZw6d0BbVeD5H9ehEea+8pev9cHaim3f8GiJwXKnP523
         GzwQBFAKVkz2dpNAyZlnGE86bVZGB/kLC0I90f8jSIhgAQr7FW4v/cDD5GHkKmaDRjq5
         1ZCBvs1sUedBC/RxPUGk/ycyouRMjSEObkiA4mHbKcboN95N33JVyHwmUD601df0hmXF
         GpJA==
X-Forwarded-Encrypted: i=1; AJvYcCWYVl77etCACo5TjFhc7BVkIpSF4j1mSNp3GBc27x0cTe+PVNwiP2qPZLDeEeU7wv40CX8swqo5IAEoCSjjwPy+CVSjYptOw/3UD+HE
X-Gm-Message-State: AOJu0Ywren3uhhkwnnFhPYSrmSSjEd7BAZxuGQSznncXbsDH75Ka2TS+
	yaP/eTSD8zMe8/5Sxylanf3nhVudw4IA3eNKm9ba1mYnhPycb54k
X-Google-Smtp-Source: AGHT+IEhK78V53bzJOOKLDCLv12a2XM+2jYUL5BNalyQIVaBMmHGdaZyIZAal9qxrLM3OD4p1tx86w==
X-Received: by 2002:a17:906:32c3:b0:a45:ced8:e131 with SMTP id k3-20020a17090632c300b00a45ced8e131mr5381811ejk.2.1710184372652;
        Mon, 11 Mar 2024 12:12:52 -0700 (PDT)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id r24-20020a170906549800b00a45a62e0ed0sm3129450ejo.98.2024.03.11.12.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 12:12:52 -0700 (PDT)
Message-ID: <5f6b7fad-5ad3-44a0-9e10-3e1c13109abd@gmail.com>
Date: Mon, 11 Mar 2024 20:12:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: cfg80211: Remove parentheses prism2_get_station
To: Julia Lawall <julia.lawall@inria.fr>,
 "Felix N. Kimbu" <felixkimbu1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 outreachy@lists.linux.dev
References: <Ze8LBf6xSjCRt4rd@MOLeToid>
 <4936c555-2c53-d421-126c-48804a26887d@inria.fr>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <4936c555-2c53-d421-126c-48804a26887d@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/24 18:05, Julia Lawall wrote:
> 
> 
> On Mon, 11 Mar 2024, Felix N. Kimbu wrote:
> 
>> Remove unnecessary parentheses around 'wlandev->msdstate != WLAN_MSD_RUNNING'
>> in static int prism2_get_station(...)
> 
> You don't need the name of the function in the subject line.  That
> information doesn't help understand the patch.
> 
> julia

Hi Julia,

I think we do not need the function name in the subject but we need 
something to distinguish between the patches. The subject line needs to 
be a little unique. Otherwise we will have 100 patches like "[PATCH] 
staging: cfg80211: Remove parentheses" when we are unlucky. Any better 
proposal for a Subject uniqueness is welcome.

Function name for this purpose is OK for me.

Thanks for your support.

Bye Philipp


> 
>>
>> This change ensures adherence to coding style guidelines.
>>
>> Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
>> ---
>>   drivers/staging/wlan-ng/cfg80211.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
>> index 471bb310176f..7451fd2bb580 100644
>> --- a/drivers/staging/wlan-ng/cfg80211.c
>> +++ b/drivers/staging/wlan-ng/cfg80211.c
>> @@ -247,7 +247,7 @@ static int prism2_get_station(struct wiphy *wiphy, struct net_device *dev,
>>
>>   	memset(sinfo, 0, sizeof(*sinfo));
>>
>> -	if (!wlandev || (wlandev->msdstate != WLAN_MSD_RUNNING))
>> +	if (!wlandev || wlandev->msdstate != WLAN_MSD_RUNNING)
>>   		return -EOPNOTSUPP;
>>
>>   	/* build request message */
>> --
>> 2.34.1
>>
>>
>>
> 


