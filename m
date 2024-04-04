Return-Path: <linux-kernel+bounces-131248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F39898538
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9951F25AF5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F9480049;
	Thu,  4 Apr 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnL0e4Ke"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AE17F7E9;
	Thu,  4 Apr 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712227247; cv=none; b=qEtXhp/Ci0OQZlsuSkGL3+HgQdq1oKCu1+kDnw3/4Ac514RX4Wk58QaMw6Sw+6r5Z2g/KKGYYe/s8xAMpEMMwhsigrC6PmLDa4xVtkSoRuuaHP0wRFkX1pph36pzOGV+gptnxZiT0BVs/wFwKcuAscE97DkECP4ma/TKYbcZn00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712227247; c=relaxed/simple;
	bh=MNpe8NXr8iBQ9y95lzJMBHR0mcfS2MVo4cooShPcHIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJJucXPs/w8Bl+yQ21aSCmNeGXLQ6p0U0ynxvG7wAZ5eaxK4J6HpVmk8hhEDNkZ9gEuaWd/qQvh1XpsFNqjq1RYtI+Lfd2Nlia3u6Z9I2rsTiNaETTZab14fejpmlBXk/sp8O9J4amwUGOnI8rAIO5itkceNnvHuc2w2lzGmYGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnL0e4Ke; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51581c51ee6so206510e87.0;
        Thu, 04 Apr 2024 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712227243; x=1712832043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHAApY73KEmZsLFXY/9Oln2REALZjiiaA9G+a918PPU=;
        b=HnL0e4Ke4RzErDFTjrw1ZiydTqUU+gw6l3xKRK7Edf1OyW1dkkI5hqYYxmoU7a0rN9
         qwXbcdT02bBDTdS92dxmW7JC8MSePk8o6Z0L2BdRlhOOJBGR6F4Q8/hlEmxLIN1u/+nt
         8LKO3nKmmojOppG2Zc5GXaBmtQcSVnafDEoMqbYvIjm74qRk7ZjytWX9GaSs+O+g1CUK
         vlVfVonr2LHfAw7qh3MyqGFmhIxwjFZi4dxJp7bSsfPsnAtuv1ID4yFUW4OSk6/l7l+N
         4xXMJvH1xA67Owb6wACfvYE+Z6X4YAMTZzSVVxMUz01Xd83VAb7eVFkr9aATvB+nu4qe
         CdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712227243; x=1712832043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHAApY73KEmZsLFXY/9Oln2REALZjiiaA9G+a918PPU=;
        b=mf6zULP6iE2tzd4tVyOCsjHH3fVA2Yl1EH2yNgrqW0Wj6BA5hISxspNdZeuqO4AcD/
         fRYV5Xi0QQRfa7XTH7BQJSTyI2nXHPQ9hjK1CNNicCZMlyD+dBzpt3DTvgJFDsQ5WqOr
         MXcAFlp19UT5MFYv9Iyd1zLXBwymUrcs3vcpfiB7W531hVgy7/rZPWbKQFQ9yuTr4AJ4
         l0hrM0bZEyyvRuLYXH/oAEglMOjpGPuHC9t6gkNBX10jM2JgbbqFKnNrdCDg3iSZQtBL
         1+aWEgnBa/UHDYYrbZiTw7BS5Ff/ksAPb+JvtsLEctl26Dy9eYaC79vX+uIVmcSFTXXf
         TnGw==
X-Forwarded-Encrypted: i=1; AJvYcCUZw5K3fPbDgZnihvtXOEVWgm2LtEwEzjWVUipm1DNiZdQRurVBGwzHj3GaZ0UkwNHTUKx8sRM3Z8+TgHQ9GRWhGkitBgHpl1cbQEU0CmeYQqhMPa0Ir/fB4MWU2GarZl1mCgDj
X-Gm-Message-State: AOJu0YzsUtfwQ5h8UxP5AmHCnmbP/s3xYMp9lPYaZIpfQjsGLFq4Co44
	JcL/puQ/4G+BPfja9TgdfFtkBRRjihJe7N5+xtFd19JK7Ev3ixtS
X-Google-Smtp-Source: AGHT+IHR0p+3ho9pbfRNL01gwquYexqbUX64yQ5zJhZK+78xpZmjzybvdAxDqeblPu+VhwI9tuDGjQ==
X-Received: by 2002:a05:6512:158d:b0:516:c241:a912 with SMTP id bp13-20020a056512158d00b00516c241a912mr1897481lfb.1.1712227242713;
        Thu, 04 Apr 2024 03:40:42 -0700 (PDT)
Received: from hoboy.vegasvil.org (195-70-108-137.stat.cablelink.at. [195.70.108.137])
        by smtp.gmail.com with ESMTPSA id co20-20020a0560000a1400b0034334af2957sm18375303wrb.37.2024.04.04.03.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 03:40:42 -0700 (PDT)
Date: Thu, 4 Apr 2024 03:40:40 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 0/2] net: phy: micrel: lan8814: Enable
 PTP_PF_PEROUT
Message-ID: <Zg6DqAWbRH9lx7BM@hoboy.vegasvil.org>
References: <20240404080115.450929-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404080115.450929-1-horatiu.vultur@microchip.com>

On Thu, Apr 04, 2024 at 10:01:13AM +0200, Horatiu Vultur wrote:
> Add support for PTP_PF_PEROUT to lan8814. First patch just enables
> the LTC at probe time, such that it is not required to enable
> timestamping to have the LTC enabled. While the second patch actually
> adds support for PTP_PF_PEROUT.
> 
> Horatiu Vultur (2):
>   net: phy: micrel: lan8814: Enable LTC at probe time
>   net: phy: micrel: lan8814: Add support for PTP_PF_PEROUT
> 
>  drivers/net/phy/micrel.c | 379 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 355 insertions(+), 24 deletions(-)

For the series:

Acked-by: Richard Cochran <richardcochran@gmail.com>

