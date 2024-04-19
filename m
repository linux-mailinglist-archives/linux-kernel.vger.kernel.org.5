Return-Path: <linux-kernel+bounces-151057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7268AA86D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8290BB2256C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFA321A0C;
	Fri, 19 Apr 2024 06:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYVVByH6"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A0BA2B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713508129; cv=none; b=T7uzYfTkX0fTHYWY/bSc5jRD9MvPAtG0JKm3YMqDuU+DYwtgomZsGePPWiE5PrUytqy/2Z3KDFGzyveHqTfILduJ7CczGGvD4A//ANwAvO9+6vKUs8NRX1eQh/b7jinOULUFitJ7bk2D3CbX0PYl8bDYacAvMpDXFMIIGsSBskw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713508129; c=relaxed/simple;
	bh=WKkdIjjJd5AwfMBglOssEINqseYjTUuL5UgymD4croI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZLsgP69o5TCD28HARISc7Eh4fYlrUuvbttKpbi/4f006AYy3asrdko5hjdpKM8YMKnwoh03Idfkdh/IPdZ9egyq7NoWB1jx+bVLeKcWHsKB7gUVx+Kqz5reWg2qJzkT1LiUNEM/oQSLxpf18RF0zf4wG+Mnho8C9TWD7kZ5/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fYVVByH6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso1192718a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713508127; x=1714112927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XvSTBBH3v6roeXx5/W42r/UqmZ0hAwtViWz/IKSvWRU=;
        b=fYVVByH6WPCV8/K85Z/NBuiOiwbCMeRHof50sACsEuzo5wyrq/tTlILw4hvHo7UTjM
         SRspFUWkzjs7uELrTcvOZSDm6T9GYELqmkq7dWT5tvFhHkhMGXAc3tL0Z8MmMfcX+2P3
         74L7kBRecYZVmfRwzwYL9or+Yhwz5V51cX/RmKV9b6gLF4reG+tO0xlXGxoyUXK+mPxo
         Fld4SuCa0nv7mZ3csbf80YW/WYI/UGqk9I4B4sSvWaZnU2YcVFXY2dJtXroauS0dCvJd
         L1rWK8nhlrJGaZro8kRjCu0dlmhcDZS6HroXfcPx/u1xodnDwjB6OakQxASExrAvbJXe
         XDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713508127; x=1714112927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvSTBBH3v6roeXx5/W42r/UqmZ0hAwtViWz/IKSvWRU=;
        b=fap3/XQ3Z3SOWvkmU69SdLHQKUvHSnUzqMEeJt8jST/b8gjIEkICMU43FlsNoyh1N7
         M9pcykzuSxD6TlRVVvhyLTMyYJ4UyQbeUO2OkzjqiZFeHZlAXWc72nI79OwQiPwUoqk2
         c56uEFOk0gJvGqely+W8WIW7dlgCmXXeUKYtB28cxAM+v1QbwP9OAyIRnyPmffsS0h0I
         Je4w0L+Vaqjj8oa+OVaRH8oPglG1KlmWO9tGO1tc5RIHCkenOR+LCN/n1ISy3ZLVXKfw
         OTTM37mbAxZN4bE8paw+fRvU3j6z12evXBN0HTYICheaz+hOYosSXuybbSoJr48dTZ3n
         Heuw==
X-Forwarded-Encrypted: i=1; AJvYcCUIx1sxN0xTEo9q+kuij94KhF0SUqonoasjAQUVC0buGFI+Nj1eY5XYkumn2P8eNxZNALMim11WGyx3RwA/J3Rx610xzk3M7VastRgg
X-Gm-Message-State: AOJu0YzEHxjVVyXN5Fpt7syJbVD6sleWUO5maEEjNVVgyhsmtPZ5LGYh
	J3pxWnQiC2g7B49MorPShHaAJGyV7J74/7CO2iGeu8u3PxYFnZugkfs/bfYQa7U=
X-Google-Smtp-Source: AGHT+IHy6niLl/88ecXlZ1L49JJ5pPAijtlXeB8NEQg0SKtgaVRWocf5WffnSjz653PBAgOikR70LA==
X-Received: by 2002:a05:6a20:c70e:b0:1a9:c214:b7d with SMTP id hi14-20020a056a20c70e00b001a9c2140b7dmr1440687pzb.2.1713508126697;
        Thu, 18 Apr 2024 23:28:46 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902c45400b001e197cee600sm2595636plm.3.2024.04.18.23.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 23:28:45 -0700 (PDT)
Date: Fri, 19 Apr 2024 11:58:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Julia Lawall <julia.lawall@inria.fr>, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] cpupfreq: tegra124: eliminate uses of of_node_put()
Message-ID: <20240419062842.dc6tzssbcqdtdfi5@vireshk-i7>
References: <20240407-cpufreq_of_node_put-v1-1-2c8889d4935d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407-cpufreq_of_node_put-v1-1-2c8889d4935d@gmail.com>

On 07-04-24, 22:15, Javier Carrasco wrote:
> Make use of the __free() cleanup handler to automatically free nodes
> when they get out of scope. Only the probe function is affected by this
> modification.
> 
> Given that this mechanism requires the node to be initialized, its
> initialization and the value check have been moved to the top of the
> function.
> 
> After removing uses of of_node_put(), the jump to out_put_np is no
> longer necessary.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> This patch is a proof of concept to remove uses of of_node_put() in
> cpufreq, which can be replaced with the clenaup handler introduced with
> 54da6a092431 ("locking: Introduce __cleanup() based infrastructure").
> 
> This change provides a scope-based cleanup mechanism to avoid potential
> memory leaks that can appear if of_node_put() is not used correctly.
> 
> The patch is based on the latest linux-next tag (next-20240405).
> ---
>  drivers/cpufreq/tegra124-cpufreq.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)

Applied. Thanks.

-- 
viresh

