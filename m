Return-Path: <linux-kernel+bounces-20321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE156827D4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB83CB224C9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 03:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60523D86;
	Tue,  9 Jan 2024 03:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn8WXrZV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD86D6CE;
	Tue,  9 Jan 2024 03:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17082C433F1;
	Tue,  9 Jan 2024 03:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704770411;
	bh=q9srmDbf4D+LE+vfVoJX5VssiHBgxplx5AHPUQqQJjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bn8WXrZVN0UT89kbeyLtwD1rsrMUx1qbbTR2yzlSNxeYt96oqhY6aX3tdLYSeQjzD
	 y51WszwMu9vFJQ2kinoF6V7UgyJglHO7xlDyZ8YvZzUvQVZow+gVrBelrWA+o6x7MC
	 fOmwxMgtw+HeaSnWC+NcE4b+8Kvf+i54WT306D8CAvu0HuRprtokFlrgKiL2olo1Qk
	 rSbbutRHTUKeUYF1fUYKYmVi31ywH05aFG9OSYXSWyozAwl10Qrsy0P0UYonNQSD6/
	 bYySJ4weJJFoyeY1DL0WrWowOJ8GJ51xrxdnN+Lxtg5HYQDIejVRkzoFX+tLdC3pEP
	 8F8Qgb4KAjnng==
Date: Mon, 8 Jan 2024 19:20:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH] octeontx2-pf: Add support for offload tc with
 skbedit mark action
Message-ID: <20240108192010.2dcedb50@kernel.org>
In-Reply-To: <20240105120247.14975-1-gakula@marvell.com>
References: <20240105120247.14975-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jan 2024 17:32:47 +0530 Geetha sowjanya wrote:
> Support offloading of skbedit mark action.
> 
> For example, to mark with 0x0008, with dest ip 60.60.60.2 on eth2
> interface:
> 
>  # tc qdisc add dev eth2 ingress
>  # tc filter add dev eth2 ingress protocol ip flower \
>       dst_ip 60.60.60.2 action skbedit mark 0x0008 skip_sw

We didn't get to this patch in time for v6.8 merge window, sorry.
Please repost in two weeks when net-next reopens for v6.9.
-- 
pw-bot: defer

