Return-Path: <linux-kernel+bounces-167867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA18BB088
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC30B20DB2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2E015533F;
	Fri,  3 May 2024 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDTjATPd"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145F15531C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752322; cv=none; b=iSEC0/K0O6ix5ru+aoiPuegRD1mk7e89yhlld4B0q1/uui1WQ8C2jVqx//9K/5wOC4yx1BnO2pfd2EW8bh11/Kb3gSRoTgXYZpEIcKbnkvTmOvTEwLNMJoCMAQ7iETIB+5nhQqf1T6LZrpYrAmAd3lW1o/30/j+My8iAAX036ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752322; c=relaxed/simple;
	bh=3wFRUkRUjz1omlOVSbpuUBuHXpaaRaKV8kxfe/9Pw0Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YrFbMP6j3ZnNBgXc8IXKVyWHeJNqWKAaEJ+kXs6NfHY0TJdbiMN1vVG6feoFekuPJwwe7Ny3bIaKPIKD/eMiv4YNQQsfKLHBUaluxdaLm60jzdIb3QfAXQ6eoLE7ra9zzDCgagBA9d60SUqBpvezybnkEZ02WT2Bqae2Ghtu0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QDTjATPd; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so119132581fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714752319; x=1715357119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pI3kz89fWVHdo2YRBeHbPpve2YagNXI7R+KDETZ+WU0=;
        b=QDTjATPdtx9v1JKBtVPN1D6W5McMeV9jR49BSTRYsiXUOPaC7ov+eJ/l3tVAsTsDgs
         kk3n8GEN9/7DnRX+VXTWq7WdJm6b5KrK3/5Z4UHXbPWzrEAjqlJ9eJdD40FPJZ0wPAn8
         TqWyJHpEMgj0RMky2h1EV1y39VM+RpzhOTUJfM8litHbmMxD4LeSjEjR/RoufHAF42va
         bue5iLkreU1uF2sIQ5DUX0odscYOX9E4OI6297Zi8BIXOCIuioKD67i3WWEzofUSJCMX
         vQCCxYY8amQApgtXGJpV7+hKR1l9FhDjfSZN04F6lvO0gh6EbQJjEg7rVDkMNt4iDwsE
         gGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714752319; x=1715357119;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pI3kz89fWVHdo2YRBeHbPpve2YagNXI7R+KDETZ+WU0=;
        b=hFzDBZFw3HU4wYrV42RVp0mgybEFT8VlMEJc8eUmL0P7OIU7SmGNuBBfj35AhaV4jU
         ynqgYGKnCJ3cXG38sD3qNW6sbd2a7N7rw19T9cXiwHTcwp4KSdrTTxIvVlR0+OhJ4yOP
         BXGo/S04GEbGzFXbU4Xqok1CTPUL4IVfjLF0CRD7gy4AKl7D8kv793O1xSS/SyNBbi8e
         aK2Ig5/o1MP4eCVj+fqMpM4fSORaxKC88E61i0cpSJ9otUjtsCo7dsYBGbPBfNbHfoBt
         3irowZjGhpr1rLC8kDbhM7fo20fKazN8Rz94j7vZujEQZW6hYLavSFEtZP9PDccU8D0X
         ktSA==
X-Forwarded-Encrypted: i=1; AJvYcCVTtupB2mGeFpKhgyBmgbIwGiIb/IqvqLOcL+Qt3gPzTZzVFeWcHepM7K9nmVoe69umqF6n7rF/3UDjX/o4Z42am8oFkQtSobQocQmh
X-Gm-Message-State: AOJu0YzSrg2TvqqhSBZqS/ClSeHfs3PnH9cggquCEIAjgAhvhMs1f1/O
	QCd4r8wHgVq9lDRRyzQLox7FJX5t8+vEA3LahZraH8RqY5o4lcXCAfNpvyEvn/I=
X-Google-Smtp-Source: AGHT+IGMuClGgxOf4NU45iXsc7aEDak8j/FRo9Y1ShE3foPvO6nSSlPTV5cbk0Bwn5yFvjbMBqjQUg==
X-Received: by 2002:a2e:bba2:0:b0:2e1:f199:3853 with SMTP id y34-20020a2ebba2000000b002e1f1993853mr1743575lje.47.1714752319488;
        Fri, 03 May 2024 09:05:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b00419f419236fsm6089474wmb.41.2024.05.03.09.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 09:05:18 -0700 (PDT)
Message-ID: <13ed1865-d702-47b6-b186-d5f060103280@linaro.org>
Date: Fri, 3 May 2024 18:05:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] dt-bindings: clock: mobileye,eyeq5-clk: drop
 bindings
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lee Jones <lee@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20240503-mbly-olb-v2-0-95ce5a1e18fe@bootlin.com>
 <20240503-mbly-olb-v2-1-95ce5a1e18fe@bootlin.com>
 <ee278102-f4b8-4ca0-879e-f83cd54efbd0@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ee278102-f4b8-4ca0-879e-f83cd54efbd0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/05/2024 17:57, Krzysztof Kozlowski wrote:
> On 03/05/2024 16:20, Théo Lebrun wrote:
>> Switch from sub-nodes in system-controller for each functionality to a
>> single node representing the entire OLB instance. dt-bindings is
>> unnecessary and soc/mobileye/mobileye,eyeq5-olb.yaml will inherit all
>> properties.
> 
> Why changing this? You just added these bindings not so long time ago...
> This is very confusing to push bindings and then immediately ask to
> remove them.

One more point - anyway this should be revert with clear explanation WHY
you are reverting bindings.

Same for second patch.

Best regards,
Krzysztof


