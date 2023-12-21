Return-Path: <linux-kernel+bounces-8942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C54881BE5D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12831F24C72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D502A6280B;
	Thu, 21 Dec 2023 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3UZnG01F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC17C1E48C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d3102d5d6so6195e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703184115; x=1703788915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwZTHk3UTSsz5JMRNija8+Bfh2RqE8ERmTcvnZMhCzg=;
        b=3UZnG01F9yoXBiRSx7/ydQACMEcfG39tAOo+91dGVpWPz0Yo1JQCBMiAg4bNtw8Xga
         O4eGx3Qo/FMvEwOGpVHeGb/lxXnt+5+i+OlSNCEcaSqv1FSejGhGIgiHGH+bc3+o9nan
         e4SHoNrCV4yapqgbIIOFeL62rDbPaASUetD2jD0oxk9yOKJJF6d+kbGXN9zY5BBFFOEE
         0uXPchZKSqupAe117UXC758zx2hIVn0HtIKvJxKGc0vGibZaOdRVq3HOxzBB1eXn+Cwr
         Lv0YZoeGSYjeFs9FcvjeUOC7DkLpwy6a4pvKGPVGnmaeoTEUgq1famkfoVqv2X/hb0yt
         wukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703184115; x=1703788915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwZTHk3UTSsz5JMRNija8+Bfh2RqE8ERmTcvnZMhCzg=;
        b=ZwYiE4YHRePYqX8m1dM2odljXCL8q8BW32heN37bHU7plOCZ8MJOiGAzGu0UBfU7ab
         Dxn07KXI+WVIiTgpa9DBuVwnL7wgOpH7hJYIbsxrFnQ1RbXS0k6DVpeuf3Rqm2MvHiPU
         pY+xSQCqAIoy4KZe+VQ0Ufh1UhxBtqmcf5rVI5vz86wTjjjC/2WEH+Rp7ZpCdYtonjsa
         zZiFmDMe3nLSfcJMyn7xO9hOOAgbJQ9vG0RZAmaScD/hPmTloKDPviR59UAGcnQDE6QT
         N4YAZ+ia8myqcUniYdPsP8s94wJopuYcJqjQgFnJvTUHR1JqAi+GssL9LAPXRDM6Y8pp
         SnWw==
X-Gm-Message-State: AOJu0Yyj5IouK60H9sVwdUKJwPSY7uFlYymRcgr87dOji0ypHsvE9YOi
	wR7IWpZgit+hmAwTi4PbEvnav/qPpgH9dXBa2DfUcu+T282t2oU=
X-Google-Smtp-Source: AGHT+IHmRtbvypnZnpOZwWfjpjGEUn4VFd/E7QiMtlf9JClG0PYD+H6AEfgvooHxAe2DNf7e962CdQ==
X-Received: by 2002:a05:600c:982:b0:40d:3fbd:dda2 with SMTP id w2-20020a05600c098200b0040d3fbddda2mr234wmp.1.1703184114704;
        Thu, 21 Dec 2023 10:41:54 -0800 (PST)
Received: from google.com (185.83.140.34.bc.googleusercontent.com. [34.140.83.185])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d530e000000b0033668ac65ddsm2592115wrv.25.2023.12.21.10.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 10:41:54 -0800 (PST)
Date: Thu, 21 Dec 2023 18:41:52 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: will@kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
	mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	vdonnefort@google.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v4 00/10] arm64: ptdump: View the second stage page-tables
Message-ID: <ZYSG8JvOGy8Silz1@google.com>
References: <20231218135859.2513568-2-sebastianene@google.com>
 <ZYSFrFDHKo_ZTkxM@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYSFrFDHKo_ZTkxM@linux.dev>

On Thu, Dec 21, 2023 at 06:36:28PM +0000, Oliver Upton wrote:

Hello Oliver,

> Hi Sebastian,
> 
> I'm going to try and review the series a bit more after the holidays,
> but in general this is unecessarily complex. Furthermore, building out
> the feature for pKVM *first* rather than 'normal' VMs makes it all very
> challenging to follow.
> 

Thanks for having a look. This sounds good, I can split the series into
two afer the holidays and push a new version because I am really not
happy with my current state of the patches (especially because I
discovered some issues after I subimtted on the list).


> I would strongly prefer that this series be split in two, adding support
> for 'normal' VMs with a follow-up series for getting the pKVM plumbing
> in place for host stage-2.
> 
> -- 
> Thanks,
> Oliver

Thank you,
Seb

