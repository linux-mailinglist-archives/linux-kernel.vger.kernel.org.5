Return-Path: <linux-kernel+bounces-99591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04BD878A71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF61F22127
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DFC57316;
	Mon, 11 Mar 2024 22:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jHobgi1K"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D04D54BFD;
	Mon, 11 Mar 2024 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194553; cv=none; b=b+/OVOpm2+9ZtBqy6+jU7OhJ7q4tVZ5633tiJ7sXHPQtXcabs921GBkoRvRRnEllcYBqYAC2A1n6iW5MI7R5m0iOmN+zR6kF3tedjw4fS0bveuOssstr5ZU6qbFMawtjJwCxQE5NFl0FuaD1ENn1NIubGw99s/uBS7O9yLYyU2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194553; c=relaxed/simple;
	bh=WZMSDmt6EsOb1aEu+xZqL6SvRsH+HrfqyguRVvtYbFE=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:Cc:From:Subject:
	 Content-Type; b=Kv0yslhTteOFLw+g1ccivOHRFMDJ4rEe6+MPtpvn1nv7jBqsehiDek9xY5v4YiNNC3ioUC6ym+nRjFqpL71hMShrlMLhdiUXo2IsX7QjH3etO0rV+0PWmFQYRejrYg+yJ2nWrjv7SYliF1WWzeSYNgPDROcaYkLDvkFlq4MOXRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jHobgi1K; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Subject:From:Cc:To:
	In-Reply-To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WZMSDmt6EsOb1aEu+xZqL6SvRsH+HrfqyguRVvtYbFE=; b=jHobgi1KJjgRsh+WYLcvUwDItI
	Q4b9axTfIs82qvCXZQoVtR0ElHVmUc+0Xt+iv6Q9PV4rSkFKdsjhiP5o9bheq3eYqGGPuqjfOoM4K
	D+qKXjicoI/hTYuIUisdmq4VnqThGnIorownXoGSEMjjXXTLOrXVcsAi+ZxuiyqwCYkN1D2GVU75B
	24GPWlFC/YaGr2XTEiLJYjEcHkF7LGcwzXl92YA7NHyMa6RZjagrE/LSYd4J4d1u/HjPaVo8N3Wtw
	ri4ESRUbnMaeOBY/ZtTLZc6/ghQSAd+zLVGVGewpu4F+KXTwQ6qtzxhYLS2uW6PWLQ/cuJ345GA3B
	eTPyGg8Q==;
Received: from [177.62.247.190] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rjnig-0093qt-VA; Mon, 11 Mar 2024 23:02:07 +0100
Message-ID: <05870905-f592-186c-146f-0dfe734cec60@igalia.com>
Date: Mon, 11 Mar 2024 19:01:58 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
In-Reply-To: <20240229204107.2861780-5-sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Borislav Petkov <bp@alien8.de>,
 bpf <bpf@vger.kernel.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 houtao1@huawei.com, linux-kernel <linux-kernel@vger.kernel.org>,
 "luto@kernel.org" <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
 "x86@kernel.org" <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 sohil.mehta@intel.com, xrivendell7@gmail.com
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH AUTOSEL 5.15 5/9] x86/mm: Disallow vsyscall page read for
 copy_from_kernel_nofault()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sasha et. al.,

thanks for this backport! I'm not sure how common is to send a Tested-by
to stable in these cases, but since I tested this one anyway, given that
I was working with this syzkaller report...feel free to add my:


Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # v5.15.y

Cheers,


Guilherme

