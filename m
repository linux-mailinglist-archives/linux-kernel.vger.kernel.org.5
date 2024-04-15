Return-Path: <linux-kernel+bounces-145118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08E68A4FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D9E1F22614
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5027D83A18;
	Mon, 15 Apr 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yxatIqoK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E4480BFE;
	Mon, 15 Apr 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185383; cv=none; b=Yy2vvCrsywViW19JkdtAxt40POW0kEzrIO6jgM5P4sOpEyBAq5wnqZoXwZ5xKcSeFYkaazQTzcQk3E78/hVN4Lly5S3RohRRojgW/h6PFgvVXcjUCRBHbVzGu6ahHZdk/lbTKVU7B1CGVDPeXuDkYbJ/yW7Le3TU8lV2R/ux1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185383; c=relaxed/simple;
	bh=LV17j8lVfsperCS+wGHMXoiZ0shCDUOI6KBK+CN55uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv0evNZGVKrE1mUmY/X2cB3+Ev4P1e0pZDXPb5ZLV0wdNCy8SBxv2GVcvTCTCnvEkuYTO6CZzqIj8Ff6SR15gtrRaUXePLR2AQgkcz0YvMr5HxrDgq4OyWGXfD+p1Fh5OKi/j3YIN4i6R2q5i7ZzhA1p/eycqRLZG8Yt6pJi+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yxatIqoK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713185379;
	bh=LV17j8lVfsperCS+wGHMXoiZ0shCDUOI6KBK+CN55uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yxatIqoKZRdi1AUWhctz9vu5L3Y6vPDYY50NaG0uUrTo+f8BCuQQwHT+cRelofTDq
	 onXsw2sIpVxm2OS5wbzIoUx0NMDYkUvZu99XSH3zcvIANjBpgmWhgMFfSB++eZVytH
	 OH7BEd+bB7qeHqG37RQO4gjCYhy7ZydVovmApXI5KM91lRxDEvvTN7WGQnYSCPALXk
	 U15AlAfk2nrwmWzG49dtvm8wHT+4V9TGza+7UdpjXJ3SkvG5MLQKPH5Wiedd3qy/os
	 yA1KaSVJeU/SlqZoFCIWeLqqzHJLcPLSW2SCnbVTjiPzVE1csYMZFE+696kQqYUEI3
	 WBM8S+rukjyqQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 931A33781107;
	Mon, 15 Apr 2024 12:49:39 +0000 (UTC)
Date: Mon, 15 Apr 2024 14:49:38 +0200
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Ivan Bornyakov <brnkv.i1@gmail.com>
Cc: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Wave515 decoder IP support
Message-ID: <20240415124938.o5j5er7osnb5ohdm@basti-XPS-13-9310>
References: <20240415100726.19911-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240415100726.19911-1-brnkv.i1@gmail.com>

Hey Ivan,

On 15.04.2024 13:07, Ivan Bornyakov wrote:
>Initial support for Wave515 multi-decoder IP among other refinements.
>This was tested on FPGA prototype, so wave5_dt_ids[] was not expanded.
>
>fluster score for JCT-VC-HEVC_V1 testsuite with
>GStreamer-H.265-V4L2-Gst1.0 decoder is 132/147
>
>The issue with Main10 tests is that fluster expects decoded file to be
>in yuv420p10le format while this driver decodes HEVC Main10 into 8-bit
>yuv420p. Though result is looks alright to the naked eye, proper
>decoding into yuv420p10le is to be added.
>
>The rest failed fluster tests are common with Wave521.
>
>ChangeLog:
>  v1:
>https://lore.kernel.org/linux-media/20240318144225.30835-1-brnkv.i1@gmail.com/
>  v2:
>https://lore.kernel.org/linux-media/20240325064102.9278-1-brnkv.i1@gmail.com/
>    * drop patch "dt-bindings: media: cnm,wave521c: drop resets restriction"
>      The only user of Wave5 in mainline is TI K3 boards, thus there is
>      no real need to alter dt-bindings
>    * in patch "media: chips-media: wave5: support decoding HEVC Main10 profile"
>      add check for flag "support_hevc10bit_dec"
>    * in patch "media: chips-media: wave5: support reset lines" move
>      reset_control_deassert() out of else branch, add
>      reset_control_assert() to probe error path.
>    * rework patch "media: chips-media: wave5: drop "sram-size" DT prop"
>       - don't move alloc/free form device open/close
>       - intead of exact configuration of reserved SRAM memory in DT and
>	 allocating all of it, allocate all available SRAM memory up to
>	 WAVE5_MAX_SRAM_SIZE from whatever pool provided.
>    * adjust patch "media: chips-media: wave5: support Wave515 decoder"
>      according to changes in patches
>      "media: chips-media: wave5: support decoding HEVC Main10 profile" and
>      "media: chips-media: wave5: drop "sram-size" DT prop"
>  v3:
>https://lore.kernel.org/linux-media/20240405164112.24571-1-brnkv.i1@gmail.com/
>    * reword patch "media: chips-media: wave5: separate irq setup routine"
>      a bit.
>    * in patch "media: chips-media: wave5: drop "sram-size" DT prop"
>       - move MAX_SRAM_SIZE define into match_data->sram_size
>       - add placeholders for validation that allocated SRAM memory is
>	 enough to encode/decode bitstream of given resolution before
>	 setting W5_USE_SEC_AXI and W5_CMD_ENC_PIC_USE_SEC_AXI registers
>       - reword accordingly
>    * in patch "media: chips-media: wave5: support Wave515 decoder"
>       - add comments around SRAM memory allocation/freeing about
>	 Wave515 specifics
>       - add comments about BSOPTION_RD_PTR_VALID_FLAG bit in
>	 W5_BS_OPTION register
>       - add W[AVE]521_ prefix to defines, for wich there are W[AVE]515_
>	 alternatieves
>       - add semi-magic Wave515 specific formulas to estimate SRAM usage
>  v4:
>    * rebase onto next-20240415, no functional changes

Sorry for not finding the time for review, I'll work on it asap.
But please don't send a full new series just for a rebase, as that just
causes noise, I can very well rebase the series myself before a PR
and if any hard conflicts appear they can be communicated.

Greetings,
Sebastian

>
>Ivan Bornyakov (5):
>  media: chips-media: wave5: support decoding HEVC Main10 profile
>  media: chips-media: wave5: support reset lines
>  media: chips-media: wave5: separate irq setup routine
>  media: chips-media: wave5: drop "sram-size" DT prop
>  media: chips-media: wave5: support Wave515 decoder
>
> .../platform/chips-media/wave5/wave5-helper.c |   8 +-
> .../platform/chips-media/wave5/wave5-hw.c     | 395 +++++++++++++-----
> .../chips-media/wave5/wave5-regdefine.h       |   5 +
> .../platform/chips-media/wave5/wave5-vdi.c    |  27 +-
> .../chips-media/wave5/wave5-vpu-dec.c         |  51 ++-
> .../chips-media/wave5/wave5-vpu-enc.c         |   2 +-
> .../platform/chips-media/wave5/wave5-vpu.c    |  35 +-
> .../platform/chips-media/wave5/wave5-vpuapi.h |   3 +
> .../chips-media/wave5/wave5-vpuconfig.h       |  16 +-
> .../media/platform/chips-media/wave5/wave5.h  |   6 +
> 10 files changed, 407 insertions(+), 141 deletions(-)
>
>-- 
>2.44.0
>

