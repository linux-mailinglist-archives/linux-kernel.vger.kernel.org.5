Return-Path: <linux-kernel+bounces-165683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B0A8B8F74
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4935B2209A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB881474C2;
	Wed,  1 May 2024 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrzVktVy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79232C85;
	Wed,  1 May 2024 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714587498; cv=none; b=RK2jZaSZje/QjLC0XJX8k+yYF9S71p0DSFWBYexzP/UMxMB1j2EP8TbfDjbYV2r1ASBgawRK6zDGb+D+uZ34MEezU5Zl7zIIcCJkJU8q473/lAakptq8E3DxicmZ+/rTOYaUkdmS7uYKDHzpLmHuqQcGRcO6Av0Z3DUngRc+jpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714587498; c=relaxed/simple;
	bh=WvJq9FDvKw1T+G2vJPo+DezC/KFVp+K/oL+4ylnz11A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDdx29I4Sk2SyWi023Zg1eQeHjAI5Wz60qdNE0z7mX8C/pBB8HyUhov0FacVt7GR2IWb77/a6WM0O7Bc4x9zPDM4JFFoUpdxKYN6+gXBf8flGDHQfVFHu7hY7s5qt6oslTmT2O3GBj+T+v3m1jjZB0FeUvvvDqSOlhVbF5HvuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrzVktVy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B450C072AA;
	Wed,  1 May 2024 18:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714587497;
	bh=WvJq9FDvKw1T+G2vJPo+DezC/KFVp+K/oL+4ylnz11A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrzVktVy6XfU5QEK0jZbvUf5pYafo8aqld2C/2kt2C5GU/GenHq6WU/PhLF9nNJPV
	 Fj/gFz/jMoBL+9YMXWSDONIDaCHb/YO3VsleGGdEI0UCJxjyCIcwBseqKIJX9QXBt6
	 oXm6PTpSw3StI7IOmFXgKHhuo02U6QsALvOwa+ShhL2oSf2BCvbwpKfDe5yVtvN2MK
	 zFecNBC+v9h/0hpZPBT48lPIbqQ3eAzsB/2QEutlAKaB4mlx+H9++fwvp8MLoye2ex
	 fEkAQpJ5tcTEkukOIu1ZKSntffAUupz2SCBO1wJ+LTDyPgpe4e3B6GA2QQ24NAoz53
	 4p41078oX9mdg==
Date: Wed, 1 May 2024 19:18:13 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v3 3/9] octeontx2-pf: Create representor netdev
Message-ID: <20240501181813.GY2575892@kernel.org>
References: <20240428105312.9731-1-gakula@marvell.com>
 <20240428105312.9731-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428105312.9731-4-gakula@marvell.com>

On Sun, Apr 28, 2024 at 04:23:06PM +0530, Geetha sowjanya wrote:
> Adds initial devlink support to set/get the switchdev mode.
> Representor netdevs are created for each rvu devices when
> the switch mode is set to 'switchdev'. These netdevs are
> be used to control and configure VFs.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Hi again,

I missed the following when preparing my previous email.

..

> @@ -113,6 +162,7 @@ int otx2_register_dl(struct otx2_nic *pfvf)
>  	devlink_free(dl);
>  	return err;
>  }
> +EXPORT_SYMBOL(otx2_register_dl);
>  
>  void otx2_unregister_dl(struct otx2_nic *pfvf)
>  {
> @@ -124,3 +174,4 @@ void otx2_unregister_dl(struct otx2_nic *pfvf)
>  				  ARRAY_SIZE(otx2_dl_params));
>  	devlink_free(dl);
>  }
> +EXPORT_SYMBOL(otx2_unregister_dl);

otx2_devlink.o is linked into both rvu_nicpf.ko and rvu_nicpf.ko.
The two exports above result in the following errors when building
with allmodconfig on x86_64

 ERROR: modpost: drivers/net/ethernet/marvell/octeontx2/nic/rvu_nicvf: 'otx2_register_dl' exported twice. Previous export was in drivers/net/ethernet/marvell/octeontx2/nic/rvu_nicpf.ko
 ERROR: modpost: drivers/net/ethernet/marvell/octeontx2/nic/rvu_nicvf: 'otx2_unregister_dl' exported twice. Previous export was in drivers/net/ethernet/marvell/octeontx2/nic/rvu_nicpf.ko

..

