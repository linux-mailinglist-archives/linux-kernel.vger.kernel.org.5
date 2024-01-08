Return-Path: <linux-kernel+bounces-19705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A5182713D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A2EB22133
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5348E46B80;
	Mon,  8 Jan 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxAv++Am"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACEF46450
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-67f91d48863so16487706d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704723957; x=1705328757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9atKNkCY7lxaNFN54oiB03vJ0WvAQsiMxxbA3uOpJJo=;
        b=HxAv++AmFbl0uOddkisZqolW49+5/sYZDmLWn55JNbPR0+0BLwAvulL5LOLtXtDYtI
         ekgeHSgkn1R233Ht51bVb+yyaVPz+mCOvghU9jU7pNrABUDI/EDExdt6wub3q0D5N9zX
         Hab6FgMqgj+wpjAwT6kdhsHlsvU4N+JKrpqFC61rjLGFg0axJjgcwCL6oSENCElubm+h
         7dJEOvlaRHLLRYn48uO69/Heg/+PwbotxuxrD7Ape5MbtAihozkhxmLZC2Tw8ZNaykbQ
         CWFVO1BTWbqt9e37D3PSpOG7izWTQFvacx1LHyDFyHr3+aIhOYZpTQf7PJu1MNWO9oHv
         qowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723957; x=1705328757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9atKNkCY7lxaNFN54oiB03vJ0WvAQsiMxxbA3uOpJJo=;
        b=rYghiE4uwibETsHf3lYreQisnvLiX9GxNxbpmOSDcIZorlx71VtK0LNR2tKhvwQrHN
         h8bsd7kVYUfyPhfbfhw8MJ/mebhOw9d5tg6RW3tV8povdSB9oV1gSXi4POahqLyLMq9u
         y2iTOOQ9bDhLAbMM/uppm7ST4IG8SVvVU6i0os6krZLN28EsXYh7F/RqihPhgZJo1SuZ
         +xm2lDn4BV7p/1QvLf8/4F5dv0FmB9YKiyqyDzHmFwcLluHLc4BmLVi/9EtqZaGyX6jU
         VpnB8jXm+yyQqN8BCdDtbdCRtSUPJR+Ggb11w8x7oAOixsgq1lahIgm4lZiz4VNehcX3
         eUhg==
X-Gm-Message-State: AOJu0Yygtyr8GxV0wv6Jym2FA59lrzw6AmDbi8cdDU6DsM/tz42ffmfs
	nZX4746XOiC4szl0jildkf07l24xdpeiJVz0AXbv5oqyPHqjeg==
X-Google-Smtp-Source: AGHT+IGYBiojUjS9fJ10IBb9JbhjqsBHMSGrip1FcvfI6xmIy5S39asxIjjlSyHXTw4klyjrfzRzcW7TpJi92WQvvuI=
X-Received: by 2002:a05:6214:2683:b0:681:212:f9a9 with SMTP id
 gm3-20020a056214268300b006810212f9a9mr3329090qvb.34.1704723957739; Mon, 08
 Jan 2024 06:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228125805.661725-1-tudor.ambarus@linaro.org> <20231228125805.661725-4-tudor.ambarus@linaro.org>
In-Reply-To: <20231228125805.661725-4-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 8 Jan 2024 14:25:46 +0000
Message-ID: <CADrjBPrpooS=8WERcQ8zUJ=tDXtWncPpyxQL2ov4PEqQ0wmwYQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] dt-bindings: serial: samsung: do not allow
 reg-io-width for gs101
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org, 
	andi.shyti@kernel.org, alim.akhtar@samsung.com, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, kernel-team@android.com, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Tudor,

On Thu, 28 Dec 2023 at 12:58, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> All gs101 serial ports are restricted to 32-bit register accesses.
> This requirement will be inferred from the compatible. Do not allow
> the reg-io-width property for the google,gs101-uart compatible.
>
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

