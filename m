Return-Path: <linux-kernel+bounces-159966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94308B36E1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA80B21A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5295B14534B;
	Fri, 26 Apr 2024 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/99TpxJ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F32F14533F;
	Fri, 26 Apr 2024 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133143; cv=none; b=i6b0c9jbxEFaB8OXJOYC2+x/CzybjiYVh+ECNS8B+rZ35dsvtcof0KdHQU8hLJ3pFik2vpjRR4vSvb+5Lyrt3e9YMnv0cse99oM/rvmuxjA/rW//d6Q1GrWrr650A3tPI2lMQ0RKQMaG9zL9QEJ7pVDq0APIyslHxx7SfY7hEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133143; c=relaxed/simple;
	bh=VZ4dyN6HsEQTrAuuWJizHwgtH2IUGnz23LHLcnDqNXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FNiQf8EvZ0fvdXAZffGL6TxZGA0MgK0U0pKDDjEekNEDAaqs2JkcLHI12H7u9pEUzTh1+5nd6QuQLqn1dzMQqgRFF759I9/EZkfEec0I5lX1wFWlskaugF9Qn4ErqJKnoLkXNCf+MNTRga7jRphUk7ZA1s23EFYaS3KiWHYlz9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/99TpxJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2dd80401e81so4791371fa.3;
        Fri, 26 Apr 2024 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714133140; x=1714737940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IFRgbloGhVnIKWuDRlSJQNjAIv7cIETH3l3I8D/RWn0=;
        b=T/99TpxJQ+o7rKczf5e7s3PcFO1hyjncMqloVg1ECYnr+swynjeq45H4KkyemaEtDN
         JrFGInHVrqTttNL63shSOeRcXxO7TqHbJGL1Pmy7ekIERifgg+sgpsmfstMeOIPh88ud
         xvGSK+HH8qaeLRiRBz2NWsUC58D5Rjgl96h1CHAa5QefuO0JFnHqpyhUIHSZqWOGPhKx
         tehh8Y8Hf238eeGR+5HS0au6ySs7VR/TZynmVnwimcPrkkGElU/jzi02gbfE5fQdxBmy
         ZZPVtSIBB+u1/m9B1FpRGzEWYYrEynO75LR1lKzFv2muvPMuuZjr0fuOF4ylEPLnN0AV
         CBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714133140; x=1714737940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFRgbloGhVnIKWuDRlSJQNjAIv7cIETH3l3I8D/RWn0=;
        b=SJWxFoK0TW2g2iBitbViKC+VM+k4DUSLAr0Fg/+8NnrrO08H9eAQBISrdDv3tVisKh
         fklvXjp2XFNRtDsRo6XgsgsX5b35O/xSB3hSHCtbxH+KGCeHi2Bkp3KZZtO8bFwqmPDB
         Eve+WPTYTnC4hne7+X/WRNpPibtWaob74D4QxAjxb/zkk4hMmb1bbdxOKoMg5isAZdIc
         AgJWVjaIKcsqcfMEQRioBU9Fzthuim3nhXKoYnvTjnskmA+0Ypvb3C96zbXtJIOgilxr
         SOvuQ6lqLqE9ttASKSIrXILYTU86YN4ksrdD2YpxsKPfvFaVvwK5L5EONt4rVR/YYC1P
         u2rA==
X-Forwarded-Encrypted: i=1; AJvYcCUV58/Xui6L7AfEuHx6NewiiNxoEX0ZoIk/lFlX8FVkzxlu5eBF29plLpGakKPQDjECtgvkSoVcTl1oP/PMlQUHTfgE5T07+OSb/Fc5wWwDwwRCZyfroJzD6NPawExeXeA4494PkPCDkJWek7Oo9nBXNl1fwhZJI1PhQIc9jkUC+jA2VwMrFM3tq94=
X-Gm-Message-State: AOJu0Yyeg1mmqXyaKSg2HBz+oqzHRvpD7qPwK9jyunZ5mDgQbNRLHS2q
	BNNoa91HiGvce4rWDO6ORfgDcxHFKSrJ9z8zBCb6oh76Mr8Nt4M/
X-Google-Smtp-Source: AGHT+IEe8mldUM2Wv5ZRNT6Twg6RekMttRFRq1NWmP7m1iCts+MYJNSTfm41RqGdQjLEgw0/c8z1VQ==
X-Received: by 2002:a2e:b61a:0:b0:2dc:759e:981 with SMTP id r26-20020a2eb61a000000b002dc759e0981mr1615343ljn.4.1714133139789;
        Fri, 26 Apr 2024 05:05:39 -0700 (PDT)
Received: from [172.16.102.219] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id k41-20020a05600c1ca900b00417e8be070csm30937272wms.9.2024.04.26.05.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 05:05:39 -0700 (PDT)
Message-ID: <81a9e3c2-2c44-406e-af19-90d9dcfe4a92@gmail.com>
Date: Fri, 26 Apr 2024 13:05:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ALSA: kunit: make read-only array buf_samples
 static const
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Colin Ian King <colin.i.king@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240425160754.114716-1-colin.i.king@gmail.com>
 <20240425232250.GA205425@workstation.local>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20240425232250.GA205425@workstation.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 00:22, Takashi Sakamoto wrote:
> Hi,
> 
> On Thu, Apr 25, 2024 at 05:07:54PM +0100, Colin Ian King wrote:
>> Don't populate the read-only array buf_samples on the stack at
>> run time, instead make it static const.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   sound/core/sound_kunit.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/core/sound_kunit.c b/sound/core/sound_kunit.c
>> index eb90f62228c0..e34c4317f5eb 100644
>> --- a/sound/core/sound_kunit.c
>> +++ b/sound/core/sound_kunit.c
>> @@ -167,7 +167,7 @@ static void _test_fill_silence(struct kunit *test, struct snd_format_test_data *
>>   
>>   static void test_format_fill_silence(struct kunit *test)
>>   {
>> -	u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
>> +	static const u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
>>   	u8 *buffer;
>>   	u32 i, j;
> 
> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> We can see the other similar cases in the kunit file. I'll post the fix
> later.
> 

Hi Takashi,

Hmm, correct me if I'm wrong, but I don't see any other significant 
allocations on the stack in the test.

-- 
Kind regards,
Ivan Orlov


