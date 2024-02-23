Return-Path: <linux-kernel+bounces-77575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00588607AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFA81F23234
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D11028EB;
	Fri, 23 Feb 2024 00:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXI5n4nY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670237C;
	Fri, 23 Feb 2024 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708648001; cv=none; b=gGB+YkjT6rfxos05KFZIuDQtA7x1tp2U+8ForokNuiyBBOEtkFSNq/xUNzD7ZBrblQq4y2ulFfFqkCUUhOGhHxrxLene20WDJFnmg/F+MD4ve+qGmQ8gXvvVazzCZ+G2rl2vedA9cihub27ef2wmvgYEu6FLnbrAYdN7ZZwrGyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708648001; c=relaxed/simple;
	bh=0+odAUcRrPnxUDpZbZCepWVt4mBZAcGQ3ErWO178AXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqlB++64hmvsOPLj/7DmElMb2t1DC/aZvgT8p/lBqHmjEc9tJI4F03PkVe2AZYpBJgexoAmSqZeziccTXQyt8xTF1nIuCEzWvxtGe55LnSLfl9VbcbZvWvxA1z3qwieAWG4tXG1WY1e7yd1Uts0K8kiBksS11Ckwl2pkysvUq24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXI5n4nY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF44C433C7;
	Fri, 23 Feb 2024 00:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708648001;
	bh=0+odAUcRrPnxUDpZbZCepWVt4mBZAcGQ3ErWO178AXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXI5n4nYSGv2YeH3Ef4dpzxnLjn0XrUccDsy7t5VZgpyGNGv4fQ+01CfHTQbgDcpR
	 MbHLfxMBkTXaJh5ofXMhTyC9T0YOoSY7FBMOcCtYvnk/A7HAWA49GpZkAol/Jrnz9n
	 LZ4a+1x6AM9Pnig+Iu6khkS2idMi29EhYJ9wYtZroqGQP7u/U5EKhuVTxIbqrWYICB
	 KaCPok4bW9mATCCZuRra0Yd2MXXzjyPCfSZxIQTYAz/Px8uWuBAf2++oU6JKC1uttm
	 sym28mGwB/s5crRb/GBXXfXPa0/U9GXVZBznlPJ+Z+PDZv0tX9jkyyV/qmUcHT5csF
	 ao3PUZcyPKyWg==
Date: Thu, 22 Feb 2024 17:26:36 -0700
From: Rob Herring <robh@kernel.org>
To: Michael Riesch <michael.riesch@wolfvision.net>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	linux-kernel@vger.kernel.org, Mehdi Djait <mehdi.djait.k@gmail.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/14] media: dt-bindings: media: video-interfaces: add
 defines for sampling modes
Message-ID: <170864799569.3932038.15905786640208782418.robh@kernel.org>
References: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
 <20240220-v6-8-topic-rk3568-vicap-v1-1-2680a1fa640b@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220-v6-8-topic-rk3568-vicap-v1-1-2680a1fa640b@wolfvision.net>


On Tue, 20 Feb 2024 10:39:11 +0100, Michael Riesch wrote:
> Add defines for the pixel clock sampling modes (rising edge, falling edge,
> dual edge) for parallel video interfaces.
> This avoids hardcoded constants in device tree sources.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  include/dt-bindings/media/video-interfaces.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


