Return-Path: <linux-kernel+bounces-109421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE68818E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADEA1F22077
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB0385941;
	Wed, 20 Mar 2024 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="kukgWbT+"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E869EDB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968713; cv=none; b=kJkanMviy882z+a5lfwHLfgk1U2iaZ9TMM67o8LTP3ze9voY4ClQMyr4wk4NKCrqt22yvxO0SLmaX2YTm0kyxCDNfVOCQaTDdIDFaV/Cz2/8Zvnk0na8+O3HxMW36a2wZwlc18QPGww0t606OIN/u9gYjKtMqjUpSSdGY9OmjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968713; c=relaxed/simple;
	bh=Wyhez9FL5Ho+UmwZKIK3g6PGWtYemMdQMXRG7Iosh+s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z03b5NWhQEbsgI2IoYGIeYoI+B/dhe3ixLiRy4D9sfU9BQhzF8zWA28zYj3CEW+Z7MpUnhKMrU6UwQooTaBvQRyyLtNEzPO9DV7/jahRGIGD4VyeiBPTNWTbBiBzO4F5uObrFgWu5CoAP7XGwGJe2GrSgR0Y0JyLAxW3TBBGfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=kukgWbT+; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DaEIabmCpPYeVfCnqcTR0G+EdrgHTPTuHfPVasDyRdg=;
  b=kukgWbT+xGfq5/9uvX9N7ywdGDBTrWS+9Sf1iK73Xupv/1agITqwFMfd
   6SxNUjC/9fCGjB+giKjfnqI5wuWvmBC9Pi6ZHXt50NZekstUyr6ifNu5S
   zgSLlzbQozMYFA4ocBzOD85Yk+8sT48SRaqbS2Wcj1yQLNfWNWuXIfvzT
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,141,1708383600"; 
   d="scan'208";a="82705121"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 22:05:04 +0100
Date: Wed, 20 Mar 2024 22:05:03 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Ayush Tiwari <ayushtiw0110@gmail.com>
cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com, 
    gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
    linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8712: Change type and name of local
 variable
In-Reply-To: <Zfs+GKmt9hDZdWt/@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Message-ID: <alpine.DEB.2.22.394.2403202203470.3361@hadrien>
References: <Zfs+GKmt9hDZdWt/@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 21 Mar 2024, Ayush Tiwari wrote:

> Change data type of local variable blnPending from u8 to bool and
> renamed it to len_padding since it only assumes 0 or 1 values and
> seems to add a padding based on wr_sz. This change also address the
> checkpatch warning "Avoid Camelcase".
>
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
> Changes in v2: Changed values of blnPending from 0/1 to false/true
> and renamed blnPending to len_padding

I don't think "len" is a good choice.  That suggests length, which would
be an integer.  I suspect that bln is an abbreviation of boolean, and the
while thing should go.  But when you remove that, you get pending, not
padding.

julia

>
>  drivers/staging/rtl8712/rtl8712_cmd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
> index bb7db96ed821..f499bbbf5bf5 100644
> --- a/drivers/staging/rtl8712/rtl8712_cmd.c
> +++ b/drivers/staging/rtl8712/rtl8712_cmd.c
> @@ -284,7 +284,7 @@ int r8712_cmd_thread(void *context)
>  		pcmd = cmd_hdl_filter(padapter, pcmd);
>  		if (pcmd) { /* if pcmd != NULL, cmd will be handled by f/w */
>  			struct dvobj_priv *pdvobj = &padapter->dvobjpriv;
> -			u8 blnPending = 0;
> +			bool len_padding = false;
>  			u16 cmdcode = pcmd->cmdcode;
>
>  			pcmdpriv->cmd_issued_cnt++;
> @@ -294,12 +294,12 @@ int r8712_cmd_thread(void *context)
>  						     0x0000ffff);
>  			if (pdvobj->ishighspeed) {
>  				if ((wr_sz % 512) == 0)
> -					blnPending = 1;
> +					len_padding = true;
>  			} else {
>  				if ((wr_sz % 64) == 0)
> -					blnPending = 1;
> +					len_padding = true;
>  			}
> -			if (blnPending) { /* 32 bytes for TX Desc - 8 offset */
> +			if (len_padding) { /* 32 bytes for TX Desc - 8 offset */
>  				pdesc->txdw0 |= cpu_to_le32(((TXDESC_SIZE +
>  						OFFSET_SZ + 8) << OFFSET_SHT) &
>  						0x00ff0000);
> @@ -318,7 +318,7 @@ int r8712_cmd_thread(void *context)
>  					       (pcmdpriv->cmd_seq << 24));
>  			pcmdbuf += 2; /* 8 bytes alignment */
>  			memcpy((u8 *)pcmdbuf, pcmd->parmbuf, pcmd->cmdsz);
> -			if (blnPending)
> +			if (len_padding)
>  				wr_sz += 8;   /* Append 8 bytes */
>  			r8712_write_mem(padapter, RTL8712_DMA_H2CCMD, wr_sz,
>  					(u8 *)pdesc);
> --
> 2.40.1
>
>
>

