Return-Path: <linux-kernel+bounces-112792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6B8887E30
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E270B281990
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81901A27E;
	Sun, 24 Mar 2024 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="svE32i9g"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6841A38F5
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711302971; cv=none; b=bo7nP6uFNCml1L5866Ljgr77Ox4NaaovTQmY9a9GRZRq+4HV+6rbMR7PqX0l3ErZPP9OfoJ2WVEJCY9xPJzcOZjJ+G6Xjux3bnyZ60GFoKNq3O+bLRvV7Q6K6kMA2vqlqnUwfrecDzcz3szcNZ1Gedm0Ma5ltT6mqaTQU4mF2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711302971; c=relaxed/simple;
	bh=fa5fUBKyxJrg3h40phiy5mMcmrDjqBtTD6LNmVoyvRg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sn7wN8pt+XOeusZQcjBXY2nydUm4fnuI2/Gk6NB5nwWeUVgpNXvhbNb1Rfc6xya3x3aKPmm8GcfLeCuThjzkPtcq8f9b/c4dS7GSQcNNqiIXwQatylDZOsz/shFIqqF26DbWtCk1dewRALf4VbufAbmbsAoFuCXhv4KHVI89OZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=svE32i9g; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711302960;
	bh=fa5fUBKyxJrg3h40phiy5mMcmrDjqBtTD6LNmVoyvRg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=svE32i9gt2Ke09RCTjMcLfFSENFh7wLFwxL9X9TGyhWJXIuDMTj3MwPb0z1nOyq6B
	 h9QjaAOEDlECVzDLd8Z41GizDb/zc90mheuhOF/NseP8aAajhARB1NxlevFUvNpaMJ
	 +oKzcEj7Px6xSnrwmihtVDUTYz8dQx+yr7HNFoQL6VJHu8I29NY+loVA+3fEZy3oiU
	 lIWeGkKLwMewNN/NfcDxt6Hxd6/jtXCmDtAN3r3OPBMXUEoWEiemy4siBVXigb9F8k
	 EqmR64nhi40Qta3N3X7CXF1QwRk03wTCvjS+jIF+aXj9MATJokg8e4bzjBTtl9yrRo
	 RRgmh7utALcvA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6CF983781F92;
	Sun, 24 Mar 2024 17:55:55 +0000 (UTC)
Message-ID: <c12ada0c-0c59-4be7-979f-0b99c7da36b8@collabora.com>
Date: Sun, 24 Mar 2024 22:56:24 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Nico Pache <npache@redhat.com>,
 Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: Fix hugetlb mem size
 calculation
To: peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240321215047.678172-1-peterx@redhat.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240321215047.678172-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/24 2:50 AM, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> The script calculates a mininum required size of hugetlb memories, but
> it'll stop working with <1MB huge page sizes, reporting all zeros even if
> huge pages are available.
> 
> In reality, the calculation doesn't really need to be as comlicated either.
> Make it simpler and work for KB-level hugepages too.
> 
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index c2c542fe7b17..b1b78e45d613 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -152,9 +152,13 @@ done < /proc/meminfo
>  # both of these requirements into account and attempt to increase
>  # number of huge pages available.
>  nr_cpus=$(nproc)
> -hpgsize_MB=$((hpgsize_KB / 1024))
> -half_ufd_size_MB=$((((nr_cpus * hpgsize_MB + 127) / 128) * 128))
> -needmem_KB=$((half_ufd_size_MB * 2 * 1024))
> +uffd_min_KB=$((hpgsize_KB * nr_cpus * 2))
> +hugetlb_min_KB=$((256 * 1024))
> +if [[ $uffd_min_KB -gt $hugetlb_min_KB ]]; then
> +	needmem_KB=$uffd_min_KB
> +else
> +	needmem_KB=$hugetlb_min_KB
> +fi
>  
>  # set proper nr_hugepages
>  if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then

-- 
BR,
Muhammad Usama Anjum

