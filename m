Return-Path: <linux-kernel+bounces-79733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB18625F0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23AE8B2171C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F195D47F59;
	Sat, 24 Feb 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkmkVtjg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98C3E493;
	Sat, 24 Feb 2024 16:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708790766; cv=none; b=dW9WhUuNhhvU6buhibaM0WAlXEWoGwrlQUbLZ/sjpBldwbvfiGpXoQPNcUv+ETtDTLkKAaxxGfyMuLUn25w6apsaFJL6shqC1VWKQGegOBah+klqW5QgxPV0er0YRjXM+Gz4PJ6evYiFnSBXGCAsabWdy/WupS/gFJO3axRSE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708790766; c=relaxed/simple;
	bh=nyzuVj8K5P7BiQiq3KxcTFDs8z/JutsiWaTLBwIE2II=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEUA7WNZnAVMU2ETkMPsHdpQU5DpFlrbjav63F0onoiM39uJ2Wlko6lvikbTOYkZp/tVuAoAtAXA8EaMI0AE9yVsuFWGKWggnpblcT6QMh+HGBNtd5Y4Df3lAKtAGHScBVG40pwFc5QRdiSROu8cZ5gvCvK5jDVmEh8aAmtOoHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkmkVtjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2617CC433C7;
	Sat, 24 Feb 2024 16:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708790765;
	bh=nyzuVj8K5P7BiQiq3KxcTFDs8z/JutsiWaTLBwIE2II=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JkmkVtjgvBLM7Nc0uHIwtOyBRWlNofLXoA3wKFaXJGM1X9tf47ZbdmVWpXFoEv/cg
	 gUVdRmKXEHn5xbAAOVesmIuCoQq1lituaTAcceC6S9ayavC69eLEQMIRCyQtxi8DeV
	 jmepv6qYkpp01Ur2BAr4B9QeHQ1NA0MtvRWc9PouEQBxQsLmY/nmoJ1Q/w9qD9CV5A
	 N2p2VIrT+7u68gqSWaEJvD95GiJkIipSNzqjjeBUrMnXZrv6dOFhVsR1egfAVa+16T
	 q6ZiBfw57R2n9hT8fTqN66T5tc6BfnDQ92TFlrS3GfrQH4i1oenCn77nAiqmfMO6tn
	 YGc+iDZrOZIlg==
Date: Sat, 24 Feb 2024 16:05:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: puranjay12@gmail.com, lars@metafoo.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: ti,tmp117: add vcc supply
 binding
Message-ID: <20240224160550.03f7138a@jic23-huawei>
In-Reply-To: <20240219131114.134607-1-m.felsch@pengutronix.de>
References: <20240219131114.134607-1-m.felsch@pengutronix.de>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 14:11:13 +0100
Marco Felsch <m.felsch@pengutronix.de> wrote:

> From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
> 
> Add the binding to specify the vcc supply. We can't make it required
> since this would break the backward compatibility.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Series applied to the togreg branch of iio.git and pushed out as testing
for 0-day to see if it can find anything we missed.

Jonathan

> ---
> v2:
> - mark vcc-supply as required
> 
>  .../devicetree/bindings/iio/temperature/ti,tmp117.yaml       | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> index 8c6d7735e875..33f2e9c5bd81 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> @@ -24,9 +24,13 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  vcc-supply:
> +    description: provide VCC power to the sensor.
> +
>  required:
>    - compatible
>    - reg
> +  - vcc-supply
>  
>  additionalProperties: false
>  
> @@ -39,5 +43,6 @@ examples:
>          tmp117@48 {
>               compatible = "ti,tmp117";
>               reg = <0x48>;
> +             vcc-supply = <&pmic_reg_3v3>;
>          };
>      };


