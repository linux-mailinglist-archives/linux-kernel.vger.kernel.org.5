Return-Path: <linux-kernel+bounces-15044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CE182269E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE99D1C21B8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B9B139F;
	Wed,  3 Jan 2024 01:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fmys2pX3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8D1365;
	Wed,  3 Jan 2024 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=brZ7JXAC7jui/xfNaqc5Z1H36T4Tr46rZP4DUHfhpL4=; b=Fm
	ys2pX3ODCTgSErILCBvtJ0ESmOhSgbSCsnI+miReduAbuaFONtSEzr9i9yBWkf2QujV17XMfFR9vV
	awLuTOOoIATq2UrVwTET47G9Zmubk01oydLu/nC3xvHO+YbDMl6y3S5XYyj0e0zqY0mRMsl5/YrZD
	YvvfC3PY1mB9xCg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rKqGl-004Dcr-4N; Wed, 03 Jan 2024 02:42:07 +0100
Date: Wed, 3 Jan 2024 02:42:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?B?U2FuanXhbiBHYXJj7WEs?= Jorge <Jorge.SanjuanGarcia@duagon.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"s-vadapalli@ti.com" <s-vadapalli@ti.com>,
	"grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] net: ethernet: ti: am65-cpsw: Add device tree
 property to set max MTU
Message-ID: <285f6402-db06-462b-9ca5-8363027283e1@lunn.ch>
References: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
 <20240102081825.14635-4-jorge.sanjuangarcia@duagon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240102081825.14635-4-jorge.sanjuangarcia@duagon.com>

On Tue, Jan 02, 2024 at 08:19:15AM +0000, Sanjuán García, Jorge wrote:
> The switch supports ethernet frame sizes between 64 and 2024 bytes
> (including VLAN) as stated in the technical reference manual.
> 
> This patch adds a new devicetree property so the switch ports can
> be configured with an MTU higher than the standar 1500 bytes, making
> the max frame length configured on the registers and the max_mtu
> advertised on the network device consistent.

Why do you need a device tree property for this? How many other
drivers have a device tree property like this? Why not set
ndev->max_mtu to 2024 minus overheads?

	Andrew

