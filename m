Return-Path: <linux-kernel+bounces-82892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAB4868B55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19AACB21723
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9E6133297;
	Tue, 27 Feb 2024 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QC/kb2no"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA66A3D68
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024102; cv=none; b=dRWmQ3mZFj3Ba/NitJR5+yXUI93CIyM4L1vzP2EnbtpuN2j21HmI8xJlMF83ssRvgfDYXxsxMKae2XDZdN9mmlkYd7HOxSxguZauCFr3yaef0xWflz103daDMxdRKf3iDrzfviJ0HuytoQf30bWyn+a6e+tuUo8dD/i6RLbEn94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024102; c=relaxed/simple;
	bh=e65miCkicj1NdvFVKAgHu/VbuyPfNh0KeRITNON5WD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKr+w6/94jM/oGUd09gx9odTz6GRsgpzJIU1zb6nQK6xCDzcwR/k+XpvvttBNRBNg9LnLQBfIBcz6oNdoElF0RGGZ7jtcU0PkKtBYSCWDGoNlcTxCPXdswxDCGPg2MtyniILCtDDGXry432ZUQOiVpYwMsbSllZwYNz9/28j7iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QC/kb2no; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412a3ebad2aso15295075e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 00:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709024099; x=1709628899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HoOFxtqK/5ZaKWmPUt4ourSkgleZpPjmZJgHHXaK8e8=;
        b=QC/kb2noP3iC4aPpTCHslNJtkbdFwLDhz1MVQhG9YrNYCfVihVayu7gwpa2+/LS4ys
         AA7U2tR2PG80iWlrgpf3wKJERUKsaYoEfQglS6tcFqykYSo8+0zh5rg+BNIQch/BNu0A
         MIyjqTlBjF5CNSH1gLQCC0FEMYSNIi09Tw+jONgEAL20XzzGPygm3s/X6HABPRH9rrzP
         7Zcu27tspztJ2spU/LzAx0qE+BUut6wmDRkG+KdqmjrzWPJUnvjhd73F3jGX3zOmpnsE
         I00sH/NwhNl2UiwwT9YSSiWgLaJXHFcuqy+YPEX4Z/E5ibKRGxFnyxDmXoyxM6cFvmZX
         mZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024099; x=1709628899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoOFxtqK/5ZaKWmPUt4ourSkgleZpPjmZJgHHXaK8e8=;
        b=rtM74d4h+NCbOODj/BIh5IYpIPKl9zT6l483KqA7likoNosu0tKVS5+tDquVKMuB3E
         Al34lJr50nLV1ZgnSCTwlR9/O3e/t5d73J67d+ea7zTq6gFb1rbMo/N5y3d6mh+RDjnt
         nwCIF5121aRjmagcKS/ckyZ6OGYxtFzZcfREaZW0FI78SEf7m4Al3OY0J9SrEoATz/6Z
         5VaO9cmOxHIK539a/T0gpnZsCPTWo7kiSXXtDxez8cCsIiZmLzLMa+Q2vH9lwj4uBih8
         yqhvVYv31+5ZnSQzMEjF7GrMFI3g1HdEQTizxLUcS8NlIOaYoGVJ7RUOqxkC2LRbeWyG
         bK6w==
X-Forwarded-Encrypted: i=1; AJvYcCUwV/crAa8qyOsOKtG0bwDcqmTqsgW65asyYuQJF/BDDb2Of45KnyrCLUwokH3ahQZ1UJ8xIDP8OHY5U7l1l4uO9NkbgAyWXWngqh53
X-Gm-Message-State: AOJu0Yx+izJde6WQ3eaMv0Pxrc8WQRVaC5k/PQixNcBcoXJjxGzKsvzW
	ea43IDPPYStK/EJzBxLf68BZiozF715U68TP8mOEPehOr/E/cyo142VIiKHMSYg/Cqvwtsusiqg
	y
X-Google-Smtp-Source: AGHT+IEcssd0DZn1GwRIx6uxtu/6p9Ar/DTRb8JebvM7osNUBQzyWw5I8ki+RUWt518g6UqWWYW8cg==
X-Received: by 2002:a5d:468d:0:b0:33d:14a7:c4b with SMTP id u13-20020a5d468d000000b0033d14a70c4bmr6212734wrq.40.1709024099075;
        Tue, 27 Feb 2024 00:54:59 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id u14-20020a056000038e00b0033dca6f8b44sm8036668wrf.16.2024.02.27.00.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 00:54:58 -0800 (PST)
Date: Tue, 27 Feb 2024 11:54:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michael Harris <michaelharriscode@gmail.com>
Cc: gregkh@linuxfoundation.org, hdegoede@redhat.com,
	Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: hal_btcoex: fixed styling issues
Message-ID: <da4ff70d-6c64-40b6-aae4-3aab87da2a1c@moroto.mountain>
References: <20240227080943.13032-1-michaelharriscode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227080943.13032-1-michaelharriscode@gmail.com>

On Tue, Feb 27, 2024 at 12:09:43AM -0800, Michael Harris wrote:
> Fixed various checkpatch.pl styling issues: spaces before tabs, constants being on left side of comparisons, unnecessary braces, etc.
> 
> Signed-off-by: Michael Harris <michaelharriscode@gmail.com>

Please run checkpatch.pl on your patches.

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#12: 
Fixed various checkpatch.pl styling issues: spaces before tabs, constants being on left side of comparisons, unnecessary braces, etc.

regards,
dan carpenter


