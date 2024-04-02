Return-Path: <linux-kernel+bounces-128545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB18895C3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8F01F224EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096E15B56B;
	Tue,  2 Apr 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBZTsvt8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC755382
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085038; cv=none; b=DTcPPSqUpoHGMb3JByMAFB6cgOxgL62nMGSv1EMX7kTRDUGQDy4vPLj87lyvOjF1HUPsZtWoKPrIC7xvOAey63l7drV0Y1CbflyiNURY8gIK58Z0OBZXszX/UGKH5iWi+YhWDTMec6oI5HWvI6kNK9YAPNritZD26cZDXOhpK0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085038; c=relaxed/simple;
	bh=agcjXa+M61lyq6WsNu27vE75TiPghZbjIpAKaKKQsZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrSE8abo65d4DUC2BmhZOqiXtHj6FEAr5lqkn2oVqv1cZDoIU0kzQgPe3u8GuOoAZht9Hw9kay88Q2SSL/OeKw0y0fPv7x6KyU/G54+qXCLQ6uJDChThdYL2wYgw1HhvoOXbCRcqfQ0MSVZ8UK4EPUJj3ksGq5sts2ntctMfHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBZTsvt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4149C43390;
	Tue,  2 Apr 2024 19:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712085037;
	bh=agcjXa+M61lyq6WsNu27vE75TiPghZbjIpAKaKKQsZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZBZTsvt8XXxVZS1JbmnGRPlkzGhJX6Tfs925mem8LV5IuurkPUT+Z2dLCMh+R+cBO
	 4nv/cqXAQqS+hGSUS/jkxjK+ZFrAmZD/RlKWeiqzGTPL/TroPax4Rn7YNpLxvk863t
	 XjwNdRAVo2GdFREs3uHq/0mbw/2pQyw3DXZ6TPwvqvjVO5GGJmaI85JWGYmW3HqIbp
	 nMdnJZdF1qnEKwHKpV6uXMf54SbzcsNkF7YGGBGGmnLv5pTZJJVg2XdjtCnZtpPF7c
	 xVI0siU2CZzA7a3pHbZS4IoMECge1M/kcbBgc0FpDSH+hBq/kxOCvWJnkL1YHAmEhu
	 BxqZrglvlQ5nA==
Date: Tue, 2 Apr 2024 22:09:47 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: rongtao@cestc.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] memblock tests: fix build error
Message-ID: <ZgxX-5Eu4MU_SEqV@kernel.org>
References: <20240402132701.29744-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402132701.29744-1-richard.weiyang@gmail.com>

On Tue, Apr 02, 2024 at 01:26:58PM +0000, Wei Yang wrote:
> Some kernel change break the test build, just fix it.
> 
> Wei Yang (3):
>   memblock tests: fix undefined reference to `early_pfn_to_nid'
>   memblock tests: fix undefined reference to `panic'
>   memblock tests: fix undefined reference to `BIT'
> 
>  include/linux/gfp_types.h    |  2 ++
>  tools/include/linux/kernel.h |  1 +
>  tools/include/linux/mm.h     |  5 +++++
>  tools/include/linux/panic.h  | 19 +++++++++++++++++++
>  4 files changed, 27 insertions(+)
>  create mode 100644 tools/include/linux/panic.h

Andrew,

I can take these via memblock tree, what is your preference?

-- 
Sincerely yours,
Mike.

