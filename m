Return-Path: <linux-kernel+bounces-129409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FB2896A57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C8628F44F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE871747;
	Wed,  3 Apr 2024 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIHMSw16"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573376F085;
	Wed,  3 Apr 2024 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135915; cv=none; b=emZZ25Cc9KTHcwmtAsw1HHwNVzD3lZ7nJgjSuqNyUxTM0Wp7bdgA7Ux9QJvvavqVYxtJM+5a6LfzD/YaBZAF1RywQlmd09qRJSw2GdytpAGwQQzztBWoqa4kwU4YQU1EvfDmYKg35sA8Rtuyg5rFvKvr/W1+EzS1wyBgdq8xh0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135915; c=relaxed/simple;
	bh=CzfsKrznimmus6818cmtZRxRPiIEQhbv31NtqO99GAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaQLg0GIw148TxZ2ELrfOfMfGQoU7TjZ6ZH05tua/jDC83u0R4WnqcHJrCS+wdIKOYk+x512YFVFf7STfnRg+izC/VMYwI53Evht+VB10/EREAUUkHnqux7yz/WtxeQTdxRSrmxGK2FO0HIyXSZI6UKWUeJWZnb1o3ma2OnUIJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIHMSw16; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e0bfc42783so51661395ad.0;
        Wed, 03 Apr 2024 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712135913; x=1712740713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/UVKbDArSXf9OPq4uUdi846hr4Zk17CJip7zdbVBGE=;
        b=FIHMSw16xUQtnVxJ3KRn8JVdL/IUIvMw9CpzUoOnlHSGHg8bPYrU73msAPxYtNtL+B
         3lD6eonkSZkBw+s+ULKS/i/vwd0/7irOTmatpv11mplSqw0bjoUp0rN7I4t8XDyUxRaB
         MUnFlLE7kFrfCR+LhFivCIqYDa3lQGbhoKQ2fDPWT1oe3NYoCDc+QLTs/Y3jtjT/2GKO
         rPH8PXcL3uhz6ProH74unm2SxYfyzyZrjiTQZUs2npAsfg4M83NwsaSfETZqLiOy+XNX
         gFEXPyW/NRLSpK4eb0jriQEA9lEbBZrPR6hkpIruU7vRxTp84Ni9FGcL2aUiGofuBbzI
         uQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712135913; x=1712740713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/UVKbDArSXf9OPq4uUdi846hr4Zk17CJip7zdbVBGE=;
        b=sWZV+5PkH5Bt4bGsOwf61QYPYYAUDWDnLqoQYW8gdI18j+4Luhw9RPheJ3NYIZ/nqP
         x9RtJYMKz4wrLxbVx8buv8/Z/h3g5XVI5j8EKNjJWSvlS3MbzE/hM/VJ2nLb+v7g0oTx
         BVRH4o+3XvFpSmZrZ24oxWtFJNlNkabRcEuc+E4m/IJoeCxkc8NRU4a1tPDAcYYQnLKL
         zUSm7NRroBc+m7GNVa5t35Ogu/CVC2gmO7f8saGsD2h6otmFKLwfRIsp84CE9jPm5udm
         PHdSLUZ7lAmN/+gJ/1rLASubXnPoAIeRcziIgd6+oHImQM9GG2D9xPLfdWyyzCNa9Sw2
         Cx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlAo8mE5taDG2KizMa5BEmJHl0m+gFSNYizlgvJidzCBQqhwwDQll0tlPVIwY2qOfMAgjHHKVLVd2P+lts1iqnG7F0WJYx/bgwgYDiF+YoRCVefCmPwLSVDfBY9BMxyVowaTl7I9g3NkeO7fkLmtSrf417Q1biBMiD/Yw1SfHFpBa57LB+WbfZ
X-Gm-Message-State: AOJu0Yy33zgePobfXQYAuDnGF2peS/W1DjMT20WqRKiTNj7IrypSaDyI
	SFuGrdxqE3AMR8EGEFobCfmJ30j/nxM6e6HNisCTE+yjqzw7VAUW
X-Google-Smtp-Source: AGHT+IEaFhwRz3VWSg65jk6f3e+gnvcIMOhfysLRN3LKjo7jt1SN05PzLJCLDWUi6JBCZtwahwn/sw==
X-Received: by 2002:a17:902:f644:b0:1e2:926c:f16d with SMTP id m4-20020a170902f64400b001e2926cf16dmr1041331plg.63.1712135913591;
        Wed, 03 Apr 2024 02:18:33 -0700 (PDT)
Received: from ?IPV6:2001:b400:e307:843c:cd04:f62d:553a:c932? (2001-b400-e307-843c-cd04-f62d-553a-c932.emome-ip6.hinet.net. [2001:b400:e307:843c:cd04:f62d:553a:c932])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b001e2881c8de5sm1921544plh.82.2024.04.03.02.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 02:18:33 -0700 (PDT)
Message-ID: <79b7e2ef-6f53-4642-ad3f-99b8ce780a7f@gmail.com>
Date: Wed, 3 Apr 2024 17:18:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>
Cc: patrick@stwcx.xyz, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
 <20240328022231.3649741-4-peteryin.openbmc@gmail.com>
 <20240401135637.GA342928-robh@kernel.org>
 <ab76b0549172cf3e33d6242fa9ea3e6a87b4a58e.camel@codeconstruct.com.au>
Content-Language: en-US
From: PeterYin <peteryin.openbmc@gmail.com>
In-Reply-To: <ab76b0549172cf3e33d6242fa9ea3e6a87b4a58e.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks, I can wait you update it and send a new version for wdt driver.

Andrew Jeffery 於 4/2/24 20:09 寫道:
> I had a patch converting it in a local branch which I've now sent:
> 
> https://lore.kernel.org/all/20240402120118.282035-1-andrew@codeconstruct.com.au/
> 
> Perhaps we can pull it into this series?

