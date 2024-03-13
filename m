Return-Path: <linux-kernel+bounces-101210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E1D87A406
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDC4282AD3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8DE1A708;
	Wed, 13 Mar 2024 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="qdLxfDOT"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C585199B0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317893; cv=none; b=Kuz1sxHeHV961o+Zv2jTWHcVQ8jBQzaKRAOXAJYjVR1GShwxhF8r81XsaFq6ixdnodth+MqVk3W6VNbTG0FDc9xJMKVLgIYH63AeH/ajp86GIRoA5cWJiaFTikHbw6dKpE6F0F+/biu1tEQZgjmmy869EjzfAbLn1VvAikRB/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317893; c=relaxed/simple;
	bh=eMQlvTb4wLG9OvlhD/JOFhGA2GaNKGff8WlL0I+tz/Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ewjgXQJ6XwwjNK+Lm8ZZ4pr1tDx+AIqQ9lbTFySTv5CuOF1TsvvpumVdV/vg3cOao/NTLOzgG09DwHcxV04WQzIClb8+0W7bLBY5OIp9oJnoNRyTUD+bsCrEFtItLPCzorvqHD0e2bezM8wUzeivl2TbawWu7MRIQgNi9u5eia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=qdLxfDOT; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3nqnd/maiTSnv6Ai2MihMDQqeX4giogW9roRuAfqM8Q=;
  b=qdLxfDOTl8GPVsL7Rg/druvRFHLTznKOqErqxiMR1+j2+8mcueqWBnAB
   yJaAJJJY+//8MUWyqkeH02on9cUo6HgyPr/8VQxt3ExvyPBjj6sxpoJ9C
   ah/oFmRQMElb4QInjIZG+MoeszxMSrwZa0jJ0rI/ZZw/wrhpRwHSTXIO7
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,119,1708383600"; 
   d="scan'208";a="156385381"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 09:18:07 +0100
Date: Wed, 13 Mar 2024 09:18:08 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com, 
    gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
    linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v4] staging: rtl8712: rename tmpVal to pct_val
In-Reply-To: <ZfFfW/Flrlzb0+UI@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Message-ID: <2c63a094-6966-7679-2b23-58c057b451d8@inria.fr>
References: <ZfFfW/Flrlzb0+UI@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 13 Mar 2024, Ayush Tiwari wrote:

> Rename local variable tmpVal to pct_val in function process_link_qual
> to give intuitive meaning to variable and match the common kernel
> coding style.

I don't think that the patch with the name avg_val was accepted, so this
patch has to replace tmpVal by pct_val, as you say in the subject line.

Also, the comment says:

/* <1> Showed on UI for user, in percentage. */

I still have the impression that the value calculated here is an average.
Total num is just incremented:

if (sqd->total_num++ >= PHY_LINKQUALITY_SLID_WIN_MAX)

while total_val is updated with a new value.

julia


>
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
> Changes in v3: changed variable name avg_val to pct_val
> Changes in v3: changed variable name tmpVal to avg_val
> Changes in v2: added a period in message
>
>  drivers/staging/rtl8712/rtl8712_recv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
> index 1fabc5137a4c..0b13d0a04304 100644
> --- a/drivers/staging/rtl8712/rtl8712_recv.c
> +++ b/drivers/staging/rtl8712/rtl8712_recv.c
> @@ -861,7 +861,7 @@ static void query_rx_phy_status(struct _adapter *padapter,
>  static void process_link_qual(struct _adapter *padapter,
>  			      union recv_frame *prframe)
>  {
> -	u32	last_evm = 0, avg_val;
> +	u32	last_evm = 0, pct_val;
>  	struct rx_pkt_attrib *pattrib;
>  	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
>
> @@ -883,8 +883,8 @@ static void process_link_qual(struct _adapter *padapter,
>  			sqd->index = 0;
>
>  		/* <1> Showed on UI for user, in percentage. */
> -		avg_val = sqd->total_val / sqd->total_num;
> -		padapter->recvpriv.signal = (u8)avg_val;
> +		pct_val = sqd->total_val / sqd->total_num;
> +		padapter->recvpriv.signal = (u8)pct_val;
>  	}
>  }
>
> --
> 2.40.1
>
>
>

