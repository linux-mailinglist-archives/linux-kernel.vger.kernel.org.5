Return-Path: <linux-kernel+bounces-132108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C7898FC4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 038F3B21A42
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A47C13A41A;
	Thu,  4 Apr 2024 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1ImY5ow"
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158E1292CE;
	Thu,  4 Apr 2024 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712263423; cv=none; b=G6gQH0Xj6BSMEkJ5rMiDZE/j/DJwx2VA25ZzHCoekLnwpg+3iFL5MJFD3VA1H3Nt18muZRzii5XhL8cUWV7dpzAl3iAlzYD7zhABofnGy1HPUNmDyMLL4p+65fO4Pg9n4/00M5zU4aHoG8iBzPN0CihxA5TXmfzlmbJLy43cf9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712263423; c=relaxed/simple;
	bh=oJzU1DchjJ7xBagvA/BSZcE6n68phH2iAnsMriy52xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hx2Bfig2uWjUW022yHcoRHalzFCpyEXcv9Qb1gFaLFDZNQRiOouZWxHxCxEZCIFeOl5A2JqQDeDSw1kJMP/qEPyNztGa8qYApwwJN+iVosjFnYbLwSSWkmc4qXNtUf0vlvtVRdc7ieob1Giudp0vgAvWmmbw0NKHXZ9eazIuT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1ImY5ow; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-60a104601dcso16022327b3.2;
        Thu, 04 Apr 2024 13:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712263421; x=1712868221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKmfpV6KrJ0i98Wh/0eskG0hyAllvgPjh1mOsK1t4hU=;
        b=I1ImY5owmZqE6IhCJvRkMtcG9dxv8wOr4SVu739HRdzyDC4ZZn7Fv5i1oXlLaiyurv
         unwgbO+aKznCtdpcFQ6VhEclpss9MRwC2WSuKjJYlm+XOtDkYsdCa0iRQGar1Bk6xAwu
         kKZfHcXHHph0FO3SQx+5o2zDhELgdBq1aTXeMH48gaOVVNEaCqUZgjr14E4DJtLnWHRe
         p/SzoQiqCnNd9W7clTWya74E+U6lnZb+DUuzVeIem01OnAKJWt7fqmnKfkCV4ywuNvt9
         gWMeDFfuANj4ycGe/nuR9bbW1DBPcDd0MPQOOy6DpqT4BvwsAp7d1qr7uHp+gaaLqe+I
         LZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712263421; x=1712868221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKmfpV6KrJ0i98Wh/0eskG0hyAllvgPjh1mOsK1t4hU=;
        b=nnuvnQZ/+rPNYQe/IoQr6IEgZhTo8XIWhYJ74Qa8Ob4L/MKfbrw38/ttAkBW40wsR8
         RTUBOCOhXrmgdCdV9dI6rS5rlpzxVpsB4e86+8nznTQM1DSKcrf+kCJebuiO9/R/4orA
         mvfohnR9xysR0C1o1BFzNPtMhzn4asvNGcnp7VB8Dvg+QbA4RR5gOeo3j0DbPVrDx3LF
         O8PrVkdiWllf+TDf37tZmbMPnhN/kuifw4TCgfSJ2IgGyCMhLHEV1fZaTZlyKXthQUO0
         kazFBYSA+fnufl4EWXy7LkAQUG9lA4ziCrTzxMscZkapqfdNVisSiKwCmCjFlPDyEujC
         JzqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNLDLvsNpt/+Dg8DvlUAj/80l899PP0y3X+/+MoZ+pU3JkkdCL30SOMRkx6/1xyNpQqenlIG9yG4azvWPeRPE64SlzzLKLF3b5EhEX
X-Gm-Message-State: AOJu0Yww/lmYJGwRRhFC+TVY/e7tU6dbfjBiMnj4lkzbH98sfHetRa3r
	NiRyNLAOJ8l+DvAwJuTJAGOLpbrX6PpWVLbFjMZmB2Lyd3ToBe/d
X-Google-Smtp-Source: AGHT+IGDgKuMAKhqUpXoM3ovArMEGP+ceyMkb2rh8iiSQhZCVHS7jAbeIre6Po29dMVGSorIXuhCzQ==
X-Received: by 2002:a0d:ca01:0:b0:615:1ba3:5732 with SMTP id m1-20020a0dca01000000b006151ba35732mr3527710ywd.11.1712263420902;
        Thu, 04 Apr 2024 13:43:40 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id if3-20020a05690c690300b0061511220f16sm45006ywb.92.2024.04.04.13.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 13:43:39 -0700 (PDT)
Message-ID: <b5f79571-b4a8-4f21-8dc8-e1aa11056a5d@gmail.com>
Date: Thu, 4 Apr 2024 16:43:38 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 07/10] net: dsa: mv88e6xxx: Track bridge mdb
 objects
To: Vladimir Oltean <olteanv@gmail.com>,
 Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <20240402001137.2980589-8-Joseph.Huang@garmin.com>
 <20240402122343.a7o5narxsctrkaoo@skbuf>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20240402122343.a7o5narxsctrkaoo@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vladimir,

On 4/2/2024 8:23 AM, Vladimir Oltean wrote:
> Can you comment on the feasibility/infeasibility of Tobias' proposal of:
> "The bridge could just provide some MDB iterator to save us from having
> to cache all the configured groups."?
> https://lore.kernel.org/netdev/87sg31n04a.fsf@waldekranz.com/
> 
> What is done here will have to be scaled to many drivers - potentially
> all existing DSA ones, as far as I'm aware.
> 

I thought about implementing an MDB iterator as suggested by Tobias, but 
I'm a bit concerned about the coherence of these MDB objects. In theory, 
when the device driver is trying to act on an event, the source of the 
trigger may have changed its state in the bridge already. If, upon 
receiving an event in the device driver, we iterate over what the bridge 
has at that instant, the differences between the worlds as seen by the 
bridge and the device driver might lead to some unexpected results. 
However, if we cache the MDB objects in the device driver, at least the 
order in which the events took place will be coherent and at any give 
time the state of the MDB objects in the device driver can be guaranteed 
to be sane. This is also the approach the prestera device driver took.

Thanks,
Joseph

