Return-Path: <linux-kernel+bounces-51842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB57848FE7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 19:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3541F21203
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD0B24A12;
	Sun,  4 Feb 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgvtXjWe"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368CE249FC;
	Sun,  4 Feb 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707071167; cv=none; b=dsH8YhJhcQw6NXreEPeuEQBjokaYjpC9piLWDEAjbxfbnWdXEkphgMWUfT4XoG0UsqHmYycnvc21MysmjUw5gjeJLbNq6kdSgp1vdIzMrRsKmyg8FJvZmFU/KzDF7eyRQKHHkNKJtPnyhMSmq9MNa3Iqxc5n/2tgHSxcN2QTTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707071167; c=relaxed/simple;
	bh=+n8izHAXFZnrqFbFS1Sh0sU58lVPwd9ZgLBu35KlaLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1qPB5yu1HVh2drDjLVCdXaJ/6Jlmao7n/JbmZzkiT1Wfs9y6aZEuawNnutcDZdEQaEIeUdOztAfwgspzNa3+Am0++/Hd/axqEoeMQemNL0J1Hc6mjgDBPZf4OD2PEjfIfpI5E3aWrvK1/AqkCNuSqC+xJc67ZoMc8GCDkQL0jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgvtXjWe; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-511234430a4so6396783e87.3;
        Sun, 04 Feb 2024 10:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707071164; x=1707675964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+n8izHAXFZnrqFbFS1Sh0sU58lVPwd9ZgLBu35KlaLc=;
        b=EgvtXjWeOCeeoYB8GbAh2uadc80h3uFsJBKvKMyTgXdP01cgAPVp6VN7Aelifoixfd
         XHvNxZhAIXsCULjZC/7sGOt/FgLIFQ/wExFwxp8lIxKNDC+pi6mNk+RsTX+FK1A0F3RY
         oDGC1ZqlA5Y0mOFDjm1kGtMKfxg4eMBmbGHrRPaqrSBAEUsM0NHKy32EFFKEsS4IEv/2
         4PsNeLb9lbuMah66F8JajXBQBLEQTrJbBxqt1h12Ro9LBykEWhAonf+R4F/Tmdog0QXE
         Awciu4bM9AOWLZ0YRY/6Qcoj7bBYdf6QBZjkBm6xEMOJG7+LWtCKEDI1wsD1pNL7q5DU
         Y0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707071164; x=1707675964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n8izHAXFZnrqFbFS1Sh0sU58lVPwd9ZgLBu35KlaLc=;
        b=DkrWjNtkFQKkvGUU9bW9IkBYHDkxGiffwiLTD3ADOutMBeF68/t7JXDnATZ3TJu1tG
         qLphEMkVPt+pl0tRKBPNYgQjyITSjkEzHeXsljF6v6LapNlTxUbyM7wxqO4qXqFUB6Uo
         /4+nPx39JDa5azh7mugFYQQfMP38g3UL+nVOCxqTijy+z5cty/oQWKDEgcPFkA5caC2z
         wg03R9sEu7w7Uox2sSNfHv+7dRXBGFKm3rTqPRsK+tCmcV6MCe4hDGVuOcgr8wDUZKvp
         qbwkFaU+m7ohRUVRFqaNIo3aPUYE9Xr8ZBbjbOqoOpy1RcVfAcXnpOktkCFM2Qz2iHVt
         UpoA==
X-Gm-Message-State: AOJu0Yw/STuFjeyYVurKE/yP7fev4Oeg2JLdrTned02+2vITXahaRd+1
	azdSE5PkALry7E4lkA5r/hqbYgPJ6MiTVgYjv5/x/agFDdTWkYD9
X-Google-Smtp-Source: AGHT+IHXiOYVa+aebZfnQZzsZ9tHi25lPw6wdexQX3EMzWUbYrtM5XMzcMS6pO27Aq/nODDQyLorGg==
X-Received: by 2002:a05:6512:2803:b0:511:3a13:158 with SMTP id cf3-20020a056512280300b005113a130158mr4415609lfb.35.1707071163944;
        Sun, 04 Feb 2024 10:26:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVoKLsxIgvJ+jO44uqoxB837qt79V1rtSbvkTNqlcsCS/JQmAUePP9JXr/LM7uSQ+jgG+jQg3FhruuwfKetYF8zsxn0hcSKdhYEy3eSQRwykOSQIxXHMuFAZ2Ns//RWTSydbXVTpg6cUPsYDQzIwGc4WHSh6J6n+G/vlA==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id vu11-20020a170907a64b00b00a37a38737d5sm654687ejc.89.2024.02.04.10.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 10:26:03 -0800 (PST)
Date: Sun, 4 Feb 2024 20:26:01 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: andy.shevchenko@gmail.com
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Minjie Du <duminjie@vivo.com>
Subject: Re: [PATCH v1 1/1] spi: fsl-dspi: Unify error messaging in
 dspi_request_dma()
Message-ID: <20240204182601.kg2hwc7heo4l42si@skbuf>
References: <20240204162106.1179621-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204162106.1179621-1-andy.shevchenko@gmail.com>

On Sun, Feb 04, 2024 at 06:21:06PM +0200, andy.shevchenko@gmail.com wrote:
> Use `ret = dev_err_probe(...);` pattern for all messages in dspi_request_dma()
> for the sake of uniforming them. While at it, fix indentation issue reported
> by Vladimir Oltean.

"making them uniform" sounds better than "uniforming them".

