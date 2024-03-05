Return-Path: <linux-kernel+bounces-91602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BD2871427
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8B32824E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D228429439;
	Tue,  5 Mar 2024 03:12:47 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8317C6C;
	Tue,  5 Mar 2024 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709608367; cv=none; b=rponyid+GaBUznjCqXdwlIE0/mf7F8fTQSKsLiGEbcRSliYZ29TR3rQK8XQSVIdrIk4Yz5IJVTlG0NaHHSFoKUii4XSu59Q/xY1266b/N2twt/SQBEDUYNPzxds00qd2keewe4WGy57pd4hfGsDjGyhXbclWWQNERPva+ErDUEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709608367; c=relaxed/simple;
	bh=lSXxxxpioOAxeOtZbqCCdlhjYdL68wCyBhBzH8l+rHc=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cnoGmHma3z3T/uxJqn0XHkYLOLw+RMrUAnswmnsIYDK30USENscpbi2SwXqXQ9zYWJlss6EThgu9+Q2Mg39iaA1Wx6FD8YcYY74GpYt1uka5KEF/YZUYWH9+QWRtbpsA2nVYycJFuW/NR6/xouU7dIKNdgl8GBAR80dFlAJSEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TpgYB01HDz2BfJh;
	Tue,  5 Mar 2024 11:10:21 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id F41BD1402CB;
	Tue,  5 Mar 2024 11:12:41 +0800 (CST)
Received: from [10.67.111.82] (10.67.111.82) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Mar
 2024 11:12:41 +0800
Subject: Re: [PATCH] usercopy: delete __noreturn from usercopy_abort
To: Jann Horn <jannh@google.com>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <CAG48ez1h9X7Qv-5OR6hAhwnSOng6_PSXBaR6cT7xrk2Wzu39Yg@mail.gmail.com>
 <a6591565-2c67-13fb-746e-b3040657212b@huawei.com>
CC: <gustavoars@kernel.org>, <akpm@linux-foundation.org>,
	<jpoimboe@kernel.org>, <peterz@infradead.org>, <dave.hansen@linux.intel.com>,
	<kirill.shutemov@linux.intel.com>, <keescook@chromium.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
	<linux-mm@kvack.org>, <nixiaoming@huawei.com>, <kepler.chenxin@huawei.com>,
	<wangbing6@huawei.com>, <wangfangpeng1@huawei.com>, <douzhaolei@huawei.com>
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <7dfef7b1-8c5a-dd0a-2653-15a9c656f111@huawei.com>
Date: Tue, 5 Mar 2024 11:12:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a6591565-2c67-13fb-746e-b3040657212b@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/3/5 10:54, Jiangfeng Xiao wrote:
> 
> 
> On 2024/3/4 23:15, Jann Horn wrote:
>> On Mon, Mar 4, 2024 at 3:02 AM Jiangfeng Xiao <xiaojiangfeng@huawei.com> wrote:
>>> When the last instruction of a noreturn function is a call
>>> to another function, the return address falls outside
>>> of the function boundary. This seems to cause kernel
>>> to interrupt the backtrace.
>> [...]
>>> Delete __noreturn from usercopy_abort,
>>
>> This sounds like the actual bug is in the backtracing logic? I don't
>> think removing __noreturn annotations from an individual function is a
>> good fix, since the same thing can happen with other __noreturn
>> functions depending on what choices the compiler makes.
>> .
>>
> Yes, you make a point. This may be a bug is in the backtracing logic, but
> the kernel backtracing always parses symbols using (lr) instead of (lr-4).
> This may be due to historical reasons or more comprehensive considerations.
> In addition, modifying the implementation logic of the kernel backtracing
> has a great impact. Therefore, I do not dare to modify the implementation
> logic of the kernel backtracing.
> 
> Not all noreturn functions are ended with calling other functions.
> Therefore, only a few individual functions may have the same problem.
> In addition, deleting '__noreturn' from usercopy_abort does not
> change the internal behavior of usercopy_abort function.
> Therefore, there is no risk. Deleting '__noreturn' from usercopy_abort
> is the solution that I can think of with minimal impact and minimum risk.
> 
> If you will submit a better patch to solve this problem,
> I would like to learn from you. Thank you.
> 
What are your suggestions on modifying the kernel backtracing logic
or deleting '__noretrun'? If you insist on modifying the kernel
backtracing logic and persuade me with good reasons, I can also try
to submit the patch for modifying the kernel backtracing logic
to the community.

