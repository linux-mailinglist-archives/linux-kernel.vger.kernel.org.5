Return-Path: <linux-kernel+bounces-119810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A5A88CD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6551F62A29
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508B513D252;
	Tue, 26 Mar 2024 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2/Mi6NT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AAC380;
	Tue, 26 Mar 2024 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481526; cv=none; b=SPSXAZX9aJG+woYSSWT0sSmCM6UspmlMFWFgd3m7v2aJKxF1nWFvrYQcHzUcdAXOkXAaGTPp4rC4yFCixWB85yu0bAUabDE47s0ET3igdGbUWogpSapya1lJdzBBCWZHQUksAM9OqW7TGeisxx+RLLjY7eNmrBNd0OElXICoVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481526; c=relaxed/simple;
	bh=rFkeoQf8Rkxl60GNNwUB//zK3YjAfCtCSIFZaTIkbzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPSIZ9eso8RfJvAxk2LyJDycDsjdvLw1JKNVf+IxyRWa4UgJsgOotsMMUklHGi1KuCspLROu3H09wPVv2i2zAtb4wLjgSeibMUhmqCTDr53Qy/PsNnSn7bcoNu5PT2u7MJBg6Qa57iNUKfwmC1sJs4MsvLb6BWfmzDpZniAKCmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2/Mi6NT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2745C433F1;
	Tue, 26 Mar 2024 19:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711481526;
	bh=rFkeoQf8Rkxl60GNNwUB//zK3YjAfCtCSIFZaTIkbzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H2/Mi6NTN0A31Hem/MaSOiAhV7Jl8h6bObjN0WOaowjpJBrN10gJX6vgqumB7BZSG
	 dXkMKrLBv8etz0tY+fqXciDw+X/3tHZZQdtr1BdVLSsvzfWAtB2PLycj7H4yvhTMPq
	 V+CypcJEITaPqL6sWyJTMhqkIAHC1KV19chRxBf5O0ahNKWtssVxhUriOp5qvxnngl
	 NMqgFDiKL2FsjYEC1tS5vF+mfOPhJRb10gxbCMXywK1WaTQuRJfN76OR6qaL0mge/w
	 QrBwL8bd1IUBsTeWLAQzFuCqCCyln3rQ4+4CmND338o5PzWXasfyrt/74jE0vX7xpx
	 gM/j21vi+e92g==
Date: Tue, 26 Mar 2024 14:32:03 -0500
From: Rob Herring <robh@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v6 0/5] spmi: pmic-arb: Add support for multiple
 buses
Message-ID: <20240326193203.GA3252922-robh@kernel.org>
References: <20240326-spmi-multi-master-support-v6-0-1c87d8306c5b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326-spmi-multi-master-support-v6-0-1c87d8306c5b@linaro.org>

On Tue, Mar 26, 2024 at 06:28:15PM +0200, Abel Vesa wrote:
> This RFC prepares for and adds support for 2 buses, which is supported
> in HW starting with version 7. Until now, none of the currently
> supported platforms in upstream have used the second bus. The X1E80100
> platform, on the other hand, needs the second bus for the USB2.0 to work
> as there are 3 SMB2360 PMICs which provide eUSB2 repeaters and they are
> all found on the second bus.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Changes in v6:
> - Changed the compatible to platform specific (X1E80100) along with the
>   schema. Fixed the spmi buses unit addresses and added the empty ranges
>   property. Added missing properties to the spmi buses and the
>   "unevaluatedProperties: false".
> - Deprecated the "qcom,bus-id" in the legacy schema.
> - Changed the driver to check for legacy compatible first
> - Link to v5: https://lore.kernel.org/r/20240221-spmi-multi-master-support-v5-0-3255ca413a0b@linaro.org

Where are Krzysztof's Reviewed-by tags?

Rob

