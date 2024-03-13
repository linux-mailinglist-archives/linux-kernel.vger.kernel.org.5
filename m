Return-Path: <linux-kernel+bounces-101144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9506387A306
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A1D1C214FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E144818EC3;
	Wed, 13 Mar 2024 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="BWs5pePU"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8818629
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710312290; cv=none; b=Yzob2oiguPKd4lbQFmUDzR2Bj2PuaOY+DUHL1YdUTZvORrO9mH82qhIFOrGnnn3LeecoloZSNY7IsQjbXf4mKvhsbn2fWWacT8AElveBvQIPtlcUMXm3jrqLvF2eb2KQH3FZICVIvvQZ/ZNgbwJ+dlJtLkjX6RpfoMl0/UZWVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710312290; c=relaxed/simple;
	bh=TM1rmGPrdfiR9PzrANbtrHezb6aRvvbEUO4pTe07UuY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=exYH2JRtB+T/kJ2GYsERYzY78a1T9ud52rG5sUT8CdFScUNZuJ521WP2DKQgq2Vzsp8SUCezYlkWw8YcmK+XhHX9HPmCocSwCmpod9EQT79WuozAMgG8qq075woL/HLEcslIkQ3tX77HiLZnXZ5qFCXpKp6le5X9k/sQT5wfpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=BWs5pePU; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NVhchdFlSqvatkPMxpndknNhXgMLZz8ISGeYtFhJ08M=;
  b=BWs5pePUQTzKZefkGheXNpTzxeP2bN+cgUohLzdLR0KhAoDGkz4SEXUv
   GqCB4oZpR23Rs1OilSThHVSvFVcTay0AyHZVEwn2POpQL31yInrjIh155
   gC8TUfW/H5TbbUfgQegp2KbyM4JL/ZAtdRQWgCyNKl9z4hK6RR9RT6Vnc
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,119,1708383600"; 
   d="scan'208";a="82007499"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 07:44:46 +0100
Date: Wed, 13 Mar 2024 07:44:45 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Ayush Tiwari <ayushtiw0110@gmail.com>
cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com, 
    gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
    linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8712: renaming tempVal to temp_val
In-Reply-To: <ZfE4iDfGUyq/C9s4@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Message-ID: <alpine.DEB.2.22.394.2403130744040.3473@hadrien>
References: <ZfE4iDfGUyq/C9s4@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 13 Mar 2024, Ayush Tiwari wrote:

> Renaming variable tempVal to temp_val to address
> checkpath warning 'Avoid Camelcase' and to

Also, it's checkpatch, not checkpath.  And it should be "to address the
checkpatch warning".

julia

> ensure adherence to coding style guidelines
>
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
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

