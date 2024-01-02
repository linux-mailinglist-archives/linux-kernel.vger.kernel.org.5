Return-Path: <linux-kernel+bounces-13983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8975182167A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32C3282022
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD7EC9;
	Tue,  2 Jan 2024 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNrJ+sdD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17A15C5;
	Tue,  2 Jan 2024 02:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bbbdf0b859so4679864b6e.3;
        Mon, 01 Jan 2024 18:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704162691; x=1704767491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vu2esYXgdHq52zmfKNEvoanAaZ8qTAO/U+OEWvx+QPo=;
        b=ZNrJ+sdDbGfmVMs0BQmcGf++cCIXP6phJtmT8rAZfl/suQvSvrn4+bZ3g2GsBiM27r
         9Jlbc+b5Z7vV4Zof7NdiRSEnolo6w1VXzZ9o+zzJu+WRUhFR+Ki6FxZEpyd57hpAa9d7
         /pMJZa/IwwrQjtjQ8AG0wDOHdtenYJkYWvqRh7duWi/HrJAN69xI7VoKb6Iu+iUp//CI
         6+TOWxrp/aAGYdP0QR3s6NAXJHb6RH5DTNyxqx/IfDfxm5CACo6zGyUXhMTDL2ykNkrg
         BytHZsfnYGlW7S6AKjVwIdx4L4DBQzK/fIUyYiy4ZKXyUvEYdccvD8Vdir9rv+mvxUZC
         F4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704162691; x=1704767491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu2esYXgdHq52zmfKNEvoanAaZ8qTAO/U+OEWvx+QPo=;
        b=jVVHIIY8Eb5YvkD0tdTwDYQT114DX8VX3FUVK/8eJjqJaJgsynlZ8mX7ZZSe3KzZ3o
         UjSYLDlCCorBwRPm9Fqoz/0DPvvhzPQxi+tVRWUvFmk5bkE+iwgm28VA269NPckO6UIe
         ggr76ADv8tF3DUmOeANvfISfWht87c/YUapvYN503hY6j/EU0qrrVagsgql9+xbI69w/
         6k9q5ToZWlUBwfqzsR3vuQL9ErgVie05NhJZLTJtA8Af0IbxQtQSNR4EZh8p5CXN7Lqs
         TqQ8bk+gEf7LL9TWm8naHM7nAp+Y7ONCTxtOQC9kMQInlMSheZSVogOTmAhcXm9SFAV7
         Z3gg==
X-Gm-Message-State: AOJu0YyZjMQwGif5sO2kgWUappTl5w5rHJWAohwCLviVhT4CT4o9wGkN
	DuE4uV2YA0LWHjcwHWaRoXUJLcNpAoxGZXBB
X-Google-Smtp-Source: AGHT+IFVcWUV+oJlKFMyrgY+TtuHciGctK97wf+lCgROzQR7SdbRi3GQR1kpLNorMyeyf4ysVVJgZQ==
X-Received: by 2002:a05:6808:bc4:b0:3bc:1479:9a94 with SMTP id o4-20020a0568080bc400b003bc14799a94mr1195241oik.56.1704162691677;
        Mon, 01 Jan 2024 18:31:31 -0800 (PST)
Received: from [192.168.7.25] (45.78.55.121.16clouds.com. [45.78.55.121])
        by smtp.gmail.com with ESMTPSA id q7-20020aa79827000000b006d9a94a03a8sm15830384pfl.77.2024.01.01.18.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 18:31:31 -0800 (PST)
Message-ID: <c7e29d85-277d-46ae-87ae-bb77dd423652@gmail.com>
Date: Tue, 2 Jan 2024 10:31:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix length of strscpy()
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>, "axboe@kernel.dk"
 <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240101175051.38479-2-pugokushin@gmail.com>
 <ed0b9dd45fca4f6e910a9e1ffa756180@AcuMS.aculab.com>
From: Guoxin Pu <pugokushin@gmail.com>
In-Reply-To: <ed0b9dd45fca4f6e910a9e1ffa756180@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thank you for the review. Sorry if this is the duplicated reply, as I 
didn't configure my mail client to send text-only message and the 
previous mail was rejected by the list.

On 02/01/2024 05:47, David Laight wrote:
>> @@ -79,8 +79,8 @@ static int parse_subpart(struct cmdline_subpart **subpart, char *partdef)
>>   			goto fail;
>>   		}
>>
>> -		length = min_t(int, next - partdef,
>> -			       sizeof(new_subpart->name) - 1);
>> +		length = min_t(int, next - partdef + 1,
>> +			       sizeof(new_subpart->name));
>>   		strscpy(new_subpart->name, partdef, length);
> Shouldn't that be a memcpy() with the original length?
> Since it looks as though there is something equivalent to:
> 		next = strchr(partdef, ',');
> just above?
> Maybe with:
> 		new_subpart->name[length] = '\0';
> if the target isn't zero filled (which the strncpy() probably
> relied on.)

Yes that would be better. But since I'm fixing the issue caused by the 
mentioned commit, which was an accepted change to use strscpy instead of 
strncpy and seems a part of a series of changes to do that, I think 
there might be a reason the maintainers preferred strscpy over strncpy 
over memcpy? Otherwise we could just revert that commit and keep using 
the original strncpy + setting NULL method, and then potentially swap 
strncpy with memcpy.

On 02/01/2024 05:47, David Laight wrote:

 > Same

Same.

On 02/01/2024 05:47, David Laight wrote:
>> @@ -262,7 +262,7 @@ static int add_part(int slot, struct cmdline_subpart *subpart,
>>
>>   	info = &state->parts[slot].info;
>>
>> -	label_min = min_t(int, sizeof(info->volname) - 1,
>> +	label_min = min_t(int, sizeof(info->volname),
>>   			  sizeof(subpart->name));
>>   	strscpy(info->volname, subpart->name, label_min);
> WTF?
> That only makes any sense if subpart->name might not be '\0'
> terminated - which strncpy() would have handled fine (with the -1).
> Otherwise what is wrong with:
> 	strscpy(info->volname, subpart->name, sizeof (info->volname));
>
> 	David

Yes, there is no need to calculate label_min here. We could remove int 
label_min altogether in this function and use a single line of strscpy.

