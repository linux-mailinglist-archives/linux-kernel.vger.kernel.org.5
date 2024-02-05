Return-Path: <linux-kernel+bounces-53897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5F484A7CD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0571C27A8E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC48112F371;
	Mon,  5 Feb 2024 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4KeZYyz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3B12EBF9;
	Mon,  5 Feb 2024 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163789; cv=none; b=WkjZyeKmfpOe0Ryq4VIxFZ57cZZRglq3Zh54ZhYvms0OzujfVRUUl1AoEQLRtsDUOlRudvHeT65TyXZwwoSnAIRjrkhP0mO6PTHfQL9dN4v8SmcxwyxDeeqBnJo/Yc+TGdDyeJfyvZI1zMKROqAZG9hSzq2LaHVP5HTcSCN32nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163789; c=relaxed/simple;
	bh=bx0TTeJpKN68v/TlRfV9dvj+W0tQCORcDy0cAHmBBxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVpz+nXh+HXfpIo5OJV94Y/LRaUEnWs0Vy8H1uF7bBZV/k3BQ5lHeQMTWBV2VZ/bz+kLnxLScEYDus7/xX91+L6UZw8M8amyZm74UR2UuLsSQeRxhs2hv9R9awNjhO7DXQCk7hKYQSwSmp6xKxrQgdZzoAfufHgjN7fxgmZ7khA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4KeZYyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AF0C433C7;
	Mon,  5 Feb 2024 20:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707163788;
	bh=bx0TTeJpKN68v/TlRfV9dvj+W0tQCORcDy0cAHmBBxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4KeZYyzkzJ+3iSgKrOK6J4rf3E911LFyZ/zMdGrih3frRXhJQrOJTcMlws8l1Isq
	 Kld1PS8KCnm4d+r1fGEuCfT1Xn0Pi5WgqX7n8EtFw2xhUnW1dINXEY/SxzstNJLamp
	 D80SKDBLDdb+a9M+O7FgzOHBkqIOZTT3Nbd/So+iVxrDFPk6oO6CRaZDoiENi+6pqX
	 BoMLqebxpw+kMCQs0ydcP0BK2M7Po8X/Mv6EyaZpUauAgOxhB0BX8Yk2dnUzgHt9eq
	 EgC1tbqfRZdcWOLEU45pWgaH1bHspo3ZNAN61Nq6YRr9T5sQFQhpfY83+Lp4QyxoWL
	 9VL2uQGVW3cVA==
Date: Mon, 5 Feb 2024 20:09:45 +0000
From: Rob Herring <robh@kernel.org>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: b-brnich@ti.com, conor+dt@kernel.org, nicolas@ndufresne.ca,
	a-bhatia1@ti.com, praneeth@ti.com, linux-kernel@vger.kernel.org,
	p-mantena@ti.com, hverkuil-cisco@xs4all.nl, vijayp@ti.com,
	laurent.pinchart@ideasonboard.com, j-luthra@ti.com,
	krzysztof.kozlowski+dt@linaro.org, nm@ti.com,
	andrzej.p@collabora.com, robh+dt@kernel.org, mchehab@kernel.org,
	linux-media@vger.kernel.org, vigneshr@ti.com,
	devicetree@vger.kernel.org, detheridge@ti.com
Subject: Re: [PATCH v4 1/3] media: dt-bindings: Add Imagination E5010 JPEG
 Encoder
Message-ID: <170716378412.295212.11603162949482063011.robh@kernel.org>
References: <20240205114239.924697-1-devarsht@ti.com>
 <20240205114239.924697-2-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205114239.924697-2-devarsht@ti.com>


On Mon, 05 Feb 2024 17:12:37 +0530, Devarsh Thakkar wrote:
> Add dt-bindings for Imagination E5010 JPEG Encoder [1] which is implemented
> as stateful V4L2 M2M driver.
> 
> The device supports baseline encoding with two different quantization
> tables and compression ratio as demanded.
> 
> Minimum resolution supported is 64x64 and Maximum resolution supported is
> 8192x8192.
> 
> [1]:  AM62A TRM (Section 7.6 is for JPEG Encoder)
> Link: https://www.ti.com/lit/pdf/spruj16
> 
> Co-developed-by: David Huang <d-huang@ti.com>
> Signed-off-by: David Huang <d-huang@ti.com>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2: No change
> V3:
> - Add vendor specific compatible
> - Update reg names
> - Update clocks to 1
> - Fix dts example with proper naming
> V4:
>  - Use ti-specific compatible ti,am62a-jpeg-enc as secondary one
>  - Update commit message and title
>  - Remove clock-names as only single clock
> 
> Link to previous commit:
> https://lore.kernel.org/all/20230816152210.4080779-2-devarsht@ti.com/
> ---
>  .../bindings/media/img,e5010-jpeg-enc.yaml    | 75 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


