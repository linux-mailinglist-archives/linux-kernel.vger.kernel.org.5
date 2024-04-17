Return-Path: <linux-kernel+bounces-148861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA648A8838
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE30B2816A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135831482E3;
	Wed, 17 Apr 2024 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="cKT4+UCt"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F79B13C668;
	Wed, 17 Apr 2024 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369338; cv=none; b=CsDfqB2DZURXIOCyqdWmk3E75ge+y4S3C6z1rRF2B1lvyJi96P4gltwYz8jXE90HyIH+UOtn+puyvIFQvgL74LSjVWkdnDrFTrtk8JXbrhXUxMH9f1maYCDT7RCIhDZa52k7tI/r0cdLE21dIXMfbs7g0gSG2zusDtB58vfmYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369338; c=relaxed/simple;
	bh=4OPp/HvKGr0IAlp73XYr1aBNWLKAgCI6r/zvAt0TjZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BACU1wttDR+8MYodbAr8SxbE8pzmDdiVXgnlHg+fay1Z8yd1kpBCl10dbOrBdlbuyL/+PCH0z1WiJvDx5Uk9dEXk1Zst8tIxIc4uHwfgGGqNi+/2OzbbvPf/4dqGJ1712vB5ywepaohnDde89zKaXoy0d9Camvuz+JWFF3Inxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=cKT4+UCt; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de45f24.dip0.t-ipconnect.de [93.228.95.36])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 706332FC0071;
	Wed, 17 Apr 2024 17:55:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1713369332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCL3zkxnd3wyi+giBnUtur7ZZh2+WR2bbaZ8Kg5zg9M=;
	b=cKT4+UCtntW7Qy6XOfDrqZ6/w2+8c0Hx9eCAhxZeKlsa+77oSHsMZzaG7g1+OlIKjlqujD
	Pw1ceCgBOb+F+9wic6XjTTSNxPBkLCTAlkklYT9eZnqsun8NiW99J/hwdnVmrQZ8fa64ij
	jCAhgwv3EUSm9gQAq+k124hcoACIiFI=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <d5d5e679-8456-4f78-9569-ffb7f7240373@tuxedocomputers.com>
Date: Wed, 17 Apr 2024 17:55:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: resource: Do IRQ override on TongFang GXxHRXx and
 GMxHGxx
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Christoffer Sandberg <cs@tuxedo.de>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240417103509.28657-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20240417103509.28657-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry noticed and issue with this, please don't apply, I will send a v2.

Am 17.04.24 um 12:35 schrieb Werner Sembach:
> From: Christoffer Sandberg <cs@tuxedo.de>
>
> Listed devices needs the override for keyboard to work.
>
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org
> ---
>   drivers/acpi/resource.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 59423fe9d0f29..deeb4e182687a 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -558,6 +558,18 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
>   			DMI_MATCH(DMI_BOARD_NAME, "GM6XGxX"),
>   		},
>   	},
> +	{
> +		.ident = "TongFang GXxHRXx/TUXEDO InfinityBook Pro Gen9 AMD",
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_SKU, "GXxHRXx"),
> +		},
> +	},
> +	{
> +		.ident = "TongFang GMxHGxx/TUXEDO Stellaris Slim Gen1 AMD",
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_SKU, "GMxHGxx"),
> +		},
> +	},
>   	{
>   		/* MAINGEAR Vector Pro 2 15 */
>   		.matches = {

