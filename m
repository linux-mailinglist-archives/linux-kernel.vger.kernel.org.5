Return-Path: <linux-kernel+bounces-154204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270DD8AD940
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A839E28345C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0D845BF1;
	Mon, 22 Apr 2024 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kp2/rg91"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8221C287;
	Mon, 22 Apr 2024 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829408; cv=none; b=BCojFzX4cbI8tVMGGR+CMLwcDhgXOlZjQVQ/Xvxb7k9l/U/tOvf5xlY/TY29duRhpsok++SFXNuRwKacfNeoNUn6hsR2qFN3mSxNN4tzSa7TcAHLg7wHifDh+kwvtJCKsFdQYSCAVG5dA9jMuyzqaX8JUKFolePEAynuQ5ckNcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829408; c=relaxed/simple;
	bh=hgTV12rvvAxuPjT7U1DK4mDFOpELr+YjSRDMnEIMAG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=losvpZWVLuOM9SpAfCzOUpHzDqYExactE1YE5YOXIzp1CnUCtddq6GKxIE/WJGjf4svOsjJtlCdMQExHZUhjrzYZqp+aTGBXF/5GKg8/3t7H1XiFEyf4uDF9S/DzyPGHlJdkQes9md03HsQQOLUGlNt3dzWuQYVUkp0nv+BqZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kp2/rg91; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/5dxVdkbXUlP8Fri7+a5GHxcDX18ViLtZfG+NQBl9ss=; b=kp2/rg917Jfco9rnHzTSnXqdbu
	HBOdwMobaH9cF0bfrhWjk0Ij6IAeFwcWMSciRqnM12aYP6azsdr4VSL/rwAdMlKz9mN+o41jduG8v
	QBa7zCxJoD5enoSu9V0+4btsqGCKio7L+6AidJRruoBaVyzI+RPS5gCrl/tkfw8X6awc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rz3Jb-00Deww-LK; Tue, 23 Apr 2024 01:43:15 +0200
Date: Tue, 23 Apr 2024 01:43:15 +0200
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
Subject: Re: [PATCH net-next v4 00/12] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Message-ID: <5201c27d-a534-4d29-8c71-d54a2646edff@lunn.ch>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>

On Thu, Apr 18, 2024 at 06:26:36PM +0530, Parthiban Veerasooran wrote:
> This patch series contain the below updates,
> - Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
>   net/ethernet/oa_tc6.c.
>   Link to the spec:
>   -----------------
>   https://opensig.org/download/document/OPEN_Alliance_10BASET1x_MAC-PHY_Serial_Interface_V1.1.pdf
> 
> - Adds driver support for Microchip LAN8650/1 Rev.B1 10BASE-T1S MACPHY
>   Ethernet driver in the net/ethernet/microchip/lan865x/lan865x.c.
>   Link to the product:
>   --------------------
>   https://www.microchip.com/en-us/product/lan8650

The patchset did not apply cleanly to net-next:

https://patchwork.kernel.org/project/netdevbpf/list/?series=&submitter=206056&state=*&q=&archive=&delegate=

Which means it did not get any of the standard automatic testing :-(

      Andrew

