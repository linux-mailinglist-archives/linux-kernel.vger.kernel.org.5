Return-Path: <linux-kernel+bounces-136676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED2A89D6FC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE58E284092
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C20681729;
	Tue,  9 Apr 2024 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtNGWNRz"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA380BF0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658600; cv=none; b=e7bHBxBQTRdIJbF/XI7XcvyR6v5k/DcItIdXXWk/ek8r4LFZbcc1Z0lHbBywlr8WqRpOTkdy7h04I2lOOlNf7Xa0sSVGoPiE9xui9TwscNhu1pZWayBgBxU46OZlMRXlZlUcFBDfo+jJSs71Eqjxm/exPJJi8kvOonWXwuwGzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658600; c=relaxed/simple;
	bh=1pJc8FYsL2hW347cawkDvUVa3vHO/1Plz4SprVr1CaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVuchte9hNni+ZwPps5OutSggXYc/G5g8GAoI18RY8fQFopbbjKDQO48AgiosFUFuywdcGxyi5BI58WMDHGsj4JhOzuo40XhzvUyxVWdagFd64I8y92ruiVvflfPTIuwm0VfUWGWTOhV9aJkAA0nYr4XeMYNeMP/1IM37NhO8Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtNGWNRz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343e096965bso2791266f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712658597; x=1713263397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QSaOGp9c1dDH8MD3uHu5DGg+gsqr466YacODisop3PM=;
        b=gtNGWNRzhQZXxcFd+Pa2u8NxTC2L01Kqz9DwdWHwQqw0AbSLKByYuX6t/5NI4NbPBf
         qjns82B9hewhKz16mWCkhkNb7Y/aqww7djt+gm0Rv6K6PsPmvKAy9NRzXjHjihi57/w0
         /fIVM7hWMe6Itd2pc/1xdahi3TZao2h8DbcgPhu9kdknR/XPg06EJ9xCrIgJ9SVvH9+Y
         WGddwKIbjZaghWHJ1xdWv17OHws6X4WTZBUFejkaLNYil/IuygGSuaWxe3B67M6vG/cd
         0sqV+bn0oR4v+mXqWNaWD7atdbbcBUZLow/QCaivb1FPBY0SVnu8QS24S2jT6BNN3VJt
         g5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712658597; x=1713263397;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSaOGp9c1dDH8MD3uHu5DGg+gsqr466YacODisop3PM=;
        b=Rc5ZgbJP6lZXJFwmqVRQD7OeC4b1+DgvWFE4cregEcfv/3so+b/XvwrnfjrgKxgDWa
         DtitdmvSCsf1fYkx8aU9wIaTCN0BnTdSE4Td5BEt//QzVTg5lpnhUCo0qqw+lBQOOZzE
         ZLV0GidIZgN6yArtu+5+6Rs35ZEsnhijFx79eAsYJCU/sWaGXd7f1JlEwaEXJsDrFYsv
         i7hFI5COD4wucU8+UbwxOlfi+uuFLHyYWuYaNj91uE+8ZiRSKDOGM/bqblN/5xdJp+qg
         fUMC2BBS+yIsmqAX7rzgiMfxU2kDaVF6sKOlCj6mV5Yt66pVTOE+nwQrxfXGzRCvtvXm
         IV1w==
X-Forwarded-Encrypted: i=1; AJvYcCVJjD/9/zgz6cFHKZc54elzYsyneBL7rpUXabUK//uVBw5gHdWkFjJCL86iQL4WNTdYow6XcFGcZzG8TbNlWDBGRvwPwYKHT3nXPmh1
X-Gm-Message-State: AOJu0YyZsYmp+Vw9nnI9BhxNO2pt7YcA7trZjZs+n4td77b/CpVTzjUl
	ZxunizclUUuWG4lc2eIxc/13+qMSe4tWVfzlb8/V1L6bOLSCqJatqO0u0N48nmk=
X-Google-Smtp-Source: AGHT+IF6pICYLqGObByyD6xPdMloA7SGXRa1XZu+UqpcCU9vqr92vyZZRlIqk9ZNqIWcvdafgOaaBg==
X-Received: by 2002:adf:f4cf:0:b0:343:9230:e079 with SMTP id h15-20020adff4cf000000b003439230e079mr7994478wrp.71.1712658597457;
        Tue, 09 Apr 2024 03:29:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d490f000000b003439b45ca08sm11071794wrq.17.2024.04.09.03.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 03:29:56 -0700 (PDT)
Message-ID: <3a2da499-be65-4b42-9e25-3b25daeca53d@linaro.org>
Date: Tue, 9 Apr 2024 12:29:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: clock: rockchip: add USB480M_PHY mux
To: Sascha Hauer <s.hauer@pengutronix.de>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20240405-clk-rk3568-usb480m-phy-mux-v1-0-6c89de20a6ff@pengutronix.de>
 <20240405-clk-rk3568-usb480m-phy-mux-v1-1-6c89de20a6ff@pengutronix.de>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240405-clk-rk3568-usb480m-phy-mux-v1-1-6c89de20a6ff@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 09:38, Sascha Hauer wrote:
> The USB480M clock can source from a MUX that selects the clock to come
> from either of the USB-phy internal 480MHz PLLs. These clocks are
> provided by the USB phy driver. This adds the define for it.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  include/dt-bindings/clock/rk3568-cru.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


