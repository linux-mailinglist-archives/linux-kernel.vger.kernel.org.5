Return-Path: <linux-kernel+bounces-63890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193F185360A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA41C28B67A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1C426AD7;
	Tue, 13 Feb 2024 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGbC2s9/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322C7491;
	Tue, 13 Feb 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841858; cv=none; b=lQnVjDlIra8FbE179ryOzYEM2xttIaxX6nB03kH/wp9ikdSULUvjF3uG+uxvbN4/j8WEqqUQNrGMymgF7Qx6jOsGHgujXS/f6CHkVPyIo7HvN5BsWDubdx/VwzEiH3932oPznWr+g65838FTGF+QbHdGPihBZ6wa57ThgqcQZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841858; c=relaxed/simple;
	bh=M+iSkQzlFvKqKVdIDb0KbYwtekmltOd8aXuh0uIB/co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrokOPcb5qwK1NKpGo1kVmKa6mSEQoBxMIOqSgR9wh9hgAs38D4bGIjQLNH5QgrYwW8fH8J7hBxGks6Rfy/HpDhpQMT5Joj/nWQi5cdY/dOvhs9nzsttEVHiaXx5Uxub9Cc+LuEYL1XHxBClTmjsBpn/osOtn7XNwnHhePiShmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGbC2s9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7628C433C7;
	Tue, 13 Feb 2024 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707841857;
	bh=M+iSkQzlFvKqKVdIDb0KbYwtekmltOd8aXuh0uIB/co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qGbC2s9/34KrvzdF2opEnNBqHmFpoCBeeJ5TpzKvEu4eOYaq9VObtJAqzXpUvh8gd
	 /EXxH3lec5MXI9BLsBE9PA8ynrhhV9r54uZ+2Eeb27sQxEdaFceGZY3FyyZBvdZn7e
	 S28ni/aizs8SKJC4ec+q35QiW2LvEpoVMdBpUIyjEIUqlxR6chrFOcXR1i5/6G01qC
	 Dt9Z964Rn51vqFAJ0/i0EE0retrWpnb1Du0cEk68RiRo0WqPp5yTL/ALGvd8+2p2mR
	 AmbJRk01uxBA9COfFdpY3MhgBRkfd2QdFxt7rxkPLSNo26iTqcxSJXFB7OjFu2iSfe
	 m/uisfECjRnDw==
Date: Tue, 13 Feb 2024 10:30:55 -0600
From: Rob Herring <robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-scsi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Avri Altman <avri.altman@wdc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ufs: samsung,exynos-ufs: Add size
 constraints on "samsung,sysreg"
Message-ID: <170784184808.1480991.12030700618297062106.robh@kernel.org>
References: <20240124190733.1554314-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124190733.1554314-1-robh@kernel.org>


On Wed, 24 Jan 2024 13:07:33 -0600, Rob Herring wrote:
> The 'phandle-array' type is a bit ambiguous. It can be either just an
> array of phandles or an array of phandles plus args. "samsung,sysreg" is
> the latter and needs to be constrained to a single entry with a phandle and
> offset.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/ufs/samsung,exynos-ufs.yaml      | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Applied, thanks!


