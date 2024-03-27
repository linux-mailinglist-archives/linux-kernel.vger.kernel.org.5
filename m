Return-Path: <linux-kernel+bounces-122001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF7088F088
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33652B23326
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8319015351E;
	Wed, 27 Mar 2024 20:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I32QU/6W"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C3941760;
	Wed, 27 Mar 2024 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573048; cv=none; b=gX7B9WFr5lpwE7/bAS5n31wO+7VPQpw8GnZ0qUqxGsGW0fW8jFrzJZxXQieh6jVzMUVh5JD7lExCJlP9/ZFpFpADb8Y+ZC35LAW7b8KOl+pwenwzNh7jeT8C+J4rSx0PpA69QoUrq8u6ln3mvZ888gvEpJGx4qZLOy7f20hd5eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573048; c=relaxed/simple;
	bh=pjHbYSEpPgHM1kEiDgVmvCyBkD87pYONFMJomn9n2Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Z/jA1FVl0/rcU3pjKHAcKEqMA/dfv7mcTZyD2Y+hm6TUgH4lf5Sa21jhVdtw9/A/YWGW4yQr0m+/UmJe/+kqOWPmVkmnM7iso9VOdHWwKXk++7eAFvycEY5pOqVhs5lNJHjeEv8IF/kBQiGRF9U51cTGXHMdv5jYEjSCZZKE2so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I32QU/6W; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33ed6078884so769771f8f.1;
        Wed, 27 Mar 2024 13:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711573045; x=1712177845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t/OshXTbOf0/0RWZkIZUHM3fViD/ee2V/FuKY2I6mRk=;
        b=I32QU/6WanVhdFjkUY2LcJEfMgKg8SCVpICuxn8ZlCgXgu4djJYNHGiRnD0ed07gDz
         0EbUxxDmCdrj+P/a5YQirgGM/ZXq1IQPkVWRg1eVDmi9qWydNnKoZyS4LB7HivoHiX32
         RBliTDcNXoeaewGqBanBO1+6QFUkD5botxhYeQ/wvwkzL2c2i4SDXfohvU4R/Y55rVfK
         x5EraOhIA56LW8LICNWUCmnv4PU1PfLmiQ2zbOi3rKbEfFhvr+cMGzJHUAjD00nK8trI
         JYS7GfKZUqJJxJNbBwP9VvLznQmnMLwKx9EK9bVMFAFXThJIkk+6Q2E63QIZajoaqOYb
         tAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711573045; x=1712177845;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/OshXTbOf0/0RWZkIZUHM3fViD/ee2V/FuKY2I6mRk=;
        b=FYXgTXKzuiVLCEisu2ZnK1UoPwypkzwF5hcw6cbDqlbxgZR2m3xOJwaHGIfKCYoWDK
         VqzfoK7hkaPDWHzQS1eXsIixDPdqY1P1rTuIQ8EiYOLuj+32sO3SdHbKVmbqcMFE3Aii
         FB0QV8llToaCY4GfkuToU2GWHnY8syVcMBfu5G6KLTSFbGg3v+sw948e+bhNlh1A6atV
         zfs1n6IQ3VZlWy1XiFUcFJpEspUCCF+4LQgeG7yNVWoWaFSBF5ltuvFCr5yqx5mknnq5
         8+K+X6YZg9VI7QumjOMGpekCfLbQq7rTaIJJJBKPKQ7G4VKdO9DJaSlrjShv1rJyjfPU
         VBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuVj3ZASnp50oj90e22SPKj9Go0BnFVnsaG/UFzXjVmySffkjFEZuvPqU6/OehuvPius0010cxBw0Onjrjr5H+KHLEnh15
X-Gm-Message-State: AOJu0YzURp30j5uqkqTEsFJUoL+F0JcEW+VOwLerHcvrH3XDeOAhBvOi
	wJtpo9vC7VJAe+CroiqIwuat0SSIGwdXDyecM9IMHThvbKvlrLDa
X-Google-Smtp-Source: AGHT+IE1BOKkogON6pk/RJmUnwZD11wOJqQQZBQDW8z+OqIgl1EJ3OGOPeKP7pWDwh7CTXDnWm2B6Q==
X-Received: by 2002:a5d:590e:0:b0:33e:2d7b:c5a8 with SMTP id v14-20020a5d590e000000b0033e2d7bc5a8mr318923wrd.17.1711573045356;
        Wed, 27 Mar 2024 13:57:25 -0700 (PDT)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id az7-20020adfe187000000b00341ce80ea66sm8669296wrb.82.2024.03.27.13.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 13:57:24 -0700 (PDT)
Message-ID: <46091098-d51b-45b2-a17f-f1e0329bcf01@gmail.com>
Date: Wed, 27 Mar 2024 22:57:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] net: wwan: mhi: drop driver owner assignment
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Loic Poulain <loic.poulain@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
References: <20240327174810.519676-1-krzysztof.kozlowski@linaro.org>
 <20240327174810.519676-2-krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20240327174810.519676-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.03.2024 19:48, Krzysztof Kozlowski wrote:
> Core in mhi_driver_register() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

