Return-Path: <linux-kernel+bounces-6069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380878193D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EC1287CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AC13D0C4;
	Tue, 19 Dec 2023 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjtxOuKo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC67E39AF3;
	Tue, 19 Dec 2023 22:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0B0C433C7;
	Tue, 19 Dec 2023 22:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703026250;
	bh=s1/+bxxcBS5WdK2rZ7PUQ8eT9olEr2/GFE7anYexsbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjtxOuKo7Ry2RXRmW17ZDHXUg592bnDvwFYHZ5OGTP5iTuAlky9OGLMRQnJ5plZEh
	 LrW9+Dotar44nCjaEEW9AaX2kKLdddmmcPm+olaF7Zw2mLCLAFk9RlFZhHBtC+Kps8
	 w5ECG27E6sJC+wWcU7VX8TVWNrwhzBt5rJVBR2IFH5ytfDEpfy3h4Fe+Ky4Ipz/b5c
	 vp1WbSUhQQLPpXANIo9v25KK18xoZ5zHYxWJpZ5jmnAn9ZDnKcBLsjvDP7s1SYPPpx
	 /YiLet7Yw++98ile+dI51CrUmt2ojD9U/73JN0vN5gWVecJ6ceu14KIDwxAa8lwtMT
	 EKfw2TMrQNaNA==
Date: Tue, 19 Dec 2023 15:50:48 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	axboe@kernel.dk, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
	yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 5/5] dm-crypt: Fix lost ioprio when queuing
 write bios
Message-ID: <20231219224943.GD38652@quark.localdomain>
References: <CAMQnb4O15c=JC-zkCJD0U9GWwWko+Hez1iU7+cc3vhNSG86p9w@mail.gmail.com>
 <20231218012746.24442-1-hongyu.jin.cn@gmail.com>
 <20231218012746.24442-6-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218012746.24442-6-hongyu.jin.cn@gmail.com>

On Mon, Dec 18, 2023 at 09:27:46AM +0800, Hongyu Jin wrote:
> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> The original submitting bio->bi_ioprio setting can be retained by
> struct dm_crypt_io::base_bio, we set the original bio's ioprio to
> the cloned bio for write.

This commit message does not make sense.  Can you make the commit message
properly describe the problem and how the patch fixes it?

- Eric

