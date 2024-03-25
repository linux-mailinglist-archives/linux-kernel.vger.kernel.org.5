Return-Path: <linux-kernel+bounces-116446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C896B88A081
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB66B3FF0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42616136E1C;
	Mon, 25 Mar 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ojac9/me"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602120F24E;
	Mon, 25 Mar 2024 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335277; cv=none; b=Cx+7lEWG3zEUn24ROYL/C/EQ+UJyQwvJGKyAv15frhWTTCoQUbBVFWeI9hAfETpPW5GVU4AL2IxWZHtuHxe6iB907I7UEEF3w2rOaEBDg3GhThoeYU1CTZK0ZgTMyASARORy+AMyRLZA1P0ENRJMxRVgtFXRoOCCeQGcDWdJXmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335277; c=relaxed/simple;
	bh=iaph6dzxbblkt8qoI/AOozNUOs1rsLBMBUXmR/qDgjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZoMuz1UKzFQVKn8nSAc2UL6xaGht6AebwXaZAIv/YeH0LPZYHk5IzC52FYd8FWsPUnBZ3M9fs/F7QAkYGjs7AO3TkinfKwelxKF4ihOx5Zk0mbaULMN5p00v4VBmLA6rWHbcLhk5Pxx/NcIPuB3E2SEdZ67GjKwzN9T5nxBNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ojac9/me; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711335266; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6hu5khovx8ax4ZNqLjRit7QknnfTLVkDtkeyr/hEzXY=;
	b=Ojac9/meesKJx6WavVrOyFiO6D8EQli4wTaLkLGWTzNafCwRQ2QjTN/HWteddU5/83QzhGqu/xYa4UUCW9Em6BdDMmpRk9oo4m97jx/00GAZyIBF16k/ZVYCxMMv6y/4UkYeMdn+Txocx84lOcmYw2s+ysH3WlEWkrAgAzrLO00=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W38Nam5_1711335265;
Received: from 30.97.48.191(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W38Nam5_1711335265)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 10:54:26 +0800
Message-ID: <7b30add0-0be6-4b79-9791-099bbec1e673@linux.alibaba.com>
Date: Mon, 25 Mar 2024 10:54:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Signed-off-by missing for commit in the erofs-fixes
 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Gao Xiang <xiang@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240325130007.2ed83dbb@canb.auug.org.au>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240325130007.2ed83dbb@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Stephen,

On 2024/3/25 10:00, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>    77720dfe2cf3 ("MAINTAINERS: erofs: add myself as reviewer")
> 
> is missing a Signed-off-by from its committer.

Thanks for reminder. I will fix this soon.

Thanks,
Gao Xiang

> 

