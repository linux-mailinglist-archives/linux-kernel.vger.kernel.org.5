Return-Path: <linux-kernel+bounces-6065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE98193C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431F71C2540B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065F73D0B7;
	Tue, 19 Dec 2023 22:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX5axLoH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CF637D22;
	Tue, 19 Dec 2023 22:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0D6C433C8;
	Tue, 19 Dec 2023 22:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703025963;
	bh=Jj58epTQCKjG6uAWckKMda4oobhThnJdGwJHItYarYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VX5axLoHN0w6N0iubLaIcgpiM2R+2M4XZGC+uAVZ0dN4RynbPsTVAF+6EdSz2uyQ9
	 Qbjm6ZpVjC1UG1zKM5hcCnhc6UmoCotUycRlUIlSCl+akelwPnx7jjae+89TLyzueh
	 nk2dQvdbdEnsxHBxX05o8tXwn6ToyU3Bo6LjXKVv6Bh6uGb0wXlw/rGgBECkFHkyx8
	 PbIqINc598GEhYElT17Ln0gl5DCx7UK3EytBGirky9/U0GmTzFRZocZZtawirq7VJu
	 nTj1H+LrTO/Ly+oHit+HMZTbSnAkj5gLEuhkrQOWJHn13swBJb9jjPTc9dsZbpVkkt
	 eazeEf2Or7bnQ==
Date: Tue, 19 Dec 2023 15:46:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	axboe@kernel.dk, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
	yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 2/5] dm: Support I/O priority for dm_io()
Message-ID: <20231219224601.GA38652@quark.localdomain>
References: <CAMQnb4O15c=JC-zkCJD0U9GWwWko+Hez1iU7+cc3vhNSG86p9w@mail.gmail.com>
 <20231218012746.24442-1-hongyu.jin.cn@gmail.com>
 <20231218012746.24442-3-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218012746.24442-3-hongyu.jin.cn@gmail.com>

On Mon, Dec 18, 2023 at 09:27:43AM +0800, Hongyu Jin wrote:
> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> Add I/O priority parameter for dm_io().

Needs an explanation.

- Eric

