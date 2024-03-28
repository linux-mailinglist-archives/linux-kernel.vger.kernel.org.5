Return-Path: <linux-kernel+bounces-122237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C262088F3BB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F323B1C2AA77
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358E6101D0;
	Thu, 28 Mar 2024 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RQxWZHVG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D9A36B;
	Thu, 28 Mar 2024 00:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585978; cv=none; b=n7shh+LVU6hDSLs1kJQxqXcpJK0OnNdwEcSSaU/g6ZWz1b/SH+/RAM6gakbBPu/gCYqzVgEWPRRO3dhteCvYbT4ylGWk46duxINI2O6hDWH+gazB3gdRiH1exkXZ/Or4S53td/Rnj6HOonq4jhp0ayNrgDROYa+5MgKaFUhpebU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585978; c=relaxed/simple;
	bh=UCWHLp4FdzzMBauHwQooqbX9tSiT1V8/n/hnpwh9EFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLNgkjKfrMxp6gRSaYPHPUzK0Lgq4mH2ETSV09V4irmc1q+KZjeb28Dtc7JlBw60/0yQcA981G6UXRfarUIYZbs0RFg895BoynmDvg4IWzWoBHk9TNgRpmF1b/C4fswVUZg9Wk+7honMAt11+crNnJcjTemnlq2EQyCYmuQqLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RQxWZHVG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=R3IwXdmodzpVMvblIree2CIRTU0R+iTfZh8eA9g3U0g=; b=RQxWZHVGBZ+LUwLaoKA9chZxNT
	Y1/mipc/u/eYmgmmqrWvcz0yAB1QFNMWprnk3HOjYqIrhnG0SxB2rV1hIsiDyRCmDixferTtxCsqg
	vGJU1O9auFT++/gQ+HfTP06OdPcXsY62DKDIxSxDM6Zgj9oNEk1i6g7cco0a+knj/B1nEadRuPERI
	B27JRygJi7rKne3WT2H5J8LgfaYLLM3SAFaoBvhDaMa5WXHoJO2E3d//AUsGcNXuzwrpDDB5JrUAe
	Vbm5oHOBCE1zIdO6Zl88OF/HziEgk+ppc/+6BounEXWQ2KxXNHzRh5aQXeCwl9crnxyBGF/Ts1yLw
	LIyXNKRA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdhN-0000000Blyz-0a2K;
	Thu, 28 Mar 2024 00:32:53 +0000
Message-ID: <f4158f39-005e-47e7-9fb3-b0fe9b878514@infradead.org>
Date: Wed, 27 Mar 2024 17:32:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 RESEND 4/5] Documentation: tracing: Add ring-buffer
 mapping
Content-Language: en-US
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com
References: <20240326100830.1326610-1-vdonnefort@google.com>
 <20240326100830.1326610-5-vdonnefort@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240326100830.1326610-5-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/26/24 03:08, Vincent Donnefort wrote:
> It is now possible to mmap() a ring-buffer to stream its content. Add
> some documentation and a code example.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 

> diff --git a/Documentation/trace/ring-buffer-map.rst b/Documentation/trace/ring-buffer-map.rst
> new file mode 100644
> index 000000000000..0426ab4bcf3d
> --- /dev/null
> +++ b/Documentation/trace/ring-buffer-map.rst
> @@ -0,0 +1,106 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
> +Tracefs ring-buffer memory mapping
> +==================================
> +
> +:Author: Vincent Donnefort <vdonnefort@google.com>
> +
> +Overview
> +========
> +Tracefs ring-buffer memory map provides an efficient method to stream data
> +as no memory copy is necessary. The application mapping the ring-buffer becomes
> +then a consumer for that ring-buffer, in a similar fashion to trace_pipe.
> +
> +Memory mapping setup
> +====================
> +The mapping works with a mmap() of the trace_pipe_raw interface.
> +
> +The first system page of the mapping contains ring-buffer statistics and
> +description. It is referred as the meta-page. One of the most important field of

                      referred to as                                       fields

> +the meta-page is the reader. It contains the sub-buffer ID which can be safely
> +read by the mapper (see ring-buffer-design.rst).
> +
> +The meta-page is followed by all the sub-buffers, ordered by ascendant ID. It is

                                                                ascending
might be better IMO.

> +therefore effortless to know where the reader starts in the mapping:
> +
> +.. code-block:: c
> +
> +        reader_id = meta->reader->id;
> +        reader_offset = meta->meta_page_size + reader_id * meta->subbuf_size;
> +
> +When the application is done with the current reader, it can get a new one using
> +the trace_pipe_raw ioctl() TRACE_MMAP_IOCTL_GET_READER. This ioctl also updates
> +the meta-page fields.


[snip]

Thanks.
-- 
#Randy

