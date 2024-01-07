Return-Path: <linux-kernel+bounces-18953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FCD82659C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8693528153A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E7B10A36;
	Sun,  7 Jan 2024 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CNd4uLQZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1610A1B;
	Sun,  7 Jan 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3ITLUw3/wwzNbCgnrBc39myl7J+F3NZ5Z7SwgjR2fQQ=; b=CNd4uLQZPqShcuU+wNi7F7AamO
	TJ50Wk/4AoY4GAayKb6qKIen+J3kf1sMDWzFNwkEiTJncIBb/JBcjnKAnMRoZkQWH/6cs+Y8TSZQg
	IV/+I6GhLRGCUGX8AnZjObGq5zVrHF/XnzKDlkQUIhq6Mqk6i93h+NO30OHI3hpohq2w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rMXwB-004aDT-G4; Sun, 07 Jan 2024 19:31:55 +0100
Date: Sun, 7 Jan 2024 19:31:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Vladimir Oltean <olteanv@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Luo Jie <quic_luoj@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [net-next PATCH RFC v3 1/8] dt-bindings: net: document ethernet
 PHY package nodes
Message-ID: <1437d9df-2868-43f5-aebd-e0c57fe4d905@lunn.ch>
References: <20231126015346.25208-1-ansuelsmth@gmail.com>
 <20231126015346.25208-2-ansuelsmth@gmail.com>
 <0926ea46-1ce4-4118-a04c-b6badc0b9e15@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0926ea46-1ce4-4118-a04c-b6badc0b9e15@gmail.com>

> And I would like to ask you about another issue raised by Vladimir [1].
> These phy chips become SoC with all these built-in PHYs, PCSs, clocks,
> interrupt controllers, etc. Should we address this now? Or should we go with
> the proposed solution for now and postpone modeling of other peripherals
> until we get a real hardware, as Andrew suggested?
> 
> I'm asking because it looks like we have got a real hardware. Luo currently
> trying to push QCA8084 (multi-phy/switch chip) support, and this chip
> exactly contains a huge clock/reset controller [2,3].

Ideally the reset controller is modelled as a Linux reset
controller. The clock part of it is modelled using the common clock
framework. When done correctly, the PHY should not really care. All it
does is ask for its clock to be enabled, and its reset to be disabled.

Also, given how difficult it is proving to be to make any progress at
all, i want to get one little part correctly described, the pure
PHY. Once we have that, we can start on the next little part. So long
as we keep to the Linux architecture of blocks or hardware with
standard Linux drivers, and DT to glue them together, a small step by
step approach should work out.

     Andrew

