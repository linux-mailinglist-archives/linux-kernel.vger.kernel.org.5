Return-Path: <linux-kernel+bounces-89901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BC686F710
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A691F2151F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A17A146;
	Sun,  3 Mar 2024 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6nBdepE"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996252F844;
	Sun,  3 Mar 2024 20:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709498392; cv=none; b=fK4bq+v0o7STBcfAnBUs9RsalPQKVqD2COgy1B0+vE9at3WJf4OsbuX1POPxjq6d3pjr6bF0Ca2Zd3owCcWW0gRZ85lJ8voZXqCIAD/N5vHvT8l/AxsFyiGIdEHghPHytYaozsipzkj5JB/DpoPaw1nQBL44dmZPdcvStaRCVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709498392; c=relaxed/simple;
	bh=qIQL8+VpB+h3yj9pXUs2lnjY7v1plffxjJZjnfiLNpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqOX3s01KlP74kE0LggaV8nqBVV9DOQ1K3N4WbkvA9zjPCAEvruTmqtqXB4SW+Tg/WqNRJECYJLOIp2/NWChkSs/WHWdMu9g0JC8fHcKg7v0n+XUUtnWq3vkWR4Q5Z/A3Icmv+zZa6EF4STL1Mt0sUtoL2ouKj7WH53fe4X04K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6nBdepE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so13083405ad.3;
        Sun, 03 Mar 2024 12:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709498390; x=1710103190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pN/1d5DownrmIE+gLPYLU0o0qiolXNSD+oUBKdJeTmA=;
        b=P6nBdepEMFCvUAW5R/Iwir+7iqQL0X96sjpzbNFWma8ETYHK7yEeJ4luIhlJDlbAGw
         E48lvjw5JZ8n0V3uJ+ZGN5jYx/JrsMrGc5Q0WO9KgPupXI9c1I5Kl6dNiGUsDDi2dYLE
         YDsO9YtnUh40XQSWCTp+XCqABiS7VGL271WAf+4hdsg/u5LCutGAoelZJLA8yy8npWu7
         iZ4JfyLGgxp6C/JUxrR9i4B+sz+6zgEhdjdkyBJ8I815k6Iwu+7wBFSg7H2okaKsaeCq
         h+rVwA/0xUxBR2EfPq9cRdvVNkMu6tmhZTfYdKBYBkLbSV3UauhH9T1mAbVeppIrP4V0
         kC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709498390; x=1710103190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN/1d5DownrmIE+gLPYLU0o0qiolXNSD+oUBKdJeTmA=;
        b=MsBCdhrc1cX7Yc2f+TnYGyxsi8EHdIeiNwjwFkYTtxFk9EJM2rhXM3xQKXXp3o/hpj
         eq755TA0bIEYiGRCgLN/Z7J+OrcRwVScYJHnPdP+6y6rHwheFONgAxwFyPoGw76DKsAa
         s7W6NjaN0R55Ao4Ro7dFVuvwEVX9RO5J95CgZbhHCmWX36Oi6Opx6KHAZEgJ2dCap6Yu
         PisbjI8ovSiqI0vYqXm0RddW4fZw8v7Og0DvxD1q1fhsNHjoVACgDmZzo7mTKlvUE8vK
         qiPqh2cimAXG78HuaS8smSyiVNOCD63F9gytlijmA99SnRtAuisPLCdFy57uaDNaiiyq
         +aDg==
X-Forwarded-Encrypted: i=1; AJvYcCXXrDFLT2isavfpTHJznqoQEjbblM8/1AY0sjNSMC7MmTYvaZ6515cXotN8mqZSWh+gR5bk7P6rqiaXxLmksKBhBTT22mbZnZkcT5zXHWEnojIitMLlEeDH6nlb2F8IjiUEx4/p3lRoZfPxX7sDLu5roRyQeAx+3yYyDj2+BRzDB0kO7rt9Dn6n9OZ5AJsAXFPDyEFWtPjMJRYhHXc4wLef+dg=
X-Gm-Message-State: AOJu0YzUxXPC3X0PdKjaYmh3HQXIGtK1/igN+CWP5Ar1ZMuLa0y9Qa+M
	rbhJyqRQZKnnpfeF81Y8IAiUvB7VxcT8840PdZlv2KujvKPI/rSJ
X-Google-Smtp-Source: AGHT+IEUV9hlQRuEcCV5Vs+s/sYjvcr0+9tzbHPb+jztvGvubCPbZiSoT0oYiFZ5vEHR+76Hwqrzjw==
X-Received: by 2002:a17:902:c951:b0:1db:c6ff:6648 with SMTP id i17-20020a170902c95100b001dbc6ff6648mr7297610pla.10.1709498389642;
        Sun, 03 Mar 2024 12:39:49 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:2474:84ad:2e03:cad8])
        by smtp.gmail.com with ESMTPSA id t14-20020a170902e84e00b001dbc3f2e7e8sm7029810plg.98.2024.03.03.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 12:39:49 -0800 (PST)
Date: Sun, 3 Mar 2024 12:39:46 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Karel Balej <karelb@gimli.ms.mff.cuni.cz>
Cc: Karel Balej <balejk@matfyz.cz>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RFC PATCH v3 4/5] input: add onkey driver for Marvell 88PM886
 PMIC
Message-ID: <ZeTgEmjJc_VhYpLm@google.com>
References: <20240303101506.4187-1-karelb@gimli.ms.mff.cuni.cz>
 <20240303101506.4187-5-karelb@gimli.ms.mff.cuni.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303101506.4187-5-karelb@gimli.ms.mff.cuni.cz>

Hi Karel,

On Sun, Mar 03, 2024 at 11:04:25AM +0100, Karel Balej wrote:
> From: Karel Balej <balejk@matfyz.cz>
> 
> Marvell 88PM886 PMIC provides onkey among other things. Add client
> driver to handle it. The driver currently only provides a basic support
> omitting additional functions found in the vendor version, such as long
> onkey and GPIO integration.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
> 
> Notes:
>     RFC v3:
>     - Drop wakeup-source.
>     RFC v2:
>     - Address Dmitry's feedback:
>       - Sort includes alphabetically.
>       - Drop onkey->irq.
>       - ret -> err in irq_handler and no initialization.
>       - Break long lines and other formatting.
>       - Do not clobber platform_get_irq error.
>       - Do not set device parent manually.
>       - Use input_set_capability.
>       - Use the wakeup-source DT property.
>       - Drop of_match_table.

I only said that you should not be using of_match_ptr(), but you still
need to have of_match_table set and have MODULE_DEVICE_TABLE() for the
proper module loading support.

With that fixed:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

