Return-Path: <linux-kernel+bounces-7516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A092E81A921
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D365C1C22BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8824B5A6;
	Wed, 20 Dec 2023 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UB43aTH3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289254B159
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BE6C433C9;
	Wed, 20 Dec 2023 22:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703111216;
	bh=sEZuyE2uQkcwfjJLcJ9BQpOsJ9lsf+m92KdGBFS1GE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UB43aTH3FCFC4o2XnzpmhexYfzK1gzNXBHG68eY6FjgGVW1NJ6K7a8E67ntsIIShG
	 uI2yh4+3tJ0efJa4nAuAhBzoSFPtJ6CV/CqUuwuKAX8qmnfvA5cFpBRGEJ32lyjzVW
	 l3lLrCh3JTAbQgA1YC6WqI1QAxogT2s0+xYlI6no=
Date: Wed, 20 Dec 2023 14:26:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Muchun Song
 <songmuchun@bytedance.com>
Subject: Re: [PATCH] MAINTAINERS: remove hugetlb maintainer Mike Kravetz
Message-Id: <20231220142655.e8797dfc0fff619f12bff53a@linux-foundation.org>
In-Reply-To: <20231220220843.73586-1-mike.kravetz@oracle.com>
References: <20231220220843.73586-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 14:08:43 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> I am stepping away from my role as hugetlb maintainer.  There should be
> no gap in coverage as Muchun Song is also a hugetlb maintainer.

Sigh.  Thanks Mike.

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9762,7 +9762,6 @@ F:	Documentation/networking/device_drivers/ethernet/huawei/hinic.rst
>  F:	drivers/net/ethernet/huawei/hinic/
>  
>  HUGETLB SUBSYSTEM
> -M:	Mike Kravetz <mike.kravetz@oracle.com>
>  M:	Muchun Song <muchun.song@linux.dev>
>  L:	linux-mm@kvack.org
>  S:	Maintained

Your patch is buggy.

--- a/CREDITS~maintainers-remove-hugetlb-maintainer-mike-kravetz-fix
+++ a/CREDITS
@@ -2126,6 +2126,10 @@ S: 2213 La Terrace Circle
 S: San Jose, CA 95123
 S: USA
 
+N: Mike Kravetz
+E: mike.kravetz@oracle.com
+D: Maintenance and development of the hugetlb subsystem
+
 N: Andreas S. Krebs
 E: akrebs@altavista.net
 D: CYPRESS CY82C693 chipset IDE, Digital's PC-Alpha 164SX boards
_

if that's OK?

