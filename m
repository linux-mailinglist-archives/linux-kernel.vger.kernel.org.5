Return-Path: <linux-kernel+bounces-90936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244F8706FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4F0B23AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FBA4CB3D;
	Mon,  4 Mar 2024 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB4RHpau"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5544482EF;
	Mon,  4 Mar 2024 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569693; cv=none; b=EWFuCpv+QDsa5XdFHBH41b3CIrIpSMhw/YXMTcQcaPd1H76pjehYTwcMwxCEfhjLLt9swPD0uiKLtOlxAT62EKhq9wj2zAvR7Q/Al+FOX8B+FcjKA3dBJzyMzkfWAaATDkDLgW7UqDzfAI+EB9jgeDvUC6NBKUwzo+cZV/eforQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569693; c=relaxed/simple;
	bh=L0jLtyPZbItn8KbijN41lcA/FmtrSMyJCLKJ1HIJGi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pM2erjv9UfBQcaDgas/mc+4foBtoWZfm/NFOXHIq+AYgNeqOf3GQhVCzAidYgS7C9cOabpbkCvgHIJmVbz4kf/f/Riv8n/rxXUzTGfcCoLZ7rMImttSwR68/GcjfN8rgnxN81Clsh3znpg3WL29+Zppivqzcb9d9/0d5gdRu3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB4RHpau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E761C433C7;
	Mon,  4 Mar 2024 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569693;
	bh=L0jLtyPZbItn8KbijN41lcA/FmtrSMyJCLKJ1HIJGi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KB4RHpauAvX0OazxS1wZX4PwHWd0afUdhxmvohYXv0W1NAqqcMtSErNc1mpc6MWX8
	 K4VuUYLkgACJUEwKXNtPU//BlRmW9eak8pFhH73XC933gNfei7QpwEOs1BLgw4xaDQ
	 oGF4gWn7Jq1+8b3SAlZ5sMcwLkfmTNqGwKuXYIhxjYxiT1Y4j8qJ0chSltG0f3wL9F
	 nYOSySqcXYDIyAvwWMNyNt5YjMZJjLsicViSEPA8P0O6aop1lnAuX8xGEyODJyASZr
	 xWw3y+7PXFzC2JakT8CVThdu2a3Zz+Y7nCA+chm9BQ54ezB5Fyzfk1Q2ahkj7fBuJ0
	 TMIDkvk2FXAgQ==
Date: Mon, 4 Mar 2024 10:28:11 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: add ad7944 ADCs
Message-ID: <170956969031.622753.9168069143401175386.robh@kernel.org>
References: <20240229-ad7944-mainline-v4-0-f88b5ec4baed@baylibre.com>
 <20240229-ad7944-mainline-v4-1-f88b5ec4baed@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229-ad7944-mainline-v4-1-f88b5ec4baed@baylibre.com>


On Thu, 29 Feb 2024 10:25:50 -0600, David Lechner wrote:
> This adds a new binding for the Analog Devices, Inc. AD7944, AD7985, and
> AD7986 ADCs.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> ---
> v4 changes:
> - Fixed broken patch due to misplaced changelog
> 
> v3 changes:
> - Removed default 'multi' value from adi,spi-mode property. This simplifies
>   things a bit by not having to check for two possible conditions (absence of
>   property or explicit default value). Now, only absence of property is valid to
>   indicate the default mode. Constraints that depend on this property are
>   updated accordingly.
> - Fixed spelling of 'conventional'.
> - Expanded description to call out potential confusion of '3-wire' mode being
>   unrelated to the standard spi-3wire property.
> - Added standard '#daisy-chained-devices' property for chain mode.
> - Relaxed requirement of cnv-gpios since it was determined that an active high
>   CS could actually be used in chain mode.
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7944.yaml    | 213 +++++++++++++++++++++
>  MAINTAINERS                                        |   8 +
>  2 files changed, 221 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


