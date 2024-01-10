Return-Path: <linux-kernel+bounces-21882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680758295F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDD81C21696
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341683C48D;
	Wed, 10 Jan 2024 09:12:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9146D3BB53;
	Wed, 10 Jan 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A7E82F4;
	Wed, 10 Jan 2024 01:12:56 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 188653F64C;
	Wed, 10 Jan 2024 01:12:07 -0800 (PST)
Message-ID: <dfe99d03-2d44-28c5-0125-b18993de9fa9@arm.com>
Date: Wed, 10 Jan 2024 09:12:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 0/3] arm64: Support Neoverse-V2 for Perf Arm SPE
Content-Language: en-US
To: Besar Wicaksono <bwicaksono@nvidia.com>, acme@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, catalin.marinas@arm.com,
 will@kernel.org, john.g.garry@oracle.com, mike.leach@linaro.org,
 peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org,
 irogers@google.com, alisaidi@amazon.com, vsethi@nvidia.com,
 rwiley@nvidia.com, ywan@nvidia.com
References: <20240109192310.16234-1-bwicaksono@nvidia.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240109192310.16234-1-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/01/2024 19:23, Besar Wicaksono wrote:
> This series support Neoverse-V2 CPU in Perf Arm SPE.
> The first patch adds the Neoverse-V2 part number in kernel header.
> The second patch syncs the kernel change to the tools header.
> The third patch adds Neoverse-V2 into perf's Neoverse SPE data source list.
> 
> Besar Wicaksono (3):
>   arm64: Add Neoverse-V2 part
>   tools headers arm64: Add Neoverse-V2 part
>   perf arm-spe: Add Neoverse-V2 to neoverse list
> 
>  arch/arm64/include/asm/cputype.h       | 2 ++
>  tools/arch/arm64/include/asm/cputype.h | 2 ++
>  tools/perf/util/arm-spe.c              | 1 +
>  3 files changed, 5 insertions(+)
> 
> 
> base-commit: d988c9f511af71a3445b6a4f3a2c67208ff8e480

Reviewed-by: James Clark <james.clark@arm.com>

