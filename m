Return-Path: <linux-kernel+bounces-155767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E278AF6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32BA1C21E95
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5882513E8AC;
	Tue, 23 Apr 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWKeXMsw"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4273EA76;
	Tue, 23 Apr 2024 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713898084; cv=none; b=inOXu+z9yeB6uOSXcS8J/Td3+ZQssQgZFRP7VgX4NmInJI6/OXpYE2F+9mHXBmcJM8Y0OQrfAPZx5Ise0/s8KtDJPj7nDdfDplyLtY4cNaAIeAqT+siL3eoenasvp+qYnwFfOFazMNxxCJuoRMrJ4aiDS/AXaQzQX0kkSIHdPhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713898084; c=relaxed/simple;
	bh=H5568VIrx9lixuPNa8YvFEWiBslOts9v3R70mPD8pzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i61C6lcbOaJCbICYfLlEZ2Crx7R2LFMySVeg7VSaRrWo6+VNF9b3mSGbTN5nsp79HLv5AmwfRPJEV4KXqe0fd2P1Q7I4djzhMgSb0ohxRia1S7/8lYsXKuPPode/jcX2qvvZ3EP1iWmn0+tjjhSiZE4ymDi8TqnOxb1ipPIhV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWKeXMsw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e3c9300c65so51713375ad.0;
        Tue, 23 Apr 2024 11:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713898083; x=1714502883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pX6RYPwRziaLwatJslL9RyMCesZcjbHxs3ByM77+JCY=;
        b=SWKeXMswtT47xjFM02PzpjTrPZKtZlGkL1aoQ8cM/QfyRH+wYxggAcutxPs1UdHvRr
         hRExlA45VEoz4nMvbgQb4nskeOTxcYnge8FH1xjSriwtG8lWK8hcSvFU146+Wlq5mB6Z
         8BYSTvPlF4ZMS/AM2tuVeJjklHOG5LF+XMNktx/w6TP9DRSrsY7UPYVDbpsVDTVz4SKZ
         z1eROukJ7H2oOk4+sTUQ3k2EW8H4hoUC8eYTcnpfhHcB15tT8MAq9FFRTsG7TbAAUKR2
         +dHkHzSUrBgv5eAQGdPpqbabksOxlmGCrX0Vq3OZu/SMEX1XbNQJ6i318Qq1pl/Dubqu
         sWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713898083; x=1714502883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pX6RYPwRziaLwatJslL9RyMCesZcjbHxs3ByM77+JCY=;
        b=S35w/vfZ84tTVhV2QJwlZBpLBy+ki3B29aMLnR6KsvBj9AOrnauCXgs4XOvatlJdLh
         rJyzoP9hJbhNTxStRLbXxYKVF+L7KuEUNFCB46FE78Ea+GFuGdwM2fBAo6zBOnyvg25z
         G0n+Zr4hmreMAddjgrHtQ1Jom1gtLXhlY/5NomQsgiA7KjXIRb85GBzcqW2/EW6xGxAX
         5dcRSkkkRpKN+bSvcDeVUzIETudRJTCGS/HQpnpXDehyVu9fO03wMuatuu78lry42hVL
         jeG+ztAQVy6dwe+WC8zH0DP3ZMQnlfyH2SElMTGmyYSUJhikKCa7Vc2lHqbx10YYd5kx
         UGzg==
X-Forwarded-Encrypted: i=1; AJvYcCXjD0Erv3tECQ/K7eP/r0s80u51bQmSYwJ6VzN96YsJWIUEQ8oDaGBS4uQZcCMEaKh+1mLQyOBqOzmw+YslBaCQqq36AzO6P2X0rBwGDpqbFLRt0S4Y6t3VPZtdTelViUGt9g1E8uLvJA==
X-Gm-Message-State: AOJu0YzdacAmzjwDUNLVt+h/7rOzeuGHXwhHApMivlmpmBzIpXrViaVT
	BclerJN3mMP3Rspju+nt0zCNgSgd131LtTMoHSyG1pxAIQxaONqy
X-Google-Smtp-Source: AGHT+IHO+XPG1I7/p/baM5AJcJmueayGWEnQTbjJxKPqrnkkS2plAOEp+7WSaHEZhaTrjWIAgzNrJw==
X-Received: by 2002:a17:902:9a42:b0:1e5:31c5:d7be with SMTP id x2-20020a1709029a4200b001e531c5d7bemr344081plv.40.1713898082818;
        Tue, 23 Apr 2024 11:48:02 -0700 (PDT)
Received: from [10.69.55.76] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z3-20020a170903018300b001e0bcccc800sm10377709plg.35.2024.04.23.11.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 11:48:02 -0700 (PDT)
Message-ID: <d8dcd3ad-25c7-46fc-b628-e6adcb5c2c9c@gmail.com>
Date: Tue, 23 Apr 2024 11:47:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: brcmstb: Use dynamic GPIO base numbers
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Phil Elwell <phil@raspberrypi.com>
References: <20240423175025.1490171-1-opendmb@gmail.com>
 <5f550f60-d7b9-4cb2-badf-fde4f53db790@broadcom.com>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <5f550f60-d7b9-4cb2-badf-fde4f53db790@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/2024 11:11 AM, Florian Fainelli wrote:
> On 4/23/24 10:50, Doug Berger wrote:
>> Forcing a gpiochip to have a fixed base number now leads to a warning
>> message. Remove the need to do so by using the offset value of the
>> gpiochip.
>>
>> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> Thanks!
Just submitted v2.

Sorry,
     Doug

