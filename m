Return-Path: <linux-kernel+bounces-12797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F88A81FA2A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6D92852B4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5491F9D1;
	Thu, 28 Dec 2023 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="gGN9rLI8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED0F513
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d5ab2f9f1so24551615e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 08:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1703782743; x=1704387543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJkw3kMfw4c7+0aPOU/382bF1hMC8vk98/y6RCWuVXs=;
        b=gGN9rLI8hHJjgC/bAtsjR0B5MC+34HnQRgGoA1UwRtqpmFstl2p5P9+gc6JuPkVjwC
         Ztz7T5ZWe9UBst/+Kq3k2By8LDdadE1ZHiO7/HLB/ooNZ+1cKjQUCj9vn4KPmVOn1f5j
         6N3f+lbS0Ugi/k25HvDyd0wOiO6Mp2vY6Xp3Fl0C6Ty4ACnCJrqV8ScBFbTKxaASlMnK
         27417QjXJHeeXNPOKFWYgUTeBKuMnjzZD8hwrOQip4Ov0dvfkHuBYx17Op/WtYJJFX44
         LSXYRDVgHIfO4j75OguQV9dmFOenldm9BQ5X14PO65bGYEJWM8Ff3lhOv1aEgLuNH5ob
         lvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703782743; x=1704387543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJkw3kMfw4c7+0aPOU/382bF1hMC8vk98/y6RCWuVXs=;
        b=tq2aFZkKuVC+IFZe9dcXLRT9wDsL545oEQeabwrZzFIlOr5Q8Nz6/XLIWc8UHw/c76
         9osM6Fr+pX7EnK8Lj7z38GKp4/pmgWvZvLPbI2UUitZ7lV+SF7hOasxIZ+Czw6JUN/zN
         5J2SJaKB4Pgch1V2lAxTYAOBDO5QgWV0ebzYAczab9svZ/TMz/WhVcS20LbKUdQUbgn6
         RYs2f3knmMmnuM5yn+zILR/aUkaVBQWyeI0MDnB+S0D2QF6RtCl4Ryjniqzm+FctTVPI
         tnGFnPiVOn4lzKD5liHEhN3ZJePD4YguSlp4GNM9a4DYnQOX8744a3sd5zyzBA3TyvB7
         oPTA==
X-Gm-Message-State: AOJu0YxE4ScGuSMoSroHZCzVoydnHVjyPF2OM88wjJPdDAR48yX5DxGs
	AesyuS/fGxzPnuA+9vGKSgM4tKM8qnInRA==
X-Google-Smtp-Source: AGHT+IH7bPqpbYnbSKS9iLDqgXE0pweTMlZ6RMG8DNsA1bAhDM0jgnm0wwEh7m3MP0lcZcEyRBpvcQ==
X-Received: by 2002:a05:600c:a04:b0:40d:6f02:cbef with SMTP id z4-20020a05600c0a0400b0040d6f02cbefmr309420wmp.59.1703782742789;
        Thu, 28 Dec 2023 08:59:02 -0800 (PST)
Received: from airbuntu (host109-154-238-212.range109-154.btcentralplus.com. [109.154.238.212])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c198700b0040d579817b0sm12545409wmq.15.2023.12.28.08.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 08:59:02 -0800 (PST)
Date: Thu, 28 Dec 2023 16:59:01 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 02/23] PM: EM: Refactor
 em_cpufreq_update_efficiencies() arguments
Message-ID: <20231228165901.q4sj43wkpiy2be2t@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-3-lukasz.luba@arm.com>
 <20231217175812.s5vaabxtm4cgil36@airbuntu>
 <89df2982-5492-43db-8e25-d974ff19fda2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89df2982-5492-43db-8e25-d974ff19fda2@arm.com>

On 12/19/23 10:30, Lukasz Luba wrote:
> 
> 
> On 12/17/23 17:58, Qais Yousef wrote:
> > On 11/29/23 11:08, Lukasz Luba wrote:
> > > In order to prepare the code for the modifiable EM perf_state table,
> > > refactor existing function em_cpufreq_update_efficiencies().
> > 
> > nit: What is being refactored here? The description is not adding much info
> > about the change.
> 
> The function takes the ptr to the table now as its argument. You have
> missed that in the code below?

I meant the commit message could be more descriptive if you care to expand on
it.

