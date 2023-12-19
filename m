Return-Path: <linux-kernel+bounces-4537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E43817EFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6D81F243B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B7E441B;
	Tue, 19 Dec 2023 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYn1oNvd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E41FAE;
	Tue, 19 Dec 2023 00:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DA0C433C7;
	Tue, 19 Dec 2023 00:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702946805;
	bh=xh1CgRit2zifGJ88VossMVAydGb8FG8d0kaCnxDe6Xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XYn1oNvdK5Sxni1Hr9pyUL/VMSY8aMl+eHPY4/1lnW1xSVlZfKFtzVfvlrWIttU3T
	 kOaqlp4LkHdoADlcHm+wk4L7oZ3fvnm/Mvkzd/btzZdiqkK2tL6P51FgyfjPxCq6r7
	 LpVdwOSFIRFabE4IPPc/Llsq3saMk5LJW+nvrSnVfEsWA7osjZuNib1O6HAlSUywdp
	 KF2Uk6CiJSuLnvwzG0dK/R7d0iALM3VDT9sITGwU87mZvLfdhKmm/pVvgys8AgJAh8
	 IDSY+Od9X+rgHjSCha5mliInpyeNk7te7jNNItsHPCmj1iZDJxXL0G7SYn7dUXbtYt
	 RxxvUrxIKumZQ==
Date: Mon, 18 Dec 2023 16:46:41 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	axboe@kernel.dk, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
	yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 0/5] Fix I/O priority lost in device-mapper
Message-ID: <20231219004641.GA1961@sol.localdomain>
References: <CAMQnb4O15c=JC-zkCJD0U9GWwWko+Hez1iU7+cc3vhNSG86p9w@mail.gmail.com>
 <20231218012746.24442-1-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218012746.24442-1-hongyu.jin.cn@gmail.com>

On Mon, Dec 18, 2023 at 09:27:41AM +0800, Hongyu Jin wrote:
> All changes are based on commit 9bacdd8996c7 ("Merge tag 'for-6.7-rc1-tag'
> of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux")
> on the master branch.

That's from last month, and the patchset does not apply to the latest mainline.
Can you make sure to use an up-to-date tree?  Thanks.

- Eric

