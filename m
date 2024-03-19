Return-Path: <linux-kernel+bounces-107123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EAE87F7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C9A1F21AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF6E50279;
	Tue, 19 Mar 2024 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7LluEj0"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6B4438A;
	Tue, 19 Mar 2024 06:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830840; cv=none; b=JcvjKHV7GLBb0h+u1vwr3gE6tiZVJEQTlLtTNAzPh3OHKVsai4FIRXjQN/JRh8DoXu5mch6X3+h/HkJ/+WZkn0cNdpKy8WIodDhLweGoo30jko5s1P9F8ACnhjEscyCBekOomnO8atg5OHMXosnKF6w0frKFIzVdWdih/9yjbaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830840; c=relaxed/simple;
	bh=5gtHSYwXJV68C8zJ8rxc8LY/RW9X1o35jV3nacpKc2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jtAACgLl29K7NrVDvGqaESZCmrMU5B42tVGZdZhJS9TNZE6hxMBTHcfXhZojJ3dD1Q9d6Xy30WrdrSrGtS1FbQOoIocfzaYDFxhYCJ4irSGcyRcjaNtOc5t/VDUpuMJlDdPvv1/5fHxcU3XK2UxEUBmU6OWbc2vHwLuWACIDT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7LluEj0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6fb9a494aso2662752b3a.0;
        Mon, 18 Mar 2024 23:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710830838; x=1711435638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mcliv/L3zWAX4KNH4oJjctVPq87mh6KvjFep3NTqLok=;
        b=l7LluEj0f+GQSo4PEQjiTM8Bmz3P7hRIw+y7nvXrRoC9cQSGIxd4q9qrLIvchmAMDq
         cbrX3LCBbjwQ+ZD9J7C9PakFfUgYnXp8h9cS5BZJhkwVTj8RllZuRpPmEid4yC77X6+m
         1ZIKo9F6WZu0x8u75JV7XXunnfFP4lsBs9bSi7JKlHYu+DxCklq15NmoCh58iGwK5UqJ
         8ouOYjxu54Ck9lF53ZEblmcJYqkmDGe8DN93sKg/DghofV9CQqxBDg0vRY2n/syrUV6Z
         T6bUAWPNu9gSOHYylwWEdS2gEpp6RZewLLPloxvVqQJr1Ra7Y722RdCWrSFduQUgegxO
         66+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710830838; x=1711435638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mcliv/L3zWAX4KNH4oJjctVPq87mh6KvjFep3NTqLok=;
        b=L4dfTUDtOy9Vd/FFhU1pTkxeSUcb3KQcsD1Pg5J3iAU2GVV4ZCYxDaWsaY2SW6X6zv
         EnBUQsr/AjV+jgAgLdKAa+feu+yq13ZJMwKMYMnyly4qihxFE5AEoI9ISNuBzgPa+gJG
         +ULevqOF/AFD1uaZMljbnRwqFYeX0u4SeBynizwmaXzKqOL8Z5mz9DufHHu1vIPlGHow
         QZfCbI1bLqJ5EEV+sTq10S7xGvwXVBJtELwN8d0M7X4kk5QxIBou/SV8eZQDfT40Zzll
         7MdnixVb8thJWZjhNxJ/jbnrI0KxNNMSbSEigY5U/tBIftGTy7/AazwxfmoCVbiJb9Wa
         iiGw==
X-Forwarded-Encrypted: i=1; AJvYcCWWSPQeV6ir7PL2WUpXqxGl05EdCxAImfgzCWG7rF5OWgfTbVf3/ZmwQyfhO5xkQbVYlVvM+uuq8zN5PmJIr0/lYtfwFcRARFV1owBBzdp/eL/JD+OOfMBBv8zHCVUkB6cSBPaptmBSDDZX/FF898j0BJ3J4GfLRZENPUihfpFgFssqaQ==
X-Gm-Message-State: AOJu0YxRvgNZDCclFp5F8zyilNTfIk2W4tEYvkyBrdVWoEtwSVloUWsr
	OG10N78Ogxp8jGJ4deWA6zpVdrUT4Ol9kLCIXiJ9c5a8CfpqDFSC
X-Google-Smtp-Source: AGHT+IGn01bFm+mPOLfCut+RdmK9QJx2Dvyl6xsp0/JlSdy25DMPadErJIUiUPMF8Z5ezLXGNj8vtw==
X-Received: by 2002:a05:6a00:1489:b0:6e4:cf7c:6c28 with SMTP id v9-20020a056a00148900b006e4cf7c6c28mr15088249pfu.22.1710830838641;
        Mon, 18 Mar 2024 23:47:18 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id r7-20020aa79ec7000000b006e6d0165a7bsm8787672pfq.82.2024.03.18.23.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:47:18 -0700 (PDT)
Message-ID: <89ec1649-5231-422e-9760-6e04b2a514fd@gmail.com>
Date: Tue, 19 Mar 2024 12:17:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] mikrobus: Add mikroBUS driver
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 lorforlinux@beagleboard.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Mark Brown <broonie@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
 Vaishnav M A <vaishnav@beagleboard.org>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-5-ayushdevel1325@gmail.com>
 <06009676-6189-40b9-a6d6-66a112e4f387@linaro.org>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <06009676-6189-40b9-a6d6-66a112e4f387@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 11:34, Krzysztof Kozlowski wrote:

> On 17/03/2024 20:37, Ayush Singh wrote:
>> DONOTMERGE
>>
>> this patch depends on Patch 1, 2, 3
> So none of your work should be reviewed? I don't understand this, but in
> such case I am not going to review it.
>
> Best regards,
> Krzysztof
>
I am a bit lost here. It was mentioned in the patch v3 that I should 
specify the interdependence of patches in v3. And now you are saying I 
should not?

Here is the rationale for the dependence:

1. Any changes to the property names in dt-bindings patch 1 will need an 
appropriate change here.

2. This patch will fail to build without patch 2.

3. This patch will fail to build without patch 3.


Ayush Singh


