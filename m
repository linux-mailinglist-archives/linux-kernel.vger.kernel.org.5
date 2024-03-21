Return-Path: <linux-kernel+bounces-110111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C48885A25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBDB1C211BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B24184FA6;
	Thu, 21 Mar 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMNmknAs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C4883CBD;
	Thu, 21 Mar 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029220; cv=none; b=PsHHTJJe+2dz18pEU0Lqwt81toqBooL5KMyIZGSenm/P8UoTdlfHeFMC4oRoVcnBdZ4LPoZJuaxLNlg9aEqpyfWhL+kLBMMopAR7TtP5Zgur0y2IJKO3LHMezR0XBJPsklLbQCOZ4+anM84npzD24UPFEkXmbqQDKUxZbzkRG4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029220; c=relaxed/simple;
	bh=DvBB/6zGVSZEaFi3VzDateQj+BuaDOQRH3kaUMryqAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USTpe7HLrHielpgJK4xQoIg5VTnDC5UYvR5blXIyDRRHLnTNRQAhMnd8foHCRNeS0kRO24+iR7z68FJGWNu46AUV24DtzabtfNP2Gs4uA8hruMf67yXUCeIuWXvzVXtPwKI1u5lXPLZx/3FMMPxsVv5NW7wPOOcrpnLB8pMMsQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMNmknAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997C6C433C7;
	Thu, 21 Mar 2024 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711029220;
	bh=DvBB/6zGVSZEaFi3VzDateQj+BuaDOQRH3kaUMryqAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SMNmknAsOyNkFkvEajAPGgh18UHLS9x4ff9AqvWrb4D+691nx3lmV4E7gHlOPkx0F
	 5bBarqx7qjYaCJBCSlRvs9pPhuNwC0acUoL548A3yjB8RPuPkoIfG2AnEFGxsKaLeE
	 pgbiL6/DpMZtwT50H8I/RPaJHiRzSTLOSGPYhhNMmC7qpMG4pwrCxqkmRdQG9WiQu5
	 A+TdCUusbi89soOaxyVC3Mm1xCiAXJ7KMl+4FuRw7AnRhU8PVVzmuJZ3jEaCKEuAmG
	 bHqGAzM5ydlWTGBHkEeDJhRoqaR3Gcy1CWImrtzw8WTsbKz42Q7cMG3yTPPM2c6dp5
	 MEZIE5rSopL7A==
Date: Thu, 21 Mar 2024 14:53:34 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: tfiga@chromium.org, m.szyprowski@samsung.com,
 ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
 hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v21 3/9] media: test-drivers: Set REQBUFS minimum number
 of buffers
Message-ID: <20240321145334.25c23712@coco.lan>
In-Reply-To: <20240314153226.197445-4-benjamin.gaignard@collabora.com>
References: <20240314153226.197445-1-benjamin.gaignard@collabora.com>
	<20240314153226.197445-4-benjamin.gaignard@collabora.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 14 Mar 2024 16:32:20 +0100
Benjamin Gaignard <benjamin.gaignard@collabora.com> escreveu:

> Instead of using 'min_queued_buffers' field to specify the
> minimum number of buffers to be allocated when calling REQBUF
> use 'min_reqbufs_allocation' field which is dedicated to this
> purpose.
> 
> While at it rename vivid_create_queue() parameter.

LGTM.
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/test-drivers/vimc/vimc-capture.c | 2 +-
>  drivers/media/test-drivers/vivid/vivid-core.c  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
> index 2a2d19d23bab..97693561f1e4 100644
> --- a/drivers/media/test-drivers/vimc/vimc-capture.c
> +++ b/drivers/media/test-drivers/vimc/vimc-capture.c
> @@ -432,7 +432,7 @@ static struct vimc_ent_device *vimc_capture_add(struct vimc_device *vimc,
>  	q->mem_ops = vimc_allocator == VIMC_ALLOCATOR_DMA_CONTIG
>  		   ? &vb2_dma_contig_memops : &vb2_vmalloc_memops;
>  	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> -	q->min_queued_buffers = 2;
> +	q->min_reqbufs_allocation = 2;
>  	q->lock = &vcapture->lock;
>  	q->dev = v4l2_dev->dev;
>  
> diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
> index 159c72cbb5bf..11b8520d9f57 100644
> --- a/drivers/media/test-drivers/vivid/vivid-core.c
> +++ b/drivers/media/test-drivers/vivid/vivid-core.c
> @@ -861,7 +861,7 @@ static const struct media_device_ops vivid_media_ops = {
>  static int vivid_create_queue(struct vivid_dev *dev,
>  			      struct vb2_queue *q,
>  			      u32 buf_type,
> -			      unsigned int min_queued_buffers,
> +			      unsigned int min_reqbufs_allocation,
>  			      const struct vb2_ops *ops)
>  {
>  	if (buf_type == V4L2_BUF_TYPE_VIDEO_CAPTURE && dev->multiplanar)
> @@ -898,7 +898,7 @@ static int vivid_create_queue(struct vivid_dev *dev,
>  	q->mem_ops = allocators[dev->inst] == 1 ? &vb2_dma_contig_memops :
>  						  &vb2_vmalloc_memops;
>  	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
> -	q->min_queued_buffers = supports_requests[dev->inst] ? 0 : min_queued_buffers;
> +	q->min_reqbufs_allocation = min_reqbufs_allocation;
>  	q->lock = &dev->mutex;
>  	q->dev = dev->v4l2_dev.dev;
>  	q->supports_requests = supports_requests[dev->inst];



Thanks,
Mauro

