Return-Path: <linux-kernel+bounces-78417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD3F861332
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3121C21198
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3078E81AC9;
	Fri, 23 Feb 2024 13:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SePNvT1G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BB7F460;
	Fri, 23 Feb 2024 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695996; cv=none; b=PT9Wn4PBohxvru8h7CBbEaFOpcYUSEOD/WICkU9c8D9CbqPwOyKE7S7iBxncN8vE+3MqvQzv3d3Jf5eD7iNpnNkAGneJIUFsIOrfV/CtBjTRDJpWhixHLgectyHD4JbdFXoOnjB29iAdhux+Vg7RKT8p/ESQzCvYV3S6yxgGMH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695996; c=relaxed/simple;
	bh=rAdPCw4/OBjz1i35v/28fcS0w6qDxGtRaIay5aCZaOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cljS0Kkj2GhJtTmbaVo0Fz+lJKVEX8tnPy+VqYbqXcblcyuNoAjpKbHGf/rkczv4sjD9y1hY6vdrczQyqZykPtHd/zo877sznQ759SRLSHEGoJLi/+aS3dv0c5L0dJJoxA4R0DU9oat8MtCBspjVGpQGJOMVhQ8I0sLYHYVLw5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SePNvT1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DABBCC433F1;
	Fri, 23 Feb 2024 13:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708695996;
	bh=rAdPCw4/OBjz1i35v/28fcS0w6qDxGtRaIay5aCZaOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SePNvT1GYvJOrP4vf6P3CONoAsgu/DsxLW6ssDjmA4ODguznAPsYpcSgpEso/2HnV
	 YVTCDF+R6hrLaBlyxJhOpq4EgJeyHYr1K1K3Qr95H9lcgZ6mCbaAod7Z8Hd0UHGFr+
	 rQFHUBMixQSWop1DDlXB7xQDfYXmkAkKnxOHUw/iCLkxx/bU7rOUkVq3NCplxHiJ1m
	 V08+PjxcESx8YMUnKwlBkarkR2no3fod+6weGydj73rLklpHrFpjHcrOiYCTqI6h5G
	 nVmWCkHD/Lgvk8tjKY2CY12UaHt2c/eGeadeEg0YCy9nrwiam3kaf4rd5bcTut/GNL
	 HRf1iX7G/xEFA==
Date: Fri, 23 Feb 2024 06:46:34 -0700
From: Rob Herring <robh@kernel.org>
To: Danila Tikhonov <danila@jiaxyga.com>
Cc: conor+dt@kernel.org, david@mainlining.org, adrian@travitia.xyz,
	mturquette@baylibre.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, sboyd@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 7/8] dt-bindings: clock: qcom: Add SM7150 VIDEOCC clocks
Message-ID: <170869599338.1761205.1578787689309150034.robh@kernel.org>
References: <20240220165240.154716-1-danila@jiaxyga.com>
 <20240220165240.154716-8-danila@jiaxyga.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220165240.154716-8-danila@jiaxyga.com>


On Tue, 20 Feb 2024 19:52:39 +0300, Danila Tikhonov wrote:
> Add device tree bindings for the video clock controller on Qualcomm
> SM7150 platform.
> 
> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> ---
>  .../bindings/clock/qcom,sm7150-videocc.yaml   | 58 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,sm7150-videocc.h   | 28 +++++++++
>  2 files changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-videocc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm7150-videocc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>


