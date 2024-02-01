Return-Path: <linux-kernel+bounces-48342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03617845AAD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA92A1C23BCD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5745F49A;
	Thu,  1 Feb 2024 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P66iXILR"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4B5F46A;
	Thu,  1 Feb 2024 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799258; cv=none; b=BT594DbhJ6r8tjsXctv3Pdr/FchNpC50u96kl8LKAk5qX/XA+zT9miYRAiHAUE15lo2hdPz6vJMwBpDlebr7GuiKqpCCoLMgZB8+XaB63q5Pv3lvZHIVIo2mlj+mWanpWjm6vLGcstebrr53BlShEdfir+4MX/nuvWC6br/AtNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799258; c=relaxed/simple;
	bh=p/b6hnnkmVbqYjPV4zfBIYg62+5N2H+iQIk2/GjHndM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/b2T3McRc0l49ovND8HCQISCVVgLv7WGrQ+/BiAXYkchdvnK2deALbWEKBUNtTCjhFy9jEtuWVeGh+hyUKv1MarfzIT1VKQ/9zWjKPAwecImUUbJg+pnkZe5ZP8NkDn1ldA/n4fKglQfQkb80Pq8NsSbUkSsJDBNGZiLkD6lrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P66iXILR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f279dca99so1421587a12.3;
        Thu, 01 Feb 2024 06:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706799255; x=1707404055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nMywRXmrmzqtM14OLjyYgWiqPrrFs6p+ZGoaxrmNKtw=;
        b=P66iXILRNBk2jfitWA39ZvjdSDu8x5xj0btCXy+eynM/Tm56dyZAX7dyW/KphBxg1s
         aj45JtQ2TyJEi8ckmRAD6KqoDgT8jjf4SGKHicMXvEyF4rWXePpZm7Lv7KY0Ib7UNDIZ
         DKt7shIyLGzmGK1+eemaLVTuDqgxhbz7b6F0DG8XnzT5csODajNCIzvla1emjUqKq+wy
         r5NXXW7N7EdneeyvpLqcD2UdWAIaaUgq92uVcr8y4tAzOr8ViehjtlWh4aK3BPFHjs7T
         OQaUZr3vLta7edCgsvoVizpvIce9uw2Ned35WusrcUN/EG6ZOGnEptEiFTFAfWWlh+/Z
         JHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799255; x=1707404055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMywRXmrmzqtM14OLjyYgWiqPrrFs6p+ZGoaxrmNKtw=;
        b=kh04SFx0ou7ULI4KOSeivny9MvfBFPdSJy1yrkME+FAdnUudh9WDh4vyPseTnBPb/K
         Uj89RFJnPfxTk2jDJ9daMUsyxBpQ+lVqyvlz1UcUEG0XwSfrVWN5IumTQKmH+t6R1+ra
         P9zryNsHw3NIFpWpYF7O6PJ/Og+Ebb1K9AUt9JsJXaZGIixKIBfOPUKsdly977TSqIod
         7nAwr6h5bmL2Q4ZUvCwxf+Ma1evSDIa5kgqJE30ihaAMuVmVp1bkCKse1ZOPkVKCeimv
         VH6ftEUy+hde+1IrO14L9aQZwx6jD8K61UdatYSN/mhDHZMoAuCA+wb1GxxujeN+PEQ1
         NLXg==
X-Gm-Message-State: AOJu0Yzo6x7DhHLp5gyuyusSaxNYDg6YmLLfiC++9f0JI0f31RstuYuD
	2cDI8D7txXOj1EgYKPxkaXyB4pGLfL5Fy1sSvofn6v1SjNKbv1gr
X-Google-Smtp-Source: AGHT+IE+wfFLQKMiqxH2g0rO4B6Uzrf9CNTT9m490pfZ6eJPCnC8ehw/M9egRgGS7x5pACMhE65Prw==
X-Received: by 2002:a17:906:4f0a:b0:a35:de06:23f1 with SMTP id t10-20020a1709064f0a00b00a35de0623f1mr3427175eju.0.1706799254445;
        Thu, 01 Feb 2024 06:54:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUN8MNFjIYlikHUtEEhB9lWlSRHg7TC66e8kCR2HL9cwl3bGm7dRG012iTPoqqyp45K4tZZdINkuQg4m8c+TPzz6F6/ds8kvbIV8LtAC1zQ71hTFLqP70TaQR6Y4GXRbz3sRoJmq4Jg5tzZW2bJbmvnAFv2vTmezCYB2ps5Eyx6rrhps/I/6k5pCTyuRX9rhhFrq6gZ4iM88Z9QmLOzxXu8yrddnmEA6KDVUOAvOsvcH81N2D1wCdB0FVsIUdPU/YRIhptnpihZmmYrYJrgPKbOS0Wqv44xs8zTtN1gaDS8xdHLExvRKFF8zxkHMxw+kDmezPwqjtMwkdgSTYhC4ONu+Atfl2LtcdZaqF0HbLnj2DEmEJXCITcjsOCjt8EllPFUZ+SrYYk=
Received: from shift.daheim (p200300d5ff0f3300aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff0f:3300:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b00a2b1a20e662sm7265531ejc.34.2024.02.01.06.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:54:14 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.97)
	(envelope-from <chunkeey@gmail.com>)
	id 1rVYSD-00000001VyN-3Tdf;
	Thu, 01 Feb 2024 15:54:13 +0100
Message-ID: <69cd3865-1af0-4ad4-8a5e-0bd5d51cb059@gmail.com>
Date: Thu, 1 Feb 2024 15:54:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/9] wifi: fill in MODULE_DESCRIPTION()s for p54spi
Content-Language: de-DE
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, Kalle Valo <kvalo@kernel.org>
Cc: dsahern@kernel.org, weiwan@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, andrew@lunn.ch, leit@fb.com,
 "open list:P54 WIRELESS DRIVER" <linux-wireless@vger.kernel.org>
References: <20240130104243.3025393-1-leitao@debian.org>
 <20240130104243.3025393-7-leitao@debian.org>
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20240130104243.3025393-7-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/24 11:42, Breno Leitao wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Prism54 SPI wireless driver.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Sure.

Acked-By: Christian Lamparter <chunkeey@gmail.com>


