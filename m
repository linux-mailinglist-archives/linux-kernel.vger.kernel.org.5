Return-Path: <linux-kernel+bounces-95419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81AC874D68
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782B21F22374
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3122128836;
	Thu,  7 Mar 2024 11:30:05 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70B95FDD5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811005; cv=none; b=GYBaYEW07T/A4gENA6KjNUomxxXGEOvPqy2UXF0qHKzt6d2Dj68c/gxltr1KxrM21ypjdNsjT4VPvPrtZYMCzns2dn7xSOFG52GgQH0Cm2X23IZ7Ycnhlr/h/4qwoMXrdgkYcEUITaNdbwgU7mm/KGp+hKqX+JQyZMQInI/ADeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811005; c=relaxed/simple;
	bh=tYbrPzwPHLtCbPmmzOI5EEE0z7+hi9V/Z6XXn7U1AlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdQK9sx1FpBen32/UOXVhOoManNFnMil5OPoVeCVx+EIMKdpqnUcetZGHFZL8o1+hwh0BylNaFrLXrgOrl7VQ6unxMYgAX21laNwKAcYMYIkLZwWiCiZKT0AZVQ+ERqpm1vRXxWHl26qu6z/7tiXbTblSbzjt+9b469bVVsEg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33dcc82ecc1so185511f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 03:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811002; x=1710415802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApptroHB6/NmBRK02Xfs7tuTGYgteOdPDSgkfdE6Ajw=;
        b=JR5KWlUMYmlUyWLI8/ojg0TyeMXOYh8v+RkMM/JOHS8x25nDl2G8gyH+XdTYe/6UOW
         7NAftCTaBokNeW7036mIZwTdzHREvqUNJXDeLdnM13h5D4HsR/KZqJKpnDSFYUkVSfTg
         CGuXYr43v2w3v+y/Vezbn9UT0gz/i1P0koxKfYWYaX6qHhu3LN2Sa6s7dogIovUU9vXs
         +H40Kdh2BAmut/hL65HKVssDeLmvs5IBqvCNdH5uMWHt169NJR3Xqbg7L2QgmaXFJ9+e
         m5EsVPD94z900PB2pzyr/0uQQumqzKtmXzTTVvoq+no8zzrOTs1Bz4ZT4JDTl66zon9T
         EDlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOweVjcZwkQZerM1kKf3KPGk4b805s2/5IsNAU1FtIrUx/6SrWRFECaHEbgfzMPbvOLWfWRevpOhTCm23lG8ISh3s8PSep7HxBLRkj
X-Gm-Message-State: AOJu0YyKjsF9x/KfbZVdrIR9m8jhicsEGkyLJ4FglX0Xnukfx1cJYuVl
	JEKE0kW+zbRAaTF2EQZvPcfxBZKCLhGHKvLY/I0CxpjjR/NnVBEf
X-Google-Smtp-Source: AGHT+IFNm9w8o7TxExzzs96NaUE2Q1A6pBh5XH6Al+ROud3wF0x/jdcnGm4etOlec9sJlkqBayUa4A==
X-Received: by 2002:a5d:5447:0:b0:33d:568f:8986 with SMTP id w7-20020a5d5447000000b0033d568f8986mr1097620wrv.2.1709811001971;
        Thu, 07 Mar 2024 03:30:01 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id u2-20020adfeb42000000b0033b483d1abcsm19934771wrn.53.2024.03.07.03.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 03:30:01 -0800 (PST)
Message-ID: <432a39d5-6d08-4d38-a357-7c8d9123189a@grimberg.me>
Date: Thu, 7 Mar 2024 13:30:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvme-fabrics: short-circuit connect retries
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240305080005.3638-1-dwagner@suse.de>
 <22b01fb4-b543-43b2-949c-1873105dc343@grimberg.me>
 <72c1d3a8-14ad-43e8-a68a-25be903698c4@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <72c1d3a8-14ad-43e8-a68a-25be903698c4@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/03/2024 12:37, Hannes Reinecke wrote:
> On 3/7/24 09:00, Sagi Grimberg wrote:
>>
>> On 05/03/2024 10:00, Daniel Wagner wrote:
>>> I've picked up Hannes' DNR patches. In short the make the transports 
>>> behave the same way when the DNR bit set on a re-connect attempt. We
>>> had a discussion this
>>> topic in the past and if I got this right we all agreed is that the 
>>> host should honor the DNR bit on a connect attempt [1]
>> Umm, I don't recall this being conclusive though. The spec ought to 
>> be clearer here I think.
>
> I've asked the NVMexpress fmds group, and the response was pretty 
> unanimous that the DNR bit on connect should be evaluated.

OK.

>
>>>
>>> The nvme/045 test case (authentication tests) in blktests is a good 
>>> test case for this after extending it slightly. TCP and RDMA try to
>>> reconnect with an
>>> invalid key over and over again, while loop and FC stop after the 
>>> first fail.
>>
>> Who says that invalid key is a permanent failure though?
>>
> See the response to the other patchset.
> 'Invalid key' in this context means that the _client_ evaluated the 
> key as invalid, ie the key is unusable for the client.
> As the key is passed in via the commandline there is no way the client
> can ever change the value here, and no amount of retry will change 
> things here. That's what we try to fix.

Where is this retried today, I don't see where connect failure is 
retried, outside of a periodic reconnect.
Maybe I'm missing where what is the actual failure here.

