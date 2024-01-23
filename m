Return-Path: <linux-kernel+bounces-35763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCE0839626
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6769B284D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3147B7FBCA;
	Tue, 23 Jan 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ws1srwvS"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1687FBB0;
	Tue, 23 Jan 2024 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030276; cv=none; b=BSxrSwOsSa2Z2j5FTXuMR1Ey0i8SeGG/F5XjqeYePhL4TiAmOn0z0VHse2F8XSrX3452lHTnCV102xEhGN9ePspdhCsR2w8Xq37ox2Lmm3s/aEFak4M3P7Ql+sA2wBgCOBToe3Xd9ppvmGvbT3bWmi4RTwp55CUFrHrIQblPKkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030276; c=relaxed/simple;
	bh=/TkEZGFcHQF2SIiCdN4cqab8TBirBALqNgIZyTdGwp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5rG61q/nIhaxS83Paw+U/v3BpTQA0G+MIobxcyy4mc5JswB0zov2qI2C53LmoI5e4dQfxgx03qn7mrv1XUuKl35/q+YiBi5MzcRErWCh8Xq+zMqjFum8xfSQoRt23x/9TkIt4XHrkKQH6o6qgHnMwtEmw2oKL+0s7DaoOEHdlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ws1srwvS; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g/GuoEY/EPrX7DEIHhw/ru6Y5B3PMqs71NqVwZgK7L8=; b=ws1srwvSVwAbX+58wsAnsp9QmK
	0GbH8Y7Dv3Is5d5JMI98TT5hz3xSsHdyRjUZGanaPdCbrCxTkWUs/7fOk68ek4/Oh79HwrVeZkhen
	ZzHzdEDHTJS4hu+sNMq3svWpwIofFsUq2vZ5UbDtfYs9b43JTzOYf1jKWA3D4A5vVzYRozcZOtizQ
	3vTyrNXsdPrzWm3VqEDZEpkYXSnTWgtUvootyJCsK8Etqwl5tdJ5KSkqc3dgm/7Nr9dy8IqUg1RbD
	2UOdNBIX7Ee1aHtymlIMYYE9sMuif1n1gz/AKkcRqbkVpwD7XbUq/8GTy54VvJtCf+sbFlnQqRFqQ
	Ri1ugUjA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47320)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rSKPE-0002pb-2k;
	Tue, 23 Jan 2024 17:17:48 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rSKPC-00027Y-96; Tue, 23 Jan 2024 17:17:46 +0000
Date: Tue, 23 Jan 2024 17:17:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, sdf@google.com,
	kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
	vladimir.oltean@nxp.com, przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com, richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [RFC PATCH net-next 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Message-ID: <Za/0um6oUo3CQaR2@shell.armlinux.org.uk>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-8-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122084530.32451-8-danieller@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 22, 2024 at 10:45:28AM +0200, Danielle Ratson wrote:
> +int ethtool_cmis_page_init(struct ethtool_module_eeprom *page_data,
> +			   u8 page, u32 offset, u32 length)
> +{
> +	page_data->page = page;
> +	page_data->offset = offset;
> +	page_data->length = length;
> +	page_data->i2c_address = ETHTOOL_CMIS_CDB_PAGE_I2C_ADDR;
> +	page_data->data = kmalloc(page_data->length, GFP_KERNEL);
> +	if (!page_data->data)
> +		return -ENOMEM;

Hmm, so every use is forced to use kmalloc() even when it's just one
byte? That seems rather wasteful.

> +/* See section 9.4.1 "CMD 0040h: Module Features" in CMIS standard revision 5.2.
> + * struct cmis_cdb_module_features_rpl is structured layout of the flat
> + * array, ethtool_cmis_cdb_rpl::payload.
> + */
> +struct cmis_cdb_module_features_rpl {
> +	u8	resv1[CMIS_CDB_MODULE_FEATURES_RESV_DATA];
> +	__be16	max_completion_time;
> +};

Does this structure need to be packed? I would suggest it does to
ensure that the __be16 is correctly placed after the 34 bytes of u8.

Overall, I think the idea of always kmalloc()ing the data is a bad idea
at the moment. We have no implementations that DMA to/from this buffer,
and it means extra cycles spent, and an extra failure point each time
we want to do a CMIS command.

It also introduces extra complexity, where we could just be passing
a pointer to a function local variable or function local structure.

Unless we decide that the data pointer should be DMA-able from (in
which case, that needs documenting as such) then I would suggest
getting rid of the extra kmalloc()...kfree() bits.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

