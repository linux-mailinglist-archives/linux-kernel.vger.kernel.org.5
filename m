Return-Path: <linux-kernel+bounces-97593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB52876C48
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30841F21D50
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46005F84B;
	Fri,  8 Mar 2024 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3k/WFpg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2609217745;
	Fri,  8 Mar 2024 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709932393; cv=none; b=ucZMAmUSuohPw/60GZudTBM5MpRtNtD4A7xRCdwsBc9JOA5o+MdzNn4695nygOBFc/LbH9AL1t4QL5+SJzZFaZXYoorKk6ITqJ5QvDXrNTEyeT2Mmd+Pu/eeEfoe/VViT2mzUKVMGes0Cn8uYxEbiyZ2xPvUw7bd7GMq7WdjNaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709932393; c=relaxed/simple;
	bh=Cl/9Sp/NINGtvBYYiSrwF+QPSh3NMkkxwESwsbvSXak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVfymHcQmo9IXXtnIQyAxDZbwlTY5RClnsRBNixmOYNSgojQG63N2eU/Hcn6MMI7V1ky4/LCWSAFl9qtePs+lxLutoZvYFLVr0pwUa9ufUJlR7nX/qwVg1jqHvSRdvIvkpVkk9WVDOxvHWXBGQKroP2Q9hEvbBd+KzbG5JWcqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3k/WFpg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B78C433C7;
	Fri,  8 Mar 2024 21:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709932392;
	bh=Cl/9Sp/NINGtvBYYiSrwF+QPSh3NMkkxwESwsbvSXak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3k/WFpg5OC+DFozK8WwA9u1toMKDEt7mS4BOsCZBggUwISOFws3qP2Zo3W4At62A
	 M01+5T1KwTrBO2Wbv6ps0axa0muQKblUlWQimJzXUKeDGi29jp2GhnA+o2mlZsvvN4
	 9xDY3a9v11lws7MbmYh88KwtZbkAMC5AEuMEYpolYE303RIg3Nx/UDdRdHaclwfJ1Q
	 kajW1QH04Tt/NfBcG0qC7uWe05M+/M7PV5vyK7rdHl8N4L/4XPclPpRpEixKMfDinD
	 vpLHwROOhhG8fYdOTkR38MZMhanKrDQjtE8LFVsuqTsoibumL46BbxDu068MiATv/O
	 3o4uX44uvKFIQ==
Date: Fri, 8 Mar 2024 15:13:10 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Conor Dooley <conor@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <20240308211310.GA1291632-robh@kernel.org>
References: <20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com>
 <20240308-asrc_8qxp-v6-3-e08f6d030e09@nxp.com>
 <20240308-croon-goofball-797d091e981a@spud>
 <ZethoKhsUZ08HHL0@lizhi-Precision-Tower-5810>
 <ZetzOu+SqmLQfsOs@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZetzOu+SqmLQfsOs@lizhi-Precision-Tower-5810>

On Fri, Mar 08, 2024 at 03:21:14PM -0500, Frank Li wrote:
> On Fri, Mar 08, 2024 at 02:06:08PM -0500, Frank Li wrote:
> > On Fri, Mar 08, 2024 at 04:58:16PM +0000, Conor Dooley wrote:
> > > On Fri, Mar 08, 2024 at 10:30:52AM -0500, Frank Li wrote:
> > > > Some sai only connect one direction dma (rx/tx) in SOC. For example:
> > > > imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
> > > > for dma-names.
> > > > 
> > > > Remove description under dmas because no user use index to get dma channel.
> > > > All user use 'dma-names' to get correct dma channel. dma-names already in
> > > > 'required' list.
> > > > 
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > 
> > > Please drop my ack from this, this isn't the patch I acked originally
> > > and we were having a conversation as recently as yesterday on v4 about
> > > this patch because Rob didn't like this approach. His suggestion is
> > > better than the one I gave on v4 that you have used here.
> 
> I paste your comments here
> 
> "What I suggested is different, it is more permissive than what you have
> or what Rob suggested. Your original one allows
> "rx", "tx" OR "rx" OR "tx"
> Rob's allows the same but with a nicer syntax. What that stm binding I
> mentioned allows is
> "rx", "tx" OR "tx", "rx" OR "rx" OR "tx"
> "
> 
> Actually:
> 
> "rx", "tx" OR "tx", "rx" OR "rx" OR "tx" is exactly what we want.

No, it is not.

> "rx", "tx" OR "rx" OR "tx" is only feasible, but not perfect. Why need
> limited "rx" and "tx" order? 

First, that's exactly what the binding already had. Why loosen it? 
Second, defined order is just the DT way. There is less reason to 
support both ways. It is simpler for a client to read properties if it 
knows the position of entries.


> It just bring us some noise and no actual
> value to do that.
> 
> Frank
> 
> 
> > 
> > Why do you think Rob don't like this approach? He just said this is 3rd
> > method. And it is simple enough and match all restriction.

I don't like the approach. Clear enough?

Rob

