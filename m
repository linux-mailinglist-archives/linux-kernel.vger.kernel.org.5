Return-Path: <linux-kernel+bounces-5521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE855818BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E18528748F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316D91D13C;
	Tue, 19 Dec 2023 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD3M2ZuY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23AE1CF96;
	Tue, 19 Dec 2023 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ca02def690so54531041fa.3;
        Tue, 19 Dec 2023 07:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703001242; x=1703606042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+/0NojnEKyeTXrrsJnCjkci5dAMTlrQZF+wpXNcSGQ=;
        b=GD3M2ZuYOYBCjVhcSS0baON2f1i717mEJL8oxbr0Ew2fSpRZBzwnIDkUZ8/bGuWFcx
         sgDtZPY3DT3rK0rAe/uizSGuUxCxvceaT6zfmZy83dyUSL6AteWfCMHswWkcM1jiLKhV
         HLz+Ivlw/tig6p3ZdiqPGni6rCY4iP8gvMgbPcC+IX8n5fVTgl9eZZOKMls8sCsW5201
         DXw+ba0EuCRZ3A/S9swyhoqSwT0Hv7hGTtxMfeKrw+8spgPN080nQcq3ZQlFwMru8PLA
         cDnjLO3Hjia51oHS6ekoZ8yWbautQbXY6MbS4w6L5Aw1PIcKSAwlM7vmeH0hwy1Ohcj9
         K/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703001242; x=1703606042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+/0NojnEKyeTXrrsJnCjkci5dAMTlrQZF+wpXNcSGQ=;
        b=Kv2nNzzgdMtYD+M+3WcyeKvC6TBGZiDEvyEBnBxDPvq8zOpe8zxRZXmppG8+22u9AP
         a/QqpqvURfZr0qIF7gtj4uVZ8pFVKpAKRGvwMW2W1P2q/LNxdyo/IttpMuRp4AFDP7Tr
         9g+SVhScybf+YePuFZNQuLo53lpPsjzcPgyV2twnw2HhRpiMPWyjvFsa3eluGNHz8xuK
         qo3NUZZwGzh+8I27cG94NDdkeo0orIn1qpOAfTJIQmDmChQ/+FMNmv5Obev90UU/g9Zt
         0v+q7j7YY6eX4WfdTOKPlTxsHKe9vek2jxfeRGykYcbXYcw93rvXzCGpyTDIsZs/JvoX
         0C5g==
X-Gm-Message-State: AOJu0Yz7sxdQ3PMnfsHjOsM8swJNlZzqb3sQCeF/TuPjpoXBxJJQ+eMI
	O9VR1vdzF80+wKLJYSCl3B0=
X-Google-Smtp-Source: AGHT+IGxgJlS76KKbhiIvrV4SZ9jaaRyya80b/MRTuQcf4q27hcVV0Tzdk0NnqtpF7D4YgggeMnAPA==
X-Received: by 2002:a05:651c:b09:b0:2cc:88bd:d4dd with SMTP id b9-20020a05651c0b0900b002cc88bdd4ddmr325821ljr.63.1703001241537;
        Tue, 19 Dec 2023 07:54:01 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id z22-20020a2e3516000000b002cc6a6d6a33sm1026846ljz.115.2023.12.19.07.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 07:54:01 -0800 (PST)
Date: Tue, 19 Dec 2023 18:53:58 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Lai Peter Jun Ann <jun.ann.lai@intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Song Yoong Siang <yoong.siang.song@intel.com>
Subject: Re: [PATCH net v2 1/1] net: stmmac: fix incorrect flag check in
 timestamp interrupt
Message-ID: <bhw5l75erhcci7z55vrcos43qtyn7txsspv6qtazhlulpbn7km@dp6yg6sf2gwk>
References: <1702885892-30369-1-git-send-email-jun.ann.lai@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702885892-30369-1-git-send-email-jun.ann.lai@intel.com>

On Mon, Dec 18, 2023 at 03:51:32PM +0800, Lai Peter Jun Ann wrote:
> The driver should continue get the timestamp if STMMAC_FLAG_EXT_SNAPSHOT_EN
> flag is set.
> 
> Fixes: aa5513f5d95f ("net: stmmac: replace the ext_snapshot_en field with a flag")
> Cc: <stable@vger.kernel.org> # 6.6
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>

Right. The blamed commit has wrongly converted that conditional
statement.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
> v2 changelog:
>  - Add fix tag and stable@vger.kernel.org in email cc list.
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> index 540f6a4..f05bd75 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> @@ -237,7 +237,7 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
>  	 */
>  	ts_status = readl(priv->ioaddr + GMAC_TIMESTAMP_STATUS);
>  
> -	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
> +	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN))
>  		return;
>  
>  	num_snapshot = (ts_status & GMAC_TIMESTAMP_ATSNS_MASK) >>
> -- 
> 1.9.1
> 
> 

