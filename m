Return-Path: <linux-kernel+bounces-108406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8E9880A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3C41C2211C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEF81170B;
	Wed, 20 Mar 2024 03:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0rDXsb+"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E7510A16
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710904864; cv=none; b=nCWMAibbIa66g1In8MtEsCeUxE2DO7oqHjsDVz8NVvj+k4lc3k8igjFC8NRWAuuxSmpiX5JEoXIiYDKvPHLrd6VngipZbpnWKgP1TPXWdtAWiOu9dwgF9rXLRsosZlSR4sjR/in2GcrW3xxtre36W5ZCKdFqfWOvMOjyU4rKfUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710904864; c=relaxed/simple;
	bh=P+Zkz/NOWOsgVlncUTyNmvXcTlE9NnXrsFiBq9pCUv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6MnSxGSdz417PpEUP2z+G2IYkzQR/axHj1HIhVW1tozhmjqiF7/0aWnfut9zW0Ez9/0FJFuSTDQvrzdXV5AKpCtAQbP2d+kn4dJ7OJD1/KhmVc5LvK8GSGiii6e/Tmf3G8rsWoeGyLWqZ1Wz5u6btHOavmCh/bbziVt1FY1dAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0rDXsb+; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22215ccbafeso3156320fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710904860; x=1711509660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4P//duYekxql85fsXRWTB88tD2kAUJ1b3yRQNxznTM=;
        b=G0rDXsb+nnyNVMah+5vN0hFi+6hfWke8yQ1q9G5UNpAEAUUhX38zmgYTPxFFhHRpNU
         ttX5BaihaFfw+rH0NbboHBbWRdmpxO6avCv5o9uBZw79HwXpjdpTA91E+h7nA4IBMggK
         76hd7s57uVZLWZYH1tU2t75sgBr/lCFjcsXjM5O2Lw5mSygTpQE6nhqCUSwUP4J5cOWE
         lRPRPjEofRNgfXKoxzWCIt0oNpxxhAkr6Up5h2UrsQXU1dsg9ZUcD8T8dsKB5EWe64Qg
         j8B3/gKxVRqYTyvfFXKbfqmEAm3+LVwe0G0kW8hlt4R2PiMXWvPn3Tbl/DdnxduAhhFg
         jhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710904860; x=1711509660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4P//duYekxql85fsXRWTB88tD2kAUJ1b3yRQNxznTM=;
        b=ubi6OFgDIYcQ3X2ELFe0uIdUEWS87jkuc4yXdwvEZZuz93EM/vCSq3BDY8nbY4CRtW
         vnbVV86BWz1yD1UKLRN27Uw5cmUOXHUimEWGF1+UjZxRPIfctoH6A0bGomoWb20KTw6H
         HC3TzxiSP/TIn6tLT8izl7CMgRcuNmq/vwn1CX5vJ1hQplbRFhAPUby4ilcvXi3JMXiW
         3fyg2xomKO05iV8dsMprCVpyhH2MgrrE/tdM54FrJPPp5BLfqli+y0j5sKSjQyJU8j+N
         KFYT1mdajlTqYOHCWwfIw+f8VEjDBnG3GfFQhL5sXp1iGIYDOON2zMUE3rIjSkl/gDO4
         GPIA==
X-Forwarded-Encrypted: i=1; AJvYcCVk6vbuvybT0v02NS/utfjz4NEm+glDoPmq63MyNLUxIkUYxgddfR5TdCPKYjC3OvSXdevXzQ8VA4kjQEml/5/jYeF6HotSJ2e+2m0o
X-Gm-Message-State: AOJu0Yxb2t8lPPiQ+3oLwWCQkxUH1yaMNY6Ndspc0hP+PvR6tFt2Q4Sy
	hHDu+2tirvlMxKwl9xkjrbS80gKcTTxkMbupad0mExnM/kSqXX2Q9dzuYCqLG9s=
X-Google-Smtp-Source: AGHT+IHbL+Bh9CUX9P3VLguZSd1oALL1RLaIYp2Dzz7vCxIzDX/QpNrzopRTUMNJ3l7QFS1qhsmagQ==
X-Received: by 2002:a05:6870:c1d2:b0:220:94b4:2074 with SMTP id i18-20020a056870c1d200b0022094b42074mr19107005oad.37.1710904860544;
        Tue, 19 Mar 2024 20:21:00 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id 4-20020a056a00070400b006e71d70c795sm5416714pfl.96.2024.03.19.20.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 20:21:00 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:50:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: rafael@kernel.org, ke.wang@unisoc.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, xuewen.yan94@gmail.com,
	di.shen@unisoc.com
Subject: Re: [PATCH] cpufreq: Use a smaller freq for the policy->max when
 verify
Message-ID: <20240320032056.2noz6lu3k2utcpid@vireshk-i7>
References: <20240319080153.3263-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319080153.3263-1-xuewen.yan@unisoc.com>

On 19-03-24, 16:01, Xuewen Yan wrote:
> When driver use the cpufreq_frequency_table_verify() as the
> cpufreq_driver->verify's callback. It may cause the policy->max
> bigger than the freq_qos's max freq.
> 
> Just as follow:
> 
> unisoc:/sys/devices/system/cpu/cpufreq/policy0 # cat scaling_available_frequencies
> 614400 768000 988000 1228800 1469000 1586000 1690000 1833000 2002000 2093000
> 
> unisoc:/sys/devices/system/cpu/cpufreq/policy0 # echo 1900000 > scaling_max_freq
> unisoc:/sys/devices/system/cpu/cpufreq/policy0 # echo 1900000 > scaling_min_freq
> unisoc:/sys/devices/system/cpu/cpufreq/policy0 # cat scaling_max_freq
> 2002000
> unisoc:/sys/devices/system/cpu/cpufreq/policy0 # cat scaling_min_freq
> 2002000
> 
> When user set the qos_min and qos_max as the same value, and the value
> is not in the freq-table, the above scenario will occur.
> 
> This is because in cpufreq_frequency_table_verify() func, when it can not
> find the freq in table, it will change the policy->max to be a bigger freq,
> as above, because there is no 1.9G in the freq-table, the policy->max would
> be set to 2.002G. As a result, the cpufreq_policy->max is bigger than the
> user's qos_max. This is unreasonable.
> 
> So use a smaller freq when can not find the freq in fre-table, to prevent

                                                      freq-table

> the policy->max exceed the qos's max freq.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  drivers/cpufreq/freq_table.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

