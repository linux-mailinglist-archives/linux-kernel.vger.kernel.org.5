Return-Path: <linux-kernel+bounces-151063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFA88AA882
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4962828F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2E0376E5;
	Fri, 19 Apr 2024 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flcJxh5p"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E736031A66
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713508800; cv=none; b=oNA/ApVwsy4sxULe1DlRw7VtqmnuGRGSoq0jKg1wS/EkkM2hhvgRQ83NMggWMAe6E1NhgDw1TJ2RKE6/MpInOxp3hmndaVohPXKSyAorfIKi/8higNDdmXOv0YMZek5FcbP/IRNNjErfMTQzfX6Z4RLTpxkBvVeEbFMFkT6m/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713508800; c=relaxed/simple;
	bh=KO0xtQBpQZiR18joiWf/pJcceYmytvVfGuc9Q/51F+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAWV8MNvlFGXXSv7sm6S7ZfBn7aa9GkN33bx7tcvXQhdwAssNnAJCW4UyddwEyM+eWha/H2CkKdFXNzgAW7X3XgNUCt5hzXodFPt0QlvA+YM0yvRRmvIgc6sHVlZcsNX59QJyvWWtOXwelPd2hM9GWFCJakUN+dzqFZtoeXKb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=flcJxh5p; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e411e339b8so13061105ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713508798; x=1714113598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=behcu3HpDw80Nj2+p0givcvikiqXXCDSWOXRNk2VtxQ=;
        b=flcJxh5pTRqmt1tEeDf4ShvoK8kfFrlWV03sHvgHpD3e1G+1oVT9c2Iu+q/aJjpYox
         dnpye0oFudh3dyqJa8twv9kBZEh39Ks3V9LMLwS3T0EOdrrnnUEncJnH8makE+s6oVb5
         Ss3vI2Zg8bt1OYyVK33LdgQv0X/OP5V/k9DzE+Q96hPEBIBdNUBDLmXtX2m6RoG0dc/H
         HzSWEI3QhVH1I8KGc5zudJQ0nphwdEUPd5A05TmYmfux+63Qla8j2WTQKWVUu6mVqf0G
         WYBP6UcYgU5zji1hbKClu6JEKdCJ7Tlqa02PsYLQLWYHEaVfAKoluuoVNzEPQAJiytau
         7PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713508798; x=1714113598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=behcu3HpDw80Nj2+p0givcvikiqXXCDSWOXRNk2VtxQ=;
        b=V20P5H75E4l4n576i5d8MBxdPn3o7flqw+cWfO0ACzF7o+f6siKvqXKCpCQk+rVUeG
         WAn5FFtPzfuSLM8UgGfWVRIaZNMiKIuSXzFjFtjb7X87XZeoHfZ7EGixFyPiYDzNWpYK
         v4DnU0LgMc5gnRQUpxiFxQo/Jl16KfOoOcw9SyqJzV9eMef6qsTZ/RCo7tEAJO+oIa9h
         rTE4p/H6DuwlQ3PaeEyauR3KltT0y10ujCNVMFhCVehS+6udOnHxgVvVeFfrgL6yvaSZ
         +l+g34qkSMuPXcLrj8Q4Q9uatjLPPe4QA2avXsDDisY9FXV00mS01ePjUgfXGlk588YZ
         hEVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqiB6+SXgjHIZX9DMCdQ0IhqAV71qE8ImPjziHHN8juxH4fYTFbKbuXkOCsViufm/VLbh5ObgGmZeXczC/0CARgxMK5xKvZ6SviSEU
X-Gm-Message-State: AOJu0YyAWy+WFIwyXed7kwJu19YkqlUwRx1GinzOtbYKz4AbhOnPowVl
	UavW0DZrFbMrhd1nKVy/fvSS24250HosT4USK1URCGBjwK38suVFjsReMJLiqSw=
X-Google-Smtp-Source: AGHT+IFjC4SYo1RfgyjASxoVyHVH5G3r/xD7roVjnqsMZux+u6GUIuiQPmKURIcdYeJqQKak87M6Gw==
X-Received: by 2002:a17:902:ceca:b0:1e2:a449:da15 with SMTP id d10-20020a170902ceca00b001e2a449da15mr1420976plg.15.1713508798014;
        Thu, 18 Apr 2024 23:39:58 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id c17-20020a170903235100b001dddcfca329sm2588042plh.148.2024.04.18.23.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 23:39:57 -0700 (PDT)
Date: Fri, 19 Apr 2024 12:09:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] cppc_cpufreq: Fix possible null pointer dereference
Message-ID: <20240419063955.jzfd6pfiag7kz2i6@vireshk-i7>
References: <20240405094005.18545-1-amishin@t-argos.ru>
 <20240408093536.19485-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408093536.19485-1-amishin@t-argos.ru>

On 08-04-24, 12:35, Aleksandr Mishin wrote:
> cppc_cpufreq_get_rate() and hisi_cppc_cpufreq_get_rate() can be called from
> different places with various parameters. So cpufreq_cpu_get() can return
> null as 'policy' in some circumstances.
> Fix this bug by adding null return check.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a28b2bfc099c ("cppc_cpufreq: replace per-cpu data array with a list")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> v2: Fix mixed declarations
> 
>  drivers/cpufreq/cppc_cpufreq.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Applied. Thanks.

-- 
viresh

