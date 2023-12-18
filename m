Return-Path: <linux-kernel+bounces-3069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 517CB8166E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010C31F2153B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8E5C8F1;
	Mon, 18 Dec 2023 06:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TEZZF3xe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013DDF41;
	Mon, 18 Dec 2023 06:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2041BC433C7;
	Mon, 18 Dec 2023 06:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702882452;
	bh=AwnwLeZjuA8ssS4thTHCovTIbXMTSmXprhrXHbecjl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEZZF3xekE0G2AF/ZrrBlozkVu5GPmdfy2ImhsFGKGa0e3JF7U61gp3gkTBE6zDdL
	 pqjHX0POMD4J9dp7bMHagTdUFtHCkfxIIcfF0CwCySNqqgMWFiwefj0jSLktvXXcrJ
	 FHBo1derxaHMUe6g90afkJyeWSOYDKZzQiAooalY=
Date: Mon, 18 Dec 2023 07:54:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: bp@alien8.de, rafael@kernel.org, wangkefeng.wang@huawei.com,
	tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
	linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com,
	will@kernel.org, jarkko@kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, linux-edac@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, stable@vger.kernel.org,
	x86@kernel.org, justin.he@arm.com, ardb@kernel.org,
	ying.huang@intel.com, ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
	robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v10 3/4] mm: memory-failure: move memory_failure() return
 value documentation to function declaration
Message-ID: <2023121805-wrongness-whinny-8f41@gregkh>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20231218064521.37324-4-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218064521.37324-4-xueshuai@linux.alibaba.com>

On Mon, Dec 18, 2023 at 02:45:20PM +0800, Shuai Xue wrote:
> Part of return value comments for memory_failure() were originally
> documented at the call site. Move those comments to the function
> declaration to improve code readability and to provide developers with
> immediate access to function usage and return information.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 9 +--------
>  mm/memory-failure.c            | 9 ++++++---
>  2 files changed, 7 insertions(+), 11 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

