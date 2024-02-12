Return-Path: <linux-kernel+bounces-61152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872A2850E13
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDCA1F2107D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C238D79C8;
	Mon, 12 Feb 2024 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6j/WrfY"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470736FCC
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707723164; cv=none; b=tHjMzfZOmxm84X39r9iSYoxkvtOEgne3P6DByR39wL0FMOOD+4Gevi7FkjhVLsZNtQFk7Mb8g6Q1v9bvcTar8G+PcAt+LLIn402BVL3B6uWY3+fLrh+dCvp2QqgCVWu7iG7o3oE/Q47YuLB8V4dkdGSk8dckaz3ENfD6JxMb0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707723164; c=relaxed/simple;
	bh=I6xNOGjP1RrP9r7Wi57qOGh14wvcu3szIOb1b52ZAAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mx6w0Kr7fkwRt7KvKrE5dC/jedFDA6AFGTlxR9n73Ug7TGq8w5xUq4NWnb5LynycsJAAWWhmI2Lui+VClN+F+vrziy51fSQbIMCtlCZxspSK8ufdCwdgxvbXIDH38LIIDleri72/mE/01/nG9IGaPWUelDKCVXXA8PmFH4+F0pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s6j/WrfY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-410fbf07602so524075e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707723160; x=1708327960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6xNOGjP1RrP9r7Wi57qOGh14wvcu3szIOb1b52ZAAA=;
        b=s6j/WrfYvRft25NEnalgXMcUc3BKGZX24SK8dK/r8nsQr8mngxlCU1rzt1kZZxtzSz
         7r1ue0eRjLtvuCSx+a8Pe6mWReqNI96ZVhfiHIS7xG1hKLfzhCAJ00YG60+9g4Io5oza
         nkTgEyb3aQGsZNb2fUp/zht1W9+AaftNznfRjqd+SyhU7nQtH70ffIehMhtppUL4HtWJ
         1UoCM0GvQvFnlq2hA/F+uichmN8q7e/DSoTw0lc04DWe3VBzuCIxZCLToOjpbYFvMgNN
         ecA98oPCJIwL+eCciKQby+v6s9cE5nr7R/rZDjwDozru64RvttFBS8Aqu8cFrwz0BoFh
         MQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707723160; x=1708327960;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6xNOGjP1RrP9r7Wi57qOGh14wvcu3szIOb1b52ZAAA=;
        b=dZbJFA27ivo+k+Ui/OETDvkdE5I0plMsaf3UsSoTk9S0yDYRsD4gdTtjaGHKwX1Sn9
         xbcIlHRU0lmspj9CKE63+I/Py1gmYS6+oqofL2aKRZt9qmkkaSm5zfPqdX/WQNIVZkl/
         gtcCDYKuCycxBCycqJ/+FxhxMYyImBgxXY8RUamkJ3eS8KK0MxdPRoQXrfRnoQD7l87o
         7y5Cr5eJgPqfVdgf4lj/fi7MUJU1Opl0LC8HV8oeSg8w3ixznouDWvE5nIvbZR9JvT1+
         wNKC00o4+lXl/WCDa0DrntXYnH82/JPx/bl3Umm8JHoX4Fcu+7VRyXllyt5kL7zdVBvz
         XJaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOFYImhL1E6CanR0CzKJJ6ppmgzMinURiTfZHmyHUrwsUylFtp8J2SFNRdp+QmP+fBkA0IV8AbIKwr2xqafUH000CVV7HaWEQKIXXw
X-Gm-Message-State: AOJu0YyqCuiEVgoXWW346F98KM5/d74OcKVmfCrQIAwTjMf/gFlo1WOt
	QJxU96b71yvDKZ2/ul/akU/jORudGbWBwC5wayUz/fM2ybOxnMHduO6dJ2G0IIo=
X-Google-Smtp-Source: AGHT+IHJcAXFafgwGYmD9HjGOvVCrSZzXKqwg/ZwWYKIJrEGxSzuEWiBNRMzv0M1bGmuFhb4SdbxUA==
X-Received: by 2002:a05:600c:1c85:b0:410:ebdf:73af with SMTP id k5-20020a05600c1c8500b00410ebdf73afmr438039wms.7.1707723160525;
        Sun, 11 Feb 2024 23:32:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmXyGy/WCeyX3OoAi+oiZTLGP0sbC/mKFD4flNjPHeN798fKZS1QAqeL/BoPUo02TErF6Q7BR7l9hsptW1QMHhwI3lSSV7Q7LkqNeV5IHNF0CI0KVzqPOCAyfGyhTYpBcGjcst+ReDcdAAahxkDDt9/E33Ck/M1+i5aV6wRaSZjJPxSt+78jvIcdpVBrz+YVvYVNDg0XhPluulmXCfhbBEgvHleP8aQh9hN3bjksEdIg18K0+Uc5csINVT7WIs1rSMM2A9Hrj5XZlZgEYKyYRtVgPO81Cx82TlK9aS2xb6y//eOcLzGNyuBwTjq2fsWulS7c8gTSQmWA==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id d16-20020a05600c34d000b0040fdb244485sm7801137wmq.40.2024.02.11.23.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 23:32:40 -0800 (PST)
Message-ID: <06b2be70-c270-4f21-a3f5-595ac5e1b5d2@linaro.org>
Date: Mon, 12 Feb 2024 08:32:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] dt-bindings: arm: tegra: document NVIDIA Tegra
 Note 7 properly
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Shubhi Garg <shgarg@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240212071843.6679-1-clamor95@gmail.com>
 <20240212071843.6679-3-clamor95@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240212071843.6679-3-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 08:18, Svyatoslav Ryhel wrote:
> Document correct codename for NVIDIA Tegra Note 7 which is tegratab,
> not tn7.

This is compatible, not codename. Change is meaningless, because
compatibles are just unique strings. Old string was fine.

Best regards,
Krzysztof


