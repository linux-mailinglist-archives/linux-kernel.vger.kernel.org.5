Return-Path: <linux-kernel+bounces-166022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C11B8B94E1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EC72816EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43A22EE4;
	Thu,  2 May 2024 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z0eNvovy"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E79B20B28;
	Thu,  2 May 2024 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632647; cv=none; b=Yr/QEdwH7/Wm+PnBDNOVnVGD+tgMfcXBNDAcA6OiFAWdvYSWef+LnMPojnFDiNqOzHxyNaFsTrQ+kdkjbxZtpojgFpD09OiVhu4TO7IQxDyjgeGpzq7ANt/2GxpXwdbebLvWRuWxnAHWu72t6P5iauQMsE/o0lCcatGNSGsg6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632647; c=relaxed/simple;
	bh=0KtAjG/lQgOLJAFTu2txRbylcS7quAOoyaCIXOphnRE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/B9IIiXw0VVNoHmQvUGsI09fc9zIWoNESl44ohwzB2/uEhfg3DZYviPGn/B2eetYvFrZGhA/s1CKk7yFhCkHKHVdHbUgNVda1tfMHCQhmYQsbOpwdxGm8NnX6Me7ktvtspV8HpTz9yI0ndxyEc9kVojHJEFCYrVoMnRnKORdis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z0eNvovy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714632644; x=1746168644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0KtAjG/lQgOLJAFTu2txRbylcS7quAOoyaCIXOphnRE=;
  b=Z0eNvovyAvOCOfS0HzQfpKk4ZPbZylmdysCXcxOM4BOuO9Ad0LmqoTiu
   4D9fwicoPC3IZav15cfStLivb3/x5qJlgZ8hxpJnwxo6qd13LE08v6tRs
   guA83ORm2jiI0KPhYvkwps1xLgDGPrFvpzGSR4Cf10xCz8C+SI8W2UNd1
   c9hwdxH9TPm+RtSyLFo3rSvswosSbzWdWDg/KPPZLSEtkSl6J1aftmJIZ
   aHOsVaoGu0+PtYdlcgWxjM6T++QzsYA+Gs2yQSGcPzefFowKXfZlGNc+D
   2C0dByk9IA0zPHc1Vsjon0CbJDY2n8NfGb1KkI7sE8YEMSSVkION9KCk5
   A==;
X-CSE-ConnectionGUID: i2nnprOWT+as/Z9/JQ0dlg==
X-CSE-MsgGUID: uhYcgmjHQaO4Rf4DNJeUmg==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="scan'208";a="23940607"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 May 2024 23:50:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 23:49:47 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 1 May 2024 23:49:47 -0700
Date: Thu, 2 May 2024 08:49:46 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Min Li <lnimi@hotmail.com>
CC: <richardcochran@gmail.com>, <lee@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Min Li
	<min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v7 3/5] ptp: clockmatrix: dco input-to-output
 delay is 20 FOD cycles + 8ns
Message-ID: <20240502064946.yc6v7xadwkfldbsw@DEN-DL-M31836.microchip.com>
References: <20240501160324.27514-1-lnimi@hotmail.com>
 <LV3P220MB12024CB984967E4AC05A1E13A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <LV3P220MB12024CB984967E4AC05A1E13A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

The 05/01/2024 12:03, Min Li wrote:

Hi Min Li,

> 
> From: Min Li <min.li.xe@renesas.com>
> 
> Set dco input-to-output delay is 20 FOD cycles + 8ns

Can you explain why you are doing this change in the commit message?
Is this a fix or just improvement?

> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/ptp/ptp_clockmatrix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
> index d069b6e451ef..21f3a2c179f5 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c
> @@ -2165,7 +2165,7 @@ static int configure_channel_pll(struct idtcm_channel *channel)
> 
>  /*
>   * Compensate for the PTP DCO input-to-output delay.
> - * This delay is 18 FOD cycles.
> + * This delay is 20 FOD cycles + 8ns.
>   */
>  static u32 idtcm_get_dco_delay(struct idtcm_channel *channel)
>  {
> @@ -2196,7 +2196,7 @@ static u32 idtcm_get_dco_delay(struct idtcm_channel *channel)
>         fodFreq = (u32)div_u64(m, n);
> 
>         if (fodFreq >= 500000000)
> -               return (u32)div_u64(18 * (u64)NSEC_PER_SEC, fodFreq);
> +               return (u32)div_u64(20 * (u64)NSEC_PER_SEC, fodFreq) + 8;
> 
>         return 0;
>  }
> --
> 2.39.2
> 
> 

-- 
/Horatiu

