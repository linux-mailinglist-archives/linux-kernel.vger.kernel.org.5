Return-Path: <linux-kernel+bounces-56243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B1284C7CF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B122282D80
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729C23741;
	Wed,  7 Feb 2024 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+OpaAY4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BE0224CC;
	Wed,  7 Feb 2024 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299173; cv=none; b=HyvTI10p8b5WOstY+Xrpj3Kx5LKm1OPMubIxfGC1qy5dTHDz2loPqo+e33P0lhtFXAzU7m759nRx8E5Js10/y0iWcvR8j6ffQFIri19GtdzZqg/KBDZTueJ8rYTtNXqquhKkWVBM6ojwery+4R2aBeikWbU7GPhVqJQr+piQdNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299173; c=relaxed/simple;
	bh=hkrf29qHJozatNFewJsMGAqd91LzfIcTuGK9E1t1LtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gskgXwy990quUu91Z5VrI3qqUlzbTn5xuTWuy+sdFFGQdJdWDnA8fT0CEaTylqzgZbu+6p8bintpBu4NUc1vrVMDSMJAmELMYEd6iMhcq5HAsIUz+36E//apaSpm83Sg52MyMSENdaW7/zLxvbIjrY4uTzc+RL81Zo5I3D/d/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+OpaAY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4457CC433C7;
	Wed,  7 Feb 2024 09:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707299173;
	bh=hkrf29qHJozatNFewJsMGAqd91LzfIcTuGK9E1t1LtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+OpaAY4HT4KwIzZQl8KtgYFQiSKDgvJH5Z8iTfZHwDywdRqNtQgDAl1NRhx57Rrf
	 wWMvDfmwVdEWa2BfaVK8o9bh9F0LPOHFxar91VFDB2oG4Vd6KePKtqdfHvDayK0L1m
	 LFT0Hxc38QuIQmkjmjqqQe9ygWc/8BZmmdT39Yl74oi8e1JTjYfQIXcw/UBOTMrDKZ
	 4r80d3LYaQQitMU8/E66IfRD6qTPwa3RU0rr1P2X6PEY0bYPECMv1JcZXttLgYUl+M
	 0hh9o/H7lOzqeq0oa0XvDDbx6MOo6LPom4lhhBtFMsOegHFhiSRNajAzRVYBhHcKQq
	 ay5kPd7s5tbJw==
Date: Wed, 7 Feb 2024 09:46:09 +0000
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] netxen_nic: remove redundant assignment to
 variable capability
Message-ID: <20240207094609.GN1104779@kernel.org>
References: <20240206115049.1879389-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206115049.1879389-1-colin.i.king@gmail.com>

On Tue, Feb 06, 2024 at 11:50:49AM +0000, Colin Ian King wrote:
> The variable capability is being assigned a value that is never
> read and is being re-assigned later. The assignment is redundant and
> can be removed. Also remove empty line before assignment to capability.
> 
> Cleans up clang scan build warning:
> drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c:1189:2: warning:
> Value stored to 'capability' is never read [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
> index 35ec9aab3dc7..51fa880eaf6c 100644
> --- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
> +++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
> @@ -1186,7 +1186,6 @@ static int
>  netxen_p3_has_mn(struct netxen_adapter *adapter)
>  {
>  	u32 capability, flashed_ver;
> -	capability = 0;

This part looks correct :)

>  
>  	/* NX2031 always had MN */
>  	if (NX_IS_REVISION_P2(adapter->ahw.revision_id))
> @@ -1197,7 +1196,6 @@ netxen_p3_has_mn(struct netxen_adapter *adapter)
>  	flashed_ver = NETXEN_DECODE_VERSION(flashed_ver);
>  
>  	if (flashed_ver >= NETXEN_VERSION_CODE(4, 0, 220)) {
> -

This part doesn't seem strictly related to the patch description.
But in looking at it more closely, I wonder if it would be good
to reduce the scope of capability to this context (and leave the bank
line).

>  		capability = NXRD32(adapter, NX_PEG_TUNE_CAPABILITY);
>  		if (capability & NX_PEG_TUNE_MN_PRESENT)
>  			return 1;

In any case, I agree that this patch is correct, and I'm happy with
it with or without the change I suggested above.

Reviewed-by: Simon Horman <horms@kernel.org>


