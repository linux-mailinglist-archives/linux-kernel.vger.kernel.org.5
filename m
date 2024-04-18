Return-Path: <linux-kernel+bounces-149737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B571D8A9536
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EDE1C20E90
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED6E15887E;
	Thu, 18 Apr 2024 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtrbtFfU"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F51E489
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713429719; cv=none; b=q0mGkjqF2Qf9c7xfXTFXHcbOVKll3PWu+ZQeM4b+5vijuk/KbzOQk/RsykaT0hqHEQYERfHX6f24pxB4ejBnI+yTTjiSnrE+T/uFWghc7ZNoR4gWfjlNj53DzSe0Fw1ll+VndjvV7va44zgfY7vGdqO6sBqoKyk95B2TMLz4et0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713429719; c=relaxed/simple;
	bh=lcAKWCMj+reGzv/SxgQTObCQDHvEXKI5uKBcKnB6ORw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ2hNqjyt9PVBmgTe3oJe6mwESnnmyyk9R53VRG04lXyVRdLtdcA4Hev4L/g+LTXmg0OBHGdDvaG8pYiW41RY2Y0BBGcsce1L8MFf92iYEAkoFzV4Jx0stB9cpfcfyh6tyWZiWxNQQiRyCvw7/jwES+Dt61r+Tcelq0z09W+gpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gtrbtFfU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41882c16824so5201195e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713429715; x=1714034515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lcAKWCMj+reGzv/SxgQTObCQDHvEXKI5uKBcKnB6ORw=;
        b=gtrbtFfUUdhicm878kFdTF6Isf4skHahi/1MuSlK4Z7HcYM8AA2y2KsviQ/of+c9X4
         eY9SOJoIudA01qadgFIacWC4EpAIgPhq50/VimmTJYZW0r4zh8AQHM78HL+7MsZ6FmzJ
         pM4RRXPJrm6/s3lB1dkuUk99ghDYFvBq1TyfmdOEviYl4jQ3iPrQ75UJ+gebDdu8JUbD
         Gtop9FCaNMyMWUtcIj2T4itJWKQB/h28sjDw7SLBn8cXZNJkaVAbMz19006A528aWIRf
         R1BWJ3Pq5M+FcuOyuy2gKU8hWXCL55tXzrMLrTXjRZ1bvzAhtpkdSk5z1WEriQKp6MVp
         6gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713429715; x=1714034515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcAKWCMj+reGzv/SxgQTObCQDHvEXKI5uKBcKnB6ORw=;
        b=PZUtgSTCa53JqyVKnDAAipCC9EGxvIi0Zk3/tpoYH6Ocu4uWFmvdPkgfwZlRdJJq2t
         nBVpyfE/SStS5gkBhF4zzXZLVwNYJGW3+VztitEVaU5qPQ/vRY28XhieI4rcH6QfVwxt
         8tT4eHTwje+ioOSuoiggHsJtxIilQQmzZP+5mHOow1GM0JvGht9EfmlBzlj446hz39tA
         6efMMsKRI/SqYp8XY94Ye+qSTxg7eIY7uLLXxWW9rXfoJF/SW7l6FNbbXSdgfpfTZReN
         ffOSab8ZXJRVH3Cbm6vxDn5T0veXHJGVaK7fDFDmsoYlNsG308NRQcvYxxZJI48LdYNo
         Yj4g==
X-Forwarded-Encrypted: i=1; AJvYcCV5KFHPQl62cVHszSXnZ1ZM7u4AKEzP7rRNR/iNDVeLhhfISc5RJ582q1Ltps/LrTRlxOCmS9KLwFhPVTW6IaLnlsYI4Ce5hQpI13WM
X-Gm-Message-State: AOJu0YxckGducw4EfzLMUlrfXLkdFJLq74GFG+/w8iwDqHO0z2VkHrOu
	pvsWcCX/Ndd6X68iK72zy+UuUAbot1VfMlPOmt52TREFV/00gwoh7stuzJR7CsA=
X-Google-Smtp-Source: AGHT+IGtSojqwzGCY7o8kpFDZjkynQ3UI+S+NsFqETzKmtJMJWjWSr5MyuisF3yopc1Ssg3dQzg7tg==
X-Received: by 2002:a05:600c:3555:b0:418:f400:4af1 with SMTP id i21-20020a05600c355500b00418f4004af1mr12010wmq.38.1713429715231;
        Thu, 18 Apr 2024 01:41:55 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b00417ee784fcasm1894342wmq.45.2024.04.18.01.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:41:54 -0700 (PDT)
Date: Thu, 18 Apr 2024 09:41:57 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Flavio Suligoi <f.suligoi@asem.it>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] backlight: mp3309c: fix leds flickering in pwm
 mode
Message-ID: <20240418084157.GA162404@aspen.lan>
References: <20240417153105.1794134-1-f.suligoi@asem.it>
 <20240417153105.1794134-2-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417153105.1794134-2-f.suligoi@asem.it>

On Wed, Apr 17, 2024 at 05:31:05PM +0200, Flavio Suligoi wrote:
> The mp3309 has two configuration registers, named according to their
> address (0x00 and 0x01).
> In the second register (0x01), the bit DIMS (Dimming Mode Select) must
> be always 0 (zero), in both analog (via i2c commands) and pwm dimming
> mode.
>
> In the initial driver version, the DIMS bit was set in pwm mode and
> reset in analog mode.
> But if the DIMS bit is set in pwm dimming mode and other devices are
> connected on the same i2c bus, every i2c commands on the bus generates a
> flickering on the LEDs powered by the mp3309c.
>
> This change concerns the chip initialization and does not impact any
> existing device-tree configuration.
>
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

