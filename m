Return-Path: <linux-kernel+bounces-151068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E068AA899
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC79B21D80
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254033A1B5;
	Fri, 19 Apr 2024 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/owIBop"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F65DDCD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509187; cv=none; b=uNC9TvQEGatp1qlqRIaNAgUVU6O2WOMmz1OEFUTAl8O0EQ/btxkW6ZT4hzqSTWhNGW93L40GAeiCnEEd4q5CLPdWcWc7w9EBAwi+k+zwPEJZFIZHp/E4RmrCfYTt5B0oVFylXL1OXnkhMV//vuZpUlFr0pv5hDVY8CoFuMi45FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509187; c=relaxed/simple;
	bh=u0HF41IZwgeTJDQsNauxGr+WavqSpst5cZbgaiLVR9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8BsLSmvQoLK5Cw0xCGSUCauNpFyH1QUXtMOUrSJA+7BxRCKV+id/B8MmiMoyLMKwmhVXLPTPkFrxwC5ogkSc0GbKaFbKwmB+3hcNxW6UqliHCJRkK0rQr7Bsda++wvcU37jnnbrs68XR1awXJSGFWQR2HwB6cIu9JdjhpRFmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/owIBop; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ece8991654so1554804b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713509184; x=1714113984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=likPAjK9PgGVk5+qxCMBfysBI+F/PO0e/FyQV2RaWbo=;
        b=W/owIBopzOD7dPCYJ2XOmjBD+ELNGChEk1AqkXfin1HLtKqfC9Ro/ZUoMfdXCX641z
         N5qEgS77nHwatWXeSznhLBAayJa1oFLHEdmQcbM47Le2Pj9jGun9voRXQdxgATb41XCZ
         C8TMcsf065eZSJfUnVDgH9tfKWim8b84uKJNfi/IjpcJJyjUWIKof5KtcA6E4WKI3Wj4
         7QO649qpB260BNFADZdchzMGoMtTwMj80tLpIV0lQ3bL7UZQSkoporjWDEP3FIwsBQKQ
         4s21A7NzVh32IltPh3eCde9z5ECph6UrD16Np+cIOaHtYbUW+UXWI0jH4uVf3j+65hSJ
         XQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713509184; x=1714113984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=likPAjK9PgGVk5+qxCMBfysBI+F/PO0e/FyQV2RaWbo=;
        b=HU50MNB6xH4L0WmAsmIFEoJn8h4YjBvRKUEKdTIjzkPgMbLB1T+iTk8irUAZMibHCn
         s+VPH1AFk/fDohPQ6g5AVFvU6CUoCCEPep7XFZ9giEEazUCgUhKTFSDP8nVw6KCpjU9s
         ufVPZ7HbBOwjtrVRx44wDp5mrUFaTp0fD3A7pQsep7vGC5E7slBTn+9/PCfgijbAb+9z
         VZQPQlybIuPPkZqUWuID5RWPhAZjqrfgbA71pQwWzUQ2kMYPvat285m3XibDPX7TEX67
         aPagMKbfnqK2p1+EyeodejCH2HIP0rQXaugryYzOA0CZ30rLZs4ejbMgZrE2ayuCCHud
         brIw==
X-Forwarded-Encrypted: i=1; AJvYcCW65qnVXjoftPuijkaXK4G62Z8q+kUYUX/ft0Po/RxXTwXsrMX9vxWeHAvybWLQJLnc5lfcoWj1I6aXiRPKlf+fNuVLhRm3lrYUEse+
X-Gm-Message-State: AOJu0YydVY3eum2TYsOAs2ZV9BNIrIij7ezXCzum1+XanRv3Bx1fPeFL
	rfMLspQqxt66F5corSSsw+RRiRirDPaAyuuPWvtuSi6DlKt0oX3tj2UTO/0C47U=
X-Google-Smtp-Source: AGHT+IHJdn4XMlV/f4j2y8kUhBIVDEUhNZSWwAvnrLM5ep4RxiBIGPPNC3RiVuCyXUa4Dmo0aTOsfA==
X-Received: by 2002:a05:6a20:5653:b0:1a7:bc31:933b with SMTP id is19-20020a056a20565300b001a7bc31933bmr1492291pzc.47.1713509184494;
        Thu, 18 Apr 2024 23:46:24 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id k124-20020a633d82000000b005f7d61ec8afsm905236pga.91.2024.04.18.23.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 23:46:23 -0700 (PDT)
Date: Fri, 19 Apr 2024 12:16:21 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Shuah Khan <shuah@kernel.org>,
	kernel@collabora.com, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: cpufreq: conform test to TAP
Message-ID: <20240419064621.a4qcqt6ck26te6up@vireshk-i7>
References: <20240418153146.2095230-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418153146.2095230-1-usama.anjum@collabora.com>

On 18-04-24, 20:31, Muhammad Usama Anjum wrote:
> This test outputs lots of information. Let's conform the core part of
> the test to TAP and leave the information printing messages for now.
> Include ktap_helpers.sh to print conformed logs. Use KSFT_* macros to
> return the correct exit code for the kselftest framework and CIs to
> understand the exit status.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/cpufreq/cpufreq.sh |  3 +-
>  tools/testing/selftests/cpufreq/main.sh    | 47 +++++++++++++---------
>  tools/testing/selftests/cpufreq/module.sh  |  6 +--
>  3 files changed, 31 insertions(+), 25 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

