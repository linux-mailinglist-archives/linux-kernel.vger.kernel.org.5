Return-Path: <linux-kernel+bounces-164726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2852C8B81C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B541F2486F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65931A38D3;
	Tue, 30 Apr 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5P+VeDa"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC72C179B2;
	Tue, 30 Apr 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714511105; cv=none; b=jNHj4HRV6JL2wDvONXvHnsB+KYIVLNFPrlVDnvQ2IhLbzNFRqKjPriorYCJm8spyRG/69BKUFktl+zdEkpR1L5PI4RzSMgsBec+lQ1j8h/7Z3dj8nIGLilndmI0cQ6cI+jPSv3HW/IS/IM2fjeiA1qdevQzgiFCASi+T8dEc8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714511105; c=relaxed/simple;
	bh=F/rohq7qOnPPqVGaFInXQM5IP4eoAokppwhdkbE6i1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YT6+xvq/gs0iVSdnY6itXjVqL1ev7BB6z+Zzu8rxHHsH4OGadHyVq9hKt9amWC5t+AKZOIwPRGKOcUP/75rRC5BuD1sMW3xSLsoo00+wWCTNpa+qilkeHNphBI86AxN/L4e4B3aLeBWDYjaN8uz55c9PpRylABVjLBFjaBiu9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5P+VeDa; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b2769f017aso1068324a91.3;
        Tue, 30 Apr 2024 14:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714511103; x=1715115903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4iHfZMligVtaN3PJeTsVRrBoDkEzMS8Sae0cv4zl38=;
        b=k5P+VeDaaxfpeqoAcIxKn2QGf+HcaP9ATRiIHSlAOR4fQakk6pfikmlFTyQDXJOC1S
         5eIJRGa0WhA1Q5vprmw7wTHgkZ2z7Fq6ZsaorGZvBwEGZAXn4ijY6QsNmDmi+FGOXdMU
         ZAA7qxVrq9NnqWLHGa29pHrVjNXcq5G9oMGId/C7L99nyTq6dUPpwd9+iltkhMAiucrv
         saz9b+bHNWXL/QygfIh/1CUaJvQQPnaxTw1pm7Zs6YaPUlk2ZjMHsk5p+6/YTa+HbAes
         I0FdeFkLZ3a+h6xUAo8k6Pgi+S2PUjem9H6CjPZ29+Fq+/YqtUvM7kIlQPHp6Cp0BHRd
         K3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714511103; x=1715115903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4iHfZMligVtaN3PJeTsVRrBoDkEzMS8Sae0cv4zl38=;
        b=POpSdBcPxZ0CSUNNEZlHUVKA9pWkszbdUJkdtuvx5CZrqC4ncaAFcrXPOSVDzQye3I
         4noa5fv8eAE1fI1K2SQMXO33zdeMxab+CwaYzmqwdygLYS1OLwCDK2lmPXsMbhy1/qp3
         lxa+Y/yBru8ePMLeprJ0lu58XrGTuhtKBooHlG+Dera1LLzEoE/ZYUWqv7QcSLFgaz3a
         /aU6JaJsubq+60z6kgo3sl0GzhC+Jiok/xCjTSrTrBkmu5ermVb/xERV+7X0fCYubc2U
         EW7wojERyUv1aJ7vEySh+Zsq14F7g/Z2E5JuO8DVSE8/05vVvuvwGqR6AuT5defYA500
         hfzg==
X-Forwarded-Encrypted: i=1; AJvYcCVNUmDuFVVgG5i+2iyXNuH8vdH7pFqh6pm6/+GbTgccqOu023YbQMsxyV2PDFRzOqhsVlOfT2P4UiCQ827R/plQ5jj9jzeOEL9rCLb4VOVeuotv4yNXDJS77wXMDSjCvzyyG6XegNvjyywPdWwLa+/C5g55C3DmnAnmdejoSdeftJGyZ+Iy9tUC1d8=
X-Gm-Message-State: AOJu0YwVqm7PC8THz9SDZtLjecKCJKFqs/KdwSsxw/dvO5qWF9DY9Xgj
	i7xU+5y5ntgCcYxX3UhrbkZEctijc8z7vABdL4oeH7IisbHgmDk7irtcbw==
X-Google-Smtp-Source: AGHT+IHCNGsoBLeJ3fU8TFjhexfzHWOIYrM1UjKlIVT9yaZbnjjWa024wKqsRJmgw5t6qW1JejjlUg==
X-Received: by 2002:a17:90a:1fc8:b0:2a5:2f48:1eba with SMTP id z8-20020a17090a1fc800b002a52f481ebamr619471pjz.13.1714511103054;
        Tue, 30 Apr 2024 14:05:03 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:68d:41e7:d081:607d])
        by smtp.gmail.com with ESMTPSA id sn7-20020a17090b2e8700b002a610ef880bsm36286pjb.6.2024.04.30.14.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 14:05:02 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:04:59 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Input: ff-core - prefer struct_size over open coded
 arithmetic
Message-ID: <ZjFc--tMio1wmBpf@google.com>
References: <AS8PR02MB72371E646714BAE2E51A6A378B152@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB72371E646714BAE2E51A6A378B152@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sat, Apr 27, 2024 at 05:05:56PM +0200, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "ff" variable is a pointer to "struct ff_device" and this
> structure ends in a flexible array:
> 
> struct ff_device {
> 	[...]
> 	struct file *effect_owners[] __counted_by(max_effects);
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + count * size" in
> the kzalloc() function.
> 
> The struct_size() helper returns SIZE_MAX on overflow. So, refactor
> the comparison to take advantage of this.
> 
> This way, the code is more readable and safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Applied, thank you.

-- 
Dmitry

