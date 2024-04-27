Return-Path: <linux-kernel+bounces-161141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB0F8B478A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 21:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89C21C20D29
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBB1433DC;
	Sat, 27 Apr 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vsC7iT7N"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAEF3B7A8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714245802; cv=none; b=KVU6Et4nE7TYopHCEYbaSQ88DB4vHUUVVRHmYeB9bQS6yMrO6xqNNax/J07tOb1Q1ZSw8CLS29/xUQvnzEulTJI9iEnqfz1mA/E1MGYmJI56OFPiDanl8cy07H/qMYyLPXFyfPjySqstRXbK2b0LH9+jptzIdi7mmKXLWUqc5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714245802; c=relaxed/simple;
	bh=JCwvXXGOOpRiQQroxgGXin1e0AgQOViaWS65wT7HZjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSvsztK3HhApBjR8aRNrBNUYxSyQk4LlaEMk+zuZuAHwmoCMVfEE4Cxll9D6aJK1R4m7eZgomqF5b5bft9aCkwFewilDfHgTi3hx5WmDU+DfZHczW9OH7UDSJhV5+vAIGkc8CNEW4/cki5Ew1gOWINkPx6123o2Hk5jrcsVHFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vsC7iT7N; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d88a869ce6so43338391fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714245798; x=1714850598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3rDeek3ek163NM2ICcH8yFDp19I1XYbwXVQl5oOKRdM=;
        b=vsC7iT7NVsAGa25CbtGRVs9EPqgstAZQuaqaCs9i/atc4EAnfGqMuCLicp3I5IGqMN
         apjWWywswu9pEaG0imV4JdSrG7anlKA5a1VifbSGFL2tzcf7d4zJgkEeLLEw61NHd1Tz
         Ibr+0cH69Jymia2EblI2M2ClrdlPsiDR9t6Do7cFcup1iOqefxRaGkn7eFrQlcXFkuCI
         GsJivQgfD3LVr3pURB5LA4lWxaCnwdjlny1Q31jWwMOz2GXWWau3koWRNkPiotEbXA+i
         19MgdcKcXiLgYrt3YdjHvY1fN9wcXt7ItelPpXoQBFSG8bLvj5xLmHRZkC1OhjAtgHyL
         RhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714245798; x=1714850598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rDeek3ek163NM2ICcH8yFDp19I1XYbwXVQl5oOKRdM=;
        b=LF0iaiZCQGsySJJkHjGf17uzfP2ZPJPY0AC5IyYBXOnW6SSZgqaRMSv6ZFhRlfRYC2
         9Aw04zGFeOwaMVMiku+mRKDsmUmAAUXtl7+FPGiXZdHuNfMKv21ZCufcUsuchl3A3y6N
         +HDQpX+Md+U8W+2Z8ok87Q3cPtxYI24Fv3KrPHWGRGoEBlb13nbVbRSmmTVFIi4lyfo3
         7h08mEhjEfcsDF3bLeS46bDVo23f8nHxNyfmXMjiiFyGW8jMMi2y/GOGS8ZdZtuwSzh8
         0k/lj8+9U1qadIbBb0Edbwjh3OSTaL+uF6DEh355Dufjk/P6M13Q+ot4Mmp9KR2w88QR
         kuIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkCBNtcQhBpKnJ7g7XBHfwFjMTVu9YQcp8BU+HPjGiglQETmNI0JgN2DbPHVqEZH/dmtvFjvPq3t20yIy7Z9sbs2tcOM1WhhQz577e
X-Gm-Message-State: AOJu0YwPpfGQJW6+InKpa0Lde+SVQlHEpjtIUncpqirlup0w8DFWgV6V
	esSGGM9R3r71VgNY4iF39MW1L8tyvt+THuI/rEclPNiOuyUygriqIRpJzqZB3Xw=
X-Google-Smtp-Source: AGHT+IFKqPXK39wIAvLsU8xjJKO3ifaHVSzycC6r8B85uS8OxIfghvSOSvqOl6SjJGRsxf9adzAVOg==
X-Received: by 2002:a2e:9112:0:b0:2d4:3e82:117e with SMTP id m18-20020a2e9112000000b002d43e82117emr1920448ljg.32.1714245798256;
        Sat, 27 Apr 2024 12:23:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id z19-20020a2e8e93000000b002d8a12e3d90sm3095509ljk.122.2024.04.27.12.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 12:23:17 -0700 (PDT)
Date: Sat, 27 Apr 2024 22:23:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com, kyletso@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdbabiera@google.com, amitsd@google.com, stable@vger.kernel.org, 
	frank.wang@rock-chips.com, broonie@kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Check for port partner validity
 before consuming it
Message-ID: <ktl5xjnb7njuoyobnekivyjw6uf6ozn7shd2wubl5styzmmoc6@buzgfwr5wive>
References: <20240427175010.3367154-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427175010.3367154-1-badhri@google.com>

On Sat, Apr 27, 2024 at 05:50:10PM +0000, Badhri Jagan Sridharan wrote:
> typec_register_partner() does not guarantee partner registration
> to always succeed. In the event of failure, port->partner is set
> to the error value or NULL. Given that port->partner validity is
> not checked, this results in the following crash:
> 
> [17514.377076][  T275] Unable to handle kernel NULL pointer dereference at virtual address 00000000000003c0
> [17514.378270][  T275] pc : run_state_machine+0x1bc8/0x1c08
> [17514.378286][  T275] lr : run_state_machine+0x1b90/0x1c08
> ..
> [17514.378377][  T275] Call trace:
> [17514.378381][  T275]  run_state_machine+0x1bc8/0x1c08
> [17514.378388][  T275]  tcpm_state_machine_work+0x94/0xe4
> [17514.378396][  T275]  kthread_worker_fn+0x118/0x328
> [17514.378406][  T275]  kthread+0x1d0/0x23c
> [17514.378412][  T275]  ret_from_fork+0x10/0x20

Nit: thre is little use in the timestamps and the T275 tag. In future
patches you can safely ommit such data.

> 
> To prevent the crash, check for port->partner validity before
> derefencing it in all the call sites.
> 
> Cc: stable@vger.kernel.org
> Fixes: c97cd0b4b54e ("usb: typec: tcpm: set initial svdm version based on pd revision")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index ab6ed6111ed0..8a4fa8d875c6 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4,7 +4,6 @@
>   *
>   * USB Power Delivery protocol stack.
>   */
> -
>  #include <linux/completion.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
> @@ -1580,7 +1579,8 @@ static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
>  	port->partner_ident.cert_stat = p[VDO_INDEX_CSTAT];
>  	port->partner_ident.product = product;
>  
> -	typec_partner_set_identity(port->partner);
> +	if (!IS_ERR_OR_NULL(port->partner))

I think that it might be better to check typec_register_partner() result
in tcpm_typec_connect() and skip setting port->partner in case it
returned an error (an error message would be also beneficial).
See for example, how this is handled in ucsi_register_partner().

Then these checks can be turned into simple `if (port->partner)`.

> +		typec_partner_set_identity(port->partner);
>  
>  	tcpm_log(port, "Identity: %04x:%04x.%04x",
>  		 PD_IDH_VID(vdo),
> @@ -1742,6 +1742,9 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
>  	struct typec_altmode *altmode;
>  	int i;
>  
> +	if (IS_ERR_OR_NULL(port->partner))
> +		return;
> +
>  	for (i = 0; i < modep->altmodes; i++) {
>  		altmode = typec_partner_register_altmode(port->partner,
>  						&modep->altmode_desc[i]);
> @@ -4244,7 +4247,8 @@ static void tcpm_typec_connect(struct tcpm_port *port)
>  		port->partner = typec_register_partner(port->typec_port,
>  						       &port->partner_desc);
>  		port->connected = true;
> -		typec_partner_set_usb_power_delivery(port->partner, port->partner_pd);
> +		if (!IS_ERR_OR_NULL(port->partner))
> +			typec_partner_set_usb_power_delivery(port->partner, port->partner_pd);
>  	}
>  }
>  
> @@ -4323,8 +4327,10 @@ static void tcpm_typec_disconnect(struct tcpm_port *port)
>  	port->plug_prime = NULL;
>  	port->cable = NULL;
>  	if (port->connected) {
> -		typec_partner_set_usb_power_delivery(port->partner, NULL);
> -		typec_unregister_partner(port->partner);
> +		if (!IS_ERR_OR_NULL(port->partner)) {
> +			typec_partner_set_usb_power_delivery(port->partner, NULL);
> +			typec_unregister_partner(port->partner);
> +		}
>  		port->partner = NULL;
>  		port->connected = false;
>  	}
> @@ -4549,6 +4555,9 @@ static enum typec_cc_status tcpm_pwr_opmode_to_rp(enum typec_pwr_opmode opmode)
>  
>  static void tcpm_set_initial_svdm_version(struct tcpm_port *port)
>  {
> +	if (IS_ERR_OR_NULL(port->partner))
> +		return;
> +
>  	switch (port->negotiated_rev) {
>  	case PD_REV30:
>  		break;
> 
> base-commit: 3f12222a4bebeb13ce06ddecc1610ad32fa835dd
> -- 
> 2.44.0.769.g3c40516874-goog
> 

-- 
With best wishes
Dmitry

