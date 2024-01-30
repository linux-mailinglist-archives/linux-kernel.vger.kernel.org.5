Return-Path: <linux-kernel+bounces-44594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7534D8424BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BFE1F2540A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57AC67E8D;
	Tue, 30 Jan 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL6krSr2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621967A19;
	Tue, 30 Jan 2024 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706617422; cv=none; b=IDKdoEIq6xcQh8gwbsAmZlosg9AvSYBz1r9tJiRFimOj6xChxgtbYIeMTWkqD1uGPTDQdBiFr1uHx6dEq+xIf11DkZgqj4qAMa+B4t2hxzl2Uc8Rq2a6z/pYPoTTA96OhbNOmd63mLmZBu5Vuh6d0Z5i6kh0xTU7tB/nUhlhOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706617422; c=relaxed/simple;
	bh=+CG0gHXhGQd6gIXHHpPcppBsL3Jvua/zJuWx/hwao1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZrbKdqIe9RClyXk/sGvaeWaX//VrorGkUAlOoEHYT/c6yDXlcReHjcNEZJg4GPcnveHeW5wAQXCrxjwXTJqCp9dEDcWRiOeXks78SNN/b/Ew3YpBlCHxcQIymum8yQCJ2pjBbTDoaYGU9witphoo9d9d1f/cKcfkxEtbVvt3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KL6krSr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B7CC433F1;
	Tue, 30 Jan 2024 12:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706617421;
	bh=+CG0gHXhGQd6gIXHHpPcppBsL3Jvua/zJuWx/hwao1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KL6krSr2qYbE1Z3p0Hkxqg9LWKs150EKM+ipc/LQMVq8al/hPeFusrDD1WOnmw5Pq
	 qg6U85Tr9VZptmGWoxEEOvwS9SRGsgtGtcNYtot1iOQkGHQ0YbqqnK6fRAmtbHD76J
	 GevLqORAKe3EuM09tYjKTQueONXZ7VmRBqZYID9DJTr2jrEc2u8zUVDIvpmhBDKY7N
	 sCp6T1kdeyizyGbEnNZ8WoI0eWGJnUpFv3ar+tPxr+70op6CFG36ZnR3U3OF9QVsDI
	 NgMPNS00yvg3M6BIRz9alT2ig9PHiEGDN7jNvjFdZjjtcdQAoDm0yCpbJz9Gdda6pA
	 MRBUvW7Vw6FUA==
Date: Tue, 30 Jan 2024 13:23:35 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Joerg Roedel <jroedel@suse.de>,
	Szuying Chen <chensiying21@gmail.com>, Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw
Subject: Re: [PATCH] ahci: Extend ASM1061 43-bit DMA address quirk to other
 ASM106x parts
Message-ID: <ZbjqR0+jbdfu4neM@x1-carbon>
References: <ZbjgTmR5FbAnb-Ua@wantstofly.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbjgTmR5FbAnb-Ua@wantstofly.org>

On Tue, Jan 30, 2024 at 01:41:02PM +0200, Lennert Buytenhek wrote:
> ASMedia have confirmed that all ASM106x parts currently listed in
> ahci_pci_tbl[] suffer from the 43-bit DMA address limitation that we ran
> into on the ASM1061, and therefore, we need to apply the quirk added by
> commit 20730e9b2778 to the other supported ASM106x parts as well.

Lennert, thanks a lot for sending this follow up patch.

However, checkpatch.pl complains:

ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 20730e9b2778 ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers")'
#44: 
commit 20730e9b2778 to the other supported ASM106x parts as well.

Perhaps send a v2 with this fixed,
and Cc: stable like Damien requested.


Kind regards,
Niklas

> 
> Signed-off-by: Lennert Buytenhek <kernel@wantstofly.org>
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
> -- 
> 2.43.0

