Return-Path: <linux-kernel+bounces-76546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8585585F8D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A36E286F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D3A12DDA6;
	Thu, 22 Feb 2024 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghW4uGTd"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6AB12DDB0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606334; cv=none; b=AsHPbrzSMVnZ68Sbw6vdqQ1oJaTQRnt0Sm32D661HrBlfiu5W0qxSz3+aB3oSkhsdQRQz4VpPCccalcTHR1ooGBWVuCAkZ3SKMuLlmOkhWIh+sfC+IV2TfP7DoOgao0IPDjeYj1hoOZMyD+PzA2cC2dsAFuABhTvixCsqv2SyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606334; c=relaxed/simple;
	bh=YZgo82B41d//o7sDxWxpGAe2B+3IYZxwhge5g5/PF8o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHeVd4/hsVv2E3XZ+Zsl9ELzFqzAreAO+m0lg1uhpBLkwNQTV0hdPNBfP772J5rnrwhVDjynNellc9M5D1W1gPCPcEYmYfBi+KJtY1LB+/uT/NQnBJE01bR/mI5i6lurAuUxFcgse7AofSOd9q1mkyziEzFXuUNlxLw2MG7lp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghW4uGTd; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d220e39907so89950931fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708606331; x=1709211131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R4bu1C98vBLZH7tB289/lMNViA1falfSyt+9+Xa4zfw=;
        b=ghW4uGTdQaN6oSdrU8Ims7GkX9lu3xReuDrBg2QJwFDYTneoZCGU7LVDtRob2Ze21J
         1k5NsajbNR6Mg36vlFWBxQU3TjfmN/y80vMmt9WCOwUe1ZqgIfnvCKD6dmaqP3VglYKj
         ZhP6Q5PjQvRYTzr3gYp5KxaPwzQNH7b860JLY0oqnkJRN/GoNSFtD7CmNZTR9AatQJvn
         J0Y4czLornVL9XaPih+PKRKkGTh9K57MmjZYsyeOCZL1C9nARfDJT3eLJsLP4xQwH4JH
         E6Lw93iOoEblFGzydIj3Ycqv/AXp1IrdWiFX9tR8Jm61H2kAQMqf9aH15+y4LeTTxAhi
         9dtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708606331; x=1709211131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4bu1C98vBLZH7tB289/lMNViA1falfSyt+9+Xa4zfw=;
        b=bXxp3QkQtG2u7ZERUZyvphhcyQ+2c/bLZjB2E5c95PMmUue02uUmDU41aw+1eql4Dx
         LicPzZnx6J0RzZNqGqBRufo8sN9kqaQ0xAoU8lR2jfoeTSWjUccNWTyVHZPlM0NMyUH7
         hLBx8/QUIa//qiQJPyZNYkz1+bFyjDiKGUwl8i5Fi3Bsu4fH1mgH2ZyVA4WQF95XuKU/
         Bq6xWu0vEZBEMiVs9wag0UgxuaKS33H2SIS//Db3GE0I/0l9NTLXX83eUFa/mJwpuML4
         DuH5kj+gjkkGotm7gbEDo0ufgwlh9asRIS1C9/gMqCjhdA86+IGUal272eoe1vUt8c2q
         NnmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIez8dfeAftmCP6DlFOFM7WPa26zJV8WIzp/bOjVA8D6IOo6G4DcNodwLi+PkbKWTxkwXLIaSbZUpobUCezjv3ZVDuI4zYShjBvnNE
X-Gm-Message-State: AOJu0YxQyRjz10Z5RzJ54dwKKHCk7Ms3fmJ4Pthql1MyG3ne2fGHj2qI
	B9tH5c7ntx/uV2/4R0A3TF+un67GaOM4aObNxASXnF/UykrwFzUUFpgGIae34Wk=
X-Google-Smtp-Source: AGHT+IFWLo128zbfkmgYSAlGiHCEt+v/eP6YfSG4/bgRWkA1/NShAOAiBcjXHq1XsveclTlN71ur0Q==
X-Received: by 2002:a05:6512:2209:b0:512:b0c1:3bb2 with SMTP id h9-20020a056512220900b00512b0c13bb2mr11453210lfu.46.1708606330867;
        Thu, 22 Feb 2024 04:52:10 -0800 (PST)
Received: from pc636 (host-90-233-206-150.mobileonline.telia.com. [90.233.206.150])
        by smtp.gmail.com with ESMTPSA id k24-20020a192d18000000b00512ab0bb96dsm1882817lfj.57.2024.02.22.04.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 04:52:10 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 22 Feb 2024 13:52:07 +0100
To: rulinhuang <rulin.huang@intel.com>
Cc: akpm@linux-foundation.org, urezki@gmail.com, colin.king@intel.com,
	hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v3] mm/vmalloc: lock contention optimization under
 multi-threading
Message-ID: <ZddDdxcdD5hNpyUX@pc636>
References: <ZdW2HB-XdAJKph5s@pc636>
 <20240222121045.216556-1-rulin.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222121045.216556-1-rulin.huang@intel.com>

Hello, Rulinhuang!

> Hi Uladzislau and Andrew, we have rebased it(Patch v4) on branch 
> mm-unstable and remeasured it. Could you kindly help confirm if 
> this is the right base to work on?
> Compared to the previous result at kernel v6.7 with a 5% performance 
> gain on intel icelake(160 vcpu), we only had a 0.6% with this commit 
> base. But we think our modification still has some significance. On 
> the one hand, this does reduce a critical section. On the other hand, 
> we have a 4% performance gain on intel sapphire rapids(224 vcpu), 
> which suggests more performance improvement would likely be achieved 
> when the core count of processors increases to hundreds or 
> even thousands.
> Thank you again for your comments.
>
According to the patch that was a correct rebase. Right a small delta
on your 160 CPUs is because of removing a contention. As for bigger
systems it is bigger impact, like you point here on your 224 vcpu
results where you see %4 perf improvement.

So we should fix it. But the way how it is fixed is not optimal from
my point of view, because the patch that is in question spreads the
internals from alloc_vmap_area(), like inserting busy area, across
many parts now.

--
Uladzislau Rezki

