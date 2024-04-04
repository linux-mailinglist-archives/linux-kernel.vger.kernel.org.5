Return-Path: <linux-kernel+bounces-131185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F489841E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393CFB287EE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC08757FD;
	Thu,  4 Apr 2024 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWEmeO8F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2774E3A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223092; cv=none; b=PFqRACQ15n1+Mqs0qd3LxFSER4BMUdZ/h59hGIM/+4gubHE7viytHMKJUDmQxxnPzFxcqf9o7nqWehsHrSZMHvmhsgJ4r6onqH6vLtTf83X0+GhXoMTf73ViTaT4YkqnrUMENhX+t2Ip1U+1QIi6x3jp2DTNxEfrXAPLrlxCupk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223092; c=relaxed/simple;
	bh=1KLRrruEWrTqeDMftaKWZ8sB/Xz5Ud34n+wx3irTKz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P0sq7AglXI8kpD+tw7wUSAhpTixs7/f6Juve5r5WaSYX5KsmMa57qmnvPHxinOxEwv5+mv6EvpGvg972jdccswRpthPKUajkGyx9PK52qVj/YYnWhKiRUaF+dSSMDHqLowr8pjWdWjrVvD3iPxEGD0Vt1UNKPJSCd4eByCvtf6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWEmeO8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BD0C433C7;
	Thu,  4 Apr 2024 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712223092;
	bh=1KLRrruEWrTqeDMftaKWZ8sB/Xz5Ud34n+wx3irTKz4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mWEmeO8FnKjOEBnPg9UgzP4p81Jtrr5dYl/bTPTA9JPneLXOBcjHVqirgbZyHXIo5
	 aEbJf+2nW0nTXwxleZNtO7HcIOS8s2b90yH99XgnYDs0zbNHRjGbyZ76v+z+Nv+DTK
	 QNeadqlhxoJGxHH7Q19/SQxiTghOEVv95lZGnHmHXZr3WIGq4kGgm2dGqfvWAFBiun
	 Qoz0i3/5RmSNu1vl9Y4d0qKNmNqPwhFFpgjHrXvvIpObzltJIjGjxh4lwGbRMnwRXH
	 x5eMotYgq/SssxHmwXTWSnJffSYtRnJHtHYFcUwUqJ3nPkIMhVJ8j8VWb/4AHidDg9
	 4NrRQU0TNGt5Q==
From: Mike Rapoport <rppt@kernel.org>
To: akpm@linux-foundation.org, rongtao@cestc.cn, 
 Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20240402132701.29744-1-richard.weiyang@gmail.com>
References: <20240402132701.29744-1-richard.weiyang@gmail.com>
Subject: Re: [PATCH 0/3] memblock tests: fix build error
Message-Id: <171222309069.1396621.2828831464457944067.b4-ty@kernel.org>
Date: Thu, 04 Apr 2024 12:31:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 02 Apr 2024 13:26:58 +0000, Wei Yang wrote:
> Some kernel change break the test build, just fix it.
> 
> Wei Yang (3):
>   memblock tests: fix undefined reference to `early_pfn_to_nid'
>   memblock tests: fix undefined reference to `panic'
>   memblock tests: fix undefined reference to `BIT'
> 
> [...]

Applied to fixes branch of memblock.git tree, thanks!

[1/3] memblock tests: fix undefined reference to `early_pfn_to_nid'
      commit: 7d8ed162e6a92268d4b2b84d364a931216102c8e
[2/3] memblock tests: fix undefined reference to `panic'
      commit: e0f5a8e74be88f2476e58b25d3b49a9521bdc4ec
[3/3] memblock tests: fix undefined reference to `BIT'
      commit: 592447f6cb3c20d606d6c5d8e6af68e99707b786

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: fixes

--
Sincerely yours,
Mike.



