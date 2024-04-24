Return-Path: <linux-kernel+bounces-156041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0FF8AFD0E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDF62840AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C931C14;
	Wed, 24 Apr 2024 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="C0BEo15Q"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699C3193;
	Wed, 24 Apr 2024 00:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916971; cv=none; b=IGohGt1BUeWHK7qU9Zq7nhM5TEDbKYgE53mN2xwcrUWSauuLzbrDESDrk47hhgfpeFAOzKfuPVgdSbqiW8ykkutHS5k9x00AuT/NvXMs/Wu1W0QJCJKpbjCerkEM5mwd+H9dfOXyshoMh8GpE3QprBAtOmpS7W1XyOmPF5MiShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916971; c=relaxed/simple;
	bh=zvEIcMVTlwJZSglb1GiKi9TnhASLIxAL9lSNUP9cJFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDoNDcPO+mxgn2TnALIBNzB7yV1TbQI1sNdkm3VTO0ZDLLlqRB91i0+WpRx+FRTN6U48syqnU/q9b4itNWGtwcj0hddAl5FeV2xWnARHjTBfAZUzbeEONK4fJRSa556tgI8hr6yJxlJAbekudSI12r1QPUsWmjEGu9JNpvcrX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=C0BEo15Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=L/ug2r4EVbSkWdawJ0j/nghtH+tymAoyGiGC07jOBcA=; b=C0BEo15Q9n41MglXN7Nc441kp3
	Wjld1mD32vxcmfyS9ftxL9uaoaTenHu1cxmy3tSSmRkkIT90sj0gUR547uxUVRWcOypLMw3ntjG0d
	P55ZuaelFIfdoHaIYaBsmodQRUF0UuwKu63Rz8vHFtT/m5cBUTfz3S0p7jOud7MFRWI0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzQ5u-00DlJY-U9; Wed, 24 Apr 2024 02:02:38 +0200
Date: Wed, 24 Apr 2024 02:02:38 +0200
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
Subject: Re: [PATCH net-next v4 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Message-ID: <460a42cf-2b67-49f5-be4d-fcce6c824ba6@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-9-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-9-Parthiban.Veerasooran@microchip.com>

> +static int oa_tc6_process_extended_status(struct oa_tc6 *tc6)
> +{
> +	u32 value;
> +	int ret;
> +
> +	ret = oa_tc6_read_register(tc6, OA_TC6_REG_STATUS0, &value);
> +	if (ret) {
> +		netdev_err(tc6->netdev, "STATUS0 register read failed: %d\n",
> +			   ret);
> +		return -ENODEV;
> +	}
> +
> +	/* Clear the error interrupts status */
> +	ret = oa_tc6_write_register(tc6, OA_TC6_REG_STATUS0, value);
> +	if (ret) {
> +		netdev_err(tc6->netdev, "STATUS0 register write failed: %d\n",
> +			   ret);
> +		return -ENODEV;

More examples where you replace one error code with a different one.

     Andrew

