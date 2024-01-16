Return-Path: <linux-kernel+bounces-27528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6FC82F19E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95428285FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B4F1C2AE;
	Tue, 16 Jan 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqnIVG0O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938551C293;
	Tue, 16 Jan 2024 15:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB42BC433C7;
	Tue, 16 Jan 2024 15:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705419196;
	bh=e/enmt38ETDU8AK3j17PZvcC/PRL8UejDeO1aaDrj9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fqnIVG0Oae2WYkOudyJgYOG0msZHqLQj4embsHRm6Sb+KLObDGDf/1SyCi5PTbT45
	 m/RIZ8vIu9xJ4GaT5jXDH3Wk4OwnZwbabnwEIsEDgUdVDeqgLA73Q7XWSxnmzGneZF
	 5OBc7M6hW5bweBa++B01ysk/0DhhRwW0iKeRZQERTK88y+4B33ynlgIygVMA5GbSHq
	 Wj7dQpLY2BnQJq2amzXAjUn8dRm9Kso1W1eN9GyrX7kjSHgv9B66f+mY8EbHys+k56
	 sNU5XcYNRHOsN3alW33OEWU6OtS2dkEGCYnTGZ17mREvjEUErkYK+KCQeUH3XJkmtQ
	 K6Ls3cxysy6Rg==
Date: Tue, 16 Jan 2024 07:33:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 15/42] drivers/ptp: Convert snprintf to sysfs_emit
Message-ID: <20240116073314.09dc408c@kernel.org>
In-Reply-To: <20240116045151.3940401-13-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
	<20240116045151.3940401-1-lizhijian@fujitsu.com>
	<20240116045151.3940401-13-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 12:51:24 +0800 Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
> > ./drivers/ptp/ptp_sysfs.c:27:8-16: WARNING: please use sysfs_emit  

If the patches don't depend on each other please post them separately.
Series should only be used if there are dependencies and the same
maintainer is expected to apply all patches.

The ptp change should be reposted after the merge window, we don't take
cleanups during the merge window.

