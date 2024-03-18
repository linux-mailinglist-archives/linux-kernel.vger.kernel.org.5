Return-Path: <linux-kernel+bounces-106090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F9E87E8D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B0D1C21A63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8767376EB;
	Mon, 18 Mar 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="n/fH8NiQ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42ED37162;
	Mon, 18 Mar 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762308; cv=none; b=W6aPJAeMRYZ1eW3G2kwVz0d2rQT455mJFJX/Fxij2PCzNEtBs+SKtmXoP/S0LtpVIYX+qQb4PtrD6eIxQX+zKrFaJOM0AaJtlo/7j0R7A0sH3zhD1/Xe0OIwq3KnVy3Ecq4f2v/ckgUQP+8pe/z1f45DU4n75Acx6GviYuKYmR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762308; c=relaxed/simple;
	bh=Z6e/dx3z6MMy8O96IuhwbQHPUp+vdWCxe6wanqtKCcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byqiTjwNMTPd8gxiFKjf9Pa39ThoNIqf3dzD+W8zUHHF81w3Bk0PNho0UmIFG8WIpaKLJ7c8R9CdmklPpVhk74d8x9JcA2Ld9O5pEfk6nZ3yzA1kvbt1Ik/aGS3TeL9vIosXK70ZQuvajdpwcD2G4M87aWrc9Lm5rL83C6uAXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=n/fH8NiQ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 46C562067D;
	Mon, 18 Mar 2024 12:45:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1710762303;
	bh=pdhJxfDfYFn2PonPwIxPu8keAtH1fTErS2E0JiPlyOc=; h=From:To:Subject;
	b=n/fH8NiQIMmp8oUBdLEdxvjK8Uy4lH0BjSWQIwqdUZFse3V1SIpEGe1t3h7S1uJ0M
	 nXc1qiQ7rJb5zqcfmnPuvNRTYHk8WqFdmV5jDC0rH0TmttLytK/07p7GtO2KAnioaL
	 3x6DWQZ1mUaSsVGMNLUehNyccSxXtGMegA8ahxrSSfrp+n9TRLWRWDhXX5jjOSJ/WK
	 GE3YjubN/VEncoFGFDktdbekjwV7nIKqBBDyee8auPGpOV7kQjTv339rrFohW87ebD
	 awGGKMXYHhk6wDODzuOI709UgExziMM4kLsXi0lAMaqBNdDGEydvo2tjDuJN1afq/r
	 fjvH1ZBrnIEkw==
Date: Mon, 18 Mar 2024 12:45:01 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>, Brian Norris <briannorris@chromium.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	"rafael.beims" <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Message-ID: <20240318114501.GC9565@francesco-nb>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <ZfTiz_fhzPwRk4Xb@google.com>
 <PA4PR04MB96388A076FC16CF4C76F661AD12D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96388A076FC16CF4C76F661AD12D2@PA4PR04MB9638.eurprd04.prod.outlook.com>

Hello David and Brian,

On Mon, Mar 18, 2024 at 02:20:56AM +0000, David Lin wrote:
> > From: Brian Norris <briannorris@chromium.org>
> > running appropriate firmware. But I just wonder what the feasibility
> > would be for adding to the shortlist (or providing users/developers
> > the option of doing so) in the future, if people are so inclined.
> 
> If firmware reported support of V2 Key API, then host mlme can be
> supported without issues. There is a flag 'host_mlme' in struct
> 'mwifiex_sdio_device' to indicate if host mlme should be supported. If
> this flag is set, driver will still check if firmware can support V2
> Key API. If firmware can't support it, host mlme will be disabled.

Once we are through this patch I plan to test hostmlme on
88W8997-SDIO-UART, that should have the required firmware available.

Francesco


