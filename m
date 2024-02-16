Return-Path: <linux-kernel+bounces-68299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B90C85785D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E0CB28AD37
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB671B812;
	Fri, 16 Feb 2024 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMluWySJ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536901BC20;
	Fri, 16 Feb 2024 09:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074211; cv=none; b=cT0HBRhyXEgZBz653f2Unq0k9ubNJJQiNRhK7/nTPFnF+hXpZi3Brda9gxFo5oq4h1wMsVLT+QbpEW+bfuyG01N2zvS/Z7Ij2BJyhj8as9Ssk2GMh8VZHz3R9SDGF1p+4nwByTKGKO/jt5QAK6v3WT348p/tYThvn3q1+sEHveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074211; c=relaxed/simple;
	bh=wmHmO3hQl2xzz6OrDd+kS6DBHr35sl7ZTkYdpIxTxLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxKEHyPhl67CayEDWhtCcEhz0y9tFp+QrPxOCBDO7Vhf27iaaw9sYgER+OzGbmZtuvBFarSQe+4Fxd2C30RfR1nLHPVpufBizzpZ5hsWxYD6v76uErboujs5CGphfvlzCEOhlflmvdHAZuRToBvrkaHnIQl4bGtw18mkh8l6QBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMluWySJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e1126f57f1so1050911b3a.2;
        Fri, 16 Feb 2024 01:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708074209; x=1708679009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MS1ou+eQuFlj30s1QbfAMDR5SDcOmiXSN2q4UOae8S0=;
        b=AMluWySJdyByYcFvWwvKQjtfZEroR9M2sIFst4lnM0wGkJfA/6Ufw7Y0bsF/Bdc7JO
         XNDFuI/4EvPLqf/0h8OXLk/PEoI2vLiidURRrrbrddINiMNwmFZIJZ5aLHfdr915q6PI
         HxFXkVGuXvzxzhqcLbpLoOxnCQQbnyTrzCrypxFkycS5KlNCeYTHd2VXTJlg0vRihQMP
         lSccoidfeUZykOSoRlxwhwk3PVOg4qAz6zAbJR/bJfnX0oZZJP1fimkvBF/WpxYv/8Uo
         9tWXa1OfPNFKgjjzs6V5i3VOH0BPCCr3GbMeX/NM2xASFLGbNjzJrzrSKTE7FgOmcDJZ
         mcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708074209; x=1708679009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS1ou+eQuFlj30s1QbfAMDR5SDcOmiXSN2q4UOae8S0=;
        b=nV04RyY0RkGS+Ieea6TNER3TFmbR7uGlkiw/8DLuhEs7a5UadlohRaCTkbNrD+TaKm
         5qf/0B7cMSyvJFKDkfccMAsdtyIFN1oXOHfIAYAKdBj8wc0DGSKH2cB29ZMIT1z8hjbv
         qW6B0kMtd6Q4ZO8k96DLRt5RwriE1ORhztpbY43gqX0jEj45kaYBor4R85l6zyG0iaDP
         zviTUajCRo5QwzMNcGxcZ6Fv6cmu8NCDrNrFQn7vG2B9YvBoqtHYssaKjdLfz728q+Cx
         f82qFXaFcWdhq2/6IIjtlWt4vNSBEgBFlEK5H1wZ0yrKpN5hF1AM6hWXCQvpMc8Gw6Nz
         zpyg==
X-Forwarded-Encrypted: i=1; AJvYcCWQEmBc78kBf71MOLTiORqCSpegu29DeOUTrqaDXJWqEiaSnP75RGsUCziu4dc0eW/ApeZqjaW0U2lnR4vIS6X4CkX2Wgm53d2RwpZJvE8A0CZFvY7viM4/1u1SnetXvCdnQqlj
X-Gm-Message-State: AOJu0YxFOn+38aIkr31YGvTSrYJRTIlIPayVoTAoGwkdIQS3ujy97RuA
	CPw+kbvQA0tWJUZPzO7J/33EkMCZRaPGISq1byRjKWBNOzQhzBHn
X-Google-Smtp-Source: AGHT+IFPPQoTVszJuTvd2g54FI0WiOshhaB26U2aFpB37euTnEANRoYDUOlPLAQnSRxm4SGFtWUoNw==
X-Received: by 2002:a05:6a00:a88:b0:6e0:f3f4:8da9 with SMTP id b8-20020a056a000a8800b006e0f3f48da9mr6528361pfl.4.1708074209431;
        Fri, 16 Feb 2024 01:03:29 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 16-20020a056a00071000b006dbdac1595esm2706594pfl.141.2024.02.16.01.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 01:03:28 -0800 (PST)
Date: Fri, 16 Feb 2024 17:03:23 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
	manjunath.b.patil@oracle.com
Subject: Re: [PATCH RFC] bonding: rate-limit bonding driver inspect messages
Message-ID: <Zc8k2wYZRvtfrtmW@Laptop-X1>
References: <20240215172554.4211-1-praveen.kannoju@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215172554.4211-1-praveen.kannoju@oracle.com>

On Thu, Feb 15, 2024 at 10:55:54PM +0530, Praveen Kumar Kannoju wrote:
> Rate limit bond driver log messages, to prevent a log flood in a run-away
> situation, e.g couldn't get rtnl lock. Message flood leads to instability
> of system and loss of other crucial messages.

Hi Praveen,

The patch looks good to me. But would you please help explain why these
slave_info() are chosen under net_ratelimit?

Thanks
Hangbin
> 
> v2: Use exising net_ratelimit() instead of introducing new rate-limit
> parameter.
> 
> Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
> ---
>  drivers/net/bonding/bond_main.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 4e0600c..e92eba1 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2610,12 +2610,13 @@ static int bond_miimon_inspect(struct bonding *bond)
>  			commit++;
>  			slave->delay = bond->params.downdelay;
>  			if (slave->delay) {
> -				slave_info(bond->dev, slave->dev, "link status down for %sinterface, disabling it in %d ms\n",
> -					   (BOND_MODE(bond) ==
> -					    BOND_MODE_ACTIVEBACKUP) ?
> -					    (bond_is_active_slave(slave) ?
> -					     "active " : "backup ") : "",
> -					   bond->params.downdelay * bond->params.miimon);
> +				if (net_ratelimit())
> +					slave_info(bond->dev, slave->dev, "link status down for %sinterface, disabling it in %d ms\n",
> +						   (BOND_MODE(bond) ==
> +						   BOND_MODE_ACTIVEBACKUP) ?
> +						   (bond_is_active_slave(slave) ?
> +						   "active " : "backup ") : "",
> +						   bond->params.downdelay * bond->params.miimon);
>  			}
>  			fallthrough;
>  		case BOND_LINK_FAIL:
> @@ -2623,9 +2624,10 @@ static int bond_miimon_inspect(struct bonding *bond)
>  				/* recovered before downdelay expired */
>  				bond_propose_link_state(slave, BOND_LINK_UP);
>  				slave->last_link_up = jiffies;
> -				slave_info(bond->dev, slave->dev, "link status up again after %d ms\n",
> -					   (bond->params.downdelay - slave->delay) *
> -					   bond->params.miimon);
> +				if (net_ratelimit())
> +					slave_info(bond->dev, slave->dev, "link status up again after %d ms\n",
> +						   (bond->params.downdelay - slave->delay) *
> +						   bond->params.miimon);
>  				commit++;
>  				continue;
>  			}
> @@ -2648,18 +2650,20 @@ static int bond_miimon_inspect(struct bonding *bond)
>  			slave->delay = bond->params.updelay;
>  
>  			if (slave->delay) {
> -				slave_info(bond->dev, slave->dev, "link status up, enabling it in %d ms\n",
> -					   ignore_updelay ? 0 :
> -					   bond->params.updelay *
> -					   bond->params.miimon);
> +				if (net_ratelimit())
> +					slave_info(bond->dev, slave->dev, "link status up, enabling it in %d ms\n",
> +						   ignore_updelay ? 0 :
> +						   bond->params.updelay *
> +						   bond->params.miimon);
>  			}
>  			fallthrough;
>  		case BOND_LINK_BACK:
>  			if (!link_state) {
>  				bond_propose_link_state(slave, BOND_LINK_DOWN);
> -				slave_info(bond->dev, slave->dev, "link status down again after %d ms\n",
> -					   (bond->params.updelay - slave->delay) *
> -					   bond->params.miimon);
> +				if (net_ratelimit())
> +					slave_info(bond->dev, slave->dev, "link status down again after %d ms\n",
> +						   (bond->params.updelay - slave->delay) *
> +						   bond->params.miimon);
>  				commit++;
>  				continue;
>  			}
> -- 
> 1.8.3.1
> 

