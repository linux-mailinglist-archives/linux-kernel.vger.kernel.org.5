Return-Path: <linux-kernel+bounces-128604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48F895CFA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92AAF28668D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207D615CD4A;
	Tue,  2 Apr 2024 19:46:54 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975415B962;
	Tue,  2 Apr 2024 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087213; cv=none; b=UcMVlo6RJD0YWCk2x74X8uAg5x67toMKeEYDh7lg0be7sJVN3nxjvBe4ZO1ZVRGBdrdwU8fhPWon9uw8SovcBBTmyj5QtlwYm7F8/KebDAFRXHZC5Kyw+Do57cStx28ubuiksR0BEkjHBdq07LcGuNAFwV3pmaz4PNeDl31sjOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087213; c=relaxed/simple;
	bh=hOZpRf5Ntev9tVv/hxzjmhAqSGp12F71NkO0lPL3Szg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBBDWedXVMpZiJAIyMd75vhlt1muEB3VOuWlKU4BM/EYthI4AdUyPwYaDoIeic3eIGdf8BIdMm8+24ynRaa63XkSzzj63BuSo/plvRLgJxmIGjglORz4p2QWidYaJOGCtvmhPxaVrVaCEglQ+Z/1EObYUvdiv78/4S0wIa53isE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875aaf.versanet.de ([83.135.90.175] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rrk5j-0000Tb-F5; Tue, 02 Apr 2024 21:46:43 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node
Date: Tue, 02 Apr 2024 21:46:42 +0200
Message-ID: <4654968.CvnuH1ECHv@diego>
In-Reply-To: <20240401204959.1698106-1-robh@kernel.org>
References: <20240401204959.1698106-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 1. April 2024, 22:49:58 CEST schrieb Rob Herring:
> 'pcie-phy' is missing any type. Add 'type: object' to indicate it's a
> node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Do you want to apply that directly to the dt-tree?


Thanks
Heiko



