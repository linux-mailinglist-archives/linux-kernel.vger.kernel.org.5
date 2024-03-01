Return-Path: <linux-kernel+bounces-88877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436BF86E7DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7441A1C25385
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A180538DCD;
	Fri,  1 Mar 2024 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9hn+JQI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA21137705;
	Fri,  1 Mar 2024 17:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315816; cv=none; b=iRVk1y9rwKGX+vXJbINlZibQt6pf6SX7x9IF4HUEt6XI9bDlUyH3piyIQ8E2DcuC7z1FjY9o9WWPMhhVnw02Dox5HbDYp4Nd9v/9Ieoj3a++xMuU/0HlPrBLMfe4MRHvvfbvonlCts8tY6278hZNNEMqioM0r73XfJIxFpWmcY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315816; c=relaxed/simple;
	bh=UmK8sxWHdvXqQrq6yVG8FKBXn33bDgOtlshuAqAxznU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdXP/fLxYtqaa+5pnaFJBfsWq7S+PoDn26ouQnvMuqiFMQMtlvN4Z1+ILp6eyLY013s8LmqdGFORsNsc6j9xHT6QBnrppGzpNSt/4ugOxw7ItlNWBKo2qnHouq8GNLvRYZRlVVn9O/kKchQeOBJXHXSpd+YcTJCUY7TmPBs3Tpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9hn+JQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19005C433C7;
	Fri,  1 Mar 2024 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709315815;
	bh=UmK8sxWHdvXqQrq6yVG8FKBXn33bDgOtlshuAqAxznU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9hn+JQIOgUbaIs1I+C2YIFcyyswjIPzUWJoyiVEaqZLsGLx9TBMCrUS9tIaoI0QS
	 K21bkP1ERcXbumhNOhgHHI8qXG5q6vy3uNXHdMInXos9erU7BqcXcXxDYfL+2wE8FV
	 z1CwrC+LgPQXdm5eoviDxU5LVlKnb79LCKJb3fe5XtnAWIZXVkZEQTJVXhx+ZqPFpi
	 MqiHQoC4q4O7fW0dsBkSY9U8VLQeBSc1bGtrwX2M3YMJ2AqVPQ7f9lY7IkOwDCYY3e
	 6LwcFnYa2wDNsJEyMR+3WHDysa8Q1pI+MKPIhxge+504UUwcFZno7UMstr1BRwvHq8
	 1W2TVF8wz63Lw==
Date: Fri, 1 Mar 2024 11:56:53 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Roy Luo <royluo@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>, linux-usb@vger.kernel.org,
	maciek swiech <drmasquatch@google.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add downstream facing ports to
 realtek binding
Message-ID: <20240301175653.GA2469610-robh@kernel.org>
References: <20240223005823.3074029-1-swboyd@chromium.org>
 <20240223005823.3074029-2-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223005823.3074029-2-swboyd@chromium.org>

On Thu, Feb 22, 2024 at 04:58:20PM -0800, Stephen Boyd wrote:
> Add a graph with 4 output endpoints to this hub binding to support the
> scenario where a downstream facing port is connected to a device that
> isn't a connector or a USB device with a VID:PID. This will be used to
> connect downstream facing ports to USB type-c switches so the USB
> superspeed and high speed lanes can be put onto USB connectors.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: <linux-usb@vger.kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Cc: maciek swiech <drmasquatch@google.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/usb/realtek,rts5411.yaml         | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)

I think we need a usb-hub.yaml schema... For now,

Reviewed-by: Rob Herring <robh@kernel.org>

