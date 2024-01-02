Return-Path: <linux-kernel+bounces-14852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7479F822334
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A97B214D3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C063168B1;
	Tue,  2 Jan 2024 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw6446Ls"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE5168A4;
	Tue,  2 Jan 2024 21:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5CE7C433C7;
	Tue,  2 Jan 2024 21:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704230369;
	bh=Ac9sY8QL1WZFRp+l3xJy75UJleljP01945ZqK3wJKPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gw6446Lsvvut9SEaZKlZhgVprXqHIXrrr8pPXimW6Oed9GwxQ2uqyE7D2wEwwrr8R
	 4S3E+9HtvO81PHZbdB/K0rTX6tkAqgW7KcTV8PgN3xmyt+wiBa8XSfHHVZsvqNeMgj
	 YBDQLfFGjWvwhhWNv2kr1AKezmkeXgtkJRbqyBMS/0TC5EEvSR7a8N29nZoekmybqw
	 ww0GFRPmtaQGYT2uwpkPjHb8bR9hugcfsMsXTT6f8Y23UeTZ5NVTH2sqMY8fPckZd+
	 LlmdCESsu88RMJ2tqGEAoxqKXssyDePhI/3LB3PghnF16AsQcQ1CwcnEzZEUnEQ++N
	 zD8JAwDKN6RdQ==
Date: Tue, 2 Jan 2024 14:19:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
	James Smart <james.smart@broadcom.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH 0/2] nvmet-fc: Adjustments for nvmet_fc_alloc_ls_iodlist()
Message-ID: <ZZR93keoL4S6uF-_@kbusch-mbp.dhcp.thefacebook.com>
References: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>

On Wed, Dec 27, 2023 at 06:14:35PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 27 Dec 2023 18:09:09 +0100
> 
> A few update suggestions were taken into account
> from static source code analysis.

These look good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

