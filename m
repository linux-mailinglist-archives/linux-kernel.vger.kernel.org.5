Return-Path: <linux-kernel+bounces-61777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E90485166F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22659282D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E383FB3A;
	Mon, 12 Feb 2024 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6wwG8Si"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065093FB1B;
	Mon, 12 Feb 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746201; cv=none; b=E8BiIv0TjWpnqHb+aoWtMcY/bhRqdX8+J5McK9fMqTc0izF7B33h2Pz59DpgZvyxQFST36Lr5Yo8pQF5d8W2Vn2B0EwA8Rb/p7XVkhHCusUWYR9vyRfJgbERWmRP2Yno1dGMN/RmWeQYB0mW4onE/3OcnhxVQ7E5MH4IeyUNDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746201; c=relaxed/simple;
	bh=37nz859ShgHqVR08pnQOMTOWyjYey3mzmwOK5xjZt6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL6rK4Q62tqyM612A4P025KNIsScaKtnpgdlfOf0+Zc60XBYHpZ7O4NJKXI8MqcNcTGJ6VQrQugx/j28z89X+pdDhmIoypMepehCTDYC5KSW1x8ioO7VQlP6FP9dTqhh+Zl5de1tp3aDjKXOYv+uSeXeh+nwqiIUSkV0+tWBLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6wwG8Si; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E80BC43141;
	Mon, 12 Feb 2024 13:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707746200;
	bh=37nz859ShgHqVR08pnQOMTOWyjYey3mzmwOK5xjZt6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E6wwG8SiO9KEsmYxyKA+RtvSFKaj8uzvlrDgEXud/C7+BzkFDle8rcHVvxj4UOLJM
	 r16Z/8UyPRuihprgrjzo3fDDSq3W8mulu1HG+ohgcnKRPzz+rZ03d84ExbBT41gOLP
	 E6mpuIaaMZz+7ebZBp9qEYu55bR/zl0XDrNNRpBwvVzPAHEQUhkt6JizQw+g+yA33q
	 bxicgBJv7jCedZ92mLSpeX6WcCPulINec6tzbiDwFSqgJ43ByVo13Cp3/GYoLwj/E7
	 RImIi4a+Jq4kdLxXgc/R2EbIVyHlLk38qQ2DFZm5e3tgdmYJp43KkfKUMuGJ+kTry4
	 Ghk36Q5S+SZ7g==
Date: Mon, 12 Feb 2024 07:56:38 -0600
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org,
	Peng Fan <peng.fan@nxp.com>, kuba@kernel.org, wg@grandegger.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	pabeni@redhat.com, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, mkl@pengutronix.de
Subject: Re: [PATCH] dt-bindings: can: fsl,flexcan: add i.MX95 compatible
 string
Message-ID: <170774608242.61707.8589020918845229336.robh@kernel.org>
References: <20240122091738.2078746-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122091738.2078746-1-peng.fan@oss.nxp.com>


On Mon, 22 Jan 2024 17:17:38 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX95 flexcan which is compatible i.MX93 flexcan
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

It seems this isn't getting applied to CAN tree, so I applied it.

Rob

