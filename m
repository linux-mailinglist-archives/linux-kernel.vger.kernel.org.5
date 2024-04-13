Return-Path: <linux-kernel+bounces-143485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A01F8A3A01
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6061F218D2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52116F9DA;
	Sat, 13 Apr 2024 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRkoCYnM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5F9FBE8;
	Sat, 13 Apr 2024 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969879; cv=none; b=rZRZlWevszcJIct7TyEIemJod0N5aHQQqorh/I9GerMgdKlktDpwaBmfs6+vr2cTya+INtty1zZBg91oPepwSFGmX/Ynn5ABzeagO2TFTGdy5BiGQDZQrWdT+e0NgPYl7DDbWXhWy11ySsyfxPwu4cL1WVlSrJOrjgmelVax+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969879; c=relaxed/simple;
	bh=iKwV1siHHETSufd441N7QeNvqbceqVeJJKDGHwjTtjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqAdrkqVr0TpJwGFuWOw94soleAHqmXSl15HoeoeBuWSORAvMDD9NwxeYzKSzd1pnX9vEvPYmqxRwCRRoK3N0L51ds4aweD8XokHKfCkPcJ0svy9+/5vVofxFbNZdsSOOQMUAGwxPyE6UYbjv5t8zVLuGc0R3XDHaktDPLfBcyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRkoCYnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76322C113CC;
	Sat, 13 Apr 2024 00:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712969879;
	bh=iKwV1siHHETSufd441N7QeNvqbceqVeJJKDGHwjTtjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PRkoCYnMMwrYOVcgec4yvAzkvpd2yEzuCYLPPdtlhbsprxdZs1wkRgu1ytpuN9df7
	 hyoPmKJNaGrgx3ooEOh1eWrl9dkG3hIF0ljlbkreJKZ5jA7PmiKTtBSRvJmm8ZNvSG
	 y4yjd2MgP5ENJmf268Et1oXsKYvBTiGIQYSsw3QF2xtXC1vB5tdjCNP4QEPw1tva1w
	 yL6VypUIm6xKgh310WMxNHIIKCtAnxrSDeod/LQ4xpjAq9kkNqVezRTMedIR/ZklfO
	 V76AF6J0HhgyCA6HNUTVTrFXtwH45TBUx8+bYg+lJy3s23oD7dKLQBY+8A6CKWbqYx
	 VvhLWX9pi6efQ==
Message-ID: <b42edf62-b423-4293-a5dd-eafa9e405bf0@kernel.org>
Date: Sat, 13 Apr 2024 09:57:57 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Allow command duration limits detection
 for ACS-4 drives
To: Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240411201224.1311198-1-ipylypiv@google.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240411201224.1311198-1-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/24 05:12, Igor Pylypiv wrote:
> Even though the command duration limits (CDL) feature was first added
> in ACS-5 (major version 12), there are some ACS-4 (major version 11)
> drives that implement CDL as well.
> 
> IDENTIFY_DEVICE, SUPPORTED_CAPABILITIES, and CURRENT_SETTINGS log pages
> are mandatory in the ACS-4 standard so it should be safe to read these
> log pages on older drives implementing the ACS-4 standard.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

Looks good, but I think this needs:

Fixes: 62e4a60e0cdb ("scsi: ata: libata: Detect support for command duration
limits")
Cc: stable.vger.kernel.org

so that we have 6.6 LTS also getting this fix and accepting the same devices as
mainline. I will add that when applying.

> ---
>  drivers/ata/libata-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index be3412cdb22e..c449d60d9bb9 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2539,7 +2539,7 @@ static void ata_dev_config_cdl(struct ata_device *dev)
>  	bool cdl_enabled;
>  	u64 val;
>  
> -	if (ata_id_major_version(dev->id) < 12)
> +	if (ata_id_major_version(dev->id) < 11)
>  		goto not_supported;
>  
>  	if (!ata_log_supported(dev, ATA_LOG_IDENTIFY_DEVICE) ||

-- 
Damien Le Moal
Western Digital Research


