Return-Path: <linux-kernel+bounces-94782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F8C87452D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7454287168
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B6D3FEC;
	Thu,  7 Mar 2024 00:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V7Pm346G"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC6A21;
	Thu,  7 Mar 2024 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709771714; cv=none; b=WzaSlQIN0WRt9QYoBHgnjR/wtH+UjToYwjcxFRrsQoTQOm+QPfwB4Krqc3T7LKfxAXSGm1YgzILLVucrwywi2TSBpR57v34NQKehEq5XqxUQQdOtEghEZYdjRnPwzyYSqRv6HKvZxBzbVXFs2oGnCp2Bnmi4RG7SDN6LgEgXxHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709771714; c=relaxed/simple;
	bh=J2ieNpnYRjeck4oIq7yW7s+dh9dPDWpwIC/GAtYgbks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbT4sYn4l2RftkX8ZAe73TzNuy0x+dDvzOkY5PHgaSlZl3YjvrxqaCGRh2B6H5GL6gF/rdO0XvhUCDaAYjlW91rg6RocQNKhPidC4EFIrKuld2TR6jM/ri1EoLUg155kyuVVu2KpAORe9+r8NAUdr5MexmjcxopSjHSXz4cSXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V7Pm346G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ql4Cc0GtaCc5nuWW16/Qsukf8zJx8Z4gJkIgxE8Q64E=; b=V7Pm346GnV8zMd37NBFEOPXge0
	1/lLMCbdYjyjd/sA99Mdgvxc5ad6BFj6n6QoBbOS1ggHBSzry4Vd+pQqsEUrVpT41XrPzLipsMG3V
	+bx1texl9B1LZDUbKkXfQtEHi6UOUiPdGtr4TX7zA3E3rGlVuoBOCTWUKMXTnTeoOENc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ri1jN-009XlY-3Q; Thu, 07 Mar 2024 01:35:29 +0100
Date: Thu, 7 Mar 2024 01:35:29 +0100
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
Subject: Re: [PATCH net-next v3 04/12] net: ethernet: oa_tc6: implement
 software reset
Message-ID: <4e56f5c2-3d5c-4dda-8a37-01c1dbce27d7@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-5-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306085017.21731-5-Parthiban.Veerasooran@microchip.com>

> +/* Status Register #0 */
> +#define OA_TC6_REG_STATUS0			0x0008
> +#define STATUS0_RESETC				BIT(6)	/* Reset Complete */
> +
>  /* Control command header */
>  #define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
>  #define OA_TC6_CTRL_HEADER_WRITE		BIT(29)
> @@ -24,6 +34,8 @@
>  						(OA_TC6_CTRL_MAX_REGISTERS *\
>  						OA_TC6_CTRL_REG_VALUE_SIZE) +\
>  						OA_TC6_CTRL_IGNORED_SIZE)
> +#define STATUS0_RESETC_POLL_DELAY		5
> +#define STATUS0_RESETC_POLL_TIMEOUT		100
>  
>  /* Internal structure for MAC-PHY drivers */
>  struct oa_tc6 {
> @@ -279,6 +291,39 @@ int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address, u32 value)
>  }
>  EXPORT_SYMBOL_GPL(oa_tc6_write_register);
>  
> +static int oa_tc6_read_sw_reset_status(struct oa_tc6 *tc6)
> +{
> +	u32 regval;
> +	int ret;
> +
> +	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &regval);
> +	if (ret)
> +		return 0;
> +
> +	return regval;

The function name does not really fit what the function does. The
function returns OA_TC6_REG_STATUS0. I assume it has more bits in it
than just STATUS0_RESETC. So either this function should be called
oa_tc6_read_status0, or you should mask regval with STATUS0_RESETC, so
that it does actually return the sw reset status.

> +static int oa_tc6_sw_reset_macphy(struct oa_tc6 *tc6)
> +{
> +	u32 regval = RESET_SWRESET;
> +	int ret;
> +
> +	ret = oa_tc6_write_register(tc6, OA_TC6_REG_RESET, regval);
> +	if (ret)
> +		return ret;
> +
> +	/* Poll for soft reset complete for every 5us until 100us timeout */

Is this 100us defined in the standard? It is pretty short. If it is
not part of the standard, maybe set it to something much bigger?

Also, polling every 5us is pretty quick. I doubt most systems can even
sleep that short a time. So maybe 1ms between polls, and 1 second
before -ETIMEDOUT?

> +	ret = readx_poll_timeout(oa_tc6_read_sw_reset_status, tc6, regval,
> +				 regval & STATUS0_RESETC,
> +				 STATUS0_RESETC_POLL_DELAY,
> +				 STATUS0_RESETC_POLL_TIMEOUT);
> +	if (ret)
> +		return -ENODEV;
> +
> +	/* Clear the reset complete status */
> +	return oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, regval);

	Andrew

