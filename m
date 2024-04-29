Return-Path: <linux-kernel+bounces-163026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFE78B63D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CF81C219A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6984C1779BD;
	Mon, 29 Apr 2024 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NFT4EKyb"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C56412880A;
	Mon, 29 Apr 2024 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423699; cv=none; b=KTf5zUdEovqXcDna7lvjLZ16mx/amamgsJnyMgrmWl9VAf6RYVUnvuvX5XopuBgsEpIfx+0AB9GOUJI0Yg9skn5JooWA4AUZk3bcPiZA+cn2YP//Jo2yX2JQ84tWmt6fTJyvxp8ID+0kZEF9qk5Dj3VTKitni+nFgyrEWfG2NF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423699; c=relaxed/simple;
	bh=hi9jHuX0t+MiyHdv6bvpydi3NtTh3mzwnyovDtOhWfM=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=VLZGfyUsUVe6ggY24WDDxQCpG+Z5NQuA0ErwZ7nqGGbDAtKSrJyjooQ0JqGcOlYVz4rOZSzpcMleJmSrNZv4rFiLvbfyqoCjlLyAqX13lBLqQ+12BlBe/DO+SP3SIKzEbuz3YYdcTmJHdZ1PxVvX/dVukiqpS5ODcgvlmaEPHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NFT4EKyb; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 1XussKoaLoeci1XussY2eu; Mon, 29 Apr 2024 22:48:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714423687;
	bh=2tkIHRgbihugbvQSDrnZucCqwWRA089i99j5eTq3fo4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=NFT4EKyb8uYCTdvhnoUA2B48EVqoeOgNJHp/FkjJY7eUqfcHVw5aFI8d0rgqgI9Z0
	 4pOznp7iJq0E6E/zRrdpYP774Bf0z+yUPo94apXItBZblnlWsxW8wPqTrDzpQ0dxTS
	 zq8Dp7NA0NHS+jEtV/VwMorBFZqk5ErBM4YEMWhTXUCUpo7XAE2k/yYMOEPSwANeps
	 q72ShUELnyuUv2UoT4DUw40vJtVNFKXlkGsq7r6p8JpiS+yV3+YjMEJ1adZaUlZikL
	 WU1XHWTz1ch0uhJDDoqknfchxLXOBfpL9TQgb9qTuC2+HxF0GwSo5qOm6jWg14qAdT
	 /s7dm3fN0f1jA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 29 Apr 2024 22:48:07 +0200
X-ME-IP: 86.243.17.157
Message-ID: <95484936-3f63-45ab-8b60-179508c159fb@wanadoo.fr>
Date: Mon, 29 Apr 2024 22:48:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/x86/amd/uncore: Use kcalloc*() instead of
 kzalloc*()
References: <PAXPR02MB7248F46DEFA47E79677481B18B152@PAXPR02MB7248.eurprd02.prod.outlook.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Erick Archer <erick.archer@outlook.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Justin Stitt <justinstitt@google.com>
Cc: x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <PAXPR02MB7248F46DEFA47E79677481B18B152@PAXPR02MB7248.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 27/04/2024 à 18:45, Erick Archer a écrit :
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe. However, using kcalloc*()
> is more appropriate [2] and improves readability. This patch has no
> effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Changes in v3:
> - Update the commit message to better explain the changes.
> - Rebase against linux-next.
> 
> Changes in v2:
> - Add the "Reviewed-by:" tag.
> - Rebase against linux-next.
> 
> Previous versions:
> v1 -> https://lore.kernel.org/linux-hardening/20240116125813.3754-1-erick.archer@gmx.com
> v2 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237A07D73D6D15EBF72FD8D8B392@AS8PR02MB7237.eurprd02.prod.outlook.com
> 
> Hi,
> 
> This is a new try. In the v2 version Ingo explained that this change
> is nonsense since kzalloc() is a perfectly usable interface and there
> is no real overflow here.
> 
> Anyway, if we have the 2-factor form of the allocator, I think it is
> a good practice to use it.
> 
> In this version I have updated the commit message to explain that
> the code is obviusly safe in contrast with the last version where the
> impression was given that there was a real overlow bug.
> 
> I hope this patch can be applied this time.
> 
> Regards,
> Erick
> ---
>   arch/x86/events/amd/uncore.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 4ccb8fa483e6..61c0a2114183 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -479,8 +479,8 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
>   				goto fail;
>   
>   			curr->cpu = cpu;
> -			curr->events = kzalloc_node(sizeof(*curr->events) *
> -						    pmu->num_counters,
> +			curr->events = kcalloc_node(pmu->num_counters,
> +						    sizeof(*curr->events),
>   						    GFP_KERNEL, node);

Hi,

not related to your patch, but amd_uncore_ctx looks like a good 
candidate for a flexible array.

This would simplify allocation/freeing of the memory.

struct amd_uncore_ctx {
	int refcnt;
	int cpu;
	struct hlist_node node;
	struct perf_event *events[];
};

Just my 2c,

CJ

>   			if (!curr->events) {
>   				kfree(curr);
> @@ -928,7 +928,7 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
>   		uncore->num_pmus += group_num_pmus[gid];
>   	}
>   
> -	uncore->pmus = kzalloc(sizeof(*uncore->pmus) * uncore->num_pmus,
> +	uncore->pmus = kcalloc(uncore->num_pmus, sizeof(*uncore->pmus),
>   			       GFP_KERNEL);
>   	if (!uncore->pmus) {
>   		uncore->num_pmus = 0;


