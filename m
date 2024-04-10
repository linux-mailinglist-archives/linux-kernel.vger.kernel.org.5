Return-Path: <linux-kernel+bounces-137919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA04889E98B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA70287893
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DE92A1CA;
	Wed, 10 Apr 2024 05:15:20 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C414A8C;
	Wed, 10 Apr 2024 05:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726119; cv=none; b=tXaZiwTcPk3m7d5Pj31KECIwB4sUm8oRQfPoj790dyr+WV6lJyPN+SCwFRzN+yD0PadT9pcfCJ2gJRyBLvNONs4PQpkTXqNdv0bTt+cAw2k1n+1rx1y7TeWsdRTM1cO5Q0Jw/BOKdgli4WbfjKwtp9DHsfLf9BvAKIwjZVTJk9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726119; c=relaxed/simple;
	bh=b/pf4aX7b3wDd9ZG/avGC3si3RwDD97KfmsmPG6vnM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOusu9EpTfv+XB5SZgx/B3PPK8UmxEqwCuoY+oWdk5hp0MoPESW/wnpaMTxYTHxLSK0sRHUDpQhNLYYnmv2zrZWO5TTNvWllU0sA372pneixENV7gZHNnNMPxuNpwx3x89F85pje+Hog83lbYK742kU2hjvkgCqFw0fS2xovsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from ip-185-104-138-50.ptr.icomera.net ([185.104.138.50] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ruQIj-0008Ut-Kq; Wed, 10 Apr 2024 07:15:13 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	efectn@6tel.net
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	robh+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	sebastian.reichel@collabora.com,
	Muhammed Efe Cetin <efectn@protonmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: mark system power controller and fix typo on orangepi-5-plus
Date: Wed, 10 Apr 2024 07:15:02 +0200
Message-Id: <171272604790.1867483.16170217183416866311.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240407173210.372585-1-efectn@6tel.net>
References: <20240407173210.372585-1-efectn@6tel.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 7 Apr 2024 20:32:10 +0300, efectn@6tel.net wrote:
> From: Muhammed Efe Cetin <efectn@protonmail.com>
> 
> Mark the PMIC as system power controller, so the board will shut-down
> properly and fix the typo on rk806_dvs1_null pins property.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: mark system power controller and fix typo on orangepi-5-plus
      commit: 08cd20bdecd9cfde5c1aec6146fa22ca753efea1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

