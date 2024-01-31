Return-Path: <linux-kernel+bounces-46674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAAE8442FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 719AAB32CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731A130E50;
	Wed, 31 Jan 2024 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmmMSc85"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A2882867;
	Wed, 31 Jan 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713059; cv=none; b=Bf1OIluT3V6Ku6ePvKVNJVcFMTK9DBd/35GPyi96Jqu90ctHqWlRBH2Gw8F41/vojDosqGCB11sJKXYy2LpDy4NqhCJJtZUnyV6kCJOg6NFyAUPOGuct4iHm7M1qFC7YB4Pry/SKkB5VFDhNAgtZI35ANstdNC5WgmCMmIG5HYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713059; c=relaxed/simple;
	bh=DSXbRtBgFN5juM7kQqtXWqBYab5ClaoWzkuVt0en0dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8tJajBxgpg/bMCUsj4wNwz35VNHa9pBm83/c2KCy1/3A5HcdyKwGfOc07VrwIyCMPvEoFycxL1iFcs5LrX5SaIPbOj2xd3LF8JdjGstM+Wk4EMi3ef3qP/YJ/4NLbLYIsiv6liiuaDe96vuSOD/DCmmtGzMYPAsU481Ct+6f4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmmMSc85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183A2C43390;
	Wed, 31 Jan 2024 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706713058;
	bh=DSXbRtBgFN5juM7kQqtXWqBYab5ClaoWzkuVt0en0dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RmmMSc85ShOqr63dLFwsLGZY/jvhJfq4jS8LzT4gzw1psoP4jPSLtwmtSciTu/FvS
	 f14lUbpZuZYBJ61g4R2J+aWSqwzjsuNJBNivXQKqgFtMm4khJK/xPuQqOdJxhjk2Mz
	 lMlt1RLdi0lH3cxUwU9ElMs3w9Iuyp/PicZZ3NYaFiTLfzSS6RXGLXOHR0bYRirp1q
	 dPaYl6GAI/d28r7WXs6CEuRiTxW/OHPfX4isHWdZ9fJ7z/37ZKHWF4Gx4ISI+VJK7S
	 2k1LkXVGAGKZqiURv5NeMcogz+/XPXTfhjNyM5L/kG1Ipzd7Vo3Kh3JcpWvSO9xgsb
	 83A/AC1N5l51g==
Date: Wed, 31 Jan 2024 08:57:36 -0600
From: Rob Herring <robh@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"wg@grandegger.com" <wg@grandegger.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatible
 string
Message-ID: <20240131145736.GA1262278-robh@kernel.org>
References: <20240122091738.2078746-1-peng.fan@oss.nxp.com>
 <20240122-skilled-wimp-4bc1769bf235-mkl@pengutronix.de>
 <20240122125631.4c54eba1@kernel.org>
 <DU0PR04MB941750744E86A1656009B7BE88742@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB941750744E86A1656009B7BE88742@DU0PR04MB9417.eurprd04.prod.outlook.com>

On Tue, Jan 23, 2024 at 07:00:27AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatible
> > string
> > 
> > On Mon, 22 Jan 2024 11:26:25 +0100 Marc Kleine-Budde wrote:
> > > > Add i.MX95 flexcan which is compatible i.MX93 flexcan
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > >
> > > Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > 
> > Hm, you don't apply CAN DTB patches?
> 
> Nope. I am preparing dt-binding first, then post the i.MX95 SoC
> dtsi. The CAN will be in the i.MX95 SOC dtsi file, not a
> single patch only for CAN node.

The question was why isn't Marc, the CAN maintainer, applying this. I 
have the same question.

Rob

