Return-Path: <linux-kernel+bounces-24115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15E382B748
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B472285ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC1012B91;
	Thu, 11 Jan 2024 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7Yby6gU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2327537FC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705013357; x=1736549357;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=x5uaI/3QT1hVAAVHo7B2I3IFZzh6hekGbvyHUYtQ3KY=;
  b=H7Yby6gUYu3ZE2qzwLuqdigCxnZTzMUXdWlfnyO5KAjZD7qbVrNRkagy
   u9asHPl4lIcRK2oThJtJ3FQY0Z9+n4zQ6SLeqEafCDtq98dWRcRtBIZxo
   deVPBlOy8OR3h0zFcYEXiDnjAVKDt9KDH89CvtShereLO/V0zxA60JFJ7
   YgE5/hNDj64P42gQD0z7kEiaSOxW7g01l3YDJak+P4QUs8O35PxhQLHBL
   yEwvzHXhyB6af4sCMmX0eQhr9YjYNFwZVjlUqJSwORa7chVhBeh4I3QuP
   vRiHxsnTrdZjmHdFDUhwbmiypU/ax7Fy/Pm4DWUzg4xJoEp7KCfjej4Pc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="6377291"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="6377291"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 14:49:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="906117161"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="906117161"
Received: from ldrake1-mobl3.amr.corp.intel.com (HELO [10.212.168.169]) ([10.212.168.169])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 14:49:15 -0800
Message-ID: <d34ef8984925cfeebbd3b8c4a57e70f131fc5552.camel@linux.intel.com>
Subject: Re: [PATCH v3 5/7] hugetlb: have CONFIG_HUGETLBFS select
 CONFIG_PADATA
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>, David
 Rientjes <rientjes@google.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <muchun.song@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
Date: Thu, 11 Jan 2024 14:49:14 -0800
In-Reply-To: <20240102131249.76622-6-gang.li@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
	 <20240102131249.76622-6-gang.li@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-02 at 21:12 +0800, Gang Li wrote:
> Now hugetlb uses padata_do_multithreaded for parallel initialization,
> so select CONFIG_PADATA.

Perhaps rephrase

Allow hugetlb use padata_do_multithreaded for parallel initialization.
Select CONFIG_PADATA in this case.

>=20
> Signed-off-by: Gang Li <gang.li@linux.dev>
> ---
>  fs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 89fdbefd1075f..a57d6e6c41e6f 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -262,6 +262,7 @@ menuconfig HUGETLBFS
>  	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
>  	depends on (SYSFS || SYSCTL)
>  	select MEMFD_CREATE
> +	select PADATA
>  	help
>  	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
>  	  ramfs. For architectures that support it, say Y here and read


