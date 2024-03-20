Return-Path: <linux-kernel+bounces-109058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E021C881416
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026671C2302E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631B54D9E8;
	Wed, 20 Mar 2024 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Cl+l9JvG"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFD7482C8;
	Wed, 20 Mar 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947124; cv=none; b=oVnjxEw6b8paUNbT4NSAMPp46ExbZFZFjg3qhOG/96EW2H5e+M3Yja+jZPi2OVpnrhfgr+AqucN4L9UD/zUGe91/Wk7814EFiQyvx3JsyjHPWRvPdtO/sIaJ0X1H8lSErgwCV/TPTYDCXkD4yEbOklBVIWLTZN913UgN6R5R/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947124; c=relaxed/simple;
	bh=0XLgUOOYOmd4r9qokLq/rbrSX8VMdpDGUVyTEoy0noY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbBzGqjDP6MQ5srFsMam/od1BSMHXOXlFu2CqSTso4vXEVLZKo3i+iulc7V5+gU2k7/i6gVVx+/+15auO17YP2dg3nsNLLmfYz+PqYoEbL9s7jfO/zgPmhQXtwF5fWb5R7kSlVRHzY+5xpS5vP+6bBeTQtCkydybkcqOqhcjJJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Cl+l9JvG; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 1A5A21FA94;
	Wed, 20 Mar 2024 15:47:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1710946058;
	bh=N6dHreDxYiI/LsRMSZ272Q5m0H4lIeHxrk9p+czNgzs=; h=From:To:Subject;
	b=Cl+l9JvGRYIC6/G3iJWLeUVMSneZSVYDcHjlyVTJi48/PngzvW8LTiWyoACKogTpt
	 2wjuLneuB5cfOGwfTbblWr25WkZdG7OM14BpuPNZ4YW4dX93JaHEK1xfkMsboQ4xW8
	 rXd8whSv7RWN/tL0rsS1lPfPD6vdFXEP1XkcXTxkMeKiVrEywEUZ3Yb7pBV04F+yD2
	 cLLwLd+aDoCF5BZfDXesPRHRDbs9Wy/jQ245BkCbzcfwLOEHXlyfsjCwHZetKPcvue
	 6hShUiQpz8CZ5VKkf9Lqt14MOgDFNwGKk52lTHcDBPFtV/pNR3eGgrAvSdLERsQ4sp
	 6DM+2IRCiF7SQ==
Date: Wed, 20 Mar 2024 15:47:33 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: max.oss.09@gmail.com
Cc: max.krummenacher@toradex.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, francesco.dolcini@toradex.com,
	kristo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	nm@ti.com, robh+dt@kernel.org, vigneshr@ti.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ti: verdin-am62: Set memory size to 2gb
Message-ID: <20240320144733.GA16176@francesco-nb>
References: <20240320142937.2028707-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320142937.2028707-1-max.oss.09@gmail.com>

Hello Max,

On Wed, Mar 20, 2024 at 03:29:37PM +0100, max.oss.09@gmail.com wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> The maximum DDR RAM size stuffed on the Verdin AM62 is 2GB,
> correct the memory node accordingly.
> 
> Fixes: 316b80246b16 ("arm64: dts: ti: add verdin am62")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco


