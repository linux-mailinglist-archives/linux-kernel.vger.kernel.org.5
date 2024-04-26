Return-Path: <linux-kernel+bounces-159995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F1B8B376D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464AE1C20FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8584A146A88;
	Fri, 26 Apr 2024 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXfrl7/U"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855EE3715E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135596; cv=none; b=NVbNiNPFksBPVbCCshvQSu9jvvDllsBS/CT8H8Xi0R16Pum/Lso0K0F2Anq4Q4r5rH+x/aYlwIdBzGZ60dPU9hUdauU+XittGZ+fnFf6Su9JKJHFkwMrbBkAiodYao9acgBfJfHJ+/AVFt8v7Ar8gCKBanyeTTlZRw+DdNbKxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135596; c=relaxed/simple;
	bh=U38lBxBdbJAthk3PLgTGuFCWuSMCMjm4213qHVnCgSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K46TgI3Yj2zESXmr2VvS5XfL1U8wjmMzj1vdTqCYeaJa0931a3fwPb6Rsg9kWRlDhEHagDGLXGrsyFzftxHs95SxkoAPZOwEQmg8uBncYm/h3zCOisaw82q/9B+fA2SRciRNVxALYdKXyRMgQDbUAPdKUkOUQSe4AiWSWEo8700=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xXfrl7/U; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ee13f19e7eso1987746b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714135595; x=1714740395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPGh0gHVMZemht/wTDB6oM+5daI9kym71AAC6ctQhF4=;
        b=xXfrl7/UJp/jiVikZrxjWQfIhsaGU2qw672qSw22/5tjU+Xks0D4RdLAxQ9N1xOes/
         216wnAQTS55IS0w6b6utgKBb3KpUAs7U0dZjNgUP+fI3ag/OIHeqIRmRsyo9uWIUMlcE
         tPEOteISeaJaekn/srA3bERXqeA2dKhVirNuggIPVrDAqALnnta2LykBltnw410Pvrn/
         xei+t3umw5aG6uTiiymYftdXbkIsFD0pMS9i7L+jZXy3B4va5Agaeg4DE+vT0yVsJPhE
         mAQ59l7Is2WmhMgG5Fod1/yo/pTfTmMXhZQyukXkDDd+Y717aSYZ01ALmQfyXenMa+gx
         8Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714135595; x=1714740395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPGh0gHVMZemht/wTDB6oM+5daI9kym71AAC6ctQhF4=;
        b=P0dXdWEe5wo46Hy8wmfR7cbo6Fn/A9XAZoTUOItaFMTUcFzrgjODynZAAtf50kmvNA
         6oDSkEbVE1+XgMUg2B25+JZVzcbYjUb6jS2FeS6TAFsd+rpPy0947uB6ZkGXHcsUICNs
         IF0qAuw8qHopI+qqbRLj5PYnkOuA/efVPWKbeWCZblv4RPn5FzG1IA5LS61o7txplFwg
         DC52uWPii6kO+y9TwO1Qfb8ez3p06TMsoErnPuhhgsuCC7NiOfcVfD3ILjX1dPV74tBc
         7vDHyWxBkrNZXb3fyVThbf6/t2nxO7fALI2uODlEF/HFMU2lJdaWPaV1j5hwnZMA4RpF
         8h+Q==
X-Gm-Message-State: AOJu0YyaHrS19HATH5fqHYgoEIu/Kx7sQEyMPKrEXuuNIb0i4possiwO
	NtypBzc3A2sSiJBP1mJ5MWP+HBI4XjAc5d2IROf944HwhX87Ey+GRgYcosJA5Xg=
X-Google-Smtp-Source: AGHT+IGAUEFjtMciPj0WTl57ecfVy2di6KoPWw+jQLFGgzZkcfYdqLC/5IZA9LUBGvufMoOH/niw+w==
X-Received: by 2002:a05:6a00:4b48:b0:6ec:d972:c3d8 with SMTP id kr8-20020a056a004b4800b006ecd972c3d8mr3012610pfb.10.1714135594609;
        Fri, 26 Apr 2024 05:46:34 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id d2-20020aa78142000000b006ed007b3596sm14800145pfn.69.2024.04.26.05.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 05:46:33 -0700 (PDT)
Date: Fri, 26 Apr 2024 18:16:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the cpufreq-arm
 tree
Message-ID: <20240426124627.nscubryyy77pp4nz@vireshk-i7>
References: <20240426065343.4a29617b@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426065343.4a29617b@canb.auug.org.au>

On 26-04-24, 06:53, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   51090b2ef6ea ("dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM4450 compatibles")
> 
> is missing a Signed-off-by from its committer.

Sorry about that. Fixed now.

-- 
viresh

