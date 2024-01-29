Return-Path: <linux-kernel+bounces-43421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2B98413A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1914A284809
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660776F09C;
	Mon, 29 Jan 2024 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmLceSoA"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA94179AB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556971; cv=none; b=sMJqzIG/eD1/8HhsLx17UynMK7Fp7yQD0q8Iwz2PFyGNjxourmHKLU2CCa0DAeET4yCYYOTzCOkc7CLIBzBoLZeq4eHNy3u2c1WocoZrFcBPNoNedh8e3oqyR0cxshPQpoqA8iombXN7YSL9NisL8LGZCY50apa3LXa9mR/FnZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556971; c=relaxed/simple;
	bh=SzN5E/OZH58tSawDcGJ226eUc9651BGKKk3nvtr8mBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OELSe6gXzHvmAgQ52+klzHa7NXc81ZpzZgYhU/C06JcrqPvkRci3sCFXLH4KY2RVgqCnWBVQ+ft57mYvhZVxFnJMf2noeZro3/OS9daUZNP9Nuh8/9tVu2j3V9tQEU/kJZUnZpmoxJp20PrdIpXoSjqF/S2SVlb35+udVFxTqLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmLceSoA; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf405dae60so3512751fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706556968; x=1707161768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YlGK1ePb/U422QxxJl0KLJ2i0g645clyMklrxQdOa3U=;
        b=lmLceSoAFnthX+ZxHGCcthNAobIihY5OZ5V2nHuvn2UL0hb4N3iIzuhAeLj6G2Wiaq
         BdahNAll1VLoHlXbB7oRfH1va6JNpwwffMK6K77H9pTtQf6jEGMonAA+A31nlULT37hk
         23IgPtboBEjGoYGHfijwG2b5f3zw8svKSwyjPNDN7KpzV2Pq1f7+NXYMcSojRE5L7Vu1
         6oqsvAUm7Tm1TO/L9Na4cvOpkG3C/CU+JhwKJXka1B/9xxYntCLp6dgNArtcYiAIUvsy
         6NghMuHCcTPh7gWfyAxNm0+5rAl+9wMfbggTc/D4ElP9Z3YAIEM89OTp02zvnmp6rTRF
         2Slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706556968; x=1707161768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlGK1ePb/U422QxxJl0KLJ2i0g645clyMklrxQdOa3U=;
        b=Wq7IUonwzEx708+mfDmkEvBzl+w+oywQ5pTszqlrcyRvn/hEkjyN67rxDhmD/YzjkO
         jRohWXqP2F1rpgdY4jNFuDS8pOu3NoIxghI1BnD0BAjLn/u+Ns2UyyOL4MlzI6RAWptQ
         uXWbiqCl8wIVH+Jrffv7eR4Mk1pxnWUlG20eZP5ohXyPBN8txUQ2FIQi+1UyayJaQFmP
         jjy0Aind+IDvMiW7l6405pSUmC8+ryMWamsvzTyjVBNOKgJBqqu7dHNQZOYcLRClocJz
         YjF1x5Lzaz1vB8kfcjsDoms3Ro1zgQnkO9VgP9OAj6DS21CtbR18SRijA1rV8SrY3WTw
         QjKA==
X-Gm-Message-State: AOJu0Yyvq6ArQhV7OgWJ15gdoz8w0SHFd555ZZNWd/7VPTF6eUVKhA7c
	Rb4ymEg0tRiiR40jdLvLAU/0u5gGbE3VIclt67sXLZOkka0UGmMb
X-Google-Smtp-Source: AGHT+IGmii713iV3FedHnEYM1saOhH0iI85aKCQd1F89nzbF8KfvSe7jV2KWEriLLouPAAm3X0B5DA==
X-Received: by 2002:a2e:a3d2:0:b0:2cf:4079:3ae6 with SMTP id w18-20020a2ea3d2000000b002cf40793ae6mr4493467lje.5.1706556967558;
        Mon, 29 Jan 2024 11:36:07 -0800 (PST)
Received: from [192.168.0.101] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id r8-20020a056402018800b0055f0d17f9b2sm983279edv.45.2024.01.29.11.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 11:36:07 -0800 (PST)
Message-ID: <57575e6c-afe1-4d12-82e3-61e3c7ac4a93@gmail.com>
Date: Mon, 29 Jan 2024 20:36:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/18] Staging: rtl8192e: 18 Additional checkpatch
 fixes for rtllib_softmac.c
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Tree Davies <tdavies@darkphysics.net>, anjan@momi.ca,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240126223106.986093-1-tdavies@darkphysics.net>
 <6f13d58a-f072-49dc-a9bc-f742550fc9f7@gmail.com>
 <2024012707-garbage-kissing-99b5@gregkh>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <2024012707-garbage-kissing-99b5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/24 21:24, Greg KH wrote:
> You might want to respond with:
> 	Tested-by: ....
> so that our tools pick it up and you get added to the commit logs, if
> you want that.
> 
> thanks,
> 
> greg k-h


Hi Greg,

thanks for your hint. I am already on Position 6 on the world rank list 
for "Tested-by:..."

No.1	 Daniel Wheeler <daniel ! wheeler () amd ! com> 
2417(3.51%)	@AMD                             @Unknown
No.2	 Andrew Bowers <andrewx ! bowers () intel ! com> 
2386(3.46%)	@Intel                           @Unknown
No.3	 Arnaldo Carvalho de Melo <acme () redhat ! com> 
1300(1.89%)	@Red Hat                         @Brazilian
No.4	 Aaron Brown <aaron ! f ! brown () intel ! com> 
1206(1.75%)	@Intel                           @Unknown
No.5	 Phil Schmitt <phillip ! j ! schmitt () intel ! com> 
566(0.82%)	@Intel                           @Unknown
No.6	 Philipp Hortmann <philipp ! g ! hortmann () gmail ! com> 
537(0.78%)	@Hobbyists                       @German

I wonder if I deserve so much recognition. I thought you do not like me 
hunting for so easy credits. But it seems that I was wrong with this 
assumption.

Will use "Tested-by:..." in the future.

Thanks for your support.

Bye Philipp

