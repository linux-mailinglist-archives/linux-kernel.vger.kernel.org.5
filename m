Return-Path: <linux-kernel+bounces-63050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C72852A28
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D051F284676
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C39D1774C;
	Tue, 13 Feb 2024 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3hJRt3y"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81E1225A4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809797; cv=none; b=CM463+eZNXU9KydsV6HKucik2jL2i3cCfJnEEMqWlU2S6h5F7RItLy6Nx35dXpPJhE+MMyEHmOeYrvEmxrBq8wJ6L3wplrE9RM36BOdHwHweKygNgCPJhOSO2zEl7dJsD0DzarVXWmwB5axk4Jvs58Wh4AlM4ktoRHxbk2KxxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809797; c=relaxed/simple;
	bh=utUsPfEy/QzMITjmNseVIXiTQkZm9F74xDsOkidIx6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/2iYz0Cujuj28aVQhlU/E3Ta/3VMOtMee1L2YxlGhv8FcaBV8nov9zJahAtpabLXuM4dn2Mq2wCQQFoKKCTY2eARMCxp6lVuBBy+odax5M0/UwSn7su+RtY5TtbxqGZ1697waZbkIVk+loTC96zuIht45rL1goNvXN15/CotMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U3hJRt3y; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4116650a345so9823015e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707809794; x=1708414594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qKO6w6id7IchIagMH9q3ni7wU4UnSKJ2g30c/IBubE=;
        b=U3hJRt3y0xr8ImXtIenrHV1IK+VXNBn4qqO5pSZId/do+aCJ7cvjGSo9nPYWMTUDBj
         /p0t2wP5v81wxrsQ8xM5aUKF6Q5qfWiBHR1o9O7ejjbIc5giB8wT63jhwrmK7ES9Bz2F
         v/D0TY8ioHfnr+ZBeZGmD2xett49Yj9fVexQYw2m1EFZlK76Ht17uLqcyingdYqNZ7RW
         DAD3WyeTzhIv5Yi9MWiQOe+Yh2GyWyGShZLpIEtg7BCMEeJZt8azDGHRXHCFxxYp4kEm
         /3gYLxnhatXX2apv1vVgwO2O/lXJQazw+KvFYIVsQxeRFft/6yXiQl+L25zulFqHpVcX
         sk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707809794; x=1708414594;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qKO6w6id7IchIagMH9q3ni7wU4UnSKJ2g30c/IBubE=;
        b=bDwHnzXnHJWPQzNWN6pU1p1DCdIKjEd9T6kNJMyOchWDK//jztNLOcbYephFmucOjW
         CxjJwoNCYXfITYSx6HVpHTk80KHRAvVJBZAIzrOdzmBHbt3K9SOU87J2vhNDw4/PgnlW
         wXH+w6sYgkDe5cHfh3/I4Wj+9m0zoXpZV3xzDTz/U62WgCBldAPnrRe3OqBoHTyrYOLH
         8brMoXPvekgnoJH3AYw6RsDoyJVgbxFzFC/YTnDbh4nX0sVNdFB2XXFiJTI2TdwEpay5
         KoTyWKEVtVEnL1MR45zJWEAcjmcW9rbdUnfEvfsN3xcoatvV0yv9Ce0+G37I992+XSu2
         sPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxjMSpqu3bWjI1K95pro9mWeFUW3RTlYovUik+prGkOt8/bR8KnIRBw8xQLjiOQU8enXt03YFBcoOA0pOvB1+RWLJCeIUYDo/hFMVx
X-Gm-Message-State: AOJu0YyT3wx8MWcYYzNKcPg9Dv8OeIxvkXZkMJG6H8YfGEekzK3jj9Z2
	YClCOajZVuj5CXhazmKH48+1paYJhwkJ3gmiOKtZB5SMFzqRgRZLb31kANQeITM=
X-Google-Smtp-Source: AGHT+IF5GmEHNdHwgIu9hH7ZeYF20sFP8fOT/5Qbg7HmVeORoi87obfIJFBFeiyqu+vM0n2qpQhjzQ==
X-Received: by 2002:a05:600c:a386:b0:410:bfc1:d994 with SMTP id hn6-20020a05600ca38600b00410bfc1d994mr4916531wmb.21.1707809794039;
        Mon, 12 Feb 2024 23:36:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW74wNdLQhyMEW2twzcJU2CJ2I31uAb83QnFCX9k38I30UtMTOr6Kywtm8DY0H4S/df1ZiOSSBHqDJTi8h/mb8/lo6xx1PTAC8CelXzJyfCvSH0Mj0iqD5PBGoIuyi/a/hFwd+ZEbxEHoqd21GAHJKdfno0VGishU4y0xnp3+wc3WR/sYj0RMvXxc61/FytAWwy0uLuz3TbF5uXR9+H8d2vaN83BFiy8XKc7zKUBiXRe4HEeN9Gf1uW9lK/Qdaw/NjLkAqdcWg8Jo20jtQeCmH+QbV3ohUaYy1/VI1y+OcX1vQPCumpZPrNo7Tpu8qr9yhKc/di5DTaZ/bzLEnDUe2azATDLx3kFQ0P4+odwYiz3xzjMAlhF6QEsZo=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00410709fa0d3sm10967698wmq.33.2024.02.12.23.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 23:36:33 -0800 (PST)
Message-ID: <afb4bd72-aa22-4d74-aeb8-d3875c6d07ca@linaro.org>
Date: Tue, 13 Feb 2024 08:36:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] memory: stm32-fmc2-ebi: add MP25 support
Content-Language: en-US
To: Christophe Kerello <christophe.kerello@foss.st.com>,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, devicetree@vger.kernel.org
References: <20240212174822.77734-1-christophe.kerello@foss.st.com>
 <20240212174822.77734-5-christophe.kerello@foss.st.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240212174822.77734-5-christophe.kerello@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 18:48, Christophe Kerello wrote:
> Add MP25 SOC support. RNB and NWAIT signals are differentiated.

s/SOC/SoC/
everywhere

> 

The way you split patches is a bit odd. Shall we understand that this
patch is the complete MP25 SoC support?

Best regards,
Krzysztof


