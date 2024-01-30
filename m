Return-Path: <linux-kernel+bounces-45435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A7843072
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B93E1C2407D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82627EF05;
	Tue, 30 Jan 2024 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8aIbmYb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224137EEEF;
	Tue, 30 Jan 2024 22:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655417; cv=none; b=NIgglfb00EISV5/W1GLRbrAk7vvMAKDmtcAYgqFKYklm34VHLB26AYH/BoeDrA0Bl+kO8616E8kd+ssZDFdzUuBXUSvoLAu0W2F2nm9BwR1YIu12GqyOoUPs7WVbtZIDBF7U4ArEh8TKwmKbJc/S2GkU19xyWlJW5AQ03LNXNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655417; c=relaxed/simple;
	bh=VdU6if5rHUMAoE64rsagsgfaJZ9LSIB1pT2VMNKYYv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiPcFvLCW7zAqkIgcGNAQQFGFfHIFYWXWej9OvCxu3TyXNnUU2PXctfvKz0PB5GlNiYGmk82ZbrRAGNyBK9uf+n0FT15VNdhL4S9PN9yI8QxFQiVVCc+ASu9yB9zM08i+YBe+wMgzQtTvIKPFMk1QbN5NSweHDMH9hTY4yzvzjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8aIbmYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF22C433F1;
	Tue, 30 Jan 2024 22:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706655416;
	bh=VdU6if5rHUMAoE64rsagsgfaJZ9LSIB1pT2VMNKYYv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8aIbmYbXSXUzz5OyjXF3V2Y2TT9ChHKCPaL9WHvH4FEVUrx1FjfoWpyxup97VDjc
	 WaL2DH0GbT8Iiq3NcJSXI6GQ80Ki26ot7TM3fZqiJjpPyO05xT0MEHuwbGjQcVQ5BS
	 V8Wr4Zv9j2lssXNz4uF5INuWm9Z+g4junrxh9erfKwa/enwapQz+lgrrDA6f7wzj0Z
	 GlFUVmW4iF5UhST7Psd0Y1ct0PlPXqnSjNVzrxMcUROEWwkonZ41uDzs3TE6ZYa437
	 JDcIYoAkMLGHtdRodVmeMsMlBsvSDDN2iNIybKUMpPqtonI5yGl8mqp/RK39FPs7ry
	 t2V7H1fYOMOpQ==
Date: Tue, 30 Jan 2024 16:56:54 -0600
From: Rob Herring <robh@kernel.org>
To: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	linux-serial@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	quentin.schulz@theobroma-systems.com,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: serial: Add binding for rs485
 receiver enable GPIO
Message-ID: <170665541359.2569633.3534356334365614400.robh@kernel.org>
References: <20240126-dev-rx-enable-v5-0-5d934eda05ca@theobroma-systems.com>
 <20240126-dev-rx-enable-v5-1-5d934eda05ca@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-dev-rx-enable-v5-1-5d934eda05ca@theobroma-systems.com>


On Fri, 26 Jan 2024 18:27:42 +0100, Farouk Bouabid wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> RS485 has two signals to control transmissions "driver enable" (DE) and
> "receiver enable" (RE). DE is already handled via the uarts RTS signal
> while the RE signal on most implementations doesn't get handled
> separately at all.
> 
> As there still will be cases where this is needed though add a gpio
> property for declaring this signal pin.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
> ---
>  Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


