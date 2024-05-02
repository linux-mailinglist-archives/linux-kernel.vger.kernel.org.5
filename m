Return-Path: <linux-kernel+bounces-166025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF58B94E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A4E1F212F6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7A1F959;
	Thu,  2 May 2024 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vz6l/MTM"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B49182DB;
	Thu,  2 May 2024 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632914; cv=none; b=d2LatIl6Y3HHnDQ6JCG850vZ9FwDVILgdmSx2ZeSJNIUbanqYQyF70eVMhIIcnsRKw3nLMhrT2fvXVz4zxGIrkFZSXyKlLrqWh0mLxyeWRzKU2CWaI8rhZnzjvKZgyAL18+h7wZRf2qcGhiaHqT+7SFQ93+H4142YCb09HfDrks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632914; c=relaxed/simple;
	bh=BhqFl8BuZ3euYmoACL97M4SnkmaSYCl8501Nsks10AA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWG1OfI5deIiJSRU/LuoGR2pncP8EJzg54QFeDrKNhutfm8CkXttFaqXiGkfDoeXMIh8iLhaVj+BgsfknijzdVPsNuw2iNEPoLrUZqEUGv5sGQErDjJkQR76NpKvI5XQqFK3eRoNe7qKScMnvsrhj75mMCO/gvAwvRRKrwqnOL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vz6l/MTM; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714632912; x=1746168912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BhqFl8BuZ3euYmoACL97M4SnkmaSYCl8501Nsks10AA=;
  b=vz6l/MTMuaUXS6rf/2IRX/h63m1aFUKBM24q+oypIAl/JwwIQglEq8+/
   Qt6oD+mywsOtKJl+kcA1LfgppOKyOZn0uoa8HCZCp6Gl9sZkgZnNCSed5
   ZWMpGtNnYfdZEmv1SvrN5DCT3F6WLrDTrrFJT7ATkroJfS/SzhFb1ZTjn
   zmGSVwdrgDe7anErj8XJ8OJNWFy1SIbBCGNRC2mpciDx+hYlCDsmGzV1u
   TVWvB7dF9hvr6er6FNk6CicjwaYK5DkfBnBqT7MWSNasF6/oIBP/M2dRo
   B06GlI3D6+yfRhmvJyWn0huE3u6wj6pNPgddaiLg17lwcA7NQNwL3Fs9S
   Q==;
X-CSE-ConnectionGUID: CclnGGeKRxutdmWHu/ey6w==
X-CSE-MsgGUID: 7RHeIliVT2O8u2pwWghytg==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="254178193"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 May 2024 23:55:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 23:54:54 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 23:54:54 -0700
Date: Thu, 2 May 2024 08:54:54 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Min Li <lnimi@hotmail.com>
CC: <richardcochran@gmail.com>, <lee@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Min Li
	<min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v7 4/5] ptp: clockmatrix: Fix caps.max_adj to
 reflect DPLL_MAX_FREQ_OFFSET[MAX_FFO]
Message-ID: <20240502065454.vn3rcfovwysqvbub@DEN-DL-M31836.microchip.com>
References: <20240501160324.27514-1-lnimi@hotmail.com>
 <LV3P220MB12026BB3CBA7FCE8480438FBA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <LV3P220MB12026BB3CBA7FCE8480438FBA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

The 05/01/2024 12:03, Min Li wrote:

Hi Min Li,

Maybe the entire patch should target net instead of net-next. As this is
fixing an issue.

> @@ -2285,6 +2301,10 @@ static int idtcm_enable_channel(struct idtcm *idtcm, u32 index)
>                 ppd->chan = index;
>         }
> 
> +       err = initialize_max_adj(channel);
> +       if (err)
> +               return err;
> +
>         err = initialize_dco_operating_mode(channel);
>         if (err)
>                 return err;
> @@ -2437,8 +2457,13 @@ static int idtcm_probe(struct platform_device *pdev)
> 
>         err = idtcm_load_firmware(idtcm, &pdev->dev);
> 
> -       if (err)
> +       if (err) {
> +               if (err == -ENOENT) {
> +                       mutex_unlock(idtcm->lock);
> +                       return -EPROBE_DEFER;
> +               }
>                 dev_warn(idtcm->dev, "loading firmware failed with %d", err);
> +       }
> 
>         wait_for_chip_ready(idtcm);
> 

Also this change should be in a separate patch as this doesn't have
anything to do with caps.max_adj but it is releasing the lock in case
firmware fails to be loaded.

-- 
/Horatiu

