Return-Path: <linux-kernel+bounces-108974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15438812B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D8B1F25145
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F184207B;
	Wed, 20 Mar 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="00nZnuth"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F32941C85
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942696; cv=none; b=Z2h45TiCoMSgBGhVEmBRKHXe2keOr9avz4v8YTcHBL2T7KjFO43SEcbygCfzAhI6sAdm+9eRVtZDCsOws2W4/XCEV2tSOnGXW9RoGmRL3ve3hIRtB82HS5R83kJgHIIOYzmZaKyyt96Zh6OmTyGKAq9YHzHVdB4AUwb6WV3WUyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942696; c=relaxed/simple;
	bh=zYX1XdCiM/J/TZCdb9pgctiZ9o4mjVDtCcATQD2Nq3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qw6U41COFUPlWGe2nVsNeR4stQRPqpfY3E1eVIUX6VFQzoV+7NlefHCzWsJqoWxFQDIpoehocSEF/q517Hwsy7lfjCgXFqU6nCtiyqm9TbqTpZA3ELsFsKhVt0Jti0pvvGBA3d7d8i6WNwAIMGXkRVnLuI2kHB7m25h/RjaQ0og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=00nZnuth; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512e39226efso5768237e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710942691; x=1711547491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rLgVIWrsH99Tdm6W0KA5TMaz4bhoDoQetV9XucEEMb4=;
        b=00nZnuthZXCHLm741KVYXEwP7u9rlAXTgb/c7cFAwdR1gtQ2pADCNgSPEELdhZb6au
         R19AK1siRtF+XNP/NwHEBuA2YBx4GnYZEWXyNm6vpEwb/rhqQyXnZ8BALBZkFBqoKdlX
         AU+cijJT/Ev8a0j/dyX1jv8dOUp9Dvrl7+gEyFi74qcg1USvHiimFH7kRf3Ksn6yvFX3
         frMe2Ipux359NQp4S8qJtp708kGsY2d14B3rZUmQi/E+cZkqmNfu+SqHUYjgWrXqk3Dv
         hl9y8VRviTHnzuL/QZyR4nsiiS1EDpFcwLe0YdU3hq4NYBruksSO9dNngpvYaET1sZRC
         vLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710942691; x=1711547491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLgVIWrsH99Tdm6W0KA5TMaz4bhoDoQetV9XucEEMb4=;
        b=U2VCy2wLNbO257GluNsLfX8TGVRSSkjjPeyD1yzuVGkoxcWbE8ar6jFy9ZcVRi+Myv
         /e0KCtqIwlSBoT3xwrckd7Cz5wmDnqL5J9COei3tgkOznvU0GgIdcuRTyff0zFrxw3xm
         taPkZFYNUcthvHXv1gwyLO4+iZxJnOUhbo82hRGtv2+WCPU11pIxKKEYs7HlVSpLMs9Z
         aXaO3DF2Jr3jUIsMV8MI+Ab3spcSYlFvmX5goY31qeGKY+A7OUYAToQrD0uDWKWx2u75
         Km1FOLewygY2uvGhCCbxLcdIUxGtGfmQltybn7lywPbpE9HOtGPOTHzWMCgD544kvLzV
         66Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX25dFcvZ2seF38fmHxtC5je6cozPPUlcjcoZdyTsEZC7Yi9VHVvOhih1RrvnDnZhRz13ZHjl3eIFoontD1uo6/DVfEYn6o+rwKZ0cA
X-Gm-Message-State: AOJu0Yzis0P0EAu/E+suy/QRqzzAIFYkAdqK/9YBehy7LY0Sl5j1jmy9
	eNepbPLjGcwYvDY54QsSJQnwuQ7+0PX9A4QdGArUAYQ3CQRizq4DqCtN4V8ysA0=
X-Google-Smtp-Source: AGHT+IEsglMPSjFRtFTQ8SFDCL0ugC7y9eK0vOdPKea84vD6CAVGiDs000/3sKroYNcSGWDrgoLYWg==
X-Received: by 2002:a05:6512:538:b0:513:c5d6:8356 with SMTP id o24-20020a056512053800b00513c5d68356mr12498197lfc.12.1710942691398;
        Wed, 20 Mar 2024 06:51:31 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b004130378fb77sm2309533wmq.6.2024.03.20.06.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 06:51:30 -0700 (PDT)
Date: Wed, 20 Mar 2024 14:51:29 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com,
	linux-kernel@vger.kernel.org, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net V2 2/2] net: lan743x: support WOL in MAC even when
 PHY does not
Message-ID: <Zfrp4bwpC-ywjZ6_@nanopsycho>
References: <20240320042107.903051-1-Raju.Lakkaraju@microchip.com>
 <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320042107.903051-3-Raju.Lakkaraju@microchip.com>

Wed, Mar 20, 2024 at 05:21:07AM CET, Raju.Lakkaraju@microchip.com wrote:
>Allow WOL support if MAC supports it, even if the PHY does not support it

Sentences like this one usually end with "."


>
>Fixes: e9e13b6adc338 ("lan743x: fix for potential NULL pointer dereference with bare card")
>Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
>---
>Change List:
>------------
>V1 -> V2:
>  - Repost - No change
>V0 -> V1:
>  - Change the "phy does not support WOL" print from netif_info() to
>    netif_dbg()
>
> drivers/net/ethernet/microchip/lan743x_ethtool.c | 14 ++++++++++++--
> 1 file changed, 12 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
>index 8a6ae171e375..7509a19269c3 100644
>--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
>+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
>@@ -1163,6 +1163,17 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
> 				   struct ethtool_wolinfo *wol)
> {
> 	struct lan743x_adapter *adapter = netdev_priv(netdev);
>+	int ret;

You use "ret" only in "if (netdev->phydev) {" scope, move it there.


>+
>+	if (netdev->phydev) {
>+		ret = phy_ethtool_set_wol(netdev->phydev, wol);
>+		if (ret != -EOPNOTSUPP && ret != 0)
>+			return ret;
>+
>+		if (ret == -EOPNOTSUPP)
>+			netif_dbg(adapter, drv, adapter->netdev,
>+				  "phy does not support WOL\n");

How about to chenge the flow to:

		ret = phy_ethtool_set_wol(netdev->phydev, wol);

		if (ret == -EOPNOTSUPP)
			netif_dbg(adapter, drv, adapter->netdev,
				  "phy does not support WOL\n");
		else if (ret)
			return ret;

to avoid double check of EOPNOTSUPP?


> 	}
> 
> 	adapter->wolopts = 0;
> 	if (wol->wolopts & WAKE_UCAST)
>@@ -1187,8 +1198,7 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
> 
> 	device_set_wakeup_enable(&adapter->pdev->dev, (bool)wol->wolopts);
> 
>-	return netdev->phydev ? phy_ethtool_set_wol(netdev->phydev, wol)
>-			: -ENETDOWN;
>+	return 0;
> }
> #endif /* CONFIG_PM */
> 
>-- 
>2.34.1
>
>

