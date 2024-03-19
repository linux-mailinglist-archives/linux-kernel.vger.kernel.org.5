Return-Path: <linux-kernel+bounces-107054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5C087F701
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10AA1C21ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD57C6CE;
	Tue, 19 Mar 2024 05:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JlWABp9j"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8884594F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827657; cv=none; b=pvuMuIlq8JQ3ZpUUvC42pSTlY+me7wlohqxWTc3Cnui4jxY0G4jWzFWjIaicd1PRnVa6H9PIu5IvBpEgtbKcdU823xd0YbcQvxZGwtgqnGxEIIdIkUrom6JE/Z1SgnOkYOsP38J8ZrYlVLJQg+DVWUcnePztDe6RoI7pTMjb2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827657; c=relaxed/simple;
	bh=1hih6VSpKV8xqGVxi4o4YhgWg8A3pPntjmOFpkgpVZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFEVLZJcXd54RyL2B/bpy41ToSJLsW9YeVJT9FVDhYcjG4MYqv43HBMcKQ4A6/AWHqVy2NNvan5UnkvSkMMLpTISbrnODvMA9umLYyNnHULOTwAtxSBw3OQKHtgSFFDsT4X7b7ZCI9VC5ycqMtzrxJ+rbuDW0yUKN+k7wBkinQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JlWABp9j; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34175878e3cso1042072f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710827654; x=1711432454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vl6AA9br/anlnpNsGMnkWOpzBxrWrKpWnKKq2r224oo=;
        b=JlWABp9joYdgeaOpU8Kvf+9q18vjOHAevhyHScmXidU4MWSxV1yoxrmrxPy3vrO/dt
         zbsC7+JzT3WQVDn9z6ikBxVf7qI5lfuyd9nKKyZGbrmFfC8OmfVAkJjfbE1gvB6cHxZ5
         JsRu9kWSldTGmtquxVA+WQ3FxI7c4EnPKp+zj485EC0iVA3ry/bH8JS3aaw4RlEFaIJo
         y2u8JYV5g3WM41sToBEmH1e00m49NFbwPRF9xYQW2VTwKmqRbOqjCUUbfrLtBnbTvBee
         uBVHvE+RVCEC3Sh63kZqadamFsHxmHgxklg3I2sGW9A2vVNMV3CQdsWm93u76hYNLCae
         auFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710827654; x=1711432454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vl6AA9br/anlnpNsGMnkWOpzBxrWrKpWnKKq2r224oo=;
        b=IqkVTmQaLyx76cKOJtGFTOxqihqOsnhyxgRUTlKMz2dAOb4mu3kjew7E2hVmbxL8J7
         6WI1HucpS8rsVdGWlAVm5MbgxVQmBjFbm0ysHebs72PQXwA5j8a4ymCsG1Ypoq9sG8Ai
         Lh+4Du1DgJLjR3HCNxTKj6TX7nTIiyL6WpAB2bPqaAFpvSiB+4PGFmIY3PyYyCD7xfpI
         gBwcQ9XNlhlDPq7DrC5pBINjXZOdxdpZ1h+/UCRehERfUHsulV+Ppk/mFZK0AltPcGcK
         Zg4V84SbfcdAr9EOyMiK0BO57G2shP8j7xsTdY8vEDRZ3P83s5Q+1hvH2jzp1nNnU/Md
         9r+w==
X-Forwarded-Encrypted: i=1; AJvYcCWT2jy+kXaDV2mzBcVbMG9FyNP1FhNGxLNyStiKcQbnIG28y2kPoJ2F1e0DwQrfp9CX9mNpflaDxLWSq8OkPllrqYFE5jqUPgS5cfDi
X-Gm-Message-State: AOJu0YwgFdCiGrznJXpfL9xFNnaSmv3CpzGxQwNQGitYdA1lD6Vry0ng
	H3vn7J7YKrEcyEPhiEdzIXQcc3YCx8B779ryeX8L7fV5f6u1V2Rx091amkV6LIY=
X-Google-Smtp-Source: AGHT+IElLSQLz49jl6r3n4FmIzslQwWn+SuuJwo5rV6apuyC+62iDEgiFx46QapPIPE18jQwDqHimQ==
X-Received: by 2002:adf:a494:0:b0:33e:6a17:3e63 with SMTP id g20-20020adfa494000000b0033e6a173e63mr7815867wrb.47.1710827653420;
        Mon, 18 Mar 2024 22:54:13 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d44c5000000b0033b87c2725csm11418889wrr.104.2024.03.18.22.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 22:54:12 -0700 (PDT)
Date: Tue, 19 Mar 2024 08:54:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8712: Fix line length exceeding 100
 columns
Message-ID: <51060bc1-7d1c-4687-ae20-864e65068858@moroto.mountain>
References: <ZfiNNvks6v0JGhRA@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfiNNvks6v0JGhRA@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Tue, Mar 19, 2024 at 12:21:34AM +0530, Ayush Tiwari wrote:
> Split the argument list of the kthread_run function call across two
> lines to address the checkpatch warning "line length exceeds 100
> columns".
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> 
> ---
> change in v2: Fixed the alignment to address checkpatch.pl warning

You've created this patch to be applied on top of the v1 patch that we
are not going to apply.  You need to restart based on a clean repo.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


