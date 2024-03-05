Return-Path: <linux-kernel+bounces-91620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DC787144D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782EE1C224D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEA8381C6;
	Tue,  5 Mar 2024 03:31:19 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AB51E4A2;
	Tue,  5 Mar 2024 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609478; cv=none; b=oGYkSjpNfKFckHClFZkzF5hzSlKmRXWjHatvsWLrIbVhJ5ZB+WYcwPCbdlXMECquS2ziiHr44UiDScr2WY0YzkWgfE4k34Y9YeMWMh4RwUqjnXu0o+xCUW2oBZvDdBnmIHk58qjQYbJ2jPxtO+Jv50JA5TCFqQMranPiKXm+HNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609478; c=relaxed/simple;
	bh=hz7TyFkMZdZVrncX6mmL6FjMOpB3oeS6eGxHwb8aECk=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tXKEyVVlCLlkree7S9052nQAP2elHA+IsJ4q8PqxV6Tv2LWjjgVDxbNkzzN3prRl/0+rirXEov09YCFruLtJaf9Fm4maI0YWLSLlQxnydM3qd9f/kXLMURSwYCII8GlRUqPieKoJ3Zdio+WxjdYR6PJX/VCrg9SW4kINHu6l3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tpgyv2TMfzsX7B;
	Tue,  5 Mar 2024 11:29:11 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 7CF0C18005C;
	Tue,  5 Mar 2024 11:31:07 +0800 (CST)
Received: from [10.67.111.82] (10.67.111.82) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Mar
 2024 11:31:07 +0800
Subject: Re: [PATCH] usercopy: delete __noreturn from usercopy_abort
To: Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
 <202403040938.D770633@keescook>
CC: <gustavoars@kernel.org>, <akpm@linux-foundation.org>,
	<jpoimboe@kernel.org>, <peterz@infradead.org>, <dave.hansen@linux.intel.com>,
	<kirill.shutemov@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux-mm@kvack.org>,
	<nixiaoming@huawei.com>, <kepler.chenxin@huawei.com>, <wangbing6@huawei.com>,
	<wangfangpeng1@huawei.com>, <douzhaolei@huawei.com>
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <77bb0d81-f496-7726-9495-57088a4c0bfc@huawei.com>
Date: Tue, 5 Mar 2024 11:31:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202403040938.D770633@keescook>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/3/5 1:40, Kees Cook wrote:
> On Mon, Mar 04, 2024 at 04:15:07PM +0100, Jann Horn wrote:
>> On Mon, Mar 4, 2024 at 3:02 AM Jiangfeng Xiao <xiaojiangfeng@huawei.com> wrote:
>>> When the last instruction of a noreturn function is a call
>>> to another function, the return address falls outside
>>> of the function boundary. This seems to cause kernel
>>> to interrupt the backtrace.
> 
> FWIW, all email from huawei.com continues to get eaten by anti-spam
> checking. I've reported this a few times -- it'd be really nice if the
> domain configuration could get fixed.
> 
>> [...]
>>> Delete __noreturn from usercopy_abort,
>>
>> This sounds like the actual bug is in the backtracing logic? I don't
>> think removing __noreturn annotations from an individual function is a
>> good fix, since the same thing can happen with other __noreturn
>> functions depending on what choices the compiler makes.
> 
> Yeah, NAK. usercopy_abort() doesn't return. It ends with BUG().
> 
When the user directly or indirectly calls usercopy_abort,
the final call stack is incorrect, and the
code where the problem occurs cannot be located.
In this case, the user will be frustrated.

For the usercopy_abort function, whether '__noreturn' is added
does not affect the internal behavior of the usercopy_abort function.
Therefore, it is recommended that '__noreturn' be deleted
so that backtrace can work properly.

