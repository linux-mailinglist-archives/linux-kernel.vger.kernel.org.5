Return-Path: <linux-kernel+bounces-101192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C683C87A3D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D371F219DA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C24B199BA;
	Wed, 13 Mar 2024 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="Kti74zaF"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CE918EAD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316772; cv=none; b=BLiyH1A3dqTw+Pm/cNuu2D37vXfGHxFU4OCJhBc80q0IQIgAbWhFJVT+gVxUDeqJSpXqo+w+7ZjPRaZQf/afjCwOToTbnQVacnrZyUTT6jqPUK9P5z/NY1U80BX3W6MxPlkq4LlkxMvYljVblIuBaobtLaV/j+eTicnzWphFXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316772; c=relaxed/simple;
	bh=hQEFFLASJjOZkkMxEKIkn+Va/M9TvybsORx6+IhIc5c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hc32DOH/5fgb5/o/gWk4C/6LJbIRUP7rMIbY/qcZDfSzPA9b/Cs9SqyS1mFEXgjBES1UDHyRNj7AOGZplSHlChcINWlXKmF2b2ZcLml2me1k9GK6wIlA/Z0Z0PBMMTLVfDMHxJS7j+7Uhl3KyPeUO8USoOD6rz25OOk79gdU8yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=Kti74zaF; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XTQeG6oRObynHtTDWJgQxpuKfTUZftd6Lrh/feEPNyM=;
  b=Kti74zaFrW6tiKNNsL9RvUTMQP9gRjt8zY/viYKeW6T+Rk4u7ztuwZa1
   CQWvDSDsYvC7e5KlrKPml37Gxu43r3FXqeMcN6IskfN8xdJY69gUght0T
   bJY6Q54qdRMuu4y1grwwMFe86X7B4AELjL3+v1S8TSxCLIPNKCb3sl3f+
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,119,1708383600"; 
   d="scan'208";a="82013424"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 08:59:27 +0100
Date: Wed, 13 Mar 2024 08:59:26 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com, 
    gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
    linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v3] staging: rtl8712: rename tmpVal to avg_val
In-Reply-To: <ZfFSDoNPjQypC829@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Message-ID: <4cd4d855-b8e6-7664-a6fa-3b7e3cd4d11@inria.fr>
References: <ZfFSDoNPjQypC829@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 13 Mar 2024, Ayush Tiwari wrote:

> Rename local variable tmpVal to avg_val in function process_link_qual
> to give intuitive meaning to variable and match the common kernel
> coding style.
>
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
>
> Changes in v3: changed variable name tmpVal to avg_val
> Changes in v2: added a period in message

This information should be below the ---.  Then it will be removed when
the patch is applied.  This information is only meaningful to the mailing
list.  The git history won't contain the previous versions, so the change
comments won't be meaningful.

julia

> ---
>  drivers/staging/rtl8712/rtl8712_recv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
> index a3c4713c59b3..1fabc5137a4c 100644
> --- a/drivers/staging/rtl8712/rtl8712_recv.c
> +++ b/drivers/staging/rtl8712/rtl8712_recv.c
> @@ -861,7 +861,7 @@ static void query_rx_phy_status(struct _adapter *padapter,
>  static void process_link_qual(struct _adapter *padapter,
>  			      union recv_frame *prframe)
>  {
> -	u32	last_evm = 0, tmpVal;
> +	u32	last_evm = 0, avg_val;
>  	struct rx_pkt_attrib *pattrib;
>  	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
>
> @@ -883,8 +883,8 @@ static void process_link_qual(struct _adapter *padapter,
>  			sqd->index = 0;
>
>  		/* <1> Showed on UI for user, in percentage. */
> -		tmpVal = sqd->total_val / sqd->total_num;
> -		padapter->recvpriv.signal = (u8)tmpVal;
> +		avg_val = sqd->total_val / sqd->total_num;
> +		padapter->recvpriv.signal = (u8)avg_val;
>  	}
>  }
>
> --
> 2.40.1
>
>
>

