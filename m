Return-Path: <linux-kernel+bounces-91587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B466A8713FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4806E282800
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A1C2941F;
	Tue,  5 Mar 2024 02:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as7SqSZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E45C28E23;
	Tue,  5 Mar 2024 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607457; cv=none; b=o+YXHoN8Q2wB/zxfiOpSfiD0CBVfussk6l1YKnmQ6lxL+Wgq5Wk90qUQzqwJr60yaRHIovc+we/RFvfV3jl0n3I0fDWvVqyeDSKbtDzmmfzvnVFKGkVtHX6+qzS+goggJwgXq2RatvEyib5rkgLNDW5ZNU8SmMD9p9P5EN1mnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607457; c=relaxed/simple;
	bh=kZqURoLm0kLX1tTQOFfPyfMVa+A+jJvcucLvnQPNpu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNpAZ4wXKlnuhsb1emzypUno4I7GrlJSWxDX3Wtp9qyepathTbz+7ospSGKRTrsmjBz8P98qVkXkBZdutNhR1oYvpYlKLBq7hWMXBjOv33mIs5MdJMiYBtT4L8aqNQSerM7Iy80JpV5BpAMUymKy3EWl57JTBWym7HjjX+FoxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=as7SqSZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE26EC433F1;
	Tue,  5 Mar 2024 02:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709607457;
	bh=kZqURoLm0kLX1tTQOFfPyfMVa+A+jJvcucLvnQPNpu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=as7SqSZmwRTcTVUYzqUQhO7JRz02GyGml4FrhVWj/NlBBCpjcRcdPS5qFn+uf35Ti
	 haO2FZifwhg7YoTdByrF9HGjHk2Q0hg1ROyQs0LEkvdDTVzz6w1ASvN7oVEMIjmv8Y
	 GunlzrNGHJMmBbmF0eulR3utsanV98ZmnCCkYiwnZY0d+l3WQ0ANWB8ELec0PT0GL4
	 4ANFm3mF03k2Bt85PU/OVff7HgJoheJXIrnqm+Rq6a+1XkolrBfvXrjsi5xya0PDzF
	 FZmzfbNLV2M4UVjwTOyIhDANEwensN+cxBWrkwJLRfLMR5E71Bbr2Lh7BQzfH1zuY9
	 0FHHv2+j07YbQ==
Date: Mon, 4 Mar 2024 18:57:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v9 08/13] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Message-ID: <20240304185734.5f1a476c@kernel.org>
In-Reply-To: <20240226-feature_ptp_netnext-v9-8-455611549f21@bootlin.com>
References: <20240226-feature_ptp_netnext-v9-0-455611549f21@bootlin.com>
	<20240226-feature_ptp_netnext-v9-8-455611549f21@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 14:39:59 +0100 Kory Maincent wrote:
> Prepare for future hardware timestamp selection by adding source and
> corresponding pointers to ptp_clock structure. Additionally, introduce
> helpers for registering specific phydev or netdev PTP clocks, retrieving
> PTP clock information such as hwtstamp source or phydev/netdev pointers,
> and obtaining the ptp_clock structure from the phc index.

Can we assume there's one PHC per netdev?
We both store the netdev/phydev info in the ptp clock
and ptp clock in the netdev. Is there a reason for that?

