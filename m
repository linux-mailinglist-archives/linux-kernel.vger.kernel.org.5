Return-Path: <linux-kernel+bounces-147362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B7D8A72F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717261C217FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEF8135A69;
	Tue, 16 Apr 2024 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UoK8ibTI"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82215134CD0;
	Tue, 16 Apr 2024 18:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291539; cv=none; b=UJDYqA+IzvtgyBlPPl88CecDRr8D0KPCT9dr7d4KATtguZzNhHfwrJUb5bBEpt7DHuIp3bj9mCguRlT4x09Lh+291joy3s801YFo3tfnaK+Xwt8wIPmgnJkps+lXfMbJUL7NAxaxh7MD04uTQExFqyxyUZ4UN/5dlXiHfg8GXog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291539; c=relaxed/simple;
	bh=b8lvL9NZew815z7UQj8VRuFSqjRmCSD7OcL9Id2dkB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTpQnzdebsh/hzsAeO6K65fjJd4v85sdjT8UcZEM0IbkStsQ63QjYR57rDb4lC3+s0VUTgBNvTwQkRaD4rLE8W7mfUrPDFSnZjVAoXIcbVRCVfQHfE22gstb4cQJQMfGR8mnvebRDobxaJjNytfbDDSQIXzPi7unoh9KyfE3VnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UoK8ibTI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IJtSvi5devvC9L1eX50DCm36YklubqRumK1P8fx4YOA=; b=UoK8ibTI6a9OA/iKMvvm+u23B8
	jhD/eq0oeaNxg/BaMPkbw8KSC/bQvnRS53bnIemDyRG4Z6X/fy4sAAB7dLvo3Ccnk/iAojxu1N75a
	rgp85eFzsGj92uzTSC5txCEaAZeOf2fUHn0eartoPoyFqFJ9dk6ewWUi1FTRpBQXXZbs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rwnOB-00DARl-KL; Tue, 16 Apr 2024 20:18:39 +0200
Date: Tue, 16 Apr 2024 20:18:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, Horatiu.Vultur@microchip.com,
	ruanjinjie@huawei.com, Steen.Hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 06/12] net: ethernet: oa_tc6: implement
 internal PHY initialization
Message-ID: <af6d3a74-7e7b-4953-bba7-f9ceb26df2d3@lunn.ch>
References: <20240306085017.21731-7-Parthiban.Veerasooran@microchip.com>
 <8c2b95f4-75a7-4d6d-ab9c-9c3498c040d8@lunn.ch>
 <eeb57938-e21e-406d-a835-93c6fb19b161@microchip.com>
 <7ddbe599-187e-401f-b508-4dc62bca8374@lunn.ch>
 <e9bc573e-61f0-484a-b1fb-b5100eb9ee0a@microchip.com>
 <8de7a4bb-a127-4771-97dd-038f08fcce9d@lunn.ch>
 <372a45c3-1372-4956-8d42-8e989f86d131@microchip.com>
 <ee5dcd07-7c44-4317-9d62-0fc68565988a@microchip.com>
 <3fc3b5c3-0750-4aff-ab26-240f4bc55236@lunn.ch>
 <5100ab9d-1b70-46fb-b3ba-d4bcff6d6870@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5100ab9d-1b70-46fb-b3ba-d4bcff6d6870@microchip.com>

> I tried this approach and it works as expected. Means whenever there is 
> a c45 register access, it directly uses the 
> oa_tc6_read_c45()/oa_tc6_write_c45() functions. Herewith I have attached 
> the patch 
> (v4-0006-net-ethernet-oa_tc6-implement-internal-PHY-initia.patch) which 
> has this new implementation for your reference. Is this you expected? 
> Can you comment on this?

Please just post a new patch series. I will then review it just like
other patches. Its O.K. to send patch series frequently, not just more
than one per day.

> I tried this approach by setting up is_c45 flag when I use 
> phy_read_mmd() function but ended up with the kernel call trace 
> (c45_kernel_call_trace.png) attached here for your reference.

Please post plain ASCII. I assume you have a serial port, so you
should be able to capture it. I'm not too surprised though, no other
driver plays with is_c45.

       Andrew

