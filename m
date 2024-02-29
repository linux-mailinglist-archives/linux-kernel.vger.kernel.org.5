Return-Path: <linux-kernel+bounces-86863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39EC86CBE6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D601F1C21547
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181D2137747;
	Thu, 29 Feb 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd8bWomS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A841A80
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709218064; cv=none; b=U2dxfilCkpV49TnMQcKALmw4/SytAj2E2UOiglNCxb4Y3NEIFK2qnK+DjGCZK/TQb8L4uCpdEj9US/EREigOGIJ9YO1runC1TlNNliD70WPtT7E/z//qj/suYwmWTQaIT+gik5M4FmJzdMZTCd7kzTr8SMzj6RFIl7yizckKQ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709218064; c=relaxed/simple;
	bh=c7GmbVJf43ArHWG9m+LgTeyF8QmqxKm6DE7najW6vkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzGUPa4vosMk3jBUUnczdugx5KjYfl+djVaJbxV1UxU/r2gLlEktUNDjk9eHxgykYHYhnetuIy1QyajfXfGpTD/9k6QQ4DHplPVYhGQWzRhqVi3WtdFSbqTaPtAqpLuh5qPjdLkUWPDtKc6IhQLoiwKCRYTyFXif2QkT45bal1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd8bWomS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C91BC43390;
	Thu, 29 Feb 2024 14:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709218063;
	bh=c7GmbVJf43ArHWG9m+LgTeyF8QmqxKm6DE7najW6vkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fd8bWomSDlRNZkU9IB07feEamaa19n8kfPgUJONxZEAcmwiJIjF9ianrPSh2PUQ2+
	 NQOJxKk8u6voltML5yygA3M0NCgqDtOjxDmGmqtquTBDRHh66gOOOyIC1JThtsl6Ui
	 Z22/moAG2DQUoobCnXVA1JIYppGFI1eu86YJTtx9/j43KU+80OhaM0eDYlu72OPp0N
	 gXicsCxEPUx0xW+xxKkjldIor83o1qhPBJTdeCerzQkG7Ka/I5NvebRky5wr1Krvlp
	 +AY+VMQJOL5jaSejJsGunF6zMZc+2RzWh2YPdu2w4rjTBm3O48z4WQw6x9yhL1hPI8
	 XLt3LA5uibv0Q==
Date: Thu, 29 Feb 2024 06:47:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, arkadiusz.kubalewski@intel.com,
 jiri@nvidia.com, "abdhalee@linux.vnet.ibm.com"
 <abdhalee@linux.vnet.ibm.com>, "mputtash@linux.vnet.com"
 <mputtash@linux.vnet.com>, "sachinp@linux.vnet.com"
 <sachinp@linux.vnet.com>, venkat88@linux.vnet.ibm.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [revert 0d60d8df6f49] [net/net-next] [6.8-rc5] Build Failure
Message-ID: <20240229064742.36c2f476@kernel.org>
In-Reply-To: <CANn89iKdaMFCKnGRL4ffnbyrr2PUaKn1hoiu4VZ=sRyX=Vy0Wg@mail.gmail.com>
References: <3fcf3a2c-1c1b-42c1-bacb-78fdcd700389@linux.vnet.ibm.com>
	<85b78dad-affa-47c3-9cd0-79a4321460b8@linux.dev>
	<CANn89iJEzTjwxF7wXSnUR+NyDu-S-zEOYVXA+fEaYs_1o1g5HQ@mail.gmail.com>
	<a1fdd2c2-4443-458e-86db-280e7cbd4a36@linux.vnet.ibm.com>
	<CANn89iKdaMFCKnGRL4ffnbyrr2PUaKn1hoiu4VZ=sRyX=Vy0Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 09:55:22 +0100 Eric Dumazet wrote:
> I do not see other solution than this, otherwise we have to add more
> pollution to include/linux/netdevice.h

Right :(

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index a9c973b92294bb110cf3cd336485972127b01b58..40797ea80bc6273cae6b7773d0a3e47459a72150
> 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2469,7 +2469,7 @@ struct net_device {
>         struct devlink_port     *devlink_port;
> 
>  #if IS_ENABLED(CONFIG_DPLL)
> -       struct dpll_pin __rcu   *dpll_pin;
> +       void __rcu *dpll_pin;
>  #endif

If DPLL wants to hide its type definitions the helpers must live
in dpll? IOW move netdev_dpll_pin() to drivers/dpll/dpll_core.c

BTW Tasmiya, please do tell us what compiler you're using.

