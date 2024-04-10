Return-Path: <linux-kernel+bounces-137917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB3889E987
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787ED283A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433771CA94;
	Wed, 10 Apr 2024 05:15:18 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B391170D;
	Wed, 10 Apr 2024 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726117; cv=none; b=q5xws+8budutgW4LpbVY6xaaJGkakLN49JCIGwuPjAR0HR7lbLnIYpGOfU+ZGobuNgBf8+F7EAVE05Aso7QNtvtoximRwPxGO7KWhaudIlzuOnaVILldgERH5Gc6i14q1zqzLbLMx+yPPc2Wp7+fPW0WiR9V4oNhLZ76+9Qm50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726117; c=relaxed/simple;
	bh=0lgTCxeCSXrEBb75a6tl4Wk4OoNKx11iZYVxTbBA2a4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oM2PqgImIqzZcNG6SOA45I0ghOBgfYYm7VuvY5vyVhZ+AGTqYl+DS5m7UvMuEjzRksTg0sStf3JvY8N/+4PL16yJUWbym8MdNTrHfx3SVF+Dpdj2iHdFgsKgMiysVLAVx/cjLOECcm6ylLs9XgnPioJfv7FgysHGcoh8Fv7WptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from ip-185-104-138-50.ptr.icomera.net ([185.104.138.50] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ruQIk-0008Ut-As; Wed, 10 Apr 2024 07:15:14 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: (subset) [PATCH 1/4] arm64: dts: rockchip: drop redundant pcie-reset-suspend in Scarlet Dumo
Date: Wed, 10 Apr 2024 07:15:03 +0200
Message-Id: <171272604791.1867483.10125190310440634047.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240407102854.38672-1-krzysztof.kozlowski@linaro.org>
References: <20240407102854.38672-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 7 Apr 2024 12:28:51 +0200, Krzysztof Kozlowski wrote:
> There is no "pcie-reset-suspend" property in the PCI bindings or Linux
> driver, so assume this was copied from downstream.  Drop the property,
> but leave the comment, because it might be useful for someone.
> 
> This fixes dtbs_check warning:
> 
>   rk3399-gru-scarlet-dumo.dtb: pcie@f8000000: Unevaluated properties are not allowed ('pcie-reset-suspend' was unexpected)
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: rockchip: drop redundant pcie-reset-suspend in Scarlet Dumo
      commit: 29148d841edea9335141fae86a0742f539fe1327
[3/4] arm64: dts: rockchip: drop redundant disable-gpios in Lubancat 1
      commit: cd0793fc3b03985d90f24232056853ef79ff555e
[4/4] arm64: dts: rockchip: drop redundant disable-gpios in Lubancat 2
      commit: d892a6f34adc371ee0dbaa5ba684d02c4431f2e3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

