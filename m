Return-Path: <linux-kernel+bounces-91585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433B8713F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4FD7B21888
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DB029410;
	Tue,  5 Mar 2024 02:56:17 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7028E02;
	Tue,  5 Mar 2024 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607376; cv=none; b=D8uhxWBp5vQFCVztSHZwmVGJMk/Ras7pI8gwKl/KiMRUdR4T+6JovI/MGKH2XEKUwZORSRn12IjW8heOjDyprcZUO3Oo11Fk4JdCeek/JkKXskp2bQIwWu5cGI9XugNI34FlfrYQwCiZR+ijPvJKzoKFmL9ucso/zldkE+1N3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607376; c=relaxed/simple;
	bh=nm0aa/Wui7JHK1QhSDJ6wB/F7wstMAU998YigIZupeY=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AZJOwrem72btMo0vP71eoPVCbRY+PVSogVpufo4Qzi6pL/J/oIdAyZmyFBteCDyeecoSB3JldzeNCD7Xg4yGLSjEddaqmkdSdeYnWL4Bg9U1RiKfNopPQlBRm4DFFq5jIsyjOV9QBTz9kOcdUepyyY/rOfBKj3oVree7uPHOOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TpgB66kKKz1h1C5;
	Tue,  5 Mar 2024 10:53:50 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id B633C140158;
	Tue,  5 Mar 2024 10:55:55 +0800 (CST)
Received: from [10.67.111.82] (10.67.111.82) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Mar
 2024 10:54:37 +0800
Subject: Re: [PATCH] usercopy: delete __noreturn from usercopy_abort
To: Jann Horn <jannh@google.com>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
CC: <gustavoars@kernel.org>, <akpm@linux-foundation.org>,
	<jpoimboe@kernel.org>, <peterz@infradead.org>, <dave.hansen@linux.intel.com>,
	<kirill.shutemov@linux.intel.com>, <keescook@chromium.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<linux-mm@kvack.org>, <nixiaoming@huawei.com>, <kepler.chenxin@huawei.com>,
	<wangbing6@huawei.com>, <wangfangpeng1@huawei.com>, <douzhaolei@huawei.com>
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <a6591565-2c67-13fb-746e-b3040657212b@huawei.com>
Date: Tue, 5 Mar 2024 10:54:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/3/4 23:15, Jann Horn wrote:
> On Mon, Mar 4, 2024 at 3:02 AM Jiangfeng Xiao <xiaojiangfeng@huawei.com> wrote:
>> When the last instruction of a noreturn function is a call
>> to another function, the return address falls outside
>> of the function boundary. This seems to cause kernel
>> to interrupt the backtrace.
> [...]
>> Delete __noreturn from usercopy_abort,
> 
> This sounds like the actual bug is in the backtracing logic? I don't
> think removing __noreturn annotations from an individual function is a
> good fix, since the same thing can happen with other __noreturn
> functions depending on what choices the compiler makes.
> .
> 
Yes, you make a point. This may be a bug is in the backtracing logic, but
the kernel backtracing always parses symbols using (lr) instead of (lr-4).
This may be due to historical reasons or more comprehensive considerations.
In addition, modifying the implementation logic of the kernel backtracing
has a great impact. Therefore, I do not dare to modify the implementation
logic of the kernel backtracing.

Not all noreturn functions are ended with calling other functions.
Therefore, only a few individual functions may have the same problem.
In addition, deleting '__noreturn' from usercopy_abort does not
change the internal behavior of usercopy_abort function.
Therefore, there is no risk. Deleting '__noreturn' from usercopy_abort
is the solution that I can think of with minimal impact and minimum risk.

If you will submit a better patch to solve this problem,
I would like to learn from you. Thank you.

