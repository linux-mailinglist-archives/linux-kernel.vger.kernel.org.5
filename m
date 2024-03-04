Return-Path: <linux-kernel+bounces-90444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BB086FF3D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E441C212AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225DF3715F;
	Mon,  4 Mar 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrE5LdsZ"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03EE36B15
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548841; cv=none; b=plFJrG/DR2fP3RUxDtd68FYVJqoWgUs921uUX2jLXl9OHTdqbXMSY95mobLyUWbv5pZNrfxsAoG3/c2uweSL4sXXAyNFB4f+IGyMRr5SSv8mewPukJNss8trGSzogZFARIpQHtJF286MBa8kRnjiHyt71P8Zwlwu20PQUexle54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548841; c=relaxed/simple;
	bh=cWxTUO4sA4CsB9Yrz664BleQ4+n1N3tmHuAnX79nQrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQt1t8UOCkT8+cEOoBAoCS1QgNxzur1w0ueb4ymw1FgFp3OesEPp1vrqGDxGUTiR8tICXSFykCGZdYrsWr1x1exS7/4r3x5MUNVdWMszrCf8lS/o0aM534az29XmoxAsozJ94uaM5+edgEagDeZ+pFNWpyX9s/XJs9oTkCBbuwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lrE5LdsZ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d26227d508so49031641fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709548838; x=1710153638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LV8quPQ0BDxx7ykFaUd7lwn+4n54fD34S7jVpq0GKn4=;
        b=lrE5LdsZL96F8Pxitm6+O9TAhx+2kKmF8b5doCXxh4KQ9uPN3q4kVgZz9fukEHe+Xa
         ApoaRuNLQ9Z1kLbroms4KjjQfdRwI140CNL/ty0juQxz3t8NQ40W+bQAHHWDqQSxwh3a
         Lj78DiZqtyracuUxRvmLNhUF2wa/LqSlHSetT/0AotHnzxzaA80qKLD00Hp8BLbYe5Bp
         4iJYMEUOd4/VscMOK3PnhmrgPVWM8+lZPEj8gRRmuF/UyrYxjUD3Sq/SNtOFmpRzmJoZ
         eAMOHfUlRkrGwl9J1uMq/sKbhguOB1WCxJ3TEwfy3yjTgUrO0KO/ut2If3qtY+kHd+8f
         7x2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709548838; x=1710153638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV8quPQ0BDxx7ykFaUd7lwn+4n54fD34S7jVpq0GKn4=;
        b=XxJBgUxATrTiSthdzf99ipxq/6p9U/R2+Q9Y1er2H2EuRqdtmz2Q/WxGQq38zKi7hr
         PEs3XvdiO+ZnDCftqWnpwzYicuGGKinFa9WI6PVRK6FPvhKyquFnDeJJtSVFL22AMraf
         334s9f2V8/97GrGXXpBoFXswXZeJUpSvhwGH5heem59Mz895zhqmDs394sAv8XsVFUGl
         n4bjI5YCCNKRZZhATBJI3UxrvpqWU2GQR1S73VD6GJHCoGjFAyOjUHCW3XvMwbdIBYFP
         CJ+glmLFGErD97HdxpC4W3AXdMb9keiMrddk2qI94wxN9aEamCAXnoJcHyld6NZpMips
         t/jw==
X-Forwarded-Encrypted: i=1; AJvYcCWu+GrDzDqHfzUCEz0l/aKS4UO2oqXR3IcBvauIQjeGaeO/1GoK4lmTWYUYO+8PZFFoBMxmMSIY3dXzRSbS7biyuRxsZHkW3WSkGmUJ
X-Gm-Message-State: AOJu0YyXi4X+C1RbYz7WtEvkZA5A8FZAQB2ba17gNw8fF217/0+r3mOK
	cq3Q30JCm+OjuTwwVaYiGkB518UTi5E02ySPbL1xapgZCjdX5lZwf4XfCfr5bO4=
X-Google-Smtp-Source: AGHT+IGTmL9yC/OS8kNpqDK7pMYoQDFJesM5bEsJqIwKV3qwMLEueQFYtNsHk9OfYIqoZ7jPztpoQA==
X-Received: by 2002:a2e:3c09:0:b0:2d2:9b77:6e38 with SMTP id j9-20020a2e3c09000000b002d29b776e38mr5294389lja.27.1709548838155;
        Mon, 04 Mar 2024 02:40:38 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c4ec900b00412e0e899a7sm3897575wmq.27.2024.03.04.02.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:40:37 -0800 (PST)
Date: Mon, 4 Mar 2024 10:40:36 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] backlight: l4f00242t03: Simplify with dev_err_probe()
Message-ID: <20240304104036.GB102563@aspen.lan>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
 <20240304-backlight-probe-v1-2-e5f57d0df6e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-backlight-probe-v1-2-e5f57d0df6e6@linaro.org>

On Mon, Mar 04, 2024 at 11:11:39AM +0100, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

