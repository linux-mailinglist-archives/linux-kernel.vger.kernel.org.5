Return-Path: <linux-kernel+bounces-7747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C821E81AC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84550283820
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E74F3C02;
	Thu, 21 Dec 2023 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7iUM7jT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF63184C;
	Thu, 21 Dec 2023 02:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c39ef63d9so3213145e9.3;
        Wed, 20 Dec 2023 18:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703125083; x=1703729883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KepcuEsz7y7X78GKxHSSB7fpm+ci/PvvheM0C8NHiQw=;
        b=Y7iUM7jTZxT9TqQFvfiMsyVYAUtxoXw4XTa8r2G2MVFCXH2gZ9mT3rFvoaPaDnz6aX
         MGjeT2fVxsKXU9DZYxm3RD/MN5IdDwnaPqq/3hOoRHYJhNgSfqptwqKh7zFYbmunfhRK
         ns1JKAykHvS/WkTeNmDjPp4iOQ4OPQ3buTcO8kUpY02uYjKwUQVC+4dCbtcvfjAH5zpl
         dVl62A+vtzlhEXpcwE77nEv/FNbZdDqcn1EVwtmP9XBOe+tvEInbQidE5Sq6hg4unDbm
         Q7dbCpSW8QqkheXmj7d7yAy/12Vbnw3EAUn56iHUBM45cWyn/4F+E94FVJNo41lZYDMY
         lIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703125083; x=1703729883;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KepcuEsz7y7X78GKxHSSB7fpm+ci/PvvheM0C8NHiQw=;
        b=wIDosFsLlrG6R1NdW8VBbkjsPvne6PLiFn8XHco0a1adXLZ/utagxs+cVNvEk0GDcV
         mpiP7Q3ghn4KhvWqaWuueq2Yxufn9C3lKwJlGl+9NBdxKujN+UYK19VzsGefH51PLaZ0
         SvxhgamymBQshXtySRxLi/jDPR4JHQa42+JJY8uLMcgioWFFQJ3HvcfUaCNHftdil1IF
         B8+4dB6897xJYGFDgxqj4ckkOVVb8651rxVLIV2fN0jIIbAQzNnJRAQx5lcYI2JA7MnU
         DqyEGIHKNC2pLeSNrs9v/ZZSYb/DQVFQT65OzwLFUrEkueiYO/xeVzp56CFmB8fYUPvZ
         HQYQ==
X-Gm-Message-State: AOJu0YygFPFLAe/h81tPmNxf9vdXTAUtWcrRrtPsIWyeNzDZMIVVqmVH
	6ixQnY5+0aT78/Or7eADA3o=
X-Google-Smtp-Source: AGHT+IFPJCKBCnMsv5PlF48qQH9bVjG1uiHVkKiu0dqFfd0UrYbmA2orJF5s6NBOtOuz63FpDYpavA==
X-Received: by 2002:a05:600c:c18:b0:40c:348a:1f8 with SMTP id fm24-20020a05600c0c1800b0040c348a01f8mr277051wmb.17.1703125083085;
        Wed, 20 Dec 2023 18:18:03 -0800 (PST)
Received: from Ansuel-xps. (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b003feae747ff2sm9312050wmq.35.2023.12.20.18.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 18:18:02 -0800 (PST)
Message-ID: <6583a05a.050a0220.bc5e1.2e6d@mx.google.com>
X-Google-Original-Message-ID: <ZYOgWCEl52hX-Zox@Ansuel-xps.>
Date: Thu, 21 Dec 2023 03:18:00 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Networking <netdev@vger.kernel.org>,
	Mathis Marion <mathis.marion@silabs.com>,
	Robert Marko <robimarko@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the net-next tree
References: <20231221130946.7ed9a805@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221130946.7ed9a805@canb.auug.org.au>

On Thu, Dec 21, 2023 at 01:09:46PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the net-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/net/phy/aquantia/aquantia_firmware.c: In function 'aqr_fw_load_memory':
> drivers/net/phy/aquantia/aquantia_firmware.c:135:23: error: implicit declaration of function 'crc_ccitt_false'; did you mean 'crc_ccitt_byte'? [-Werror=implicit-function-declaration]
>   135 |                 crc = crc_ccitt_false(crc, crc_data, sizeof(crc_data));
>       |                       ^~~~~~~~~~~~~~~
>       |                       crc_ccitt_byte
> 
> Caused by commit
> 
>   e93984ebc1c8 ("net: phy: aquantia: add firmware load support")
> 
> interacting with commit
> 
>   56ded2dd1a43 ("lib: crc_ccitt_false() is identical to crc_itu_t()")
> 
> from the mm tree.
> 
> I have applied the following merge fix patch:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 21 Dec 2023 12:49:11 +1100
> Subject: [PATCH] fix up for "net: phy: aquantia: add firmware load support"
> 
> interacting with commit
> 
>   56ded2dd1a43 ("lib: crc_ccitt_false() is identical to crc_itu_t()")
> 
> from the mm tree.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks can confirm the conversion is correct.

> ---
>  drivers/net/phy/aquantia/Kconfig             | 2 +-
>  drivers/net/phy/aquantia/aquantia_firmware.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/aquantia/Kconfig b/drivers/net/phy/aquantia/Kconfig
> index a35de4b9b554..1a65678583cf 100644
> --- a/drivers/net/phy/aquantia/Kconfig
> +++ b/drivers/net/phy/aquantia/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config AQUANTIA_PHY
>  	tristate "Aquantia PHYs"
> -	select CRC_CCITT
> +	select CRC_ITU_T
>  	help
>  	  Currently supports the Aquantia AQ1202, AQ2104, AQR105, AQR405
> diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
> index ff34d00d5a0e..0c9640ef153b 100644
> --- a/drivers/net/phy/aquantia/aquantia_firmware.c
> +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
> @@ -3,7 +3,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/of.h>
>  #include <linux/firmware.h>
> -#include <linux/crc-ccitt.h>
> +#include <linux/crc-itu-t.h>
>  #include <linux/nvmem-consumer.h>
>  
>  #include <asm/unaligned.h>
> @@ -132,7 +132,7 @@ static int aqr_fw_load_memory(struct phy_device *phydev, u32 addr,
>  		crc_data[3] = word;
>  
>  		/* ...calculate CRC as we load data... */
> -		crc = crc_ccitt_false(crc, crc_data, sizeof(crc_data));
> +		crc = crc_itu_t(crc, crc_data, sizeof(crc_data));
>  	}
>  	/* ...gets CRC from MAILBOX after we have loaded the entire section... */
>  	up_crc = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE2);
> @@ -164,7 +164,7 @@ static int aqr_fw_boot(struct phy_device *phydev, const u8 *data, size_t size,
>  		phydev_err(phydev, "bad firmware CRC in firmware\n");
>  		return ret;
>  	}
> -	calculated_crc = crc_ccitt_false(0, data, size - sizeof(u16));
> +	calculated_crc = crc_itu_t(0, data, size - sizeof(u16));
>  	if (read_crc != calculated_crc) {
>  		phydev_err(phydev, "bad firmware CRC: file 0x%04x calculated 0x%04x\n",
>  			   read_crc, calculated_crc);
> -- 
> 2.43.0
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
	Ansuel

