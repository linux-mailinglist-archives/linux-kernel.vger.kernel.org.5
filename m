Return-Path: <linux-kernel+bounces-109397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7F6881897
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD75B22ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A238594A;
	Wed, 20 Mar 2024 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ly5E8on/"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B9129CE8;
	Wed, 20 Mar 2024 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710966559; cv=none; b=E56Stp+SCaYb1KfMG25ksE2+Yaafr7TATLNlhc2irVB2Oz5txkLwhyEtdR/TuMd7s5X1D4jP2EEbfpd5UivGwkjd/yrkSNwp/HPQ0a30DC4Je61wHeDVMhz8vqM7+X/MjQxu6nbbXq//zAwPjit3dQiFXOYDyVkck70/ucGK03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710966559; c=relaxed/simple;
	bh=sibqcgVk69cAWwUp5fELHFPqFKZCzweuaYfOTBxCD6o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PtW7htaMg/FnLKT3HGfAJmsGkanWm6ZAVPXu65pK508cxUXuAbGh6ZF+tYMl7Y/I1RDdWcJsfl5C3nCAJeu4v3K5US9BleeJbANJpZAEztCgSduC9IJ6fLDNFU9H3JckYEhD+e/enb5JSPepmNH44BBk2KJ4J+iQue11qD4M3Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ly5E8on/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513d599dbabso348498e87.1;
        Wed, 20 Mar 2024 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710966556; x=1711571356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dvd7/K/iPH6D09kkHMbkBRJCLxovJRz+5X5JeM9cC40=;
        b=ly5E8on/KPPjFjwvSaSEAmef/5FTEnJUr40nDBBV2TV0moKWqXDVO7ZZ5pX/7xg+rZ
         dnq8HX0ikU6MGnuvuuB6htcGI3ybwGOqYyI9fZars43ZGoiOX4xNqVSkOHWTYs8VBZbx
         hkQOGGHZJRVZUi1Hcq1gEzkxgCWbhKAQG5quZ9q7gbFvgc7vr97xIu+OJUFFdCIHX5rb
         FmOGPoNvxCR0TAV3RKOd9qhpxdOCo5EfWgUiWHYSu1M+rmkatYfJSgHQr8GoqhjolScn
         Eqz0o9ntYKrVkbCzlSrqvtuQd+wnyByFecxwzhZXfQ/paH9h+JqRN/nG9JSgFUbMa5Ij
         YGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710966556; x=1711571356;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dvd7/K/iPH6D09kkHMbkBRJCLxovJRz+5X5JeM9cC40=;
        b=GW+ODPBSQtbDNIzgDN/3ZtMyj2UOi+W2wEN7Po4O94prqDVj2tjpG1vYit72YnrARu
         x6BAynNJUqqY3kKhgQH6r41kE/SKzYLnes1k5IIbhQaQJn0bDm5QKak8Foonw5ewW9Rz
         hX2RvA/6zrav77sBY5Af9Ck5x1W8vzd/zFOInN+v/Oz6VxVrpAa1dadI2VpvwXRv8XfH
         XSj2aOGio1kr6ufAHvSpUf554u0LvsPo4oF0qX/jjBXGkmYD5lZ2G4F8podBuiulEBuX
         Ob3xoJMuL6l8kV17Mxl9/zszSFbNu1bAwNvoPuEL6XCm+9kJD9XPqxsSQ6ZSM8F0/3tj
         2cAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX69+DTh7en9/i9ZJdqiEbnSwo1ZZwxJov9+JSVP894DcEHpdgimwZ4LTia2dVBU0vb/xgaILKGMIm1oXx4CACH2GLX44Zi7p8PjE4yqpyx2nvTs9O/xYv6XusYqPlDa9wjx2acBHr0uQ==
X-Gm-Message-State: AOJu0YwNbakOUg8M5TQTf8IE35tV3st0n6KC3Vf7mAL7swxb9zzrgpwF
	IZqryDlIcKnD4+Vuo/5zPjoHQ9SdU9Cp5SMve0UAEBTcsRpL292f0rvlw+HzStrfOjzD
X-Google-Smtp-Source: AGHT+IGeAB6MCS1rA/ycdxQ22gDA1FTucn7CNo0Yl14vI1V2G3iGJZh5xoX+yAWkcX+Cye2/GFrHmw==
X-Received: by 2002:a19:f803:0:b0:512:ed8e:97ce with SMTP id a3-20020a19f803000000b00512ed8e97cemr5087582lff.16.1710966555838;
        Wed, 20 Mar 2024 13:29:15 -0700 (PDT)
Received: from [10.0.0.100] (host-85-29-76-118.kaisa-laajakaista.fi. [85.29.76.118])
        by smtp.gmail.com with ESMTPSA id q5-20020ac25145000000b00512e594e235sm2348058lfd.242.2024.03.20.13.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 13:29:15 -0700 (PDT)
Message-ID: <d20dc37c-13fa-43d1-af52-dce8d8dcdd75@gmail.com>
Date: Wed, 20 Mar 2024 22:30:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] ASoC: ti: davinci-i2s: Opitonally drive DX pin
 during capture streams
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-14-bastien.curutchet@bootlin.com>
 <00182d1d-ef29-457f-9e3e-6e9b57592118@gmail.com>
 <0bb26153-8bcb-475f-8892-5eb925fec538@bootlin.com>
 <7925bbe5-17e8-42cb-a5f0-4f3e06810a90@gmail.com>
Content-Language: en-US
In-Reply-To: <7925bbe5-17e8-42cb-a5f0-4f3e06810a90@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/03/2024 17:42, Péter Ujfalusi wrote:
>>> On 15/03/2024 13:27, Bastien Curutchet wrote:
>>>> The McBSP's DX pin that outputs serial data during playback streams can
>>>> be used during capture streams to repeatedly output a chosen pattern.
>>>> For instance, this can be useful to drive an active-low signal during
>>>> captures (by choosing <0> as output pattern).
>>>
>>> Are there really any other use of this than to pull down or up the DX
>>> pin (0 or 0xffff)
>>
>> I don't know, indeed today I can only think about these two patterns.
>> I tried to do something in a 'generic' way so it can evolve if needed.
> 
> I think the definition of the 'ti,drive-dx' is somehow odd. It allows
> you to set it to 0x1234 and the DX pin will show 0x1234 when you capture
> 32bit. If you capture 16bit then it will transmit 0x12 (or 0x34?), no?
> If you have 4 channel capture then I won't speculate what will be on the
> DX pin ;)
> 
> Would not be better to say that the DX pin will be driven low or high
> during capture _and_ disable the playback support?

After some thinking, it might be still better to use the DX pin as GPIO
and either have a custom machine driver which would handle it (set low
when a capture trigger happens) or connect it in DAPM as a supply, bias
or something and ASoC would handle it automagically.

I think that would be cleaner in many ways. What do you think?

-- 
Péter

