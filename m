Return-Path: <linux-kernel+bounces-90918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A48D8706C3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36461F2308C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A384CB36;
	Mon,  4 Mar 2024 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="UKp4OvJf"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC44C3D0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568977; cv=none; b=gbJxWe0dswwOHDhIS4LHhPRndfADNlYEDnDIbbJ4Vp8LT1Fuvr6tVlx4EAfwnJAFC7GVEArOeCYI1+mk9sLgo8ESWCpc3q0NrVEJOujQ6j2fhwEJpoIS8qvEp3cGU1UA+8ao9pHmxUZzegyG681eOis1hbUou/5/4my5fBDcO3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568977; c=relaxed/simple;
	bh=g0/AEZ+kj3ofFSyxuc6SkwhOHdxhpZlJ9InLYUqrsAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEh9ozRe0B+Cs3W3BVoqA6dUeZuEALEX4e++hYq8JFqnfIiKu/jv3zWT7I5BJ3fXdNn3gYy0WHA9REE+J/LSOPcIi6L7z68ZUrIZZaaLQjOzTsfZLK4pdsLfQhNF6QtkOfp0Np4FtWrSINGi6blqgfSy668zPg383ogvnfXUtqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=UKp4OvJf; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id h96pr5gR3uh6shAz2r64k7; Mon, 04 Mar 2024 16:16:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id hAz1ryBjyAolPhAz1rjXVp; Mon, 04 Mar 2024 16:16:07 +0000
X-Authority-Analysis: v=2.4 cv=XI02SxhE c=1 sm=1 tr=0 ts=65e5f3c7
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10 a=gAnH3GRIAAAA:8
 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=b3IyxZijl_8VvaR0It0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=oVHKYsEdi7-vN-J5QA_j:22 a=IawgGOuG5U0WyFbmm1f5:22
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xKSrONrt5I6Ut2/eB3mdoDjp4fdULvLP/a8V6qevuBc=; b=UKp4OvJfORU0mOpx3u0dgh+NW6
	mEEHmrDfVxWLHfmEwsxeBBhnX8VoBqVvbMNIcx7zPbErt4b+S5JL7GxU8Z3PMRylfCm9lcPukGL+l
	ZLfBCcd0BclMLx1LLi2mtOS32GW3pml5AijwrzWFQ05e8J+i1rvp66x237/D/G3VkDGRiF94YJ0bn
	K/SesWBbeIqkQog9Mg9maAIBllnorGaPEgOQDvIU4CKYrDsdwWuFVXeocdK59WPKqPYOjNSBr5XwG
	FDTHrlkGlRPcsV/RQy3G2kDXF0DTy313FLcVlIyYORm2hJ7BF/IeLAVHi+NaSVlEleSX30F48em10
	OCIKGS8A==;
Received: from [201.172.172.225] (port=49252 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rhAz0-003iEz-2L;
	Mon, 04 Mar 2024 10:16:06 -0600
Message-ID: <cb286926-3ebe-4ff3-926e-df9dfe215fda@embeddedor.com>
Date: Mon, 4 Mar 2024 10:16:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] spi: axi-spi-engine: use __counted_by() attribute
Content-Language: en-US
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
 <20240304-mainline-axi-spi-engine-small-cleanups-v2-2-5b14ed729a31@baylibre.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240304-mainline-axi-spi-engine-small-cleanups-v2-2-5b14ed729a31@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rhAz0-003iEz-2L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.172.225]:49252
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKiM+iQ/8OiSjyLjXfmz3re7Y111WLlKfe5Mi02zcvZi0LhIIS9DV/effPRBp8ApD9bXKJedufn3EwQqaiLFHytVIvW45xQJdebjKpOJoEjBetXw6K01
 BjV5wHYr7M0N1gAvoAm858dri/POiJ5VMB/AoOscSO6bP9Ok6CCo7nam/0BXpeP3QVIn4sOVAvW/NFN2ZX1uRdCH9Ajfx8zXJpus149BNA4XPKfqR3dx2v1e



On 04/03/24 10:04, David Lechner wrote:
> This adds the __counted_by() attribute to the flex array at the end of
> struct spi_engine_program in the AXI SPI Engine controller driver.
> 
> The assignment of the length field has to be reordered to be before
> the access to the flex array in order to avoid potential compiler
> warnings/errors due to adding the __counted_by() attribute.
> 
> Suggested-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
> v2 changes:
> * Reordered assignment of length field.
> ---
>   drivers/spi/spi-axi-spi-engine.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index d89f75170c9e..a8f626165f44 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -75,7 +75,7 @@
>   
>   struct spi_engine_program {
>   	unsigned int length;
> -	uint16_t instructions[];
> +	uint16_t instructions[] __counted_by(length);
>   };
>   
>   /**
> @@ -115,9 +115,10 @@ struct spi_engine {
>   static void spi_engine_program_add_cmd(struct spi_engine_program *p,
>   	bool dry, uint16_t cmd)
>   {
> -	if (!dry)
> -		p->instructions[p->length] = cmd;
>   	p->length++;
> +
> +	if (!dry)
> +		p->instructions[p->length - 1] = cmd;
>   }
>   
>   static unsigned int spi_engine_get_config(struct spi_device *spi)
> 

