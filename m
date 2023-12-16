Return-Path: <linux-kernel+bounces-2310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A10D4815AD3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410F91F23ED8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DAC321AF;
	Sat, 16 Dec 2023 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssfsbxlR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4573F34557;
	Sat, 16 Dec 2023 17:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B3BC433C8;
	Sat, 16 Dec 2023 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702748949;
	bh=n+ChqQGuTKLBuCwZcWnige2L5ItYstuNxrDAUkj0SzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ssfsbxlRiVzGT5Y+qKPC+qeTIFl9d32UMGbMX8Gy6yKSdJDGYaM0mhxMUJ32P3Ikc
	 wKA7bomWq35tho1/jaaRzJqzNWc0qkn3htezR+LvHyAp1aqPV+FxZ8lwwv4Nl+LjZ5
	 JcAaspGKx70QKrJgNM1G6wBRAEveE24XogsCjjPdQ1rm2kp2PyJsjB3XJiT5Yr666o
	 kTVjq1Iv3vj1VsrquzR4rwsnfJVffJtgQ+Pv9nqRvxxqG7jAn4W7aepUMk5XAoi/Ff
	 i938IJ4/AJibrRV4YRQV8p/+HaTForvj53w7jYQBSAKPoC/y8YunDaSxIQRbgOEinb
	 8l2RgL4JxQqJw==
Date: Sat, 16 Dec 2023 17:49:04 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
	pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
	wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com,
	shenjian15@huawei.com, Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v6 4/4] octeon_ep: support firmware
 notifications for VFs
Message-ID: <20231216174904.GS6288@kernel.org>
References: <20231215181425.2681426-1-srasheed@marvell.com>
 <20231215181425.2681426-5-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215181425.2681426-5-srasheed@marvell.com>

On Fri, Dec 15, 2023 at 10:14:25AM -0800, Shinas Rasheed wrote:
> Notifications from firmware to vf has to pass through PF
> control mbox and via PF-VF mailboxes. The notifications have to
> be parsed out from the control mbox and passed to the
> PF-VF mailbox in order to reach the corresponding VF.
> Version compatibility should also be checked before messages
> are passed to the mailboxes.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


