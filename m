Return-Path: <linux-kernel+bounces-72227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A7185B0FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 658AEB22F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC6D41215;
	Tue, 20 Feb 2024 02:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5Ah++3b"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C9E2E630;
	Tue, 20 Feb 2024 02:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708397621; cv=none; b=iQwcRlwP0N4kih860egSlobZrdzwLRd2jeK072yOqN2gpcUsta3UtOposGwU0vpEYS50sfVHEJAfXHASXSL577AooWl/dAFmtUNDXFWoXjswZQMJ/17dNqIOb6o/IZb7WlFX0MG77IPen7X5HkRfn6O5yP4D1MDQVUyFOWIz5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708397621; c=relaxed/simple;
	bh=wQsTe8lm8ajQ/lPO3ErWZZO+C2sVVDxH5ZwuxT4SMN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TD0+rgKGl/cDFyPWf9e7ksUiKnCiG0iy4bhDeQ5INzNvzIF7lnDSnc4v35HzyWxVKM31IMhDgZPXo21M/b0WLD3s5nvXTANilwddnG3/+8aRlKV94R9kkRmTwYxNwtISPJ8JxSOvfCnkA608GhhMDphHapQlWwaMFmXehUPizIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5Ah++3b; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2185739b64cso2972458fac.0;
        Mon, 19 Feb 2024 18:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708397619; x=1709002419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpsQzuu0lDM3uguij/1AIjBF3RcYUPdhKZTFCmqM2bk=;
        b=A5Ah++3bs3gey7IrLsG0NsDbWe/Y62FYO2419tNmRcNgGiNx028YZ4y9ONwasrDrmX
         /wAsbkIM8inr3/EieHw2wn/BZuRShtI2kYZDnK1G7WH9HDYCLCkuo0ztx6ZjlkVY17Lb
         12/ddueBEl++p5ohlzyh6lA4Va6mAtpq0c60Q2DMMwSmqGCPkz2os/nBIA2f7rB+LAtc
         KYatYQB+YzqmmkuBQFL1z/JZGlzqfjCQNpQCxYCXKQoDxZAC+h4w02CijX15OrnwLlK5
         O1xOh2m0gnNz8Rvw9Dg/RFFTJoQcgpLVEOO7znIlNPo4AbkCJZVFgNDGbp9LuOsF24tN
         hdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708397619; x=1709002419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpsQzuu0lDM3uguij/1AIjBF3RcYUPdhKZTFCmqM2bk=;
        b=uCwi2YXlsPiGB4vcj9hi7l11wBfyCpcIsPlvc3dwE0NqHmuoKDirxZIeNFWdDDnMzc
         6oiqKNMy7EbItrARBX1BmJvnxIvhTEmIEOp2qwkl38mGAMIZTUikn+n7v/+Gd5MoksY/
         SwO6MOWpgjHnUdC4Scb00MnLZwQK3+5RWdv3xxqcOGTXqyZXlTQhkJEtgYiPYwQah2pr
         FfdsY/jjc64jlDEte1D1ch4Cuv4h6QtQYnODnM3GP6xhUYYCLPa584K0Cz3r9xqqGaJX
         N2+C6x+VbshdwHyQbI1t+rBYHY/4T3f31ky3DCPbXhYzNnF/B3Z6bloxqTJI3dadTq18
         QOww==
X-Forwarded-Encrypted: i=1; AJvYcCXL25T/0To6i+IlL570iLU834V3r4nvq7iDcdbgjbhbtT69FrIOCNo2MkpJ6LKTTocKHeRMDOQvPf1uci66Vw2EgD2dSMhPvXCVTFk0EdA2sYJT1IC9birTtDpNzabfkrU8KJes
X-Gm-Message-State: AOJu0YxeZRpIpAt4qpJbA0f/h32x+8lG4IyQRNE1KDV/DJic7FmOz1xL
	/rIiA93EBNMq9/6rjKVrSGf/nOBaoW/rT89jpWRkBgFhmVL1bbJQ
X-Google-Smtp-Source: AGHT+IFgVBb7qWRyzGpB3h4Gqx9casdUXdxwXuIM+J1x2TPx9OfzQDtOwETBvKevb+OoToJZ4qLWRQ==
X-Received: by 2002:a05:6870:71c4:b0:21f:22b5:ba7f with SMTP id p4-20020a05687071c400b0021f22b5ba7fmr40687oag.54.1708397619211;
        Mon, 19 Feb 2024 18:53:39 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v18-20020a63f852000000b005dc87643cc3sm5391924pgj.27.2024.02.19.18.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 18:53:38 -0800 (PST)
Date: Tue, 20 Feb 2024 10:53:32 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	rajesh.sivaramasubramaniom@oracle.com, rama.nichanamatlu@oracle.com,
	manjunath.b.patil@oracle.com
Subject: Re: [PATCH] bonding: rate-limit bonding driver inspect messages
Message-ID: <ZdQULIRepXN4sDd6@Laptop-X1>
References: <20240219133721.4567-1-praveen.kannoju@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219133721.4567-1-praveen.kannoju@oracle.com>

Hi Praveen,

You need to target the branch name in subject. e.g.

[PATCH net-next] bonding: ...

On Mon, Feb 19, 2024 at 07:07:21PM +0530, Praveen Kumar Kannoju wrote:
> Through the routine bond_mii_monitor(), bonding driver inspects and commits the
> slave state changes. During the times when slave state change and failure in
> aqcuiring rtnl lock happen at the same time, the routine bond_mii_monitor()
> reschedules itself to come around after 1 msec to commit the new state.
> 
> During this, it executes the routine bond_miimon_inspect() to re-inspect the
> state chane and prints the corresponding slave state on to the console. Hence
> we do see a message at every 1 msec till the rtnl lock is acquired and state
> chage is committed.
> 
> This patch doesn't change how bond functions. It only simply limits this kind
> of log flood.
> 
> v2: Use exising net_ratelimit() instead of introducing new rate-limit
> parameter.
> 
> v3: Commit message is modified to provide summary of the issue, because of
> which rate-limiting the bonding driver messages is needed.
> 
> Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>


For the change log, you can put it after sign off. e.g.

Signed-off-by: Praveen Kumar Kannoju <praveen.kannoju@oracle.com>
---
v3: ...
v2: ...
---

Here is an example https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#changes-requested

Thanks
Hangbin

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

