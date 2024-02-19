Return-Path: <linux-kernel+bounces-70844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD56859D25
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07DBE282F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5420DC3;
	Mon, 19 Feb 2024 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tn28pYlA"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36DC1EA99
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708328328; cv=none; b=J/1eBwq7uagw/o2WrB5SiKi4Nrza//8OQH5LlWbtPGnXfprdVXEM4Mrn691G6SMLWanVYwmRBMykoab1XmKToANvdFm6zAjZab4GFPcf3jWgaK8Ne3L3lhQ2B7hL4z1F8a2r5nlZKEXNk/sJdIQa3vUyQp02jDWSIRgBHJFJiDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708328328; c=relaxed/simple;
	bh=NxiEFIBjTY1Do9kn5kKP/w0Pjgi5SqwX9YC+ZSzfghI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwpdLsvywubDxMIFQplC2leg6CaU1ps6wkaTUYZ98s+tHqOqHWWzhed65KBWNm/8UEKRRmnid9NvhMr75dyMj3nCF2FSn172AiTsZQo70+5zzd50+szCfgKqXTZC+qBZhcjKy7isHhjchIIcSdNMb10NxgNohc9E+soJiu95M60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tn28pYlA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3e550ef31cso93223966b.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708328325; x=1708933125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2UbzHAgsifZLHIRrIwdYYz80lAX1K8yNv65dXow/Z0E=;
        b=Tn28pYlAbvxHYW2fvPOm1WRbHCojeHBpz0H/deVs4UXTnh08IbMB5sIfZZuZZV7vg9
         vDXGQYvDs6y82dnbzImtyhht+ukATUUhdEKHPNNZKjz8+2X4vpSzSwoZDYSLYB7gOX/F
         zbO3DRA6E9zsd+678bfZWREgf2VI7q15kTs5dud8Gkwq3sFxnio1fPzdytE7NChdBLuU
         ryCqAUiL+8yqvh4agYkUL0muPuKfmykGDx1QXBdacSxRiLsCK6QEIegR0DZ9s4H2GimO
         FfgcyXTFYfIG71HjR4djgnyG5Ja4pNr1VK9G5Y2HvVlItrXJaubFbuAwOcJxaVfnFdXo
         PC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708328325; x=1708933125;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UbzHAgsifZLHIRrIwdYYz80lAX1K8yNv65dXow/Z0E=;
        b=wUKisHhqWdxL94S9Rywk8XIKvRCqVYOr8Mx8GE1STmlVkDa1yv0aHqX/XmtGf40Xg5
         ZXq01qjUx282dhhoS53p/40l6osqWComAkp7yqODbo2v2Nlt3JBqhsnf6Pop0MXAW/rx
         Dv+AJWblb7nQAr/YiSHSMz7JuI0pt+IculvBhyKua9/kRzrHAf+w3oMxevGfXxVVK2OA
         Qs35Ez/7u81iS9QVf4d4lvnDy4esdpS253FvLOw/cz9Hw0zSos9CbFZ0po0G86Ebo9Wj
         jvQ6sfTS/LCko6i0rnhUnsgFx6+tVkvyq26Cmt0EX4FOdzqRbH7d+SIbuMK8OQ9tAHeF
         5zHA==
X-Forwarded-Encrypted: i=1; AJvYcCUqJAbp5szeG1SFQJV3a6B4J4puINmmkoghUgL92IrDPizuOu1V2XksKnysjvmWrXWMwUD3p1ygRoOcS8QqyA3onqeazkXp3s2r5zLz
X-Gm-Message-State: AOJu0Ywe0UnuKACf4iVqaJX/pB9FjyoOzKY8EoSitpuxJCSmwHfRHd5v
	qfcOtJyBhjXBAIu7vYBHczsfIRUMopC1NfKxPynqHYl7+9Wikcs4zAvLr0eE9HA=
X-Google-Smtp-Source: AGHT+IFKq13yKKtl8d4bo7fen+xKM4HC7jliizmOlN64Kq5IgE0uttWwGfdyIGLRLU/CnfB7DBMxLA==
X-Received: by 2002:a17:907:104b:b0:a3e:979f:fd0b with SMTP id oy11-20020a170907104b00b00a3e979ffd0bmr1021993ejb.34.1708328325238;
        Sun, 18 Feb 2024 23:38:45 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ty13-20020a170907c70d00b00a3d60daaa72sm2654007ejc.41.2024.02.18.23.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 23:38:44 -0800 (PST)
Date: Mon, 19 Feb 2024 10:38:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Moritz C. Weber" <mo.c.weber@gmail.com>
Cc: florian.fainelli@broadcom.com, linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Staging: vc04_services: bcm2835-camera: Fix code
 style checks
Message-ID: <510574c4-ad26-4fc2-93c4-7b67737f8eb1@moroto.mountain>
References: <20240217211246.28882-1-mo.c.weber@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217211246.28882-1-mo.c.weber@gmail.com>

On Sat, Feb 17, 2024 at 10:12:38PM +0100, Moritz C. Weber wrote:
> Resubmit these patches to fix multiple code style checks for better readability, consistency, and to address errors indicated by Gregs patch bot
> 
> Moritz C. Weber (8):
>   Staging: vc04_services: bcm2835-camera: fix brace code style check
>   Staging: vc04_services: bcm2835-camera: fix brace code style check
>   Staging: vc04_services: bcm2835-camera: fix brace code style check
>   Staging: vc04_services: bcm2835-camera: fix brace code style check
>   Staging: vc04_services: bcm2835-camera: fix brace code style check
>   Staging: vc04_services: bcm2835-camera: fix blank line style check
>   Staging: vc04_services: bcm2835-camera: fix brace code style check
>   Staging: vc04_services: bcm2835-camera: fix brace code style check

These are automatically rejected because you sent 8 patches with the
same subject.  But really they should just be one patch.  In v1 Greg
complained that you were changing a bunch of random stuff.  It's not
clear what was going on there because it was random text and there was
no way it would compile.

Was it an AI generated patch or what one earth happened?

Anyway, that was the issue, not that you need to break up the patch line
by line and send each line as a separate patch.

regards,
dan carpenter



