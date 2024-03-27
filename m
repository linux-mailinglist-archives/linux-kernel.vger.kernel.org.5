Return-Path: <linux-kernel+bounces-120405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDF688D6E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61BED1C25176
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E829241E9;
	Wed, 27 Mar 2024 07:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZT0put3"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335F1C28F;
	Wed, 27 Mar 2024 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711522903; cv=none; b=n21IA1iJLBYI1Ig9FZD/TamOZ3y2epw8blGrvJZL29umxKd4gOW/WwpfM8F35NtYpei3QWgKh239q04Qcusfei9GY6+UW0Zq3yHNX8oibZNFKuOnJ0z4dGVOZXhfxwqD5jLaiKypCfG2rZv1v5Kr3wkTJRBlQ96tZUKv9rkWX60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711522903; c=relaxed/simple;
	bh=ZUNWHD+7WlXbZOUiqn2cSoRhOXVS8SMp4w/2KMETPz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYkAcV+dRJxqj6VWuBc+ouT6rsjO4vcbd+UQ8glznOUyVfpkg//lKlsttq9NE+RsWYrf4KkfVVrW8cxIH3PN0+A9qDnPEqqaq0Hu2urjXkjtky8RaV3qUft4K5/Ewy51B02mHPXp1TLt/tm75QkgqYZkfN+qlbSrh8ZsAqPGv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZT0put3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512e39226efso4532849e87.0;
        Wed, 27 Mar 2024 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711522898; x=1712127698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+ffpq03Eb9o/yuck3cfOU3kEp3iGIn2GeeKZkYGw3w=;
        b=AZT0put3j4YhQ61E9J+Esoaa7NRXOhXyihOYJZbPDGa/HQB8/TGqQL0gjdRijGVUdx
         mAzmDjEtyNGoV0ZbqIKKqa5YA71DIIefsIjEP9gyk4NrIoLX/JrW29EVpWa6oMRBZdy8
         NOTzEW0b5UAQ5HUl1yi3+8Gn6X6dRlrEm1QImgZxXrjHbJ95Ce5ghJ4Gd5R56ScSsMNM
         hrSYDe7ICuxrT1R2BNLYsBrcB11KK3OLwzGrnJFsJ/3gDjzx9BYUCHwaIn3LNZ0qS8s8
         vLIFoooPjxUmgghoAI3+9Dxkcvi4/f4G+y0csx8kkFRe0fqn2IEHUcvuGQyK80DZI0my
         3kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711522898; x=1712127698;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+ffpq03Eb9o/yuck3cfOU3kEp3iGIn2GeeKZkYGw3w=;
        b=s5OM6BDU4j+ODt+F0Br9sCRd79p5+dxTvUYcOIMg7WXSM1jyWIHlaiHAdDRNDHIx+x
         kbSK++sVoTl3G6FA0S2U53pQ4IqNPURMAKmbuZg4jv3r0QqxoBsRs/UKsoTqLcPorTwr
         Th5/YcypDl7EbKaAoVb7F1AdlKjTlww/oY/Eew9gSZcX3Mvd1Ve8aymOyFBZC1Fy4+7y
         j6u7cDkYQ/fcN/f8s8q4tJZNO6+kdFYFxXbdtf65i1MwidCyb3uTkf8V/OBXZQmJ6IDC
         mP7LUg8M9fDOGzckMEjgzNfJ/AcnFbSu190xoe+PKybczA4tkATbj89z2oLIt/JcL45z
         DojA==
X-Forwarded-Encrypted: i=1; AJvYcCVx+CudxSOG/Kx3BQHJ8q1g5uVpyjKfbTTSDFQfdl58XyHzi5ceIO9C6dJUbXqepBsKmty1ljKgswXzS2N8tzgdpq6l2tFUoK7xSBk6IsEKTuzFfw4z4weQHdoQ8eexnl5GOKht9E7Bjw==
X-Gm-Message-State: AOJu0YyOAkCVF4wP+f79LjTYDY+f8LE4VAIhrpUmEKOJF5HEY46AEBXc
	rJnD862lARx5dVFIFoFQiKDwsHgL6p/tz9AywMVUjfAIy+dRAzYQ
X-Google-Smtp-Source: AGHT+IHO0xxjQHizrwK0YPVuKODJa5GpYkOkyXmB+uJgxZq6GsBUklBzTBqfw1yzr73R/Myr5beN3A==
X-Received: by 2002:a05:6512:312e:b0:513:a88b:3296 with SMTP id p14-20020a056512312e00b00513a88b3296mr2150994lfd.9.1711522897542;
        Wed, 27 Mar 2024 00:01:37 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::6? (drtxq0yyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:7426:df00::6])
        by smtp.gmail.com with ESMTPSA id u12-20020ac243cc000000b00514b4e5d180sm1738128lfl.158.2024.03.27.00.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 00:01:37 -0700 (PDT)
Message-ID: <41c2b68d-0279-484f-8ce2-c1ba040681f9@gmail.com>
Date: Wed, 27 Mar 2024 09:01:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: Add ROHM BD71828
 system-power-controller property
Content-Language: en-US, en-GB
To: Andreas Kemnade <andreas@kemnade.info>, lee@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240326192258.298143-1-andreas@kemnade.info>
 <20240326192258.298143-2-andreas@kemnade.info>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240326192258.298143-2-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/26/24 21:22, Andreas Kemnade wrote:
> As the PMIC can power off the system, add the corresponding property.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


