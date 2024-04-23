Return-Path: <linux-kernel+bounces-156030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AB28AFCDD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72792B24667
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEADC502B3;
	Tue, 23 Apr 2024 23:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zpqagFdY"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF2B10949;
	Tue, 23 Apr 2024 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916183; cv=none; b=LFrW1ZGdAo2mZ8zLdL0ANLkwp7BOy5VT6waJJxrAzF9LCetuht7YXE/BrTAEmV7CVaLW/PW9xz22UrtKe/dT54iRhC4aFGWvPZ4IqsM6z2sm9NrBJonZil/CVsBI+TY0XM4UxFneSNQUoxRgObXBsb1HuJu0ew5lDAi5V84Gibw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916183; c=relaxed/simple;
	bh=i0T3iIuV6PoxWDJyBn/iZdSogce/hukTHjNMuRoBxzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8VSBprVMZ7sMi82VBNGweZa30nf/a4Ce8tJc7gGkj70F3yXb32dG5XP8jgaFHciSupu8ZiZVfFAnWMKtndl6H3RGX8/H3zxZdxtKYYQNgo/8XLwZUdQvuMu8i3sqeWUtWfXePNKQegTjqqXhufD5oZzd1h/7T+9WoDtMcwBjpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zpqagFdY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9OOPH5bU5DXeITmtGQhGlq5vN3KlVC4zryvPwQK8Oo4=; b=zpqagFdYHBkIM/5JXfzx1DqerZ
	4LJE0iiSEIntOgPBMGAEsybfrtgPBfwKbXOGY2DfGIX70hyLBWlKU1p26N3Oj6arAeqwEfoe44MMy
	6aWwphGa7YiWhLa2LXKyo1Iqi4AjKgxXgffAyNSKa05kboNVwRMk7c+7SkvtiX/z1Ufo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rzPtE-00DlEr-1w; Wed, 24 Apr 2024 01:49:32 +0200
Date: Wed, 24 Apr 2024 01:49:32 +0200
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
Subject: Re: [PATCH net-next v4 07/12] net: ethernet: oa_tc6: enable open
 alliance tc6 data communication
Message-ID: <8b006123-695c-4cd3-8ee1-f62a1caef4c6@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <20240418125648.372526-8-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-8-Parthiban.Veerasooran@microchip.com>

On Thu, Apr 18, 2024 at 06:26:43PM +0530, Parthiban Veerasooran wrote:
> Enabling Configuration Synchronization bit (SYNC) in the Configuration
> Register #0 enables data communication in the MAC-PHY. The state of this
> bit is reflected in the data footer SYNC bit.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

