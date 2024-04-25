Return-Path: <linux-kernel+bounces-158011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586A18B1A24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4801C214F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B223A1B7;
	Thu, 25 Apr 2024 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSv+OnR7"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4539AF0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714021647; cv=none; b=Xz5r1DmKANYtaNnw334q8dofobLnXoy7a3NBrV+yjECb5COkC0jKi0qy+ENUXBsatrMreW0KtpqC2iQUMiEGEc0p5173pBKXWMeJ30eFfYldCJn1phSzH9u0G5nclqKVa5pPPIdHqRb9rBR3SPKy1bplnK/pv3BQqvBWvvCy6Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714021647; c=relaxed/simple;
	bh=Ncm25OorSfz9ZnjTA4O3Y7gRy0DGBERjo58g7YZCcmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3j+th/eGZXF8zW4UHKv+01/rH4P3gLG/uYlvfWn4Sjak2lxlHZ0yn4m52W/L02jLDpRPTYbKLnnAt4jV0tUqm+pGjmMU0yBPq30VwXH+C7xwd3+znjM5ziq8OpaFEu0JZ7cOpHSqt2/TJMTtQ4+Rerl/x3znxcttBLNAP7Zwv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HSv+OnR7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so544123b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714021644; x=1714626444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1QZb4MudunGoT1d0CEZNxbpWlJt6A7q5DEKaxpPxYs=;
        b=HSv+OnR7EEy3RGOUvgS8KFYsug0vpc5b5XAXoB3//KCXCPp8VsDrSh0rFn4ZmCOwpj
         FfQW5QU3pQCIbBPL/jF5Z49t/qlX71WUMoZqHGQZeHDiv0l5/6MJV8f51eOgLqjS0eNR
         d0TFLDJa8bGH50ssB4LcU+uhMXcE8bQH/HlBQia6cUIS+qjRoMLVfz0qB0PlEe/w6bme
         8yN4eUqhewhPoGMc1OH1AEkPAzc3246v/fYE9y5MUre6GThThtR6S7g1VQRKsTrmAPxN
         M2yrvX6H/EEY6beKea7XCQmqHHQ8BsyWEMDfb+frxaFdcfXdWqts1gVb+aA9hFtLNnga
         Swvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714021644; x=1714626444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1QZb4MudunGoT1d0CEZNxbpWlJt6A7q5DEKaxpPxYs=;
        b=wcDOT+i+HrCJ9N0mdNLerHak74vukRLJbql90Lm90GA356NqwDZFwMl69hgP/pjtRA
         WVPSHlucI4UWiuHMkPhka7+fXewAHaBHjHRkTV2XADvRnWQeH+BQDaMttjYihvISomvL
         ejQ9WodYO1SX7dEzdrqAB+YzegjMQTjJvLE7neUqKdToYjPT1DS0ZcgtPpGMkjYA74Yh
         7I0n30K3KY1ZjsdvKfrhB/Dm8AAHoxggw1OLViIZWrriTM3C9KuYTt3PXsgKRv7OZqDz
         1C59m9gmBpt5RiTiRySxluqq68HHzM0cPwYZ22No7CQ0NFi9DIEm1bij8oMRzczLvKSG
         CIzg==
X-Forwarded-Encrypted: i=1; AJvYcCUu462LdZymuBbUEc2REsRM6Kamx/PkjUTazTNKTGEtGzZJZVFbdf/H84zPI5YpyV9JX2cdT2GVwUKZNo6yKmemh07h7nP1nOi97Uhq
X-Gm-Message-State: AOJu0Yz2lrDpSMYiwnCMl+jn3lRRmWdwiEHiPC5UaxEZkEGln5TUzjF9
	WPIB3Q6d3Xrv0stjpcBraaoDPm3WkpOMtKoN0MTO1bM46j0Ml4oFMFvvOUwAnl8=
X-Google-Smtp-Source: AGHT+IHJ+k3q96gkiNx4O1VRjqwvvQM6h0PmO0ZbYeZFT5gD1l1NPwbOgm2RMmcK2waLpaq8Sbt/HQ==
X-Received: by 2002:a05:6a20:da81:b0:1ac:efbd:dc46 with SMTP id iy1-20020a056a20da8100b001acefbddc46mr5597081pzb.2.1714021644464;
        Wed, 24 Apr 2024 22:07:24 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id j9-20020a170903024900b001e8d180766dsm10760282plh.278.2024.04.24.22.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 22:07:23 -0700 (PDT)
Date: Thu, 25 Apr 2024 10:37:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Portia Stephens <portia.stephens@canonical.com>
Cc: mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	rafael@kernel.org, florian.fainelli@broadcom.com,
	abelova@astralinux.ru, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stephensportia@gmail.com
Subject: Re: [PATCH] cpufreq: brcmstb-avs-cpufreq: ISO C90 forbids mixed
 declarations
Message-ID: <20240425050721.vks2bq7gqwl2gfpe@vireshk-i7>
References: <20240424050220.889814-1-portia.stephens@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424050220.889814-1-portia.stephens@canonical.com>

On 24-04-24, 15:02, Portia Stephens wrote:
> There is a compile warning because a NULL pointer check was added before
> a struct was declared. This moves the NULL pointer check to after the
> struct is delcared and moves the struct assignment to after the NULL

            declared

> pointer check.
> 
> Fixes: f661017e6d32 ("cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return value")
> 
> Signed-off-by: Portia Stephens <portia.stephens@canonical.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

