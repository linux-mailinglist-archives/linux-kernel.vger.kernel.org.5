Return-Path: <linux-kernel+bounces-21791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8253C829452
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15001B247B4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00AF39FC9;
	Wed, 10 Jan 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fyG9OOmp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08039ADE;
	Wed, 10 Jan 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=xb86iNZOklvvcYUTQPgNE0eZRKoTDuKrcQHp9oVgl9w=; b=fyG9OOmpqTczg+BBenyoZQfHNZ
	7rjpy2eq112ZEZ1WRvFppYyNMiPyH27l5pJiAhOgTi285c3Ip85CHMZAUaAf4b8e0g6p4bBHdebBH
	8s+ycnxUvRVBfu6PPwS4gc0eDOfNgspEKsCReAltNJjZZt3a7dan75hXtqYeRLg2Z8eNzwc/PziFG
	ZoTlLX3onKZJikeWPHAaGQrwZiLBWoWkZlUKhCwxYDGwpNAEYbDOZ7q2czVfiEW0ztcHolFB0URtd
	2MnlwE/OtlwVPDUg15kVyX6zXxydvVGzRyk0syA5BfvVHSextEUBCxvWpbnVag/+HAz4uJ+X5WXA8
	I0plBcKQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNT2Y-00Ac99-1v;
	Wed, 10 Jan 2024 07:30:18 +0000
Message-ID: <e3941caa-7546-415f-be7b-b955cf13aa8b@infradead.org>
Date: Tue, 9 Jan 2024 23:30:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] staging: vt6655: fix open parentheses alignment
Content-Language: en-US
To: Matthias Yee <mgyee9@gmail.com>, gregkh@linuxfoundation.org
Cc: dan.carpenter@linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240110072304.2226-1-mgyee9@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240110072304.2226-1-mgyee9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Greg, Dan,


On 1/9/24 23:23, Matthias Yee wrote:
> Adjusted whitespace to fix checkpatch warning Alignment Should Match
> Open Parenthesis.
> 
> Signed-off-by: Matthias Yee <mgyee9@gmail.com>
> ---
> Changes in v3
> -fixed line wrapping for commit message
> ---
>  drivers/staging/vt6655/card.c | 74 +++++++++++++++++------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> index 36183f2a64c1..688c870d89bc 100644
> --- a/drivers/staging/vt6655/card.c
> +++ b/drivers/staging/vt6655/card.c
> @@ -81,9 +81,9 @@ static void vt6655_mac_set_bb_type(void __iomem *iobase, u32 mask)
>   * Return Value: none
>   */
>  static void calculate_ofdmr_parameter(unsigned char rate,
> -				       u8 bb_type,
> -				       unsigned char *tx_rate,
> -				       unsigned char *rsv_time)
> +				      u8 bb_type,
> +				      unsigned char *tx_rate,
> +				      unsigned char *rsv_time)
>  {
>  	switch (rate) {
>  	case RATE_6M:

Is there any chance that checkpatch is wrong about this warning?

I much prefer the alignment as it was before this patch: following lines
are aligned with the first parameter after the '('.


-- 
#Randy

