Return-Path: <linux-kernel+bounces-29460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1295D830E91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A13BDB25997
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE902563F;
	Wed, 17 Jan 2024 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PJkoipQW"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B5725572
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526608; cv=none; b=J0In3r9fmmPKfn3DksZi1/VMd+uvxK5fB2/t3FYaFOx6qedZIUKHKXgYUqS7kOc4aAQjLtL455P5LgdHO4JKPN92/hN5zN6hqGgPNCEo3rhZiUEYkKt9ApbMYMm8EW8Qip9yq6yxjKN41Byl1Kj5HbMLx3VoDsW91FuedgUjiPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526608; c=relaxed/simple;
	bh=kaH9a9Hkr2U67UKTfEUbe2RJ6wXoXhdTorzk0Et6RZU=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=ZLFQ5getovPVir4xUdQHpfINOa+ClLKn7L5aGjSEt/GuqvaiRC1lX9HQzJFSeCOcFCMf+kAOrob7GuTYISzggzXTJaswo+YlKi1JjDgmImrQ8G5PuWVZJVPFCpbPgyz/lJJ/W+1a9roWgDeFwUqnf8kFrvFwdTUemtroNZtPv+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PJkoipQW; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a6c5297-6e86-4f0d-a85e-1a93b2215d68@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705526604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nk4PnGFoII20WorTY8XPDUyENB4Rwy8FvWCgKEj2dRQ=;
	b=PJkoipQWE81phR1YEm2bC199QlluF2n9wF8zN9x+YvsVDQktC/Q3hZe9S5CFC2H58mS1wP
	O8O1vhvjSwAvfOIyRgKu+JCG1Bvd4AeGioh6nssHPmEXfkLr3OgwyH6fSk1+ixw+kVKdpZ
	r+1hjmg5xsS9FayjZhG7AKbbHz0pQpU=
Date: Wed, 17 Jan 2024 21:23:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5] ptp: ocp: add Adva timecard support
Content-Language: en-US
To: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
 jonathan.lemon@gmail.com, vadfed@fb.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
References: <20240117114350.3105-1-maimon.sagi@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240117114350.3105-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/01/2024 11:43, Sagi Maimon wrote:
> Adding support for the Adva timecard.
> The card uses different drivers to provide access to the
> firmware SPI flash (Altera based).
> Other parts of the code are the same and could be reused.
> 

Hi Sagi,

Thanks for adjusting the code. One signle still have to be
adjusted, see comments below. And this is treated as net-next
material, but net-next is closed now until merge window ends,
you will have to submit new version next week.

Please, also use '[PATCH net-next v6] ...' prefix for it.

> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> ---
>   Changes since version 4:
>   - alignment fix.
> 

Please, preserve changes from all previous versions for next submissions.

>   drivers/ptp/ptp_ocp.c | 302 ++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 293 insertions(+), 9 deletions(-)
> 

[ ..skip.. ]

> @@ -2603,7 +2819,44 @@ ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>   	if (err)
>   		return err;
>   
> -	return ptp_ocp_init_clock(bp);
> +	return ptp_ocp_init_clock(bp, r->extra);
> +}
> +
> +/* ADVA specific board initializers; last "resource" registered. */
> +static int
> +ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
> +{
> +	int err;
> +	u32 version;
> +
> +	bp->flash_start = 0xA00000;
> +	bp->eeprom_map = fb_eeprom_map;
> +	bp->sma_op = &ocp_adva_sma_op;
> +
> +	version = ioread32(&bp->image->version);
> +	/* if lower 16 bits are empty, this is the fw loader. */
> +	if ((version & 0xffff) == 0) {
> +		version = version >> 16;
> +		bp->fw_loader = true;
> +	}
> +	bp->fw_tag = 1;

Please, use fw_tag = 3 here, other tags are for other vendors.

Thanks,
Vadim

> +	bp->fw_version = version & 0xffff;
> +	bp->fw_cap = OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
> +
> +	ptp_ocp_tod_init(bp);
> +	ptp_ocp_nmea_out_init(bp);
> +	ptp_ocp_signal_init(bp);
> +


