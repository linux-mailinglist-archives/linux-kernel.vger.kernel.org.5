Return-Path: <linux-kernel+bounces-27752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B04182F556
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F42B1C2399E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FB31D555;
	Tue, 16 Jan 2024 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUX/YzJ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADF21D541;
	Tue, 16 Jan 2024 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433250; cv=none; b=UiGZFcecT95o1Kd2Jm1XbcR7hZIuJLxDKFBS5C5qweCdbJmnq/98RUztFcjRTRlzH+bck2Dri8I9bpXRirlwHi2wGyL3nQBqo7VjId/5h0fMg+knd9RmKPxtQW0Ezx/WMad6PI/+hYmRJTujK3bmpulE/mMl+6rh2JMqOLAMltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433250; c=relaxed/simple;
	bh=vBWLu8oHrZSwoN6aHtVx9YgfqkzR3n3V63/JGBFBvgY=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=W4285cVdhQLZugV7+B0WPb16d7HFncXmYmOBYaihIKMCE6l/CMblMOz4mVK0zUhFz19dRWyTtoifY1GT/WJUiU0PxiJrBys87x43FK0B35husVPtJpvGMUHuaz+tbgYX081AewZBCr2+AT3etbxW4mpRPqE4MHK3GDxjLch9sk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUX/YzJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D0DC433F1;
	Tue, 16 Jan 2024 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705433249;
	bh=vBWLu8oHrZSwoN6aHtVx9YgfqkzR3n3V63/JGBFBvgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WUX/YzJ3V1h/6jM1zyh4v68+kfhTEJaEI9PRNiDhyi1007mqpShYR0h8hSYbRySO3
	 mPvJg51xtSjKaPtZllVhHCXl0ZB5g6KzMm+3lBOuEVsn8Bm9WA4U0L//JWSGx4UD3R
	 /tsF26L6xS/bLyksbSX6ZxbRBVHX4Dis6c6t2q/O1oA7VZ1ueUKt2HrUSBetzkg31i
	 f7O002Yn58NFmK2hjZZ8lXqC22FourVoI29spnEV0lA3I7lPShQTYTo/X0/CmYcPFL
	 Wm/Iuh63JBkI5BDk31+CBqXkriYjITIGY6lMf4nib8rcXZs8R3fo5GoJiWg9AzggJ3
	 SydBDRYamJsUQ==
Date: Tue, 16 Jan 2024 13:27:26 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>, devicetree@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-sound@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Do not override firmware-name $ref
Message-ID: <170543324653.279718.18172687756006729713.robh@kernel.org>
References: <20240115182017.1610055-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115182017.1610055-1-krzysztof.kozlowski@linaro.org>


On Mon, 15 Jan 2024 19:20:17 +0100, Krzysztof Kozlowski wrote:
> dtschema package defines firmware-name as string-array, so individual
> bindings should not make it a string but instead just narrow the number
> of expected firmware file names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/fsl,easrc.yaml        | 4 ++--
>  Documentation/devicetree/bindings/sound/infineon,peb2466.yaml | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


