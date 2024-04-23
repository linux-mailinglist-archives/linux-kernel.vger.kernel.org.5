Return-Path: <linux-kernel+bounces-154787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743DD8AE102
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C5A2827B3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386158ADD;
	Tue, 23 Apr 2024 09:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVdLRpD1"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A863657880
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864645; cv=none; b=f0xcLHn8oyq5joLvv0IkPpYqlMjjgSOhMya5kZpDWKqdECk+Rv1XS5WCQ1sYsd8snSXhK1sZ78XyDZr75itEqYxtIEnNPrq/TtnJ3Pw5TGs44S9yZKt6f4mIsWaIrxGKj/z6GoQpIzHcVs8x9a5ivAUNKElXJTjq5ZXUFUCF8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864645; c=relaxed/simple;
	bh=pz7gzIvrQzL0PZZpqwD/SlxEydE+N8siR5THURHsiGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Md/+pXAXHxSVjWcrPgsOvTI6tFdeMpGgL4rOGmjNfwLWBS9aCUpd9waDOd5U6w2IzsmH4LXoskgrRqLDMrQOLU7MyBugX98sZnE8TrjuWrWTGlG4gS42DqLRVeD1zuoIQznLN/mLdnkIehvW6nFNnEeIT1GnUOzd+TM/ciw2/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BVdLRpD1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso2836944b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713864642; x=1714469442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKc+QzTvoib1CxA8D0XSIoHeT+Qz1bK9S/yhE52hQH0=;
        b=BVdLRpD1hQ2IOGHUzzDOEy9JGYMRF9ipeCn/tvBUtHiDghVxCpTCiu1wupZHQoA5Ug
         P+Gjw19Pf7NIhWqDW9KtUOyBixh/JUQ5QzUEPl5EV9uwuBVj0zCr3D1oAvoCTBhTSrrU
         y0YrQeWJYwCGjM+Zst3BwzkxRGrNG9GCFE7OEaVrkWRejQ90U7+iRhW0CjPFH/Js/o2z
         k6aoy5TvT93y9I7RT+MYLI15RBKcxvLPNW2UtIzMST/EpLFiKtJmGWJ1MiwXRFZyvmi4
         jNYELKwCSVciflOpRFG2zZ4Kyopfoj2oyqVTHHCLvKY1PKRMaGjtZlWtOliqXpMhXrPu
         OXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713864642; x=1714469442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKc+QzTvoib1CxA8D0XSIoHeT+Qz1bK9S/yhE52hQH0=;
        b=kIYoya9aVhjfI7X1MFs/MvtbOAlp6woM52SUlmSLo7A1BUSO6SFQict0d83hI1Zy9r
         2BkG/pyIKeQdFP+BSb9plI0oZgHNavEaTpL5/1bzxnm0Lz/DPZQyR0PseXm8kaJbsULi
         rhXErTkJIq+IF+YbXZTUlNol2THRaOforqHrtHeZyJ2KYqBvdbtjKivsURQXIYRROPGy
         XMBLVaGTHJcTD0IUZkn+lv/vW+UBTcnXFrLm078eFPhORe9D4TeKHtQRWZPR5LeDrijH
         eOiNPNSZKLaG48Kf/i9ZQ5v/gFLrqsTyPdFlxamakhFGB0S/57lFKc9e4FbMaIGypMAl
         ZCEA==
X-Forwarded-Encrypted: i=1; AJvYcCWhxAj3Tvimio8ZbTKpppolVrxtjyzcvFP/uS0wSDZRHW0lybzdXH0l6OTdxxpiu+AS2jcUgkkpQPeECT6hquoFh7aJPnHZ94LkuDxH
X-Gm-Message-State: AOJu0Yzup149m7GOM/m2PlhLiX9ov/nHCZNdQ/PVGn9Ie7pclnXU/lOY
	Ktr/AYtSRSWflwB+wCR/x2fdhxX0Ij7XQY0IV6n7bAPbK4+1L35kTC3q+AZUaLAdaguenp6g/H0
	M
X-Google-Smtp-Source: AGHT+IGVO1aI02fvLiFE4FbChEuQhyKSChnpIbWmrCGBshS4PSn5x5AlkPFNtjNaRGeCz9SaNDSCFA==
X-Received: by 2002:a05:6a21:81a8:b0:1a7:aa73:ca24 with SMTP id pd40-20020a056a2181a800b001a7aa73ca24mr2589099pzb.13.1713864641812;
        Tue, 23 Apr 2024 02:30:41 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id h16-20020a632110000000b005f3c5cf33b5sm8979752pgh.37.2024.04.23.02.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 02:30:40 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:00:38 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] cpufreq: dt/dt-platdev: eliminate uses of
 of_node_put()
Message-ID: <20240423093038.do3vbkvcx6yhdtyp@vireshk-i7>
References: <20240423-of_node_put_cpufreq_dt-v1-0-19f51910276f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423-of_node_put_cpufreq_dt-v1-0-19f51910276f@gmail.com>

On 23-04-24, 10:27, Javier Carrasco wrote:
> This series removes uses of of_node_put() in dt and dt-platdev, which
> can be replaced with the clenaup handler introduced with
> 54da6a092431 ("locking: Introduce __cleanup() based infrastructure").
> 
> This change provides a scope-based cleanup mechanism to avoid potential
> memory leaks that can appear if of_node_put() is not used correctly.
> 
> The series is based on linux-next (next-20240422) and has been validated
> with a Rockchip RK3568 that makes use of these drivers.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (2):
>       cpufreq: dt: eliminate uses of of_node_put()
>       cpufreq: dt-platdev: eliminate uses of of_node_put()
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c |  7 ++-----
>  drivers/cpufreq/cpufreq-dt.c         | 21 ++++++---------------
>  2 files changed, 8 insertions(+), 20 deletions(-)

Applied. Thanks.

-- 
viresh

