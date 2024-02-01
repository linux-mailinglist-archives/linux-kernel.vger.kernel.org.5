Return-Path: <linux-kernel+bounces-48808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5148461D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2621C23060
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDAF8563C;
	Thu,  1 Feb 2024 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bigler.one header.i=@bigler.one header.b="UppCvTfc"
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF71B84FDC;
	Thu,  1 Feb 2024 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706818899; cv=none; b=gFHXTin7XEHm3tms7lPyv6aYWbuauW9D9/O7Wurnc/E5ql2G062rT29CxQq/KeWdLMpYXZpl0cSklidkIUgWRHZ5LYob/xFCbeZytMLYMtNUdgEMF/a93r1EQFx6hDrnYZBAPkJb2DtUKfu+7SOaJlRpzsduV2UL9l0vG9V/0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706818899; c=relaxed/simple;
	bh=uWRxYj8XRltiAC9tPZ020F7sdwr+RbT8boPBU4qJhlc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XI84YpqgGjOCRLam7NGE3Mq0Ie7/ZSygVka7LVgDYxDbSEF2sEuyawfrPJXH0gMgSzI1xzIMHYhmqas98mv4pysM25Ef4vjmXN4mwb92u/6Y0+duBBE4wUpS12MBOP5gCTpPnzKn0KRgHLMWAHhuq8k8K0u/SvMh0SFYw2DSK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bigler.one; spf=pass smtp.mailfrom=bigler.one; dkim=pass (2048-bit key) header.d=bigler.one header.i=@bigler.one header.b=UppCvTfc; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bigler.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bigler.one
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4TQqrP5j1Rz3tJR;
	Thu,  1 Feb 2024 21:14:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.one; s=key2;
	t=1706818485; bh=uWRxYj8XRltiAC9tPZ020F7sdwr+RbT8boPBU4qJhlc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UppCvTfcA2RgJNoXTU8qeaJLLREcPUA5V4YDOcX9qhBOpLF+nEvRMg6QQ0OrBlIRR
	 FrozWJ4XYhHiWdLL3w194THXHU4KTgeoGr5yuZcFXrDaerMMFASp1yBcIQkwnsRLFq
	 qydIcRb+1quMzVjs6Y3h49dpjtyV8+X0ogoplcW6uHOZOuHC6MWWMeU1A/IHON6vja
	 XcZiqix0WMDcWBH9HrWqH6RGG0tHqGCz9Vu4ukNc0nKkKdTtny1rvC4H13THZiARh+
	 lJ3mO3/X0S2Vcxh/ptbw+p47R7Or1ljYOeszbFrUZLw0upohr5y3uwzx+43mVH4LIV
	 LMWuxBGyBwz8g==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4TQqrP4xJdz3t7W;
	Thu,  1 Feb 2024 21:14:45 +0100 (CET)
Received: from mx2fc6.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4TQqrN3DZNz8svC;
	Thu,  1 Feb 2024 21:14:44 +0100 (CET)
Received: from [192.168.1.24] (adsl-84-227-96-175.adslplus.ch [84.227.96.175])
	by mx2fc6.netcup.net (Postfix) with ESMTPSA id A6C7048EEA;
	Thu,  1 Feb 2024 21:14:39 +0100 (CET)
Authentication-Results: mx2fc6;
        spf=pass (sender IP is 84.227.96.175) smtp.mailfrom=benjamin@bigler.one smtp.helo=[192.168.1.24]
Received-SPF: pass (mx2fc6: connection is authenticated)
Message-ID: <c7326b50ce3fe2a660638e1eb2c11519ad82feee.camel@bigler.one>
Subject: Re: [PATCH v4] spi: imx: fix the burst length at DMA mode and CPU
 mode
From: Benjamin Bigler <benjamin@bigler.one>
To: carlos.song@nxp.com, broonie@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
	stefanmoring@gmail.com
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 21:14:39 +0100
In-Reply-To: <20240201105451.507005-1-carlos.song@nxp.com>
References: <20240201105451.507005-1-carlos.song@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-PPP-Message-ID: <170681848016.16773.8628634408198911382@mx2fc6.netcup.net>
X-Rspamd-Queue-Id: A6C7048EEA
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: eOEbwlsnu2A8UH1oqf6GVIXsysxMrcadamR+vO9LU4MI+So=

On Thu, 2024-02-01 at 18:54 +0800, carlos.song@nxp.com wrote:
> From: Carlos Song <carlos.song@nxp.com>
>=20
> For DMA mode, the bus width of the DMA is equal to the size of data
> word, so burst length should be configured as bits per word.
>=20
> For CPU mode, because of the spi transfer len is in byte, so burst
> length should be configured as bits per byte * spi_imx->count.
>=20
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Reviewed-by: Clark Wang <xiaoning.wang@nxp.com>
> Fixes: e9b220aeacf1 ("spi: spi-imx: correctly configure burst length when=
 using dma")
> Fixes: 5f66db08cbd3 ("spi: imx: Take in account bits per word instead of =
assuming 8-bits")
> ---
> Changes for V3:
> - include <linux/bits.h>
> Changes for V4:
> - keep the includes sorted alphabetically.
> ---
>  drivers/spi/spi-imx.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 546cdce525fc..f7990ac2c654 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -2,6 +2,7 @@
>  // Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved=
.
>  // Copyright (C) 2008 Juergen Beisert
> =20
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/completion.h>
>  #include <linux/delay.h>
> @@ -660,15 +661,14 @@ static int mx51_ecspi_prepare_transfer(struct spi_i=
mx_data *spi_imx,
>  			<< MX51_ECSPI_CTRL_BL_OFFSET;
>  	else {
>  		if (spi_imx->usedma) {
> -			ctrl |=3D (spi_imx->bits_per_word *
> -				spi_imx_bytes_per_word(spi_imx->bits_per_word) - 1)
> +			ctrl |=3D (spi_imx->bits_per_word - 1)
>  				<< MX51_ECSPI_CTRL_BL_OFFSET;
>  		} else {
>  			if (spi_imx->count >=3D MX51_ECSPI_CTRL_MAX_BURST)
> -				ctrl |=3D (MX51_ECSPI_CTRL_MAX_BURST - 1)
> +				ctrl |=3D (MX51_ECSPI_CTRL_MAX_BURST * BITS_PER_BYTE - 1)
>  						<< MX51_ECSPI_CTRL_BL_OFFSET;
>  			else
> -				ctrl |=3D (spi_imx->count * spi_imx->bits_per_word - 1)
> +				ctrl |=3D (spi_imx->count * BITS_PER_BYTE - 1)
I think that will not work for drivers which dont use bits_per_word=3D8.=C2=
=A0
https://lore.kernel.org/all/20230917164037.29284-1-stefanmoring@gmail.com/
>  						<< MX51_ECSPI_CTRL_BL_OFFSET;
>  		}
>  	}

Best regards,
Benjamin Bigler


