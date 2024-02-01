Return-Path: <linux-kernel+bounces-47644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105018450A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C207E28E704
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0A83C48E;
	Thu,  1 Feb 2024 05:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0uKcdaHm"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3C2C1BF;
	Thu,  1 Feb 2024 05:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764591; cv=none; b=Oisk/gjDy67M7z3ZzAFGYl3Ir7enat/BFadCRO7msA0sElegqWP7vgCoGIFUSRatlp8FIufenrGSx0107wQ4b5at5fULJOiJMdJyGUAZH7ur+E42hNc7I5wkQP7+Dy4frwD0uu57x73wXuU42UP3llbh83ZGeAu/Hg5tqk1aNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764591; c=relaxed/simple;
	bh=CvSb+Gil1ji46VexZFFVDkpAh7xY7sGUymNfmluuP8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBYAJJ8Hx+kmnO9c1Vxpm+oke7FixgyT1Bk4//ztPfp+trTRsFxgM4r9Penq9aul43pl/uaa41LAstXiSW5AECcNNXQi/85wW65k5+F/M+iaejmJC5mOgn6lw1uFPhuiqNws/sDLIKIdRfgAST9phj1hymEfB3mPJOxTbzC5SpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0uKcdaHm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Mjh8PuY8+e5eF0GSyu0fRtJSsUkC5zDTJI32X7tIhQs=; b=0uKcdaHmeoMpzFrSRx/owahvGb
	L9Tq+yFiz2oFwHM9zVDVBxg3kJutVEBrB3ACrZP2987brgR4wRDowlJyx1cg32xIgCcne/mxAgmnW
	CJ12Pt8wNFdo15nNqkQ+3Q+qDtC5IZL3GNH6Mt2sM/N9L8gvdn4HIE0czHhS1Ja3jp0dn3TSDLrCy
	e7Z62A/hGyP2+3XoE03fsfTGlAcTe4RIz7UUpZSN2UtJoy/K6kbsTalt3ftgX2jjOjlHgb+6uJIju
	kW1RHN24jhqcZ7yL3tnzgS55Qq409eoGBCAlXePMUDGdgLmxdjWSBc38jZY0QbuZO6iQ1m8i1uaiK
	rPlNGvqg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVPR6-00000006bxu-2Q3C;
	Thu, 01 Feb 2024 05:16:28 +0000
Message-ID: <ac67aa4a-cba9-4daa-93f6-0bbdc0d4ec86@infradead.org>
Date: Wed, 31 Jan 2024 21:16:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/test_kmod: fix kernel-doc warnings
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>, linux-modules@vger.kernel.org
References: <20231104042044.17807-1-rdunlap@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231104042044.17807-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Any comments on this patch?
Thanks.


On 11/3/23 21:20, Randy Dunlap wrote:
> Fix all kernel-doc warnings in test_kmod.c:
> - Mark some enum values as private so that kernel-doc is not needed
>   for them
> - s/thread_mutex/thread_lock/ in a struct's kernel-doc comments
> - add kernel-doc info for @task_sync
> 
> test_kmod.c:67: warning: Enum value '__TEST_KMOD_INVALID' not described in enum 'kmod_test_case'
> test_kmod.c:67: warning: Enum value '__TEST_KMOD_MAX' not described in enum 'kmod_test_case'
> test_kmod.c:100: warning: Function parameter or member 'task_sync' not described in 'kmod_test_device_info'
> test_kmod.c:134: warning: Function parameter or member 'thread_mutex' not described in 'kmod_test_device'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> ---
>  lib/test_kmod.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff -- a/lib/test_kmod.c b/lib/test_kmod.c
> --- a/lib/test_kmod.c
> +++ b/lib/test_kmod.c
> @@ -58,11 +58,14 @@ static int num_test_devs;
>   * @need_mod_put for your tests case.
>   */
>  enum kmod_test_case {
> +	/* private: */
>  	__TEST_KMOD_INVALID = 0,
> +	/* public: */
>  
>  	TEST_KMOD_DRIVER,
>  	TEST_KMOD_FS_TYPE,
>  
> +	/* private: */
>  	__TEST_KMOD_MAX,
>  };
>  
> @@ -82,6 +85,7 @@ struct kmod_test_device;
>   * @ret_sync: return value if request_module() is used, sync request for
>   * 	@TEST_KMOD_DRIVER
>   * @fs_sync: return value of get_fs_type() for @TEST_KMOD_FS_TYPE
> + * @task_sync: kthread's task_struct or %NULL if not running
>   * @thread_idx: thread ID
>   * @test_dev: test device test is being performed under
>   * @need_mod_put: Some tests (get_fs_type() is one) requires putting the module
> @@ -108,7 +112,7 @@ struct kmod_test_device_info {
>   * @dev: pointer to misc_dev's own struct device
>   * @config_mutex: protects configuration of test
>   * @trigger_mutex: the test trigger can only be fired once at a time
> - * @thread_lock: protects @done count, and the @info per each thread
> + * @thread_mutex: protects @done count, and the @info per each thread
>   * @done: number of threads which have completed or failed
>   * @test_is_oom: when we run out of memory, use this to halt moving forward
>   * @kthreads_done: completion used to signal when all work is done

-- 
#Randy

