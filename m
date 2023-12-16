Return-Path: <linux-kernel+bounces-2305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825D815AC7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9744E285EDE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4C3315A7;
	Sat, 16 Dec 2023 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqNqLlxX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8AA30F9C;
	Sat, 16 Dec 2023 17:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FCBC433C8;
	Sat, 16 Dec 2023 17:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702748897;
	bh=xyDHl8fP/hyzprHzdsJdf1WRUZAO13lE7TuEr0sMIUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fqNqLlxXcx8gOIVvJwUdhJLzlEwSeEhHvnC79OEnZ0VqDQnNZAWXTCDw1wzSQyD/P
	 zj83oi6BN4fWh3Ye5mU41aNl9tsqOMsZV9LYAJAY+C87BzrUewyVPudTCW3Z65QsMz
	 XKPXnb1mK2F2lS/xrqLfBj89OQvE426fvyLpqQWgP7YpTy8qPLalG3pT73E2FMKmk+
	 Wb0hSW04iE2SaX0VwRZAH8sjzuTigvNr7sde5L8f2Ah/y4+3n1eZt7Fov6sqB6tSui
	 fFF4fw/jHU8zA4pufkFVGIYpVT2+Z/HTCP3Cky0XXwpKQBy0UbFDb/vanAmXhz2Bj1
	 Z2GbaRfxLEF1g==
Date: Sat, 16 Dec 2023 17:48:11 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
	pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
	wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com,
	shenjian15@huawei.com, Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v6 1/4] octeon_ep: add PF-VF mailbox
 communication
Message-ID: <20231216174811.GP6288@kernel.org>
References: <20231215181425.2681426-1-srasheed@marvell.com>
 <20231215181425.2681426-2-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215181425.2681426-2-srasheed@marvell.com>

On Fri, Dec 15, 2023 at 10:14:22AM -0800, Shinas Rasheed wrote:
> Implement mailbox communication between PF and VFs.
> PF-VF mailbox is used for all control commands from VF to PF and
> asynchronous notification messages from PF to VF.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>

