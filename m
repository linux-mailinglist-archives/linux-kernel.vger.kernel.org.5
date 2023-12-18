Return-Path: <linux-kernel+bounces-4458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6110A817D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75E111C21DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28F97608B;
	Mon, 18 Dec 2023 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGpb1mKP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E987207B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 22:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E3AC433C7;
	Mon, 18 Dec 2023 22:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702940159;
	bh=3ZSNz308tZZw0RJgAjD6nfFniOx5NlqsMMdcFwAYZZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sGpb1mKPPQqEAyFKy0N5+OFNxEH/2aKablBDCsdCaFGWo259hK5HGwXGgLrfhX0f9
	 asvFISaVFoOepN9b6DyAYHqP+t7JFvzo9fz/bGYTjl6SMvcxM5sMGPNDIJN34Z+EnO
	 JlrdPcQe6IcGinBBqbPUAWsW2ujwJKzZ3NlQl6iynDOtX+eecs5V25NmX8GJWQwocN
	 vqykaF8WmURtYNnmSh4R8Hl8T8IJIR7HBpyXijOT9HIB0RJqjJd/va/T1Jd6ylDBNm
	 IzGz2EMw+Sdq4TfCJxPqYnu1x5Bg2etUygtLIppiYH05TrzBTDLv8S77JusN3NRvHP
	 BxXsYFAmPuiwQ==
Date: Mon, 18 Dec 2023 15:55:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v6 0/6] nvme: add csi, ms and nuse to sysfs
Message-ID: <ZYDN_G-VP2_pn3kC@kbusch-mbp.dhcp.thefacebook.com>
References: <20231218165954.29652-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218165954.29652-1-dwagner@suse.de>

On Mon, Dec 18, 2023 at 05:59:48PM +0100, Daniel Wagner wrote:
> Rebased on the current nvme/nvme-6.8 branch and added the Review tags. Also
> addressed the printk format issue pointed out by Chaitanya.

Thanks, added to nvme-6.8.

