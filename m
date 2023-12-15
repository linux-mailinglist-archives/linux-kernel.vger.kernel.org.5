Return-Path: <linux-kernel+bounces-1023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D5C814960
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F90D2848C6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D5E2DB9D;
	Fri, 15 Dec 2023 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bNZEm07B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB72DB78;
	Fri, 15 Dec 2023 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5y1ia7oRbdSD4fUrEMlezsZFcNEy3zWEND9kRt4dvuw=; b=bNZEm07BYacmWsRZeP4QS/Ug9b
	3aAk0DlLpVeRUAQ20+xFQQMv0z8EIRaL2uRX1gY+8RGtr0kq2km9hHrxdwTluiDUIRSkZV1uqgjPo
	MbAdtefUc4NaeilPCP8Mc6aL0RwsVGZ0Ey7WJHeWJ+XovpW44odrcMtOJFilB/mhm/5U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rE8LA-0031gt-F5; Fri, 15 Dec 2023 14:34:56 +0100
Date: Fri, 15 Dec 2023 14:34:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v3 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Message-ID: <83ea51ac-e976-44b6-ad5c-f11661646671@lunn.ch>
References: <20231214090304.16884-1-quic_luoj@quicinc.com>
 <20231214090304.16884-6-quic_luoj@quicinc.com>
 <1e4c55c8-8ed6-4f2e-8328-8a173f09b62f@linaro.org>
 <3c8e33b4-6ebc-476f-a00f-15cc8a1ad9e4@quicinc.com>
 <b89abf8c-57f8-46a6-a071-b1591340fbdf@linaro.org>
 <3de98516-9a28-4f58-8951-2a7752621fee@quicinc.com>
 <1fa2d219-63d7-45cf-9e05-b85dbce24076@linaro.org>
 <f16dfe78-2e31-45fb-b2fe-f72b7e6c51a5@quicinc.com>
 <6acecb29-2a6c-40af-a5a3-bec3e7286df7@linaro.org>
 <6e5b6ab5-fc89-4986-894a-62af08343859@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e5b6ab5-fc89-4986-894a-62af08343859@quicinc.com>

> These properties "reset-assert-us" and "reset-deassert-us" are the
> general properties from mdio.yaml, which are used when the MDIO
> bus driver is registered by the MDIO framework.
> The general DT property already supports to do the correct config,
> then compatible string is not needed to be checked for doing the
> configs.

Given the complexity of your device, i doubt you can make it work
without using a compatible containing the ID register values. That
will get your driver loaded, and the probe method called which can
then deal with all the clocks and resets in whatever way it wants.

    Andrew


