Return-Path: <linux-kernel+bounces-124255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA60891474
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831BE1F22F9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D523340873;
	Fri, 29 Mar 2024 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+XFv2c9"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844A337152;
	Fri, 29 Mar 2024 07:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698199; cv=none; b=E9/5jU0v7fFDW2m7bVqy7BmKBWCpFh3+jno2rlh7kxVO3/s6cAtePPEzVVyt/HyJw60qasDkSfXPPynWEUaylBq7p4XLo8wq94BybejsamIXzUv8qjDKNNDv6sfr7Zclkh67kWv+6y2vT6dvBCWnuWPvpHBeFeotLkzpuWwl278=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698199; c=relaxed/simple;
	bh=FvFma6wKIx8yA4Hz9Pt9JN8wMlJPx5hRoa8V9FhhsDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM2QeArh3gzKOF48oz20q6Rdr/cBB0i5ZCTufOhWQEFt39kFRwvzeBn6JOEA/20rL2wzU1Za8J7thkK5mZ/0tXTwIG/4nFV564hUbJ82CU60pmfFh7ejykS5xN34KZ8AkMMb4k9MBAuEgx2zTKIiwvcjeM6RIwvQwcjLkKm41ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+XFv2c9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a466e53f8c0so217922166b.1;
        Fri, 29 Mar 2024 00:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711698196; x=1712302996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1GqML3E9IQNFqyYxYdi7v748JJTsivkrRrprbO0bu0=;
        b=d+XFv2c9LrBiXUtoRYW5v3HccWeiclqzlZCzQjsph1dAsi5HdhRM8fWBaxZL7xSo3t
         EFHvlbzIyElLhvzLpzhmnmJejtMOU9JtYeMjSDRuLx1WXqQLgvOIsKerKLTCqQASWRlk
         NPJ9oUeHJBcpZcb4wKoCM4aVdq6EvVFZSASF5xCe2/ZnUK7OTpg8ZHYRyoFRGS2GUcDm
         f+y0TQG7rFvfX+bDU+Elu+iyPowibjh174125v0eFmdjzH/hpDYXsEk7kYj6FtM3cn3H
         NNbU8idu9vT2s9JywjnfVthXRVbVKvsLb9N0vHvhl8oKpqC0j/3g0uceJOc/fuVVOkmH
         RkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711698196; x=1712302996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/1GqML3E9IQNFqyYxYdi7v748JJTsivkrRrprbO0bu0=;
        b=td+GM4WFexVY+DiR+5ObiqoZxqxhHKTYrSxnR5svnp1OoIrdHowmspimpY6habNzGL
         m3QGLmA8ahlf5/uxm5KXNTSntg5go8fB2eeSZwTo5e77OL3mg57eKL9BjiX1l0qWZbXv
         kBOxyM7HbjnrAtDS9IKUQvtEjrSsKanliVZVuag4bSxIaX680v3Xtaluwoh74lWScbMr
         DXNhEdwIimpabAWrqCtBr83PGOCHTlsSjLSc5eW5ZgfDof+jEYh7Ci+siPw3pjm9XSMP
         DzB17knDtOylta9YEL08GsTcw+4WgdhRdhuAeSYj4W9D8OvPkkEUb5v30ZpepmQeXOVv
         sQKg==
X-Forwarded-Encrypted: i=1; AJvYcCV6NK6xatRWYBTGk2Ra2m/YvlsXb5uwy/ZvzW12rqbcBZkOiX9y4bdKr8e+93r+i1vpeXLExPSTS/CEjB2CXbRfwW9Nd+cAGCAAr7LM8zgq2jtsncnxCV9rdhlZGNtFFF7k
X-Gm-Message-State: AOJu0Yx2T/elBJLMY4ulprMYyj4MnXsi53zTe/8/0BIZ2yEp4lERvFL/
	53/1G8ySnWUPSI/m7dWVdih5Lkj5VR3iBN/2Nyj+5LA0fhQBvrxB
X-Google-Smtp-Source: AGHT+IF/GWh0I2FC6gMF2DdWsHl0+T92DodzN5cejRHFxFzf1FNiC9ZnOxylXZcW3i4h0V34lNCrlg==
X-Received: by 2002:a17:907:20b6:b0:a4d:f56a:19fc with SMTP id pw22-20020a17090720b600b00a4df56a19fcmr994404ejb.13.1711698195583;
        Fri, 29 Mar 2024 00:43:15 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id lh23-20020a170906f8d700b00a46ab5aaffcsm1636675ejb.178.2024.03.29.00.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:43:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 29 Mar 2024 08:43:13 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
	tglx@linutronix.de, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, song@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] perf/x86/amd: support capturing LBR from software
 events
Message-ID: <ZgZxEcRuYBO3N2WY@gmail.com>
References: <20240328133359.731818-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328133359.731818-1-andrii@kernel.org>


* Andrii Nakryiko <andrii@kernel.org> wrote:

> Now that it's possible to capture LBR on AMD CPU from BPF at arbitrary
> point, there is no reason to artificially limit this feature to sampling
> events. So corresponding check is removed. AFAIU, there is no
> correctness implications of doing this (and it was possible to bypass
> this check by just setting perf_event's sample_period to 1 anyways, so
> it doesn't guard all that much).

> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index 4a1e600314d5..75920f895d67 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -310,10 +310,6 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
>  {
>  	int ret = 0;
>  
> -	/* LBR is not recommended in counting mode */
> -	if (!is_sampling_event(event))
> -		return -EINVAL;
> -

Could you please split out this change into a separate patch?

Thanks,

	Ingo

