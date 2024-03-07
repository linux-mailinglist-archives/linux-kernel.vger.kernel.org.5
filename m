Return-Path: <linux-kernel+bounces-95302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0160874BF7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70585B24A2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CC41292ED;
	Thu,  7 Mar 2024 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ap6V7M73"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D9B1292C1;
	Thu,  7 Mar 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806015; cv=none; b=dv/g2lD9aWKRjZ79URRULkrb+gzYshQ8BJpyL2a7M2QVkybeYxC+c3aEUfqwRfdRRa81gimlhB8GpzOfHkKtkJWxoCOLcBuke/VtsU34d7mXRvR8ZavIxDWD8s5esGjAxZ7Jr7A7eeyTxCNNPhm2ieDMEBE/GNY6My9PrJJDDJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806015; c=relaxed/simple;
	bh=8ix+DtleFB6ZlJBt/yYcZLhNl0FOKjRVkyS681gcIVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSU37kHP0y0Q5ZTxwZ83+EkYo1fE7JVT3y6rHwo1uNCQmSg5CIKJWfUnHtz63rpMKkV+kekxmPqrjPGWbi+IvL6jiSHkfEO1yHmWppT0ydCJEF8NCW2uI2kQj6ymXGKTNZoZnpjNk6cTy8uryQh8Jqkh6qVm4eqVpqUmNXhyMYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ap6V7M73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5A8C433C7;
	Thu,  7 Mar 2024 10:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709806014;
	bh=8ix+DtleFB6ZlJBt/yYcZLhNl0FOKjRVkyS681gcIVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ap6V7M73103CwlFFkQarLa2zlMQvNaW6MPGbmbg/hFCXJB2SnMNVwE5vF7dt5Htjo
	 Pka2DebBLed4VR3JbPQPx+fVvBk6bs7eJN3wRm4AnSd9fXUl8qoiePrnCKrnjXCJP6
	 d0Nen6HQuE+2YAAaqywAtJ/wmXwCKP8FbqFYMtrlkkb7OMlCszQfVlIM9qsY8Jk3DT
	 gf1Vb9QuOW3SDfFLDX79NZvn20WW3fkF+BLpS0MFhM8lnfBQWwzBBAcuKaz5acVuoE
	 EUHJYu/PwogdvCDuFYKdiGJuQ5M+MnB5Q1TgWl8jOCji7hc2cVacBR1z2kSJRZLG3e
	 y72+HkwCD/hUg==
Date: Thu, 7 Mar 2024 10:06:50 +0000
From: Simon Horman <horms@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/1]  net: bridge: switchdev: Improve error
 message clarity for switchdev_port_obj_add/del_deffered operations
Message-ID: <20240307100650.GK281974@kernel.org>
References: <20240306132130.2720721-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306132130.2720721-1-o.rempel@pengutronix.de>

On Wed, Mar 06, 2024 at 02:21:30PM +0100, Oleksij Rempel wrote:
> Enhance the error reporting mechanism in the switchdev framework to
> provide more informative and user-friendly error messages.
> 
> Following feedback from users struggling to understand the implications
> of error messages like "failed (err=-28) to add object (id=2)", this
> update aims to clarify what operation failed and how this might impact
> the system or network.
> 
> With this change, error messages now include a description of the failed
> operation, the specific object involved, and a brief explanation of the
> potential impact on the system. This approach helps administrators and
> developers better understand the context and severity of errors,
> facilitating quicker and more effective troubleshooting.
> 
> Example of the improved logging:
> 
> [   70.516446] ksz-switch spi0.0 uplink: Failed to add Port Multicast
>                Database entry (object id=2) with error: -ENOSPC (-28).
> [   70.516446] Failure in updating the port's Multicast Database could
>                lead to multicast forwarding issues.
> [   70.516446] Current HW/SW setup lacks sufficient resources.
> 
> This comprehensive update includes handling for a range of switchdev
> object IDs, ensuring that most operations within the switchdev framework
> benefit from clearer error reporting.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  net/switchdev/switchdev.c | 106 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 102 insertions(+), 4 deletions(-)
> 
> diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
> index c9189a970eec3..d5a30b626fd9c 100644
> --- a/net/switchdev/switchdev.c
> +++ b/net/switchdev/switchdev.c
> @@ -244,6 +244,106 @@ static int switchdev_port_obj_notify(enum switchdev_notifier_type nt,
>  	return 0;
>  }
>  
> +static void switchdev_obj_id_to_helpful_msg(struct net_device *dev,
> +					    enum switchdev_obj_id obj_id,
> +					    int err, bool add)
> +{
> +	char *action = add ? "add" : "del";
> +	char *reason = "";
> +	char *problem;
> +	char *obj_str;

Hi Oleksij,

I think the above variables could be const.
That not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

..

