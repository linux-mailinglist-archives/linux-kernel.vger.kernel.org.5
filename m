Return-Path: <linux-kernel+bounces-36492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB5E83A1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D62E1F245F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EADA101CA;
	Wed, 24 Jan 2024 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="In7+ica4"
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1370D308;
	Wed, 24 Jan 2024 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075813; cv=none; b=QJf+s928x74LGlkUxFmilKuPczXE0Vx1xpuvRdvL/O0sfGFHVKMXhBUUSLp1rHOB/AmPolb9/4TqtEN4VUVar+KRN5Lkg4Yw60OyPZ9VpgZPMA+aIz+GQyqjSXf9swJ/yO816aDmPU6Oxpyt0nsxwXGdlJVNYkYfSwoKXl6+yHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075813; c=relaxed/simple;
	bh=WkkVH6MZ9Ei/ds3QjmKHNo/z+L5Xn6aFoSNurUu4m4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=lAEyD1SaGLB/cyI3wJ1DT/+szB/jFJqmneIqottLoKBvUOOoT8ZOiwBVoOGoV1ao8HF8UZVGEnyab2NUEUyzAJj4tixbbswlc4opBFSyuYMz9/20eHsk+gkm3YLIbUnvj1/156UTDnLlivTZb7Y2kmg4aBNyljGILwsqu3xt/ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=In7+ica4; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id SWFarRZez8jVDSWFarqsnB; Wed, 24 Jan 2024 06:56:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706075802;
	bh=g0PHiMiElhrW6soL6QZ3bDs9/Q+9VEvAsCekTMuIHKE=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=In7+ica4uVuNs9ushLtua0BX9YGc5x3ELrA7TG7V1NfNWpaJS8I4emw0dhbluV5NR
	 IOYz+3rwVI75dfhPKdiwqcnr7ADc1TvWwt08J5aiS85Tc+HXHqSp5id8eU3myridRW
	 bYHGvyZBLpp/nyxJtoYL1jNlOHjWcE+si2MaKy94nQkW/+2AnhRClDOhf5+UKKuSA8
	 wfmi4YaPiEpYVo5A8aZjnFqEI/uxbrEI1P87X4D2Y8O5L8ZfBVRJt9zgMm6MYhysaL
	 eN3RMvYvO80GSRLXub9KfGyHTqi+Ig0nk9rorf8dmqszJ1LYhktkRYx0Pgbelj1TnA
	 CrLkeBcgb9EsQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Jan 2024 06:56:42 +0100
X-ME-IP: 92.140.202.140
Message-ID: <e2d00e0f-0211-43c6-a868-7a36655847ab@wanadoo.fr>
Date: Wed, 24 Jan 2024 06:56:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] ixgbe: Fix an error handling path in
 ixgbe_read_iosf_sb_reg_x550()
To: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
References: <d39bbffb8817499cc2ae636cdef3b9c1eba59618.1705771534.git.christophe.jaillet@wanadoo.fr>
 <CYYPR11MB8429776D3D1D830E140F5D64BD7B2@CYYPR11MB8429.namprd11.prod.outlook.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Mark Rustad <mark.d.rustad@intel.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
In-Reply-To: <CYYPR11MB8429776D3D1D830E140F5D64BD7B2@CYYPR11MB8429.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 24/01/2024 à 05:00, Pucha, HimasekharX Reddy a écrit :
> Hi,
>
> Can you share testing hints for this patch.

Hi,

No I can't.

It was spotted by one of my cocci script that tries to find issues 
related to direct return when a function also has an error handling path 
+ manual review so see if it looks like a real issue.

As said in the patch, "This patch is speculative, review with care.". 
That means that it was not tested from my side.
I don't have the hardware, and don't know how to trigger the issue.

All I know is that the code looks wrong *to me*.

Maybe someone at intel.com could give this hint? :)

CJ


> Regards,
> Himasekhar Reddy.
>
> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Christophe JAILLET
> Sent: Saturday, January 20, 2024 10:56 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Jeff Kirsher <jeffrey.t.kirsher@intel.com>; Rustad, Mark D <mark.d.rustad@intel.com>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>; intel-wired-lan@lists.osuosl.org; kernel-janitors@vger.kernel.org; linux-kernel@vger.kernel.org; netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()
>
> All error handling paths, except this one, go to 'out' where
> release_swfw_sync() is called.
> This call balances the acquire_swfw_sync() call done at the beginning of
> the function.
>
> Branch to the error handling path in order to correctly release some
> resources in case of error.
>
> Fixes: ae14a1d8e104 ("ixgbe: Fix IOSF SB access issues")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative, review with care.
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> index 6208923e29a2..c1adc94a5a65 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> @@ -716,7 +716,8 @@ static s32 ixgbe_read_iosf_sb_reg_x550(struct ixgbe_hw *hw, u32 reg_addr,
>   	if ((command & IXGBE_SB_IOSF_CTRL_RESP_STAT_MASK) != 0) {
>   		error = FIELD_GET(IXGBE_SB_IOSF_CTRL_CMPL_ERR_MASK, command);
>   		hw_dbg(hw, "Failed to read, error %x\n", error);
> -		return -EIO;
> +		ret = -EIO;
> +		goto out;
>   	}
>   
>   	if (!ret)

