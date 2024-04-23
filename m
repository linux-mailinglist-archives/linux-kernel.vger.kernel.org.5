Return-Path: <linux-kernel+bounces-155996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DC18AFC7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17717283A45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8CD3E470;
	Tue, 23 Apr 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wR2tz+Z6"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10B44366;
	Tue, 23 Apr 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914237; cv=none; b=dNAN+bS2WN/l+KGxIYMW7UgNV46xZUEpDKXXVq+6pEuvAGC6kMX70CnIjhutHAQ4oIB+Cw64ryNZmSJs4NiheyIGk6h2L2oOURVlq/dyApwY53ttq1SVwwSDuMTHg6NmBW6vkVpjYdgO85JY2WZrjgmG/vXJqZ7yj2xK9vOrkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914237; c=relaxed/simple;
	bh=6tt29QpRIkzCTP0vI3/A7kHdomrFExRog0V0dqNWXIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5ajIP4kiHhCZPxX/AuxlTfJyfDv5vlxaA/G2U3XC0fkmbsLoQcPWKP5+QnMF73KGkLEon3StN5tX3Gip23OOP9cNLudsX0qTCJMUF93T/BIdeLBnGl+cBdXCn1jUbeIpQMRklSSikGHHpKwig/H3QYgXuBCFEO7ngPVwZz/8lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wR2tz+Z6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yo/azk6enc6QmwwKUibOlX+VM7LeQmslPJZahnN5aqM=; b=wR2tz+Z6rOsIhlAh2C8zyt4AyE
	B5C/Ihh2Dk3qdhGcp2LNYv4c5DCJ6UGk42dmHyITb+mIY37uIwSKDLjDzd4qegOHxWK+QKQuJel5F
	z2E26InckLGbSQQDThYfVjIwiaxzpHrQOG/hOFu5bNfcL6ZAaSfKIMZSJUjaUSe3SRXo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzPNo-00Dl1S-Ul; Wed, 24 Apr 2024 01:17:04 +0200
Date: Wed, 24 Apr 2024 01:17:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 03/12] net: ethernet: oa_tc6: implement
 register read operation
Message-ID: <cfe4a1f4-df6e-4ac7-bd2d-1f8429af29e2@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-4-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-4-Parthiban.Veerasooran@microchip.com>

> +static int oa_tc6_check_ctrl_read_reply(struct oa_tc6 *tc6, u8 size)
> +{
> +	u32 *tx_buf = tc6->spi_ctrl_tx_buf;
> +	u32 *rx_buf = tc6->spi_ctrl_rx_buf + OA_TC6_CTRL_IGNORED_SIZE;

Reverse christmas tree. Those two need swapping around.

	Andrew

