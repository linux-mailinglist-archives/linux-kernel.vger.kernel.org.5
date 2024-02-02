Return-Path: <linux-kernel+bounces-49376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8898469B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB9E1C24241
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2E517BDD;
	Fri,  2 Feb 2024 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2tJEUe2"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E16179A6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706859722; cv=none; b=lxHeIsj++IMEAMMHtMIJF2MeQsX0wWiUc2/9i3oDtAYGC5PgUuUi1+gXBPVJIzZJNtz1SDhhr29WxoXmFY9at21hZfPKL55WGrkNyJ5RFzAsoZqxNoDV3auxMPyVDDA01kqYavaLxZfRMJ4o/K6Ij4ss+zJQpHqj9zMyISpar1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706859722; c=relaxed/simple;
	bh=YdI61V80Do6fkrkci7O45euAcTLmVoBq9nv7LxYT4Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GtiPU6ufu0VU/Pktx8xJj9sL5Iqxe/XdR9HL9bBmkQLy6Cd76BYAJ8p8mxproz4aLbWlSXU/hvI69txF2QgiRyjrrVfHPaaOUMQXHMXLE9h3mLQqQUYsrBD8HieJb02t0lJdZxHRVUou973DRXV03X3o5yw+QRzHo0dNdnR/6ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f2tJEUe2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a35b32bd055so230359366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706859719; x=1707464519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=af6Dgf/2ygFZoyY+w3zWejDc3uT/+8UdZTe+gqCbNtE=;
        b=f2tJEUe24b/pqVRCEus/DyJdkBOB9vdPR0L7RgDLC83yVYq85I9CDecbcjjGeauuEF
         d0B/FvrY3Op4Kj4vJAI1hP924A0C8biEic0E7UmTeaB//F4qzJiZJZhGY2/kztMnW2s/
         do3ic707kPOoOKhC/AyZgXN8shUY+u7p4ah5ClMaljdfFK2Yt6VM8Y1Q7x1pPyF45UE7
         h9n2GnlckwZ2wjmjC3Y8sFHqk/PKdHQSNh6UDEMZqyNtPzmQBb7s6DKRc1RUDtj38rx1
         ynvOY0yPGx0kGNVwB2Y5aq7ysyox4GPHQ0jJspMOOA/pOtYXExlpOuAyFI+sj2wUvh2G
         px8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706859719; x=1707464519;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=af6Dgf/2ygFZoyY+w3zWejDc3uT/+8UdZTe+gqCbNtE=;
        b=TGMe/GY3nTZAxN+4c20/B4WDS1eJCtSNeVTu/dFiytXv/iVMPs4CMqiMAL3RqIKhT7
         EYDK/jblifv8Da0y79lIinCk9dkTdpv/tKlvsjUO25ql15JDeRhglBJQX8Q45eQi31Mj
         6xcFocw4Rn1UiDzIOwypvdWiiz65xvDRCoFXVvMu5xS/fre7U6MWAkv0iCmuajHT+Rz0
         kNdb81If1t1vj3kXoQP7NXZFQa5ZIOVI3nspr01XI4mq3N9qaG/a4HbAoZug+4a+rbnP
         yHPryfJ6POiPgQ2ao/n8g1oU48EmzvcuMIxkrhng6ceXvsIUgwP1heWUXaFbLctzWV4m
         vHjQ==
X-Gm-Message-State: AOJu0YzLa05zt5+k9TVcxh0Wdrdmiy9VpZ1VJoLBEJ+yJqNQ89dyjI4/
	aRKo6ENG9HycNiHNh92lT6N1ibzIwSQrMGOfWI0d5h2pVaRw69opiDXZ2xUFzxw=
X-Google-Smtp-Source: AGHT+IGXC0fDTOSSby5jcEdvbKJGtgltuhsYnn+nLheB4ObClrdqHbLCIvwE1GAEQINXHtQN1JcROg==
X-Received: by 2002:a17:907:3602:b0:a35:6c2f:f0e7 with SMTP id bk2-20020a170907360200b00a356c2ff0e7mr1068856ejc.74.1706859718817;
        Thu, 01 Feb 2024 23:41:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUDHs78JOthaC5SLgscMtSK4LKGytrVzWnprFkA+BKeffKj1d417iuqF+F7AN9utEdU/Sj+UFOHMi0Ka1PZu3757y/2EqGeYM1oOK7foUlNGbmEWinOFMxRhCpW65A0L3wthsL3s7ixxv7GvVAyhH7gmD7kmx7vY8yWaQNdec59UJG+1Nsvo7TRJgb8mQ4SKJhNZ0AQNAw6YyzduuM5KbxZc0d5LPVFdmHLF3fwadryaCchrPdv+q9AizTS0e1hU5HkJJiGGN2L6bU6d84vShrSMgRmiiWPFgJob8JdyKEhLFbs81XqSGkaxOsJSNhS42/nd6AQALXQXQAcXMUrxn38EC8iWPpbYbzZpoFvo+a0Z/H4QB6iwwzQUipRM8bhJe0r2i20PZ49kYudjPjpLm21iAKdYKdqj63hz5lTfhIs8cxIYxwnECibBmcdAdpQ7nwSlOW8DCi6r642iuJO5MZmxaLdlfjdbD9PVAdXe8L6CHT6UDy2v5her/S6sSnA3RPNP4f3dYjsJtza12T5Tg17mcVNBUkwBIKPNTJ70By4mJPLDGy7y2ZCoHe8oNZDfsLNxAZbUXX8v6kZsNMZZDtCYtlmV6bwCS4oHy2oJ1IzydFIupsv9Bc=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vo7-20020a170907a80700b00a36f9941d6dsm524078ejc.112.2024.02.01.23.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 23:41:58 -0800 (PST)
Message-ID: <9933685a-5265-467e-aa39-d2c92a12edca@linaro.org>
Date: Fri, 2 Feb 2024 08:41:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v5 5/9] dt-bindings: net: add QCA807x PHY defines
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Frank Rowand <frowand.list@gmail.com>,
 Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-6-ansuelsmth@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240201151747.7524-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 16:17, Christian Marangi wrote:
> From: Robert Marko <robert.marko@sartura.hr>
> 
> Add DT bindings defined for Qualcomm QCA807x PHY series related to
> calibration and DAC settings.

Nothing from this file is used and your commit msg does not provide
rationale "why", thus it does not look like something for bindings.
Otherwise please point me which patch with *driver* uses these bindings.

> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  include/dt-bindings/net/qcom-qca807x.h | 30 ++++++++++++++++++++++++++

Use filename matching compatible, so vendor,device. No wildcards, unless
your compatible also has them.

>  1 file changed, 30 insertions(+)
>  create mode 100644 include/dt-bindings/net/qcom-qca807x.h
> 



Best regards,
Krzysztof


