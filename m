Return-Path: <linux-kernel+bounces-132248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB4C899201
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA846B21CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18AC13C3EF;
	Thu,  4 Apr 2024 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icZ+frA7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67F13C3F3;
	Thu,  4 Apr 2024 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272592; cv=none; b=q8bbqgab9i4udO0iQ2iz5tpwiy/8Ub9goUlzd55C3uMsW1U5m/7LdxjSWjQlVG6LPBtl9/rr0dEP3KiphDMVrmZjrwXX5Ms7/nSaCKggeEP0i/QqFtNLXlCSQnLWxK/3QR5Sj2fjFEoKKvv7PFqJ52t5HBvwBI8z/4MMar3wfiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272592; c=relaxed/simple;
	bh=My9slTT18ilx6RQO42SNpzMkTyyYUfq2y4VVJ6/8W/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aevwgQHMhraid11RPJzOdFYPOXQFxcKCr2C8JjrFdc9jGXWOx0Mq0bgkb3GnMfJD91lreGz5DKeKYAarSdxssKd/qhfu99ilgfhGYnWumhUSx9JpzRfIrByi/pIrUz3es0LAyXPRQ76P0tolSAFIahkgL2zGPtOf9eD16wuar1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icZ+frA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D78C43330;
	Thu,  4 Apr 2024 23:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712272591;
	bh=My9slTT18ilx6RQO42SNpzMkTyyYUfq2y4VVJ6/8W/I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=icZ+frA7SkGhEBuav5xNSoPl6hvTu5MEOBxAkSOMdTre/9Of/eOpraYv566+8aKLN
	 y8PkpuTwQ9gC9ulROThnsEtBi8PTrbydqdyoIn6QDSEkeVsS35peu4rV8owWsM+H1U
	 FV7toEQBoxcDESFZzCjPPxjI/TPZbZCkYQovyiJDv4vS3fApTX1U1YqqxfsRMuiovM
	 cjaqd8MnTsgZeviNX/+uRveduoMt5CKZw76byeZHVph2lDiK/aSu4bpw0tmKJxO+/2
	 xQsIX2+nJQGBSH6L21acLjAaRy8Rdck2t4UR6CcZ++1h4OwrDaAfejSkzWg8WGNCdS
	 MYU/qXDFNWIDw==
Message-ID: <8e37f392-1ddd-4c8e-87df-acb3bb5bdf0b@kernel.org>
Date: Fri, 5 Apr 2024 08:16:29 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ata: libata: Move inclusion to where it belongs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
References: <20240404192111.3580578-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240404192111.3580578-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/24 04:21, Andy Shevchenko wrote:
> Replace rather heavy acpi.h inclusion by a simple forward declaration
> in the public header. Update the local one to include acpi.h as some
> of the code requires it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/ata/libata.h   | 3 +++
>  include/linux/libata.h | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 5c685bb1939e..29e9387eb249 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -90,6 +90,9 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>  #define to_ata_port(d) container_of(d, struct ata_port, tdev)
>  
>  /* libata-acpi.c */
> +
> +#include <linux/acpi.h>

I am really not a big fan of including files in the middle of a header file.

> +
>  #ifdef CONFIG_ATA_ACPI
>  extern unsigned int ata_acpi_gtf_filter;
>  extern void ata_acpi_dissociate(struct ata_host *host);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 66937b787cca..68b969de410f 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -19,7 +19,6 @@
>  #include <linux/ata.h>
>  #include <linux/workqueue.h>
>  #include <scsi/scsi_host.h>
> -#include <linux/acpi.h>

Why not:

#ifdef CONFIG_ATA_ACPI
#include <linux/acpi.h>
#endif

Which avoids the union forward declaration below.

>  #include <linux/cdrom.h>
>  #include <linux/sched.h>
>  #include <linux/async.h>
> @@ -660,6 +659,10 @@ struct ata_cpr_log {
>  	struct ata_cpr		cpr[] __counted_by(nr_cpr);
>  };
>  
> +#ifdef CONFIG_ATA_ACPI
> +union acpi_object;
> +#endif
> +
>  struct ata_device {
>  	struct ata_link		*link;
>  	unsigned int		devno;		/* 0 or 1 */

-- 
Damien Le Moal
Western Digital Research


