Return-Path: <linux-kernel+bounces-148985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3E18A8A19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B461C23887
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCDF17167F;
	Wed, 17 Apr 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="UBIdhrcf"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC016FF48;
	Wed, 17 Apr 2024 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374442; cv=none; b=RD6Lc7CvY8OdsBxaMxQFJ+6lVjd2YURKZpHF+FtLsYnuL6BMr0wk9oEi5lIV7J4o6U3kmoSzFrnnF5xkg5JJGue/7P4KGUX5+RgtTeerOBHQC3psGJNqZcMHAYVPBba3KGRRI0lvj0EvTquVbughXwUq4QJ8yK1GMfeVwUH+FiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374442; c=relaxed/simple;
	bh=Kv5FPRBx5aI4mDE57tTTrqSLGgwSbiupSBg9tz9cq3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOKD5d507/fIekJZmk7dgSicboaJN6s6bnqhXupHgr8o0LFVg3vbExdJug8wiZM87E4XlbzH/FlrxGIkk8H46CeIO3QOjbl5LlfnNPfe/Dq72d9/sZp05Pc9lwVdYHQs4B9rN1GHTuANGhLigR1LBsPOc8lzARJpttzMcQ3E3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=UBIdhrcf; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 5E7E81FE67;
	Wed, 17 Apr 2024 19:20:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1713374435;
	bh=CcpFXlllLfas3Vp8HTMypgb0mIEXJNssixFuak86tvw=; h=From:To:Subject;
	b=UBIdhrcfKD/1kNjDhFs790ModI2esqNg9lKcIYrtVdtg0l4RCNWdHOXChg4WYtHsB
	 iVH5kUoThuwE59U13LFf5kUYHko8RmRQ0zcJYmYx0K2Eu7pOuTAQl97G77BbprjUub
	 P/H4dOIoiVMF/XwA3X7tkd6MwiYOiZrUdlmeTooLBMKe5H0NwWmzpDcV5yvEnv48lH
	 /8MGuHe13KCUTcZL78J7vcA0wCJf435bhUf2acDSxKhbYuJz0nEpFYSE57w+ZDxN7F
	 cfYCoXTsgMWopx6+VRfGnh2yOxes+q8xexhmpzR6oCsJQktnwcej/B05bmkbpQMiP0
	 CpScNnQO2Gx9w==
Date: Wed, 17 Apr 2024 19:20:31 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.li@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] arm64: dts: imx8qm-ss-audio: add audio nodes
Message-ID: <20240417172031.GA4100@francesco-nb>
References: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
 <20240415-dts_8qm_audio-v1-2-2976c35a0c52@nxp.com>
 <20240416065026.GA4165@francesco-nb>
 <Zh/yZ2HyF+G8bty7@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh/yZ2HyF+G8bty7@lizhi-Precision-Tower-5810>

Hello Frank,

On Wed, Apr 17, 2024 at 12:01:43PM -0400, Frank Li wrote:
> On Tue, Apr 16, 2024 at 08:50:26AM +0200, Francesco Dolcini wrote:
> > On Mon, Apr 15, 2024 at 03:46:38PM -0400, Frank Li wrote:
> > > Add i.MX8QM audio related nodes and update eDMA[0,1]'s information.
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi | 473 +++++++++++++++++++++
> > >  arch/arm64/boot/dts/freescale/imx8qm.dtsi          |  86 ++++
> > >  2 files changed, 559 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi
> > > new file mode 100644
> > > index 0000000000000..ed5a1b4af1d76
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-audio.dtsi

..

> > > +/delete-node/ &acm;
> > > +/delete-node/ &sai4;
> > > +/delete-node/ &sai5;
> > > +/delete-node/ &sai4_lpcg;
> > > +/delete-node/ &sai5_lpcg;
> > 
> > Can you explain these delete-node ? This is something that I would
> > expect when a dtsi is previously included, not in this case.
> 
> We want to avoid some property inherent from parent dtsi file because it is
> big difference with common one.
> 
> This node will be rewrite totally in this files.

imx8qm-ss-audio.dtsi does not include any file. From where these
inherited properties are coming from? Which file is the "parent dtsi" ?

Thanks,
Francesco


