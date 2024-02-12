Return-Path: <linux-kernel+bounces-61177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34A4850E63
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197F01F25FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D77101DB;
	Mon, 12 Feb 2024 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gIu/GRse"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8834F9E8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724732; cv=none; b=qZOQdQ/Dxz0dFx2MxryQuInbS8Sam3D/EmPfTIt8F1TWLuwIcok+fYZHJEnPwHyEtqW12/WpU5CkZyA9CIXEPJ0xSTj8wYP75X9ZpqafoirHm4TmZUC2EIeIZ2Ek/NfDUTrp96hlrthLVmj96q9mOwGu89GLtduacRVU0numH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724732; c=relaxed/simple;
	bh=7ez6FtuoFjmCtfXEtUSEFvEZpGgKZ3gMVzW7RDqQlVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/NotaOmjecjRLwpiJjl+PeI5+ldNVBtweZhIGy57TPyVw0HlSNijofZxIaE6Ksz169wQQAyqOAW7Z0fAU6troeOvff+EX7akXyWR+ebdeTgh8tL9LjfG+PcUTQ+Rotts+t1aTM282ApeR5ymL/WoMqCkeYZv0LALsHFp8jOFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gIu/GRse; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-410d57a533dso4087645e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707724729; x=1708329529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WffCnRPeSA2hGcw0mYIwRJnAPmPBaL6cwyuJFHA0zs=;
        b=gIu/GRseJeuQNn8vM5Q/cfT8Z5ZRsfMTB9hAaMTzTuIqe/S+0I+BChTbm3YUPJfeHp
         vzL7AkiuncMSeCnEp0Vtbh1B+nE+E9sHJ/0YG3EPqbvyjXlkZU2d9gnH1kmZSrkYcmmp
         VGXJQLbUgW79HV9wBYQNRFdX3kdRiSujy+HJBupLVe5YPRgeKQzqSAMf4aEp0lFQtMk+
         iqgBGuWgMqw7SNyOwNVyawYiI7JDjJ/FatIIL5QsVn8jhUJ70AsfI/aK0eRJ4nFjXWF2
         ipGo2rwV+/5s9MEajuepix8XUWAbhmWAHv2F8eyX4hCL9AJHhpW302PP+3Ad2h6WRrRi
         ZTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707724729; x=1708329529;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WffCnRPeSA2hGcw0mYIwRJnAPmPBaL6cwyuJFHA0zs=;
        b=LgizWexlN0MbPFjFLY430LjBa5liXGVcYQ9z+7cypkVETdXWLhjXmcPYIBqYcA4X/1
         SYKb3Y0jflC9A2dj0MT5bv/BE3RDtZHD50b8ILYVoKQ8/I4AMZs5klawQXpcVSIbNIw3
         Acf08c2yJyZ4cMoz4glMqs5kFo66bZvZWssBBE8bwPzjSOW2jRdEFAsnoOlsH9wfl/U/
         kXebNT7R3e8yqBeimSId4KHJ7pILbxyFSe20W8bmdB228jUjGnRNKG5IoiET6UArfFQj
         ny5a7VRLNueOZHW5UhHP5eADRS0uPK/D6FFS9Weln3IjrCqDOmA7Z6daoACycZ9EU+QM
         AXFw==
X-Forwarded-Encrypted: i=1; AJvYcCV3sSVOzDGZtqzxJ1pSL3KTNhiwxAuUouBh5Vv16xrmAxE1gigtolRhwjZ0CZeCB/MA5smVzkQuKBbsOG7e7WfwtLPhM5D0j5Mnv5VK
X-Gm-Message-State: AOJu0YyyuMSenx3kktP6C4TTAm1qY+WROdzSdgEMNWe68L0GguH5Neqm
	n7quSLv7+2HuLUOJJbhGbEnBX29G0JuryIgAkAr8/TZjFi+V9698X3Tr04aLqy4=
X-Google-Smtp-Source: AGHT+IHhFAF2LdTkSDDSvePuokBw1QJnMM0+9hmN/TphkAHuE/DRQiZ0z4yb87A4VY3O30b+QciDWw==
X-Received: by 2002:a05:600c:3d87:b0:410:ed9f:7acb with SMTP id bi7-20020a05600c3d8700b00410ed9f7acbmr368460wmb.40.1707724729010;
        Sun, 11 Feb 2024 23:58:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjdWl75bdtgO1vCbRWvRyK4lO+UOuzQxGZbqAidFC12xc2Aj3FPo1/HvOV0l4S7fURvjBvFE32pLpQj72ClvJ/ebdKfQ42dO4EGoaIAx/1m6NL1V2BKsqfD5a/tqvc8j1k64vslxGz9sfTsyEChqdW1s95nBtRI5dLD86+eLOQBziUnHYMHp6fjoXqcBC9MJBVwAUpauEcrVI7/j8wmfj7RHzRc3dT/jJRVEVaHseR3elnhs8rKWz0mZmwwi7kAce8fi8kvddc8FmADr3qRyN8HFeJD3sFA2hIQKD5PYbdHTb9sdP/MNZ/VkJ/KXMOvIjSytvCqRZ+FHTED9U93q3cGHKA3Xs0EnuA2i0T2+8=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id jp25-20020a05600c559900b00410c7912c6esm2886372wmb.14.2024.02.11.23.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 23:58:48 -0800 (PST)
Message-ID: <4e110cca-240a-4743-8880-6c840316ab14@linaro.org>
Date: Mon, 12 Feb 2024 08:58:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefix: Add prefix for Voltafield
Content-Language: en-US
To: =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Icenowy Zheng <icenowy@aosc.io>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240211205211.2890931-1-megi@xff.cz>
 <20240211205211.2890931-2-megi@xff.cz>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240211205211.2890931-2-megi@xff.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/02/2024 21:51, Ondřej Jirman wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Voltafile Technology Corp. is a company that produces MEMS sensors.
> 
> Add a DT vendor prefix for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Ondřej Jirman <megi@xff.cz>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


