Return-Path: <linux-kernel+bounces-90915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 217558706B9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3B91F22BD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0294C618;
	Mon,  4 Mar 2024 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="cjo+/8JL"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB44D584
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568938; cv=none; b=YlnSdFIgo/23zKkSxAAoYPUNhJuCDXVItjW1XjWJuHKrCXEYzi1aCApHJkr92ggKFSyJxaFZ9UL00g/Tpm0YYU5J4HHEtMNr3/eHC04p4l/qOhjeirnzuki9Umr+2Bt9pCpyQu2xiVtOL0Ov+41a4waSNPlsLPf9MCvBmlF9bS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568938; c=relaxed/simple;
	bh=4wLXXGapyhl5RXVihnd+1Vp73lXL989wXTA0Ag/ZZ1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukT0ulJ7P3t3lms6g/vltky+mdn1RhWshKV8+4aTYOPBdGW6PkAV+IKVqTAKozpntHYBtJ/i4dV0sIf9hOeJu6tCuMCznaeMMoLi18+MOAPKpmaU7Uu6NBROfXW9V9RRVhNpR6nlA67+9jqUEbxeTByMDCTb4mUMiSCD4svPDDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=cjo+/8JL; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id h5fNrBTXPl9dRhAyUrsTeX; Mon, 04 Mar 2024 16:15:34 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id hAyTrqZAGlNyJhAyTrtw3U; Mon, 04 Mar 2024 16:15:33 +0000
X-Authority-Analysis: v=2.4 cv=PIAJ++qC c=1 sm=1 tr=0 ts=65e5f3a5
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=cm27Pg_UAAAA:8
 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=dPq7nFLFEyjAz7fAJV0A:9 a=QEXdDO2ut3YA:10
 a=xmb-EsYY8bH0VWELuYED:22 a=IawgGOuG5U0WyFbmm1f5:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8i2X/bWggq1yfpDbyb2kwdQL3S/U6M4BjzbCsEE+miw=; b=cjo+/8JLIpVVj8RUICChZHzoqx
	XXKQHmpHQAnC4UKC22Bzg3n3eQAxaGzntF0h93IIp5KmW76LC4kmoFYtfpZ4DoKPBfbaEU/HSzDlC
	0Az9mOjkHScrMgK9+GAQZkGPCbt9pPZ98pd6Hgx22tlzFx9ACS3Dj0wWDfW3NkKGLEycgMuPmuh2C
	PB6l9QtHvw81goFu5ndmwwQgCba4oWVx4ET4jtN7zK/8lL6rNRZPjjzHWCBXHAyGQqEAPUOon2PfZ
	heb9iFidHHfE5WC9B0AOv1ivBcu0OnixBskO2P99oWtspbIvSwk7dVkbzHHqBZZBSNgeWrnPzT24d
	nW72FOfA==;
Received: from [201.172.172.225] (port=49252 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rhAyS-003iEz-30;
	Mon, 04 Mar 2024 10:15:32 -0600
Message-ID: <8281c9ed-8532-40c3-ad5b-3c7955935705@embeddedor.com>
Date: Mon, 4 Mar 2024 10:15:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] spi: axi-spi-engine: remove p from struct
 spi_engine_message_state
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
 <20240304-mainline-axi-spi-engine-small-cleanups-v2-1-5b14ed729a31@baylibre.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240304-mainline-axi-spi-engine-small-cleanups-v2-1-5b14ed729a31@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rhAyS-003iEz-30
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.172.225]:49252
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC3nIwRT+jWKu5ONsGIYITyaMbH+GA4At0vAdCHX09vRlMnj+4B7Qd8uIPviylozHmZZHNw/whXhSb38Hd++xkqgi1lyyoaqoOBK0TPLIchjZ2yh3LuF
 yZmZiRKBuzUpAWlpwkTwuetGLasishKtVpPePRnSSYgvMZHQm+RzX7qe+1A09I6VJRXiwEMMzxQCRBRO7YfR98LEytbFv7Oo6tNRz7hL00dOtuHiS9TrwuuT



On 04/03/24 10:04, David Lechner wrote:
> The program pointer p in struct spi_engine_message_state in the AXI SPI
> Engine controller driver was assigned but never read so it can be
> removed.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/spi/spi-axi-spi-engine.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index 6177c1a8d56e..d89f75170c9e 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -82,8 +82,6 @@ struct spi_engine_program {
>    * struct spi_engine_message_state - SPI engine per-message state
>    */
>   struct spi_engine_message_state {
> -	/** @p: Instructions for executing this message. */
> -	struct spi_engine_program *p;
>   	/** @cmd_length: Number of elements in cmd_buf array. */
>   	unsigned cmd_length;
>   	/** @cmd_buf: Array of commands not yet written to CMD FIFO. */
> @@ -543,7 +541,6 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
>   
>   	/* reinitialize message state for this transfer */
>   	memset(st, 0, sizeof(*st));
> -	st->p = p;
>   	st->cmd_buf = p->instructions;
>   	st->cmd_length = p->length;
>   	msg->state = st;
> 

