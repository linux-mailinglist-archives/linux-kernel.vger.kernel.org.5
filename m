Return-Path: <linux-kernel+bounces-15712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E448230C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6911F24851
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05151B286;
	Wed,  3 Jan 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IOX/oYws"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A2E1B273
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7810827e54eso987984585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 07:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704296786; x=1704901586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fq9/s0WqYoCnNEJlo9eTYEqD5A/UfmiSOMYLw450FCI=;
        b=IOX/oYws82gxxpryz2M1JAHwotIfTNmcLGuI6cv0hR6mEZMQdRX6CguUYfG+xaaHue
         mJxGkJ/NLTyTW8ga97Vv/a3GaP+pz2I57jZ8mXbILjcOx5P3UskcZCSRzzISXLFiI8Fe
         o9C+8FLsHEtp9NJ021LwP3qIoZZ4BeNksMMjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704296786; x=1704901586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fq9/s0WqYoCnNEJlo9eTYEqD5A/UfmiSOMYLw450FCI=;
        b=A1sSxkZadRbYXkd4OyocGvQnI2wzv2yx/RLo+VNUKXxNfVmVBW0YJ4GaQ4myc55DZv
         zZ+/GMxitjsh/GYR5Am+y3LDs6l3Lzhoht33DiWjIUURYhd4oXQ9v6HwveC64kc4yr7h
         wdtGFP2deS7tx36/x3K3a7dCgXYndQynmfgQwTnlqWXpXPvTnVJkummsUt/QHUqymRCn
         mEyltF9+J0L9mhmYNBsYVTgCIMoY3DFV68aiNVLnnq4I2K5JZ2+zC4WN9Umg/lrnSQzp
         6rXdAzbmVBMibHV8WLLty6WS5e5JUhqfUM4z0NdQnd55ESpiVKnJoW+ByVLP1ftqrJwD
         8qWQ==
X-Gm-Message-State: AOJu0YzWN3JnxRHBjyXetnG+iXyFvihx9svr6l/QwpDOJAHMUPAnaS5I
	rcUCCfeYuEuT0QN659BtObpGZ10K04Qm
X-Google-Smtp-Source: AGHT+IFQlezyj6qykwvgaOAfQDO9h8COcAWIKOsjca/Bf+VZmnKjc8U094sSpJ+JqlA5jfwlI9vD/w==
X-Received: by 2002:a05:620a:1926:b0:77f:38f2:2da1 with SMTP id bj38-20020a05620a192600b0077f38f22da1mr25535529qkb.101.1704296786406;
        Wed, 03 Jan 2024 07:46:26 -0800 (PST)
Received: from C02YVCJELVCG.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id e13-20020a05620a208d00b00781c8423ca1sm2093978qka.121.2024.01.03.07.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 07:46:25 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Wed, 3 Jan 2024 10:46:19 -0500
To: Arnd Bergmann <arnd@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Randy Schacher <stuart.schacher@broadcom.com>,
	Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bnxt: fix building without CONFIG_RFS_ACCEL
Message-ID: <ZZWBS5EugvO2dBp0@C02YVCJELVCG.dhcp.broadcom.net>
References: <20240103102332.3642417-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103102332.3642417-1-arnd@kernel.org>

On Wed, Jan 03, 2024 at 11:23:11AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent patch series generalized the filter logic in bnxt to no
> longer just be used for RFS, but it now fails to build when RFS_ACCEL
> is disabled:
> 
> drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_cfg_ntp_filters':
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:14077:37: error: implicit declaration of function 'rps_may_expire_flow' [-Werror=implicit-function-declaration]
> 14077 |                                 if (rps_may_expire_flow(bp->dev, fltr->base.rxq,
>       |                                     ^~~~~~~~~~~~~~~~~~~
> 
> Add back one #ifdef check around a call to the missing rps_may_expire_flow()
> function.
> 
> Fixes: 59cde76f33fa ("bnxt_en: Refactor filter insertion logic in bnxt_rx_flow_steer().")
> Cc: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I don't know if this is a correct fix, only checked that it is plausible
> and that it does address the build failure. If a different fix is needed,
> please just treat this as a bug report.

Are you using a kernel config with CONFIG_SMP=n ?  That was how I was
able to reproduce this.

There is a good oppportunity to clean this up a little better.  When
CONFIG_RFS_ACCEL is not set there is no reason to even have
bnxt_cfg_ntp_filters included in the driver build.

I'll talk to Michael and we will post a fix for this.

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 827821e89c40..83a97c65b728 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -14074,6 +14074,7 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
>  			if (test_bit(BNXT_FLTR_VALID, &fltr->base.state)) {
>  				if (fltr->base.flags & BNXT_ACT_NO_AGING)
>  					continue;
> +#if IS_ENABLED(CONFIG_RFS_ACCEL)
>  				if (rps_may_expire_flow(bp->dev, fltr->base.rxq,
>  							fltr->flow_id,
>  							fltr->base.sw_id)) {
> @@ -14081,6 +14082,7 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
>  									 fltr);
>  					del = true;
>  				}
> +#endif
>  			} else {
>  				rc = bnxt_hwrm_cfa_ntuple_filter_alloc(bp,
>  								       fltr);
> -- 
> 2.39.2
> 

