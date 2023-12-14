Return-Path: <linux-kernel+bounces-61-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2870F813B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25001F221EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E016A32C;
	Thu, 14 Dec 2023 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8y+kedQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C468B99
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5e36848f6c6so12555227b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702585294; x=1703190094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0wx1hqqMyfv3pgRgZ5ojp2Fytlta9hGiEwGZy5N6JD4=;
        b=F8y+kedQIPfWURjaDthTeivUxFN8aEh4B94LaJ3hBlMVz2YVp2/c1x3tE7AH76nMJb
         TlN+BaOxR1F1r/W/uQnWd5/9l5cXpBHo6nvUxGKwuwsxn9sADiGhG8fQFM3xWoDnfCJV
         cKgmVNHfz7UG3aucvTNW4D7re//ctnFktZ7n2GrsraxcuIOz8wL44vg1uC5lrXmeYSWq
         HObeTST3hSLd9xbQ2l6O027mTEaf/KtA8LH2TzwwuUZsVchM+Nmq1LsBMDxrQVwS+9K6
         V9Svw5MXUBkL3Kf2tv8BmyhL9zYEC/WeQ+q5M5oJ7Hg6mCcaRpjfmFJlwZUYFy/jfDrR
         j39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702585294; x=1703190094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wx1hqqMyfv3pgRgZ5ojp2Fytlta9hGiEwGZy5N6JD4=;
        b=fszNc5Mr6tUsPzgpAcsoTDzF7UELHw5Jqn2nrDU2iASOyQg2iriOle6rPXCUsMY4Zk
         S2XVResj85TgxIJ1nJF1iqYg3CmcZj1VDBIWY0QgAddVflm229OD0SOVhPOJ5uzoTIqv
         Q9yE4ZpjgTJRPta/QYWY0XicjKOXUKE4MOZv4o/Ws51cY/J7OBwn0WUV9/5N1FpMfOH5
         Y77KY2orK6JlQ6VugsIu5PucPiJO9/cP/aheaWSPMk9WTPLxsIG3fGFbIN66y5T6QhKb
         4i94BiHmwcwVbCFPqe7NciTVZCI+S9ydpZr9EUI13TzNozcH49WUlO17GOa3Lyg+6tQu
         xfDA==
X-Gm-Message-State: AOJu0Yw5juBkkZ8NQuvclN++4djgQ6HegBZRRcmFtMcmUh9wGp/c3Si4
	9y3+K2XleDRFRdm+ukZOKrc=
X-Google-Smtp-Source: AGHT+IH6MVDnIfZpDTYJc+kzuqNRej0Kpgze/9LKxdZYLtUlmHEhTb2/k7vIFa/q+pFVHL+MlHqWpA==
X-Received: by 2002:a0d:e68c:0:b0:5e3:4879:602a with SMTP id p134-20020a0de68c000000b005e34879602amr2164949ywe.88.1702585294417;
        Thu, 14 Dec 2023 12:21:34 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e177:373d:4717:ff6c])
        by smtp.gmail.com with ESMTPSA id cg4-20020a05690c0a0400b005d39efe78f4sm2763406ywb.50.2023.12.14.12.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:21:34 -0800 (PST)
Date: Thu, 14 Dec 2023 12:21:33 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Potapenko <glider@google.com>
Cc: catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
	andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
	aleksander.lobakin@intel.com, linux@rasmusvillemoes.dk,
	alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, eugenis@google.com,
	syednwaris@gmail.com, william.gray@linaro.org
Subject: Re: [PATCH v10-mte 7/7] arm64: mte: implement
 CONFIG_ARM64_MTE_SWAP_STATS
Message-ID: <ZXtjzQmnOz+GGPGW@yury-ThinkPad>
References: <20231214110639.2294687-1-glider@google.com>
 <20231214110639.2294687-8-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214110639.2294687-8-glider@google.com>

On Thu, Dec 14, 2023 at 12:06:39PM +0100, Alexander Potapenko wrote:
> Provide a config to collect the usage statistics for ARM MTE tag
> compression. This patch introduces allocation/deallocation counters
> for buffers that were stored uncompressed (and thus occupy 128 bytes of
> heap plus the Xarray overhead to store a pointer) and those that were
> compressed into 8-byte pointers (effectively using 0 bytes of heap in
> addition to the Xarray overhead).
> 
> The counters are exposed to the userspace via
> /sys/kernel/debug/mteswap/stats:
> 
>   # cat /sys/kernel/debug/mteswap/stats
>   8 bytes:      102496 allocations,     67302 deallocations
>   128 bytes:    212234 allocations,     178278 deallocations
>   uncompressed tag storage size:        8851200
>   compressed tag storage size:  4346368
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Yury Norov <yury.norov@gmail.com>

