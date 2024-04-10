Return-Path: <linux-kernel+bounces-137918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB689E989
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E986D1F21DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307A126AF3;
	Wed, 10 Apr 2024 05:15:19 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3934313FF2;
	Wed, 10 Apr 2024 05:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726118; cv=none; b=E6HTEObUVWT1ed0G1cfFvW72/MbDgPQzWDNbszOhwWrWH0k/+W2CLgM296aJ1X7as9rfxwk/51ZDuXWtejI62MjntBiwPTbUp6mkdXz2y9Og8EESoW5GVa1hmQHu13LmeT7rkFZY2ayNXGkh5HIUHWt2ioF8i50KeVFzLiowKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726118; c=relaxed/simple;
	bh=6oKvLLUGpKvfwg2xFHaxGI+wN/wjR1pH2MT3jfAKGic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H74bZ+nGCvjcJFehcNBwXKEB+uSlh93lVReuHz6RGH5yHh3tWKrnMr5iGYj2TW8bpJKnKvBPPkOwt8FgGAmBaVy+1+RKEEu5o6MJN7uJiwaxIqdXwhbuSU9B7fqxu+vjqOD38v3jcGKDPTnm4ocW4fsiynwbPeQ6/AWzwWRBzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from ip-185-104-138-50.ptr.icomera.net ([185.104.138.50] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ruQIl-0008Ut-0o; Wed, 10 Apr 2024 07:15:15 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node
Date: Wed, 10 Apr 2024 07:15:04 +0200
Message-Id: <171272604793.1867483.15917787961611178400.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240401204959.1698106-1-robh@kernel.org>
References: <20240401204959.1698106-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 1 Apr 2024 15:49:58 -0500, Rob Herring wrote:
> 'pcie-phy' is missing any type. Add 'type: object' to indicate it's a
> node.
> 
> 

Applied, thanks!

[1/1] dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node
      commit: d41201c90f825f19a46afbfb502f22f612d8ccc4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

