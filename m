Return-Path: <linux-kernel+bounces-53090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0DF84A08E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA351C2223B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB80047F52;
	Mon,  5 Feb 2024 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH5KnDyE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA245953;
	Mon,  5 Feb 2024 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153728; cv=none; b=nQ30j6LjxGLgtr0nvJgpYL3nB18bBL5WhjgO+di3uOX8zEAm0wz3rYSoycdXvryiK6L+qDct0Xx3CEjnOYSj1q8Y1FtgdiTyMQIb4Jj8lq4eshp+5mZVhsQjtN/xNVqPrLpWQe/t8Lt5rqTeBbrqQNPVE6LLWubCUvcltaJU7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153728; c=relaxed/simple;
	bh=Et6Ae8kKVfkwexIZgZibcIr2o12bANsTHAJ7mXeWTHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5c44ixBybzYX11ZsLWL0fYF2aChaHm1a3tV15kNN3XXymYFGkpFjNUhT8Cn495wecjyk06VbHwAZdDyit3kDTdOGDSiGpqUHsj+o+qoxl5jTe0u1+uydNX+ccTYSNRtsx9ZBXN76s00lAcZNlmuFcD7tj37RNgGWSsX262xtJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH5KnDyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2266C433C7;
	Mon,  5 Feb 2024 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707153727;
	bh=Et6Ae8kKVfkwexIZgZibcIr2o12bANsTHAJ7mXeWTHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rH5KnDyEFEFfgQ0g9h6NChGENuZo0wYudf5fBhcNDE1xepWPY15eDz0bV1KrcszzW
	 6Ea+R37M/gcLFJRLPtO4hZDqW3dWsI4MnFWOoLaAnJhOg0AHax3W7HUnJXEhtPnAMq
	 GbrRhCOhxDVsxoUeUprR2R8sqDbQOwxdrCdsSqt6wMBspz8u4yy0znGMDTtN1cBf39
	 TPoIBqVIAEdyPiinmu1cJir3ekzvG2WHlB/M6VUQZQgFdJqKaOGg73afv1jsbY7oAU
	 caEKAseZ2VMAeWlqV3eEjgdQVngYjcIREVIpaEkMp31LOIKSpM3B061X+wD4lNy8gC
	 u3ohm2+idj4+A==
Date: Mon, 5 Feb 2024 17:22:03 +0000
From: Rob Herring <robh@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: guoren@kernel.org, Chen Wang <unicorn_wang@outlook.com>,
	palmer@dabbelt.com, sboyd@kernel.org, haijiao.liu@sophgo.com,
	paul.walmsley@sifive.com, xiaoguang.xing@sophgo.com,
	devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
	jszhang@kernel.org, linux-kernel@vger.kernel.org,
	robh+dt@kernel.org, samuel.holland@sifive.com,
	inochiama@outlook.com, linux-clk@vger.kernel.org,
	mturquette@baylibre.com, richardcochran@gmail.com,
	linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org
Subject: Re: [PATCH v9 1/5] dt-bindings: clock: sophgo: add pll clocks for
 SG2042
Message-ID: <170715372308.3643466.1804804263763287247.robh@kernel.org>
References: <cover.1706854074.git.unicorn_wang@outlook.com>
 <bf3b8178a013004f259cd9254b13279254505852.1706854074.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf3b8178a013004f259cd9254b13279254505852.1706854074.git.unicorn_wang@outlook.com>


On Fri, 02 Feb 2024 14:41:27 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add bindings for the pll clocks for Sophgo SG2042.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../bindings/clock/sophgo,sg2042-pll.yaml     | 45 +++++++++++++++++++
>  include/dt-bindings/clock/sophgo,sg2042-pll.h | 14 ++++++
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2042-pll.yaml
>  create mode 100644 include/dt-bindings/clock/sophgo,sg2042-pll.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


