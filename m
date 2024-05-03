Return-Path: <linux-kernel+bounces-167316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B9D8BA7BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 534942818B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93600146D75;
	Fri,  3 May 2024 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGmrOF/d"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D31139593;
	Fri,  3 May 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721130; cv=none; b=Lhfz+b5nuD0qiznByLZgr3x8tpQ9wbymc4oDkGBuiv8E/7Br3Jb6+hTVD5+zDVMRSzlB7oC1D/E6vk918gNWshfDmAMNLFHfoTSWIcEH2s4xIn2BOINmvJwId+5ArL/5XVqANK0s1RxSN/E6WXtOAAhd0zSnrrbnAPOzNop0kLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721130; c=relaxed/simple;
	bh=cqv9SBuOKk4+0s89FmYuGzf91MVZ71PBD18TBj1B16Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WKtEnZUzQeN0gI/RxRB+0CmM08bS2uiLs/OZo+BvtEb2QjIKJjbE1GvV8q2sotdrf0PTwxS1TnwG86N5xXYk0NbZuvOQdnUARGHo3YxRoHJ5zmqRyh7sXG3ukjMAx7YCDHs8VCJPHFi6W1JAmZ2LWTXI610fx4BbSHn+FzNQtv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGmrOF/d; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso2182206e87.1;
        Fri, 03 May 2024 00:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714721127; x=1715325927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bfIVKPy8kEkNHpot7ISpKC3G8aLSDEdKgGxPBam63Q=;
        b=BGmrOF/dqFu7W9+KburpANTmQFvxX9+IsUJHg1idfHvwPNkq4cRNYjS2utKMa5Vyow
         GeXIegks0crNKGhhIl90V9fQteDWfykAA0sIB8wHKkLaKwRxKwf5+0aCvMWMJvmJ5JHt
         xP/Rk+tchs7yl3qUX+iruNg9WFUVuWTaPv4iFLPgKMX0sDUYI8Sy9RKqmTjvmQtVNK62
         sioRKLfbePdLzAzUZW2dXM/+xBwFvnHJn/90v2spn4GtdAgQ2NjzGD2O4gSPu3gTZH0m
         upnIGFhyqqfzgbNi1oAaKk8Eh8KzTr2D39UGP4xNMusaXdC3R1EVyTuu/MFDLSisUS9X
         vb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714721127; x=1715325927;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bfIVKPy8kEkNHpot7ISpKC3G8aLSDEdKgGxPBam63Q=;
        b=OtjHM0KU+LjROJyDXkvT0JALEIAnFbUyvMOlQkLZCUxUBnvRQKF+6uK2fQg5LEmDw8
         Pf8Euxh7oQE8jEgYIbEZp10O0iqMeYz7ReUTkbsUJe9dgx6ob/PVsLLEZwWbNGifN6Vp
         pno1VMOQwzP7/NGprYiSV8fMc++pQg7Y7H88knTrQQ40dBcoFQhJ5ZDvJ0lecgypb2bl
         MQD8gRXkEuA4A4vpaKk67y/Dnm5ZJWMUCQAboaQP32RfdFWEoTZ7aIQdHprSfePSJxVZ
         sigtpeCn2bHMRlyTkZzuhStiZlfV9kqqh76U53eP7xDBzrYybncG9w8Dcb2Q2iT+QwIq
         ybrw==
X-Forwarded-Encrypted: i=1; AJvYcCXmVPOxqZeRqrGowawVXiW5jFUGiphCWXIB887Az/6e1nUdTzTgQ2iqxe4eIZshPhbqDTmzYEABn0n3+wPeX0F3fFLhTAOWUA2hEM1By7rtHdMjac//WIXz7j/KhpcO2oAQGUL/U/5kdxWx4LEf6qmbIEXFsJ+oEm6drT/x4lOXWPnISPlTTJGY
X-Gm-Message-State: AOJu0YwvHDjizJi8sxDR1ndpKxzUthiIi85qY7T3LqY12mUvf+xidpkm
	54yI/vLoeqT6A51CE3870QE+TOA9U14hqlHBQLr/Mkecn4wpftOM
X-Google-Smtp-Source: AGHT+IHfp8TeX/0dHU9tN2siim24RPoCWkmxx7z811SZUiY7WINB0kURBDR6geiOQ/+SyFPGgu6HDA==
X-Received: by 2002:a19:5201:0:b0:51c:cf2e:db1f with SMTP id m1-20020a195201000000b0051ccf2edb1fmr1198161lfb.6.1714721127176;
        Fri, 03 May 2024 00:25:27 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y13-20020a19750d000000b0051f2230523fsm448785lfe.147.2024.05.03.00.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 00:25:26 -0700 (PDT)
Message-ID: <2286c7cd-6510-407a-817a-8d964b158c4c@gmail.com>
Date: Fri, 3 May 2024 10:25:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] dt-bindings: ROHM BD96801 PMIC regulators
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1714478142.git.mazziesaccount@gmail.com>
 <c747a3395a52bdb9b9697f814cd781fb0903b894.1714478142.git.mazziesaccount@gmail.com>
 <20240502-vitalize-oat-ecbc14647df8@spud>
 <74655775-a8e2-45f4-8a1b-8046dffa5520@gmail.com>
In-Reply-To: <74655775-a8e2-45f4-8a1b-8046dffa5520@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/3/24 07:54, Matti Vaittinen wrote:
> Hi Conor,
> 
> On 5/2/24 19:20, Conor Dooley wrote:
>> On Tue, Apr 30, 2024 at 02:59:50PM +0300, Matti Vaittinen wrote:
>>
>> Krzysztof had some comments on the buck/ldo node names
> 
> I think Krzysztof pointed out that the regulator-name property should 
> not match the data-sheet but the board. If he had something to say about 
> the node names, then I've missed his comment!
> 
>> and on the
>> initial value properties that I'm not sure if have been addressed, so
>> gonna leave this series to him.
> 
> Thanks for pointing out I may have missed addressing some of his 
> concerns. I though I fixed all issues he pointed to me but it may be I 
> missed some - or accidentally dropped some change(s) when merging fixes 
> from the 'experimental' branch to the 'simple'. I'll revise Krzysztof's 
> feedback to the RFC before sending the next version!

You were right Conor. I checked it and yes, I omitted a few of the fixes 
to regulator bindings. Please skip reviewing this version of these 
bindings, I'll handle the rest of the comments in next one!

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


