Return-Path: <linux-kernel+bounces-91954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCA98718FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0E61F240D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F858548F4;
	Tue,  5 Mar 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2bBAjaP"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D766C548E3
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629540; cv=none; b=bG4Wiugi359NGE/ESOW6aRnUqw6h7qbKnCUuW44qmx4PLLIxVpzI1F5GYYsLbJac4OKZKVqeYuuswiPIQIgcPC5GOfv5FECJ+VpaBBcnBGOr8SVQ0dHx+OguqJ1HwScOTlrXclWwcA4DFgfmgb3n5lFAe7GOPdQATUPvlSCUkzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629540; c=relaxed/simple;
	bh=Hy//Hzvgbunb5xsN63aD2HSruKb+IayJoR8TyJL4Oto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+H40EiJals/HQJ2xwXXaRIbcjcR1sx3VAy1SOX4fWe5JXV8Ga5LtA97eh4LsfOybh7PtIXI91Fdhqk/K0w/lKLBLh3oXi5RxMe6yMv4jVBwAxrJ8COYxT4jPJWWRpWBfxj3S0IPN8R9xQ9kji6d6lCkJt9SNrV8QyJgQJ4mLzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D2bBAjaP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412e993a82eso3590985e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709629536; x=1710234336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVyff6pSUeH7eXbrIj/i6abg3oo4j85mjc8PEacBjjE=;
        b=D2bBAjaPpwq7O0TT18Q8eNV6IB2CMZIv1+EPS+loG+bcNp+AFP+/XOzN7n4RTAM37z
         lDH6LVyCvyw1V1zyfHwbz+1yHzyunjboQicGLK6hxAoXjUUJ6usER1IRNgqWUKe6K3Cj
         DiKN6IeKlayNEOpBlDlkKEEqAZcmXwkDFclVZZmgATBioSYDtqdcyOXrXgf4l9NUrruY
         hnu9iVH0/8YNrxntot0G//qlmzZTfM5WUDwEeR8kHMWJXY6lVPCzo0Nu2I3V4tbNxKs9
         P/QhqJHqKDmI5fhMoG3+J4rBUyhNb37NNNoTEZ/gwIE2hu8OcKFr9vAhTanVPCSes3T9
         vo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709629536; x=1710234336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVyff6pSUeH7eXbrIj/i6abg3oo4j85mjc8PEacBjjE=;
        b=o2ba3/mjQg72PQTigjVnEhC/YcQyIU9VoS5A+xafW6ftvpT2r3y2TBF/2L49AToFyh
         nnkIuXcG5OyFwO0SwI5bn+Aia9hDzX4DPe9pja9LUrQ18rhlshZNGJPmKwudg1YQAH0b
         lCtu76iwnStVmPyCpeevPOmDKQr4wVhIZ/wvaTkeMGFe9vluG2XuhSf+oCypSERgB1iu
         iPLu9f9igx8PJyYf3GLBvbR/E1g6ZSRWUlfw8IYEpMlRcMnlVYIsL7fLh9uFJ49l95s+
         D4vmDEtU3th4Wyz4ZBa5eX9ADLE5bwMFWnnfF0ky/KBcFS8Dl672Xch52CQG8lprfu/R
         0PQg==
X-Forwarded-Encrypted: i=1; AJvYcCWpjxczFZH51oKY+ko+/kGmTPgN5ji53tcj/IAXBRpFe9ZyyquV/tplffwr4GD8VsfHzNurU3gr8IZqlBMgTfm0njrRn6YPDMdqCI0L
X-Gm-Message-State: AOJu0YxKPIlHz5otNt9lRNRTF+t8KyGixhSpTC1EGUoOCmXEB1uOnsKX
	yF2yGwRQRkAYDLqpqRECyNAUa9fhsx4eNNr2UAR+4KlVeaMTmo/Ow8RwK6PDL7U=
X-Google-Smtp-Source: AGHT+IE3V7x03ggowAKVgcziDcq2QmZUnrNLZGdToxQ4bVq1RxNhNEasbMMg5KQP4v70Va8u3fFnoQ==
X-Received: by 2002:a05:600c:474c:b0:412:c9e5:b2d7 with SMTP id w12-20020a05600c474c00b00412c9e5b2d7mr7368975wmo.19.1709629536061;
        Tue, 05 Mar 2024 01:05:36 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ay37-20020a05600c1e2500b00412e7dde7d9sm3637450wmb.15.2024.03.05.01.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:05:35 -0800 (PST)
Date: Tue, 5 Mar 2024 09:05:36 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] backlight: gpio: Simplify with dev_err_probe()
Message-ID: <20240305090536.GJ102563@aspen.lan>
References: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
 <20240305-backlight-probe-v2-1-609b0cf24bde@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-backlight-probe-v2-1-609b0cf24bde@linaro.org>

On Tue, Mar 05, 2024 at 09:11:56AM +0100, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

