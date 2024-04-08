Return-Path: <linux-kernel+bounces-135560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7D89C796
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4811F229F7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517AC13F42D;
	Mon,  8 Apr 2024 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nok+zJAZ"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE1126F07;
	Mon,  8 Apr 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588141; cv=none; b=BL1xTUx5OvG2s7puZaiPm5RK+unA5T+HrzpizYwQlC3aPHmmABYSyyRlh6zTQc0U1wJNSvnvZlHhD6m8ujrIsSvjm/5m2nw7DZZmu8swVefyXjXeI2FTHruMxG/8y7s5MHQ3RdbiDYFPylFcbszzmG8eNU0zd7n+b+5wY0EUUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588141; c=relaxed/simple;
	bh=Ov2BcR6+Z6HnKIgx85TjUBUXWlTdUZPqGxh8lge3WGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfS2BYkyxcdHh7C6nNHP1+/JB7EUnj/MW1lqLSSMCfHQWuArs7IMFQUkQ4fuqCYvt02QYXg2FNYG5EXMHkg/WL53dEoJ0Joa8hHXcZCt1yHdbyhBjgwbGn6pQ7pQDQVK5HBGRPglykA0/w9YLRH8jlRIdIuMkSYFmqesAO+I5TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nok+zJAZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1PBTRz03aq88OrjremWvkNYUDAiOv89NpdJyRW1vn4c=; b=nok+zJAZaWJpfupGZrseZ3Tvqk
	44R0VF4WDwybUX+9OHmLLkPeWjf9bSv/+o7QqaXHJ1qMYpeyKBSZY9LTrQlV1lr86ftHWcT29r65m
	YQwwPiuybeZ0X7NCN4RrzfoNeQ0/A4330dbcx3gGV3EIynt+43Vz7AphalzRBTEtlHW0v97cEq8Gp
	gT70fcGaXcg0/R3VENuMDAOMOIu5zFiVMsv2Ut2aCUgFJj3UelenHeQLFRiZ6asMtFJgssbQX/8Zd
	XAM7neTYwWs4gLnfy38iu7Nnxg5UAI5dT8VC6gnIZqmbVeIDYiPpA7v0pC5LS1698kQ73wX2gWuQu
	nJqas7XQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35728)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rtqP9-0005JN-1h;
	Mon, 08 Apr 2024 15:55:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rtqP1-0004EI-I3; Mon, 08 Apr 2024 15:55:19 +0100
Date: Mon, 8 Apr 2024 15:55:19 +0100
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
Subject: Re: [PATCH net-next 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Message-ID: <ZhQFV7I3EwW7FV+H@shell.armlinux.org.uk>
References: <20240408125340.2084269-1-danieller@nvidia.com>
 <20240408125340.2084269-8-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408125340.2084269-8-danieller@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Apr 08, 2024 at 03:53:37PM +0300, Danielle Ratson wrote:
> +/**
> + * struct ethtool_cmis_cdb_request - CDB commands request fields as decribed in
> + *				the CMIS standard
> + * @id: Command ID.
> + * @epl_len: EPL memory length.
> + * @lpl_len: LPL memory length.
> + * @chk_code: Check code for the previous field and the payload.
> + * @resv1: Added to match the CMIS standard request continuity.
> + * @resv2: Added to match the CMIS standard request continuity.
> + * @payload: Payload for the CDB commands.
> + */
> +struct ethtool_cmis_cdb_request {
> +	__be16 id;
> +	struct_group(body,
> +		u16 epl_len;

u16 with a struct that also uses __be16 looks suspicious.

> +		u8 lpl_len;
> +		u8 chk_code;
> +		u8 resv1;
> +		u8 resv2;
> +		u8 payload[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH];
> +	);

Does it matter if the compiler inserts some padding before this struct
group?

> +/**
> + * struct ethtool_cmis_cdb_rpl_hdr - CDB commands reply header arguments
> + * @rpl_len: Reply length.
> + * @rpl_chk_code: Reply check code.
> + */
> +struct ethtool_cmis_cdb_rpl_hdr {
> +	u8 rpl_len;
> +	u8 rpl_chk_code;

Does it matter if the compiler adds some padding here?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

