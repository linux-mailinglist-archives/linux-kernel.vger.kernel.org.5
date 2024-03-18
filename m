Return-Path: <linux-kernel+bounces-106639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF2487F158
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2788F1C216D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5718526AC7;
	Mon, 18 Mar 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9PjmDhn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD4222087
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710794517; cv=none; b=tk4ZYazh182HT4STtmm13KfcmJNhQJ34hcFa24Qa9mYgYSKIQcrxxorxvZdKViEpsYEmGyVp1RoCyIyL5K1FR+ez9+03shpdKT7Jrha3KxTdTOwmQQuwNKQ54aerrYQ7nkDn17VaXDPzMcE+j4vFFEpMxKup093ZdcK01I4it6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710794517; c=relaxed/simple;
	bh=i8zyFMvCnYgGOTIy4IrS6KUCSjwtDMvOAJkGI6lyBMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7PD2/Hgq9TT+G0QNoD9L6eUB4V8ROmyIiSp2D7ellf8vp5wffNW2SQLwbRi8x0uMIMlaMMn2gaWT53MjBC5p6nuJV9zCuiImgo5NxStsvA6FO4YXLRExEZgo4i1aMENS7QOYKs2YifK+N4c8xl75YTQzF+2CWXVDfgXaDXpZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9PjmDhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5425C433C7;
	Mon, 18 Mar 2024 20:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710794517;
	bh=i8zyFMvCnYgGOTIy4IrS6KUCSjwtDMvOAJkGI6lyBMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R9PjmDhnioupQKC+rvXxiTc4XhjHet6SqaNDiFrRo+tqu0LfV3X8wdlAc8Nq6RixM
	 ZMFctKRYfgSDJeAYdiQ7PAt/CeIN19BydQAMH3GPt70WpQ+NX9+t5I9M6kK9qAuM77
	 4pxMyATUavAzE3Kpay9VF15E8Gj2O9NbaONzagGhjofsBa6kn6SUTQtQJrjbSDBDLm
	 69NOgMNeRlMPMjrtp7tFq0eIePU9SdBEtdbxNy7MD4abOQmwpvOqWmBuTL3Ifd1+hF
	 pIti83zeXaM1OoKRkyy9R2shr4WUZArR/2YAlTcj1wMJ2p5Tl7bjjzP9LySINGEn9s
	 8OTSxSRVAGlZQ==
Date: Mon, 18 Mar 2024 14:41:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Li Feng <fengli@smartx.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, Anton.Gavriliuk@hpe.ua
Subject: Re: [PATCH v2 1/2] nvme-tcp: Export the nvme_tcp_wq to sysfs
Message-ID: <ZfinEuOTyMPaAX5B@kbusch-mbp.dhcp.thefacebook.com>
References: <20240313123816.625115-1-fengli@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313123816.625115-1-fengli@smartx.com>

On Wed, Mar 13, 2024 at 08:38:09PM +0800, Li Feng wrote:
> Make the workqueue userspace visible for easy viewing and configuration.

Thanks, applied to nvme-6.9.

