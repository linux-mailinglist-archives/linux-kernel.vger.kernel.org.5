Return-Path: <linux-kernel+bounces-35767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128FD839638
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF84C28DB5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95437FBB2;
	Tue, 23 Jan 2024 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3K7qBiv"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8805A7FBC5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030464; cv=none; b=bJb0RpqfTxZ/lr18TqqP33m4YqkpBDpDoWTgmYo+P/oExja+90/yaavJz/xPPqd9kvKxL3fPONTmDG92nnEJ1+5j4RYJf4OVvRYT6IwA5IU2bpoU+dNIYEzgjBGnjJ094iakjiGACBUYxrGUg61toRiERm9mdzkIzfMvWnk7dtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030464; c=relaxed/simple;
	bh=pHYOkrk7p0+vmd6Q8AhuzGmsx8q6iJdxMRVdgXKdwN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFmEv0YWgQzlVJZYG06TaVA/U9WdcdFglMNOKHQX7ZyUdIVLXeaev0RJTHgo8y2SrrKLP4fnhkMB/o0DRWXfMOtRuWvN7MObEB50Mcugmj9o0uiNKED8yOPI81/iyHHya32IvKQW3qZe0iwY/XKb+AB0W0UdKa7wv5OZ75s4xgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E3K7qBiv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e80046264so58075995e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706030461; x=1706635261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pHYOkrk7p0+vmd6Q8AhuzGmsx8q6iJdxMRVdgXKdwN0=;
        b=E3K7qBiv4x+ObdT03x/hX9OlNz1PUqpyA9vv7mRAIlNcbH+f06CUVwI8miGZ2AaiYB
         H6xJjyGoHu/fO3qVt5b2OaaL2XXRKKC06whiPQ/wj+4QyeIHXLzLj6q9Lul487ZBTgHu
         /lzX1lJWTP4XwXZEq8Q9J92tVRnly3WG/5sGR7yWGVjLrli+MFANVZgdlaCXHsLfgCYE
         O9WQVE3cFpjKQTSPVfN2aAHV+xgAwA5RM6ZppSwXToY02mwet9XhTB4uCdqOXxFTvB3G
         2K8IAVCbvjLwyUza/QdovKTjlBtosCxPCSENqwR1wTJGQ1cPUv4Vd1l6R0kJA286xh0Q
         anKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706030461; x=1706635261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHYOkrk7p0+vmd6Q8AhuzGmsx8q6iJdxMRVdgXKdwN0=;
        b=XOSYAJgczknEtKSuf2w5BefKMh4NsGsv1a2aRNXhGt8t/Y4T4Ev3TeShaCo64Pxqau
         r2HpzCAwGGDog+2/Omrkj5J2lFpyGzmKSBMoQzG9OuVkxf+3M6awi1bveJtlRsup4tQ1
         wNZ3toFlFMt9m5NbI/n/53/5e1XXYribtdw0qV9Wp2fIxUcu2jHbTYHYg/8VsrVUO5IC
         g/0ka92i+vb7GmbM6lZ6JPa6behVxMgVkIpA/e0IxMqtFuisvBs+4TbgFCuE/HbHxqrB
         Lwv2QFhvaalqCeXMEZ0PROkAvZMYBVegU+5M2bP1UTQJEYf033HDa+TaeqAokCvt8atg
         a4Ug==
X-Gm-Message-State: AOJu0YwzbotRePeaUT2hce4cmaMjdxOgwDx+ZSFdcxWIjzmGH3Qgw6Pz
	WbGfgxciOBrrpJg7Pe7w+DR5PJZ2OKiRC7WC1ZAXGNIxGx8n/H7CjrF9qK/zKKM=
X-Google-Smtp-Source: AGHT+IFYxEMGAchUt1W+s236kq5ZJsRP++aWZYwhc00KUVO1+MAAo2pe7nmIdLdtu4Jj4EfweoOMzQ==
X-Received: by 2002:a05:600c:18a5:b0:40e:9512:5056 with SMTP id x37-20020a05600c18a500b0040e95125056mr368796wmp.61.1706030460793;
        Tue, 23 Jan 2024 09:21:00 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b0040e541ddcb1sm43283295wms.33.2024.01.23.09.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:21:00 -0800 (PST)
Date: Tue, 23 Jan 2024 17:20:58 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Karel Balej <balejk@matfyz.cz>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: backlight: add Kinetic KTD2801
 binding
Message-ID: <20240123172058.GB263554@aspen.lan>
References: <20240122-ktd2801-v4-0-33c986a3eb68@skole.hr>
 <20240122-ktd2801-v4-2-33c986a3eb68@skole.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122-ktd2801-v4-2-33c986a3eb68@skole.hr>

On Mon, Jan 22, 2024 at 08:50:58PM +0100, Duje Mihanović wrote:
> KTD2801 is a LED backlight driver IC found in samsung,coreprimevelte.
> The brightness can be set using PWM or the ExpressWire protocol. Add
> a DT binding for the KTD2801.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

