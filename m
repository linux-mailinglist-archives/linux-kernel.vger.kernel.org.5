Return-Path: <linux-kernel+bounces-161355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C518F8B4B15
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E57281B46
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C45A56454;
	Sun, 28 Apr 2024 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBrsri1k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B07450E2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714298408; cv=none; b=OZzOr5pYzyr4EI2X8JnmBOs8YJe48gJ/LSTCh3+WQCWe05AH4XdNHJtwFEVLaqGTD6qRV5nVyJOScTvaU6OYpwpWZL6LonY/qtiWuVZHVUF57epCYJ+bjY6LmsCwGSU2Np3XdxXGiOO6jRtnE8AjdVFvBDKdUTNReaOO2fw0Dk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714298408; c=relaxed/simple;
	bh=Qd1fqPW8u0tnbx6oXHidvD3XgBUn59/jezsd1Be/U8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7VZzOS1bGT0aBHIvgqUwa6RT5vKxNH11w8mWLbn8minvnOPNX3ZIOm1Lhq3wjRTHjRY2t3wL2tx/C0xAhmgUTIki3JzF0pLS2oj3Yk0ocUjo7IVXMz+jtpK1Tc06xw8er20kRZybKk0qlgn5k2r9mKqUmQ2m1nDQk/QVv8LyzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBrsri1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2EFC113CC;
	Sun, 28 Apr 2024 10:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714298408;
	bh=Qd1fqPW8u0tnbx6oXHidvD3XgBUn59/jezsd1Be/U8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mBrsri1k0N89fOWW/+z6N1VQywuP6WHbOi9hVwBBvvDBBWuZoiaOgW8zs4pOivab1
	 x8BDfqC4TMLIQl2Qjxy25VtZZ79xi6O0Ck8m7Zoi95ehbOxnMjUKtZwCKwI/hKZEa0
	 lFrXULF2dgin562ULGWyRyY5SLKiuO9P/7LktLBbYDFekv7dDasUS4s19jyYMThjMs
	 lFcJlg8DWDPn8WBO+OQnC9PxmiRNysGNgo1femE5OmTkEdBD5UqWUlTkoU3prWJKbV
	 qb1X5i5xIFzt3fFRRF1yKTuP3r+6loDQQ9CDqBRCDbrLZzK9Z8m2UrBR8Hlx/ipo/u
	 xzFr0kjvsFXuQ==
Message-ID: <c1c11066-c2d9-4f88-9903-b80dae4bbf04@kernel.org>
Date: Sun, 28 Apr 2024 18:00:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 1/2] erofs: get rid of erofs_fs_context
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com
References: <20240419123611.947084-1-libaokun1@huawei.com>
 <20240419123611.947084-2-libaokun1@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240419123611.947084-2-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/19 20:36, Baokun Li wrote:
> Instead of allocating the erofs_sb_info in fill_super() allocate it during
> erofs_init_fs_context() and ensure that erofs can always have the info
> available during erofs_kill_sb(). After this erofs_fs_context is no longer
> needed, replace ctx with sbi, no functional changes.
> 
> Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

