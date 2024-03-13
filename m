Return-Path: <linux-kernel+bounces-101141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A9A87A302
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728CD1F2239F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1573E15AF9;
	Wed, 13 Mar 2024 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="oJ/5/+3A"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB514A93
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710312215; cv=none; b=ELZISkrSOHHH4VdNK0IP3sRHKfLBpfth58h7RkSnP0b9JVazt0JKBWPPjpVCdjmMSIAHCNp5uxxqOYKgGaD5yJM9NNcylq+avSYFaUFGop/MdXlSLw7CD715rw5AS/kscao/KQmP+3GLCk4siwjsy7B591U7gnhXS9+3haKTllc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710312215; c=relaxed/simple;
	bh=G9fU0sfQ+BUgFXDIEZhacWzKK0pVZkFYf2cAEq0MyZ0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EeGscqN2hnf75WmdwnS0jlF1qcp7dn+7pwEMUmRzb0gK+cRt8b9DQrSE89nL875XQamcoPOrSrg+hEZsmxiUbdb8VkdInuWGvovWzB+JjFPT3Nu2cXfcV6XFUT2Vsmi8kNaaqyINUynpwAchIwG/4hBAg/x3d7kIUrJYqCXxsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=oJ/5/+3A; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=o1iHmk4rKSpVyuwNMvqDmU6e1lRNlltfHxYanYPd4Ys=;
  b=oJ/5/+3ALIuWVRISi4JRRPv+86kP96Qv8NJgCTa1Yo0sVTDlbZdManZT
   ePruJKh4oYF2m2nm19it88PjbHlXfuEcqJm4HLle8QbB5HIPTaisypxO/
   Vff71UXW8zkS48luCXc4eNlaQQHT6Pg/RdOr7WPBnfdFLvruX0Lnz0loG
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,119,1708383600"; 
   d="scan'208";a="82007463"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 07:43:22 +0100
Date: Wed, 13 Mar 2024 07:43:22 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Ayush Tiwari <ayushtiw0110@gmail.com>
cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com, 
    gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
    linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8712: rename tempVal to temp_val
In-Reply-To: <ZfFJoZWURDM+Uin4@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Message-ID: <alpine.DEB.2.22.394.2403130740450.3473@hadrien>
References: <ZfFJoZWURDM+Uin4@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 13 Mar 2024, Ayush Tiwari wrote:

> Rename variable tempVal to temp_val
> to address checkpatch warning 'Avoid
> Camelcase' and to ensure adherence
> to coding style guidelines.

The log message can be around 70 characters per line.  The above is a bit
too short.

Your subject line says temp_val, but the code says tmp_val.

Maybe a more meaningful name could be chosen?  From the calculation, it
looks like it represents an average?

julia

>
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
>
> Changes in v2: added a period
> ---
>  drivers/staging/rtl8712/rtl8712_recv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
> index a3c4713c59b3..7fb9dfaa7448 100644
> --- a/drivers/staging/rtl8712/rtl8712_recv.c
> +++ b/drivers/staging/rtl8712/rtl8712_recv.c
> @@ -861,7 +861,7 @@ static void query_rx_phy_status(struct _adapter *padapter,
>  static void process_link_qual(struct _adapter *padapter,
>  			      union recv_frame *prframe)
>  {
> -	u32	last_evm = 0, tmpVal;
> +	u32	last_evm = 0, tmp_val;
>  	struct rx_pkt_attrib *pattrib;
>  	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
>
> --
> 2.40.1
>
>
>

