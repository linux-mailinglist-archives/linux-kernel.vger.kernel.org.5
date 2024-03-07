Return-Path: <linux-kernel+bounces-95106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE529874940
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6D6286606
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24B4633E6;
	Thu,  7 Mar 2024 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKe9b6LQ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3456463126
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799107; cv=none; b=NnAOpnrUFDvijcZlCBP9mC32rgST2U+h4LMR1a27WGfCV/fGlw9wDVOC+Ex7dH5DMPIXo2Gf4vIun633w4KCVCmSkbUIhBybP1JqZ6rHWcjX0/r6HsjOrvX5eWLiCPMlBgKo8ByP63jIv0OuzN4MpagzH5RUvSIPy5QH5DJhlek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799107; c=relaxed/simple;
	bh=gnKPbSYg9ZVsi5Y5u05+Q8alEk7BVyVlbiv9waWp/nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHocGtaoKWKM4ZQ3dS6eBzTm/wQ3Ct5tA44phGGO4nVZ/17qDg1a+n2WdrZJM6JQgalTr8mP7niejhK/VfCgjwoqGFMv8/ivpKVHIVOi//RVLW/649Qjwq7tNN5/9R/A0Eum2TAaioE2iHwkPfFJJBahKO1wLeiZ9/gBaSMEBqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKe9b6LQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso578455a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 00:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709799102; x=1710403902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQCFdPf9Wp++fkg1ydsIr/NyfvYejE6bq73BEFjrMzs=;
        b=QKe9b6LQM/fh0RguqEwOixHMsrxC+AvPnBs/xRbQsDhys8E+zteR2T/hk34HvKkpO7
         LhWRlVcac2gPwobTy+4HHHcYswdYbA/x7wtqz/rzv82mKJno04qNQpruwxcKiQoBaK6G
         CjLQSzcJgx/JRffxmmbcYJBRTro1OELgkAEw8zx5GJKg2rTWtKUCXDQWeXK6MFzyfX2D
         ua5VvkKKmznxnan/zAZHQEjUD52ro8CXUGE2jr3O+Kf1Psfb0MCL98SaNhg+C8/7MwpZ
         ZUuv4mcUiPjVVu39yhk7YDx7fDUkOK9K3zYxwCN4SD+4YLl5DGnSpuxTPzFmljVGdEtk
         l4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799102; x=1710403902;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQCFdPf9Wp++fkg1ydsIr/NyfvYejE6bq73BEFjrMzs=;
        b=qSAsaPgzoyZfsyLUgqiAG0GXTuRL0y815wRwT00RmOGYeV8tmw80DNZZqUTOJe12Kp
         1MJzg12kXYWlv0a9/g7UwdyrCDAqL2wl7mj8HirsLxIQ2qcZS0z9qckhWWorq1K65jEl
         hlxI7mJwosieh0ozrvn6Ogx/gtjZl3VfunnI0Jl0kNNI43edJ8fnGboST8VTIycENSmx
         lotm9qnK6g6T8yhaLZ4rzWmM18l71ueoh+ZDb2nZmMn9M+EL2bl6jGVx7V6KfY+r53/R
         QVoDC2A+nDZjMmCKFsiuCtN8rW2ty2Pg3yCQ3hn7Am9yIZQkGcZoo0COh1YpVbqgWGAI
         uAeg==
X-Forwarded-Encrypted: i=1; AJvYcCW6/XQl044UJB+XHhZR9WBG1l8KAs7xUcma7U/J0gmEXhc5Zh7eUfAq+eDE7cr6jGDc0XlWR28bzLXQ4h92Mi4w2vx7WZa3iWSUGPUH
X-Gm-Message-State: AOJu0YyRqCylPRQKqk4bkf3PGkfgzR0PUqzJIHeUljE8VL3ApeEXmp3V
	pPbj+43YqTrRNKopynEODnYwm3dOpYzOM4UqkGAszKd4xJPiGBX5ilQNSszpSl4=
X-Google-Smtp-Source: AGHT+IHxzYNflOAs/Q7YeU2Da/DBTNMvj/dfD/ePuzpffn90/ncllYSjX1KULTvfCSUK7Y3nQwIE0Q==
X-Received: by 2002:a50:d78d:0:b0:568:107a:9e91 with SMTP id w13-20020a50d78d000000b00568107a9e91mr1492716edi.17.1709799102518;
        Thu, 07 Mar 2024 00:11:42 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id fd25-20020a056402389900b00567bada100asm2084162edb.71.2024.03.07.00.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:11:42 -0800 (PST)
Message-ID: <3764749d-7306-43cf-a54a-bd41f3e82b2a@linaro.org>
Date: Thu, 7 Mar 2024 09:11:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dt-bindings: input: imagis: Document touch keys
Content-Language: en-US
To: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Markuss Broks <markuss.broks@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240306-b4-imagis-keys-v3-0-2c429afa8420@skole.hr>
 <20240306-b4-imagis-keys-v3-2-2c429afa8420@skole.hr>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240306-b4-imagis-keys-v3-2-2c429afa8420@skole.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/03/2024 15:40, Duje Mihanović wrote:
> IST3032C (and possibly some other models) has touch keys. Document this.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


