Return-Path: <linux-kernel+bounces-94774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74175874519
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCCB285CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390FE139F;
	Thu,  7 Mar 2024 00:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0X3QnOym"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB9336C;
	Thu,  7 Mar 2024 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709770780; cv=none; b=eukQlphtSufvw/pfMVyCAHpEvow1E/3FlVpDaVGNWVEmLbajDPEYwhIEtLI1V1hVh+9CzkEllehEWU9qOGfvaCsa0TQk3N5gwK28CLb5/3OZWAOIAn3PlaiZoCFmnF8R99RNUonpo/nbkrD5KwZhfjDtjkW4W8iaBIxBZUzsrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709770780; c=relaxed/simple;
	bh=igeX+dtlvpZvheeyhlJx/Zlz+N19RU9rqrY0FQ0MO+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0GvQHUORVE7yHruGvvGevIVBzYeTkj63yR/wMqkKnjo86vMhhTwZkcxVfHoYSntdZE58VmbKKHwsF+qLxzKsuf5crjdiGZTYp1mVBxAGukM3GZ2RiY959TuuDTpHD+tqQ/evXPQFgd7PiJw/pCjsB1DUC0wUOQlahCUD3zH1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0X3QnOym; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7QT0gBy9zGeu+xPHf2pGjhnuveV+gws6pSxdSpEf34U=; b=0X3QnOym49VvL5poDUUua87KpY
	zIfFc3eXicEaBSGUMfM3IV5VtRFzBtzFB5HK9/EcOaSuIH4+7ZTOMwDbc3CBZlz3wWq1Z4IQyGuDc
	5a0jsKrgej1J3goKHqUnDp+FdDj3bMPXKQtZr0SPLksNP4znAcrWsZ4oNuTAI69XdSTs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ri1UG-009Xho-A7; Thu, 07 Mar 2024 01:19:52 +0100
Date: Thu, 7 Mar 2024 01:19:52 +0100
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
Subject: Re: [PATCH net-next v3 03/12] net: ethernet: oa_tc6: implement
 register read operation
Message-ID: <48b65759-6e69-46ef-a2ed-857d04eadac8@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-4-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306085017.21731-4-Parthiban.Veerasooran@microchip.com>

>  enum oa_tc6_register_op {
> +	OA_TC6_CTRL_REG_READ = 0,
>  	OA_TC6_CTRL_REG_WRITE = 1,
>  };

I thought it looked a little odd when the enum was added in the
previous patch with the first value of 1, and only one value. Now it
makes more sense.

The actual value appears to not matter? It is always 

> +	if (reg_op == OA_TC6_CTRL_REG_WRITE)

So i would drop the numbering, and leave it to the compiler. The
patches will then look less odd.

> +static int oa_tc6_check_ctrl_read_reply(struct oa_tc6 *tc6, u8 size)
> +{
> +	u32 *tx_buf = tc6->spi_ctrl_tx_buf;
> +	u32 *rx_buf = tc6->spi_ctrl_rx_buf + OA_TC6_CTRL_IGNORED_SIZE;
> +
> +	/* The echoed control read header must match with the one that was
> +	 * transmitted.
> +	 */
> +	if (*tx_buf != *rx_buf)
> +		return -ENODEV;

Another case where -EPROTO might be better?

	Andrew

