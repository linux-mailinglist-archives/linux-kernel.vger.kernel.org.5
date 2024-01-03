Return-Path: <linux-kernel+bounces-15054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C7E8226B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4074928449C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DEE17995;
	Wed,  3 Jan 2024 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YUDZg7Br"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA551798E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 01:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 2 Jan 2024 17:53:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704246840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1HBeL9F4QgXBzp32UM5MYYaWivu3N2MLxcDyqF0DA2M=;
	b=YUDZg7BrIynL8+W5ltZeMwdItKNoDl5tpz246DoW45ctaJgFKhePFvHPXjSb/7ZpH+KaBi
	3hWSlAZ1t9tRPHKLItV+2eD/jdToS3wE+aWvshOEKkOTVQ4I0Xo3MQY1yFms2XKR5CZH6/
	9OaPonCgTpOg1/2ScAba0Rxm6sdOJbM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	shakeelb@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: list_lru: remove unused macro list_lru_init_key()
Message-ID: <ZZS-NLW25Z0M5Csl@P9FQF9L96D>
References: <20231228062715.338672-2-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228062715.338672-2-haifeng.xu@shopee.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 28, 2023 at 06:27:15AM +0000, Haifeng Xu wrote:
> list_lru_init_key() isn't used by anyone, remove it to clean up.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

