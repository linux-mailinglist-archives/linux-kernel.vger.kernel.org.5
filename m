Return-Path: <linux-kernel+bounces-157626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0307C8B13C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9510F1F24379
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B5513B5A7;
	Wed, 24 Apr 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtY+pvvL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521B1772F;
	Wed, 24 Apr 2024 19:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987991; cv=none; b=NBXWXl6Uzv2cV9NP2/X4DBh8YEAFPo+cn4t8sVXA94OsYUiIyDtxWexXY89r9Wl7VeJE0d4V6cs4mG0DHIBob8lDlr+uaqyX73iv3lqKUPnc+o5kQMNN78wmHRv6bvPW02IHQR9wFRZb+iYt/sQxvX9NoFozRpN1zvRKSBS2lFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987991; c=relaxed/simple;
	bh=g9/xQrMYSC/LZxTDSciUMV3IAClkbLhPh9fZxEsgBNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igacnQ2kIyFiNdiww2ZTVHVgWkw6/nYSoKTunQ4pzhhdJBKv+eD07TfhPfLwAFTMCCC+cWZvERMvnU+189Al7FeTZd7yyPDlKdULHmXLPu+mqv5sprgXEqvtfXW74c1g+NGHLsErvqn0mzRRebxT6+zDSKOU4IuJMI1F/RTKyUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtY+pvvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D353AC113CD;
	Wed, 24 Apr 2024 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713987991;
	bh=g9/xQrMYSC/LZxTDSciUMV3IAClkbLhPh9fZxEsgBNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtY+pvvLHqZs/gd93cG8gq5Z1cPP1zqcCEu2chDgbyLnX7nAr91foBns+pgnl1+Jn
	 z1Y6RTSqp923oNjmuOYJgvh5xTtDSYpTSrLLqVbLCxbZqP5rhV1pXovqjsfPBi94iA
	 DEA5mXdX6iaIL4F/lapnzkCCgmbpJLd9ZRn+LXXRMlpLltvXdV7ZENV9Lw356zO482
	 elrnqy4OP+3mwfxt3YIIWIjGMwA7XpHHfkKifxbTKfBSyGjfrhv9cm4Zy9+w8YkGSA
	 7HwCXMqVkL7HUlQjgRbUk/yER6QdfR5V4EnaeK9nfnYjchYhCyaKArqn/SJHPmMuXM
	 4s1nqk/y3bcKw==
Date: Wed, 24 Apr 2024 14:46:28 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-kernel@vger.kernel.org,
	Will McVicker <willmcvicker@google.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Roy Luo <royluo@google.com>, linux-usb@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: samsung,exynos-dwc3: add gs101
 compatible
Message-ID: <171398797667.360538.13481950472752937802.robh@kernel.org>
References: <20240423-usb-dwc3-gs101-v1-0-2f331f88203f@linaro.org>
 <20240423-usb-dwc3-gs101-v1-1-2f331f88203f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423-usb-dwc3-gs101-v1-1-2f331f88203f@linaro.org>


On Tue, 23 Apr 2024 21:19:45 +0100, André Draszik wrote:
> The Exynos-based Google Tensor gs101 SoC has a DWC3 compatible USB
> controller and can reuse the existing Exynos glue. Update the dt schema
> to include the google,gs101-dwusb3 compatible for it.
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  .../devicetree/bindings/usb/samsung,exynos-dwc3.yaml   | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


