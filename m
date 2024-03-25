Return-Path: <linux-kernel+bounces-116893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B5888A4E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764401F3F7AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC27179213;
	Mon, 25 Mar 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGlJ9SJl"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC59190697
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363870; cv=none; b=h8dTyACgReAqptgJMhuJpDOyPKbX+s+fEINZA+hPxYYyEHn73aEfObN3xam9E7hdySoZxuxXBGqI3xf66YaylZs9O0FfmHPRvk01SIfXhj/O6DhKwJ2D15znUvY8ewfgmssblt/ivWpAdFYGTerKNa6uTm/vxxrZEaIb5nEI38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363870; c=relaxed/simple;
	bh=82qCE9td6OtrJPbZ4uolnTjGQdgWhZ9rL5H7Hy2dBBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OG5OKQq+BZJNmbligArNOqk5n8yqsVjjabGaxIUPfxTXCauJDXPhLZ/t8nQrC+evjIDGiOLZvc4zrOILSHPF1NOSxzqI7oASB93hjY+spO+KJY+7euxVuQDKYn3vjkh3IxWcI3kwxmDHhVXgY/XmhLMuDk+8OYGHVmA/z6DXd/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NGlJ9SJl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3417a3151c5so2739530f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711363866; x=1711968666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=82qCE9td6OtrJPbZ4uolnTjGQdgWhZ9rL5H7Hy2dBBI=;
        b=NGlJ9SJlXLqQYeAQ+3oelSnnqY+CCgdyW95CHPTD4sUMM2x0AIPjmeayibkxycHJ2K
         vhhIM8G4dreq/JoDAGScXsgVkXUSFTzp1OUPrraRtmK6UFSsXeL1Z0A+HDHoF0+rm5jf
         UDvKFIZ7TDkcK5oH22Vcjst7Rf3mvwyYUUci468efuczytgzYmYOmejlD+RU0XkjeUsn
         XiXLFdnD4ltw0uJDuj0zcXcbIY2gmeWn5TwGBNF5X65ZOBpW/Bz7VGQxAmADqlZJocI4
         C/2uaIhldHWxruEG/t0VbJrkuR/ZiZ28QU2jt7+V2wC5uHB1O5hc0KJ6REFglxkVNTyk
         W01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711363866; x=1711968666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82qCE9td6OtrJPbZ4uolnTjGQdgWhZ9rL5H7Hy2dBBI=;
        b=iUMIdmVncX/3MILeHA3jvSVArk4ucSGinJ8sYrd4HXXFCHW2EUUpJSf2zWshSoJpwR
         IGSb8fUg4/wD2pR8GKHNILzPWturTxI4EYRcpFkXeXezzqfnHGg9tcEEptVis6vcX9in
         EOg61LUeTVx0ZbNJhJKcUhkT8lhEiRIw7MkjQOAi+gO0zL6FkEMSijGuh76AEC9lPXAe
         nYZz9YKZJFU7ZS+oKUeodseDugzWbEXocL3kIdPQZIFX2m2KMQmKk4M3LGCGDDwb5OYm
         SAPzqVBFJ8XKyqcR+o12Uxp1IsPNC/d5nDhNFedV8/AQ0I802zpizrYe/7swdLvuWP5a
         L5tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh1GvqLkpOjSrGaXVpnxJfbVrhDklJkjX5hc+nWsGrJ0T5jckmOL0fbYUiptdk8Zn5t/A5+K1OkE/JvVbRlgY9k6Xu+k1jY5vKOJZQ
X-Gm-Message-State: AOJu0Yz9tv+hFUG80VkRf8CyR2W92TaNxmd0qmwWGBRDi+Wd77pIyWqK
	QogwPlBpsv8YpL8Z/Y/HU0yKTSvaAHmB7CbwL84l2r07AudT344F2Z1gwqOB5A0=
X-Google-Smtp-Source: AGHT+IHR4nhe8qAdpwc1tLFzCRaFXi75wao/RZL6XKVs1RbH1T1CsovHHCRog5ww0klKJ0HED3DL6w==
X-Received: by 2002:adf:efce:0:b0:33e:6ac9:f5b0 with SMTP id i14-20020adfefce000000b0033e6ac9f5b0mr4620135wrp.20.1711363866209;
        Mon, 25 Mar 2024 03:51:06 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id cr1-20020a05600004e100b0033b48190e5esm9202151wrb.67.2024.03.25.03.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:51:05 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:51:04 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] video: backlight: lcd: make lcd_class constant
Message-ID: <20240325105104.GA182188@aspen.lan>
References: <20240305-class_cleanup-backlight-v1-0-c0e15cc25be1@marliere.net>
 <20240305-class_cleanup-backlight-v1-2-c0e15cc25be1@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-class_cleanup-backlight-v1-2-c0e15cc25be1@marliere.net>

On Tue, Mar 05, 2024 at 09:21:18AM -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the lcd_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

