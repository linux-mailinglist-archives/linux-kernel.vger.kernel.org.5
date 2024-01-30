Return-Path: <linux-kernel+bounces-44548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2160D842411
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506011C260A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843CF6D1AA;
	Tue, 30 Jan 2024 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TItBj1oS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70AC67A08;
	Tue, 30 Jan 2024 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615186; cv=none; b=dCNODLbrY/8b6QnzVYqT70qfgInP7jQsv/dMf9jAsIQNCWdzEpYa4Cm02PNtdxzvx+8mNFRRWgq2jjpcMvwwWGKDJBl0P/PPAJt6/LbS7hCKHfpXqTlRt5/jhZeoYJetuCf2jNi16PKOBYp4v+f1WQLlTy7YCOQ+PlPmA6zOX8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615186; c=relaxed/simple;
	bh=u0N1Oqasacq+jphPnRwL/qJa4P0GjI/1+DWbV2nwIbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THzRfUPjgiX5WxGBVMp1DXwb4mxhCS9CrjorbHu//rbjiuEmJUpANh5cIGDO7uYY5o6tWrK0K+qokc6UME/WRnobTCjHMzHvDK5H9P9Ajpvs6+YySN6/W7K67jRhqWHx9hwVM4bmMQ/Trr7v3PXJk2L+O+wwzMdEf0s39QNJmz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TItBj1oS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FDDC433C7;
	Tue, 30 Jan 2024 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706615186;
	bh=u0N1Oqasacq+jphPnRwL/qJa4P0GjI/1+DWbV2nwIbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TItBj1oSH2wtToFBbH8wXWUI8duuwtA/UHwkzhkw3S9TWK3khJ/eEeXNLjSW3GWID
	 YsmCBuyYaLg8OSDfTyXXuv0/spGrRyMDd0SUhADzj8BwQQfcSXn7AN1BykVsYhqpsw
	 ULW2UuBTlRP6uUaezhPkv4cpAA0fGNmUhc3PW+hRCOAmV+qhFQCHRrQBqYNH5BQBFp
	 90NRtfegDy65aOBotOzCCwVM4hwwbW1u6AUfGaFrrQpUPxstH8FEd6FpfhDPxXqaFA
	 MseWmUXWEpdnJ6l3bz+7k1RNhaTFBdYQ/GL95PqpXvG6tVP/82vllMxBGt+SVOiqWz
	 wytVcEz9M+/xg==
Message-ID: <6ab581f1-385c-49af-bff3-aacd1cdbe1d8@kernel.org>
Date: Tue, 30 Jan 2024 20:46:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: Extend ASM1061 43-bit DMA address quirk to other
 ASM106x parts
Content-Language: en-US
To: Lennert Buytenhek <kernel@wantstofly.org>,
 Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 John Garry <john.g.garry@oracle.com>, Joerg Roedel <jroedel@suse.de>,
 Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
 Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
References: <ZbjgTmR5FbAnb-Ua@wantstofly.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZbjgTmR5FbAnb-Ua@wantstofly.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/24 20:41, Lennert Buytenhek wrote:
> ASMedia have confirmed that all ASM106x parts currently listed in
> ahci_pci_tbl[] suffer from the 43-bit DMA address limitation that we ran
> into on the ASM1061, and therefore, we need to apply the quirk added by
> commit 20730e9b2778 to the other supported ASM106x parts as well.
> 
> Signed-off-by: Lennert Buytenhek <kernel@wantstofly.org>

I think this needs a cc: stable tag.

> ---
>  drivers/ata/ahci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index d2460fa985b7..da2e74fce2d9 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -606,13 +606,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(PROMISE, 0x3781), board_ahci },   /* FastTrak TX8660 ahci-mode */
>  
>  	/* ASMedia */
> -	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
> -	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci_43bit_dma },	/* ASM1060 */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci_43bit_dma },	/* ASM1060 */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci_43bit_dma },	/* ASM1061 */
>  	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci_43bit_dma },	/* ASM1061/1062 */
> -	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
> -	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */
> -	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci },   /* ASM1062+JMB575 */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci_43bit_dma },	/* ASM1061R */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci_43bit_dma },	/* ASM1062R */
> +	{ PCI_VDEVICE(ASMEDIA, 0x0624), board_ahci_43bit_dma },	/* ASM1062+JMB575 */
>  	{ PCI_VDEVICE(ASMEDIA, 0x1062), board_ahci },	/* ASM1062A */
>  	{ PCI_VDEVICE(ASMEDIA, 0x1064), board_ahci },	/* ASM1064 */
>  	{ PCI_VDEVICE(ASMEDIA, 0x1164), board_ahci },   /* ASM1164 */

-- 
Damien Le Moal
Western Digital Research


