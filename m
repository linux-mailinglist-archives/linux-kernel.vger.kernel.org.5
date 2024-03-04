Return-Path: <linux-kernel+bounces-90481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F67586FFD4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2CC1C2237F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C6938FBC;
	Mon,  4 Mar 2024 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpCHFWAc"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665183AC26
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550518; cv=none; b=W02YMEEhplUHYHhTJ6537UL3JD8h7a+N0M4TqPc1p9ekVBUspZqlB8EPWbCgT/6wpUivWzx7cj2EifgIWS3fD7u5VY5TZXQXJOJhyyXD4CEhgQwnwT6bHjMoPIXxax3UzCAXmjBIqQJyx8Ccbki686QjsmDFj+64Mfr9kaShA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550518; c=relaxed/simple;
	bh=J8QRT14PUSYYy03uk34X/ZoBf4XH47r3nKBEcmsMw+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgv1KSBVDCR8Knj122I4DKnNDZ/CRVYUikZFCk4IICwNWAuVm2Gzrz5a6d4vn60KOt/yZMATdqhBJ4e/NxgV+m4/RGCOgOScrccoixXNHP5iHTXvHxicA6ZZXSs36UVIwIr5dWoBSTV7PsKpcHoqzNiJ5JA0KesQTG0K74HmmTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QpCHFWAc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e1207bba1so3477543f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 03:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709550515; x=1710155315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8QRT14PUSYYy03uk34X/ZoBf4XH47r3nKBEcmsMw+Q=;
        b=QpCHFWAcdkI19m5G5tOzbJ3x9HmLEVLjsi0QPJvVtC7fQLG1EB949j73nYX8DniMzl
         n0WmnDKEZRkfUIPY2sX8i0ywd4Z9O3wPfuMyC5HoipsvPH0bOY0lgDCdcWz5jSc+Aa8U
         rFw9GaHB9X0eFeGs4CtJ7rgVv+vqBXnxYxHnJZtXOMYSi0eSwv9leeyrxY1M+I52of9j
         uKSFZb57rpzopLO1OuFDSQfkNPBn0ZTAkxbjDgbg8vvj1fWPhXp9ocEKgI0UROrTXIvI
         AHbtsaZW0x/6v2t7GLeM0vC9DL6AfKI5H3nqd79Q1RCm2JGi3agN7V9AjGixc1M7JO62
         3Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550515; x=1710155315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8QRT14PUSYYy03uk34X/ZoBf4XH47r3nKBEcmsMw+Q=;
        b=kCOvHD0UbmY6xRLAKUO6VCY8WX8UXkzsOYgXnHAecfl8ujBj0AEg0/KsTsD+HZUqMg
         AZknNt1yFJ/RWJeKkAcDondN8bWy6lq04KshN3USbvFzSUhYOfUuCQunlysaTNOpzfaX
         dEobTfIYa6EfTtVBoVCHuj/O//uId5Xk4k/J7kCulLRbifi5rzv8u0m2Mdsinv2WDWR9
         9jHAmtaoJgxMEHkyhjUGdKQnofmLkd7q+ozluqod4wWhC0ggNf5zpPc3BeMA3Ac9I4ZQ
         3VXPCPW8d5xI6VaECpC5D8jZ3L7FgkQhJWabMmpjKLJADFoH5eAUn5/uH/rxrtCm2H86
         JGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJvWzzLYjWgwlnbTFQpx60m6v2jVLuHby9HdRd1JGRza+AQKCJmIbOGiwKNJrTu2LQBhfHRNe8QBUwM5m+CnsSOd+APxs0C0Edncbo
X-Gm-Message-State: AOJu0Yx9XmX0tUNwr6TCIgACFrJYKEk9t4pCQt14tp61Pao+DJoMSQEZ
	CExpW65bgZDZxfx074s2MzQCpiSJ/kAutk3y0DGiiaSaRVdQPczp7zWFu3BSRdY=
X-Google-Smtp-Source: AGHT+IHM96X7a2A8hQD7HFP/kAS8dWVSqvNaJeysD5QyLGeU4kUUmWcLPlRWWkxANifuMKzE4sEu1g==
X-Received: by 2002:a05:6000:124f:b0:33b:5725:e516 with SMTP id j15-20020a056000124f00b0033b5725e516mr5363029wrx.51.1709550514754;
        Mon, 04 Mar 2024 03:08:34 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d53d0000000b0033de10c9efcsm11932573wrw.114.2024.03.04.03.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:08:34 -0800 (PST)
Date: Mon, 4 Mar 2024 11:08:32 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] backlight: pandora_bl: Drop unneeded ENOMEM error
 message
Message-ID: <20240304110832.GG102563@aspen.lan>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
 <20240304-backlight-probe-v1-7-e5f57d0df6e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-backlight-probe-v1-7-e5f57d0df6e6@linaro.org>

On Mon, Mar 04, 2024 at 11:11:44AM +0100, Krzysztof Kozlowski wrote:
> Core code already prints detailed information about failure of memory
> allocation.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

