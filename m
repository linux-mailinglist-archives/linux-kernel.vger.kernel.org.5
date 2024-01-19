Return-Path: <linux-kernel+bounces-31228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA150832ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F0E1F2568E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F74E52F94;
	Fri, 19 Jan 2024 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dRit8dWf"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353451C58;
	Fri, 19 Jan 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705672533; cv=none; b=YOZhu6tFtjdORSr5xvlmsowkyJry2P2lMyktKEAjE1YuS7aDXigFb78f51pyJfb07mMZXhHYGKP7YlGGoyqWDIcOHya0CdHHd0dCcaoVTTYNrx2RjYg9CFUTsQjeAvZjfPkpfXS9gXE+6P6cqX8nzqI2UJE7YbN5bT8lk3+gC8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705672533; c=relaxed/simple;
	bh=LyIQY1yLmMCzSBVpBqm9/JFsE9KeHDEBVBV7Xf+LJGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g93KCiOrjBOBC3Ac9gAU2vOSzy04dpktTTHy7D3JLeYojJ+GHAAudLsl5JQyregC4smZLHPWD2kzOuFri6MXH9wP6zWQfv+wHU7zluGL2S1i8OBbqemjdJGbdev0LhbwaodaQJSBOdo1/7azDoMBo0E0RTb8PUXXxH7SJ66wymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dRit8dWf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=skaTrSJoGr5je0d0+ifzxX2E8sgZBBRCDqE/kQ39ges=; b=dRit8dWfQ4NVAxSNdkyw9rG0vP
	pp/lsE2CNpxrr40AoigbgsUjdkh1ZE1eJIBVEjXr5Ubxt8lpoaKl7hfnYT3k3SDE+Y8+OdF4yFWcR
	68Xdax9i4BVM5zFxPbDv7lnlcWodGZdELO1yGjmCGn44+WfZ2b/lEGMAo353RIm5/SoU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQpKu-005Ywd-4s; Fri, 19 Jan 2024 14:55:08 +0100
Date: Fri, 19 Jan 2024 14:55:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
Subject: Re: [RFC PATCH v2 1/3] net: ti: icssg-prueth: Add helper functions
 to configure FDB
Message-ID: <a9c18466-7d7d-4a63-8096-d832bd9e455f@lunn.ch>
References: <20240118071005.1514498-1-danishanwar@ti.com>
 <20240118071005.1514498-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118071005.1514498-2-danishanwar@ti.com>

> +int icssg_fdb_add_del(struct prueth_emac *emac, const unsigned char *addr,
> +		      u8 vid, u8 fid_c2, bool add)
> +{
> +
> +	for (i = 0; i < ETH_ALEN; i++)
> +		mac_fid[i] = addr[i];

ether_addr_copy()

> +
> +	/* 1-1 VID-FID mapping is already setup */
> +	mac_fid[ETH_ALEN] = fid;
> +	mac_fid[ETH_ALEN + 1] = 0;
> +
> +	fdb_slot = bitrev32(crc32_le(0, mac_fid, 8)) & PRUETH_SWITCH_FDB_MASK;
> +

> +	fid_c2 |= ICSSG_FDB_ENTRY_VALID;
> +	memcpy(&fdb_cmd.cmd_args[0], addr, 4);
> +	memcpy(&fdb_cmd.cmd_args[1], &addr[4], 2);
> +	fdb_cmd.cmd_args[1] |= ((fid << 16) | (fid_c2 << 24));
> +	fdb_cmd.cmd_args[2] = fdb_slot;

> +int icssg_fdb_lookup(struct prueth_emac *emac, const unsigned char *addr,
> +		     u8 vid)
> +{

> +	for (i = 0; i < ETH_ALEN; i++)
> +		mac_fid[i] = addr[i];
> +
> +	/* 1-1 VID-FID mapping is already setup */
> +	mac_fid[ETH_ALEN] = fid;
> +	mac_fid[ETH_ALEN + 1] = 0;

> +	memcpy(&fdb_cmd.cmd_args[0], addr, 4);
> +	memcpy(&fdb_cmd.cmd_args[1], &addr[4], 2);
> +	fdb_cmd.cmd_args[1] |= fid << 16;
> +	fdb_cmd.cmd_args[2] = fdb_slot;

Maybe add some helpers to reduce the amount of duplicated code?

      Andrew

