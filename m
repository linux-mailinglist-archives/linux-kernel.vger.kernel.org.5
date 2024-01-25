Return-Path: <linux-kernel+bounces-39292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6769583CE3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB95E29C91A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2014B13B7B7;
	Thu, 25 Jan 2024 21:12:33 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3815213AA5F;
	Thu, 25 Jan 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217152; cv=none; b=gq/597XnI60BjcUQlTV54D2xcmwM2cb2w7H7dwpQp0cwS4mOXbrCqTsuPpurZSx1RKGv0Q/nPHIi41D/w6aaMZt7K/ku9JuzUaCkzixnU0L/AKzx5S5WRBnzFeH6opI9jpiWN/qFY+WvXHHXopEIauLbhbsv5LerMcKTRi6+Jq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217152; c=relaxed/simple;
	bh=GpvUuJngDjCW3ZXNphJcYwMVYNEtz5AoBXPPZ262+74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iWDdOQucZpHeyNN7jjVrOzX3r3kHtFnRMs9SV2MlEO8sF+/IhYPrn6bvZZDH8H3gHygO2haGrf4QlWHQ095eI4mf8ypZjQkvRwqqFoHvjw/10k3lK2EA5bjvhoYu/LPP3DZWlL8pQ6sDXKbzm/E2Vh8b7oC5XesgaR90eBfbCBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rT71L-0002EX-Sk; Thu, 25 Jan 2024 22:12:23 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/1] arm64: dts: rockchip: rk3588-evb1: mark system power controller
Date: Thu, 25 Jan 2024 22:12:14 +0100
Message-Id: <170621707723.1872080.11945045942033585251.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117191555.86138-1-sebastian.reichel@collabora.com>
References: <20240117191555.86138-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 17 Jan 2024 20:14:48 +0100, Sebastian Reichel wrote:
> Mark the primary PMIC as system-power-controller, so that the
> system properly shuts down on poweroff.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3588-evb1: mark system power controller
      commit: fc4657971be31ae679e2bbeee2fb8e93a7a063eb

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

