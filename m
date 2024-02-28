Return-Path: <linux-kernel+bounces-84975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3447986AE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE56A1F22E31
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED40C13A881;
	Wed, 28 Feb 2024 11:51:06 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB871369B1;
	Wed, 28 Feb 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121066; cv=none; b=DUrjomePzdpcR0xAQV71FZYMJvIF+yGxKW03GCS+dOwAfyrwr/xK+sWP9OdyY/w8a3s2CVBwtlzA36eRgUxh136M+k4A+kQl0bbyg5CpN/Pi9D48+gTmSA6TszUaJ9/QJAq2NJib00k7UIKxd7lnh9PP/+os4g4J/OsDHBiJhg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121066; c=relaxed/simple;
	bh=ON+X5ASR8b2KCbqm4XLRPuE/eP+5oPMi3wWH5PqlQ3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upr/vPEvidLtN8apV//3hlFzxa3hgLoN+CStPl5KNdNl6+DRhTREkn4shhwpXCnEHhQRLG+P2h6YFTQzD9rdS4lWhBHkn9x2Q8e6eoQDWhfZA0wcdx1bvMP8tjGJHh6Rw95nzgmuBDFFeAsZMjfUgAm1dp6WW5+yXJN3pSLQYEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rfISU-0001E2-Ln; Wed, 28 Feb 2024 12:50:46 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Wang <frank.wang@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 Conor Dooley <conor.dooley@microchip.com>
Subject:
 Re: [PATCH v3 01/10] dt-bindings: phy: add rockchip usbdp combo phy document
Date: Wed, 28 Feb 2024 12:50:45 +0100
Message-ID: <10751726.aFP6jjVeTY@diego>
In-Reply-To: <20240216170514.75200-2-sebastian.reichel@collabora.com>
References:
 <20240216170514.75200-1-sebastian.reichel@collabora.com>
 <20240216170514.75200-2-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 16. Februar 2024, 18:01:16 CET schrieb Sebastian Reichel:
> Add device tree binding document for Rockchip USBDP Combo PHY
> with Samsung IP block.
> 
> Co-developed-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>




