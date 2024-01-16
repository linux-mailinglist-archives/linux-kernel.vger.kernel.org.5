Return-Path: <linux-kernel+bounces-27576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E80B82F26C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043AA28618B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A1D747F;
	Tue, 16 Jan 2024 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="tAYAcu8C"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B04411
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id PZgLrJbG280oiPmLSrbTgo; Tue, 16 Jan 2024 16:31:22 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id PmLRrADjaKleDPmLRrcbXi; Tue, 16 Jan 2024 16:31:21 +0000
X-Authority-Analysis: v=2.4 cv=KcbBDCUD c=1 sm=1 tr=0 ts=65a6af59
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=7YfXLusrAAAA:8 a=6BFke60KTf7VZbaxHQkA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q4fmzkdIu+7QBXCoPwfWZgGgksUOdwKEo3LpI0mE/EE=; b=tAYAcu8CxItk8NfrbjkrFcaCNk
	32GQE1PGncmEr2kKSewUhIziL3jvUCeAU0JdPMryHf00II+9eHLxidsYjx5Ikh17xjYazlRv936O5
	064U0V7ZYA2gCL7YGARQmodKnlfchx+MGlAgg4Fyw7ExQWpofiCTkbIgckLr5b8x17ekFtCRlhSXv
	KxMMaz1mnxkUTU/VfLDXEiTq4HsIGXqxzZR89rRhmQyHoI5Zb9NWlEmlJWb32B5+9MDmLsCNo5VQf
	hoRYixvKayCu4Z4h7kjZeJudlOfCFZhEQA3LHp6Mk4RzX3ucraGovJ/FONpQV90uWrj+REee9GPtM
	mMvuZ3yA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:47040 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rPmLN-00020A-35;
	Tue, 16 Jan 2024 10:31:17 -0600
Message-ID: <50c583d7-a6f2-450c-bbc9-965f65b91197@embeddedor.com>
Date: Tue, 16 Jan 2024 10:30:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/uncore: Use kcalloc*() instead of kzalloc*()
To: Erick Archer <erick.archer@gmx.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, x86@kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240116125813.3754-1-erick.archer@gmx.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240116125813.3754-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1rPmLN-00020A-35
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:47040
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOOFwwVcRQiOMxuwZgssg+uhOcRkGKjM5dtkw7P+ceYuZGATVM7zI+DGIjBqZwO6IHl0ixVpcm01Fl20WE4d2HrvZqBdds2UqSC33z+1RW5TnS2PvqIJ
 DDWDtQ3yrAtJcO5x/CqAt/nF4ACMg6EQKyilVbGAq+QiOYG9tOB/lznGKgkX+E7DbGNPUTMRqpTviPcthwb/n30+sNYP8B8jUPW30w5oZ/lV0BQQ5AqUNSKw



On 1/16/24 06:58, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, use the purpose specific kcalloc*() function instead of the argument
> size * count in the kzalloc*() function.
> 
> [1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   arch/x86/events/amd/uncore.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index 5bf03c575812..9073eb0613cf 100644
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
> --
> 2.25.1
> 
> 

