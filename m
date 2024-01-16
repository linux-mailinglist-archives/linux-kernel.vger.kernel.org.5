Return-Path: <linux-kernel+bounces-27502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D605F82F118
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE62285409
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E531BF4E;
	Tue, 16 Jan 2024 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOpYA6t6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B961BF3E;
	Tue, 16 Jan 2024 15:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F554C433F1;
	Tue, 16 Jan 2024 15:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705417877;
	bh=VFvWeZJOUq1WQCh3uBIF1e3DG+wff1WHTRke4m3eOEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AOpYA6t605Q+jp1VG14hEStdtTxKFwdXC6dTmsW+Fj4P56H2RscfeAGR6yoUBPr0u
	 tE92QO3sS7KhaVNHi66DuT0bIzntb2kvzcginyaLZXiQyfViICGOH6T5RbvJDK7v8H
	 LwyQMuVcgrxs1RQUMvfi6P4yPffhedY+EGzLpThVaSZXpzsXNIrN/JlCxeORr2gqjD
	 H6K+BmRxxVxFmWxQIymIo9ndxPaW8mhEcvdD4QJLmX9JxKyy5qauaH0ErPx0zJ177w
	 aN+mGM+jVjTVPL8TvltIC9uQDJFwTsR+MVDT7hfcjal3Ni8SvD7jN9oKMzMI4ZrjIo
	 xIWSLlCmhPU9g==
Date: Tue, 16 Jan 2024 07:11:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
Cc: <marcin.s.wojtas@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] net: mvpp2: clear BM pool before initialization
Message-ID: <20240116071116.7964ad76@kernel.org>
In-Reply-To: <20240116055754.279560-1-jpatel2@marvell.com>
References: <20240116055754.279560-1-jpatel2@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jan 2024 21:57:54 -0800 Jenishkumar Maheshbhai Patel wrote:
> Register value persisted after booting the kernel using
> kexec which resulted in kernel panic. Thus cleared the
> BM pool registers before initialisation to fix the issue.

s/persisted/persist/
s/resulted/results/
s/cleared/clear/

When you post v2 please add a Fixes tag -- it may be the first commit
that added this driver if the issue has always been there.

