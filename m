Return-Path: <linux-kernel+bounces-59107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B2884F14A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D72CE1F254C3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971F365BD1;
	Fri,  9 Feb 2024 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8ipTaVO"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E683657BD;
	Fri,  9 Feb 2024 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466628; cv=none; b=DoprDiARviIjw+bs+9+ORFkp1TK3mpmAVVnLhskz0YN3WxFktBPyb3W5aYOqbxW9zD0xT0fQybC1JZgwC/rdPs63qEK9TAEiMUqRP7frSnqvqA9nTO1kp/toptTGm0Uj6JMIV4y1mTabv4EXoWVAV0IzXX6ymJYtsSK+EgsUI1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466628; c=relaxed/simple;
	bh=DJk8nWfmNdqYgyoDiET2ResGJr3KZep88Uorei5tDck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu64V/pw26t7Af5mIpoLhJpyxbXm0nNI3l68Suy/lQw81NJHpGHofcWgXLc1j+ZY7khXslCsXO/Gm1+VRzNZUd4kY6gezPTTSrUU8ye/66HbTQ7iKtzOQnkAOSUgCxunrlwMNMuarG56TQHiilV7jeb2ljD307KXDTZ8T8g2+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8ipTaVO; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so817440e87.0;
        Fri, 09 Feb 2024 00:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707466625; x=1708071425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLUirxFPsHPW9hscrOBFCmuXkv8z0rDHB6+aFX4HQSU=;
        b=M8ipTaVORfAsfV2lq2nOliRZUO6Arawc3r4hagC2ygzwRjNX8xTcaoKOiEKtVpfM3G
         E3T2pqo2YqBO0LD2HalszJGwaTZ0EQMpIv+kzd1mxuZB5m6iY7LfoGLCoSDUWb6z5Vq9
         afM/W1DmDgfevHHOdl4SrTA2ecQ96PSWFpz0hPL7A4YUFUvgzjn21P8y3udKwTlxnRSf
         AK0oI2tVais3adO2jZwjkCGsSueNIq+1x5wp0mGtFgXshXkWntlj0js99MRwsRx4hsGU
         fZL31KSXnXpFiLPwSkAlQn5hcsLwD6kYjs9RGfMkjgGp4Waa0dTIJ3SNkJiV/aH/Teh8
         LwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707466625; x=1708071425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLUirxFPsHPW9hscrOBFCmuXkv8z0rDHB6+aFX4HQSU=;
        b=a1EITytP60y6wmYK0llMJ6w1qOCVon7VnYfiWbZsxL3zjL2iwGgfzQZ0R41FR9CoYK
         4rlJ616zZsAPhFnQgxqBUMKj1Gd9WM31YrEUaTwKSPaBIfW9qd4olSiMCbosRXAva6jH
         N2n0HINo3+3ORuXCr3FmPhNja8d5BU3asHx6ytaxbFToBmmi7m6tq0biTr3LCD0j5go9
         QlZ9tuDRDfkjgFktPPWA3MS6QICdcYtOg83TxHURkwWKbbfCDuVY+fvAAAXtiMMeqFux
         lzRIW1zNYSHQ7yMgcBsY68j80Osfz0qDpEOkBeCWGRS19kSjDJI+p2WI2rvPlRgn5mjf
         kawg==
X-Forwarded-Encrypted: i=1; AJvYcCXNNW5hJtou/vPdRTg8+vq5AbYpMz+anefB9wuZppt0t/3ILSYtRo0ltQLXdV6RTLlnsWyJrP8ToB0f/zjiH4A9gyiyqD5+Q42DBlaroyWnOPX3Z84fYSkyGASDPuPAbdu2j6aBftlhGn8IuQa6XyeC7tF6fYXy6bIbda5nSszqzB05gA==
X-Gm-Message-State: AOJu0YyiiDh/REtw1nXz5ekTmGPHHjD17doackY07rwox5gXkdOZ0Sqn
	B29l8wtvtLFhPDlpmWCeCXDGazeQi4+vci8cFYk0viDSrsiASXR2
X-Google-Smtp-Source: AGHT+IGeBLWgHvJnWv+9Dg9MBZIJUScafbIJ6KqHkxt9rC2F7wEvNEfUxizUoRGxMq7L8CZ7OsgTGA==
X-Received: by 2002:ac2:4296:0:b0:511:4d37:a688 with SMTP id m22-20020ac24296000000b005114d37a688mr602923lfh.65.1707466625067;
        Fri, 09 Feb 2024 00:17:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWx76F6uJiYf0aJ3sesAUzOJ4/6zUXnZPPH9BJ1qZg/OH/FsJ4rD3JKIMiFpP7lm16gIGwrXZC0RA2b/DyJmTRtTeSLd+8FlpBaRK4536/2RACd9DbP+k6Ei9fQy+41GkV+IMsedl8lgvs5U+wdbJjSmfkV16ZuD9/pl0N69f/E86O0Sym8bassmMKV5fnjorbtocm/20pg3zBLc/5DR7xjTJI/udIhHOxdtv7Yw81Tz5TnxI3HreSO8nLSfSxT3MLwB1icDDNf2Fwc8v6VJS5O/UNDS82fRprT0gdI9onFvnwUpkDazw4uqDqsOnznFG3t5gH0efJG7YyFaA3mswcP8F1/c8ve+cgUuN87PJpy1KoWMJLnPgqauyCq7w==
Received: from eichest-laptop ([2a02:168:af72:0:765:2268:762e:2748])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c3b9400b0040fc26183e8sm1814217wms.8.2024.02.09.00.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:17:04 -0800 (PST)
Date: Fri, 9 Feb 2024 09:17:02 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: gregkh@linuxfoundation.orgg, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	piyush.mehta@amd.com, michal.simek@amd.com
Cc: francesco.dolcini@toradex.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH] dt-bindings: usb: microchip,usb5744: Remove peer-hub as
 requirement
Message-ID: <ZcXfflAvkzHzWBfb@eichest-laptop>
References: <20240130073505.8916-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130073505.8916-1-eichest@gmail.com>

Hi Greg,

On Tue, Jan 30, 2024 at 08:35:05AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The peer-hub is used to model the relationship between the USB 2 and USB
> 3 hub. However, it is possible to only connect USB 2 without having
> USB 3. Therefore, the peer-hub property should not be marked as required.

I just wanted to ask if everything is okay with the patch and if its
fine to apply it or if it needs some updates?

Regards,
Stefan

