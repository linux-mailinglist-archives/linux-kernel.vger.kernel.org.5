Return-Path: <linux-kernel+bounces-35644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB178394A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B0901F2A91A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0CC664D2;
	Tue, 23 Jan 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NI4hsxKU"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DE64A87;
	Tue, 23 Jan 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027288; cv=none; b=tWGgfosFVBBQ+rF09aBVr8y/dQtLQZC6ZltYKjHHlT4KDa4y1bR+H0v0RL8kOQZc/4RgAxrXBK8RT9/St+vZa5hk5YSmV8YArBiGEcCLHS8nMRkWYC5nI5IQJmdqkjKBRl/mvnMFqZylWfm5biii8YuiN40e5pHIEe810ueck6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027288; c=relaxed/simple;
	bh=PdJbj62zZvQxQ7woeaJi+WZHiLkY7K6WdOhj8taHFiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvjblLlAHtFsajMggQ8Z+sJwL/zalbKhONAWBQOdeNiy07gr/sM0BZGzk9WIMOkk51gIXnDdkF1aogejDlCR6griiWVWB5ZrgddKiJ2tetpxhl2+vMlyVzc/O0lIWblqR+zoPtXwBkcbKqps4+DxLYd5g1y/iz48+gM6ZVWgLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NI4hsxKU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tLucNN4+6wCQPeQRbR2eAzPwSGxPFsnr3HAlAXB473E=; b=NI4hsxKU9HsvHXdGCa3OmKc0DY
	5c8bKndK2L2rO0cOP3NPN+WCcnR7OsTJcoz82KEwQeWD0wf2Qk1Imi30V3b0jtgDBbE1NQmFfNQwK
	Z3cuXewKqXGidPGWCL5eBg4lEugxFuqaMJ1klsviS1b/jpeM5bfPQp2OJPM1ut9QpB23jNKuWtlit
	9cxfBP8U2u+HvwqSGisT0f3CrmDsc3DKfLiNRvaC/qxgQdKN+ndXTxY7hHLcmiK4GRqgvDbAgd3ba
	gnXhnhywIXk4o/0ZHxSstYJUuWebLUhioZd+k+FnWNxkZytTC3VuesZbk3he/XHvzz9FGRbQUrPC6
	CK9Oh3WA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38376)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rSJcw-0002jc-0i;
	Tue, 23 Jan 2024 16:27:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rSJcq-000256-JW; Tue, 23 Jan 2024 16:27:48 +0000
Date: Tue, 23 Jan 2024 16:27:48 +0000
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
Subject: Re: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Message-ID: <Za/pBGBB3H+VEbX8@shell.armlinux.org.uk>
References: <20240122084530.32451-1-danieller@nvidia.com>
 <20240122084530.32451-10-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122084530.32451-10-danieller@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 22, 2024 at 10:45:30AM +0200, Danielle Ratson wrote:
> +#define MODULE_EEPROM_PAGE	0
> +#define MODULE_EEPROM_OFFSET	0
> +#define MODULE_EEPROM_LENGTH	1
> +#define MODULE_EEPROM_I2C_ADDR	0x50
> +
> +static int module_flash_fw_work_init(struct ethtool_module_fw_flash *module_fw,
> +				     struct net_device *dev,
> +				     struct netlink_ext_ack *extack)
> +{
> +	const struct ethtool_ops *ops = dev->ethtool_ops;
> +	struct ethtool_module_eeprom page_data = {};
> +	struct module_sff8024_id_rpl *rpl;
> +	int err;
> +
> +	/* Fetch the SFF-8024 Identifier Value. For all supported standards, it
> +	 * is located at I2C address 0x50, byte 0. See section 4.1 in SFF-8024,
> +	 * revision 4.9.
> +	 */
> +	page_data.page = MODULE_EEPROM_PAGE;
> +	page_data.offset = MODULE_EEPROM_OFFSET;
> +	page_data.length = MODULE_EEPROM_LENGTH;
> +	page_data.i2c_address = MODULE_EEPROM_I2C_ADDR;

Please use better names - these aren't any better than using integers.

Maybe use SFP_PHYS_ID for the offset?

> +	page_data.data = kmalloc(page_data.length, GFP_KERNEL);
> +	if (!page_data.data)
> +		return -ENOMEM;
> +
> +	err = ops->get_module_eeprom_by_page(dev, &page_data, extack);
> +	if (err < 0)
> +		goto out;
> +
> +	rpl = (struct module_sff8024_id_rpl *)page_data.data;

What purpose does this structure of a single byte serve? To me, it just
obfuscates the code.

	u8 phys_id;

	...
	page_data.offset = SFP_PHYS_ID;
	page_data.length = sizeof(phys_id);
	page_data.data = &phys_id;
	...
	switch (phys_id) {

will work just as well, and be more explicit about what's actually going
on here. It doesn't mean that I have to understand what this new
module_sff8024_id_rpl structure is. I can see that we're just getting
one byte which is the module physical ID.

You also then don't need to care about kfree()ing one byte of data
structure.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

