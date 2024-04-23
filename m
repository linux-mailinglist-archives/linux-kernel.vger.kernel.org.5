Return-Path: <linux-kernel+bounces-155489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B128AEB46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11982857BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52A813CAB5;
	Tue, 23 Apr 2024 15:39:27 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99212136652;
	Tue, 23 Apr 2024 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886767; cv=none; b=qdjQEqeq1udG1XMouhXFw/eUchWoKpL6HC2hYKD2JZ36e5w15OQ2AatwUsAkSJfg0U1iZj26g7tr7IV3nmpSnBhKUa+/mHKHV5Db/Lt1Y9BT8FI4Gmm1Y5uojNIM+LGI3cG4smkVUEmtzFop8lCRSFRuSh5YWsv7ROkjtlkPNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886767; c=relaxed/simple;
	bh=EtO6N+QrbNhbhs0KN/FYNqL+zuuZdE0DVI/R+Ug2GFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/mXr/akvQmnRM9WpooGVC/IfSzLDWtVY8pMTr2fCJfdxLhuLQFXXwNtaTJsrhTQd7/Y8S78yxiF3wwsxwq3+INa0J+PcSDa17HBiQZl/MrOT9rsov5Qc/Fy7wBHvAZg4zx7T5ypRiURQEW5EvWJ284TjFeOL0r6kM50+wI2yYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d9e.versanet.de ([94.134.29.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rzIEo-0007h9-3X; Tue, 23 Apr 2024 17:39:18 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Jing Luo <jing@jing.rocks>,
	linux-rockchip@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	sebastian.reichel@collabora.com,
	jagan@edgeble.ai,
	cfsworks@gmail.com,
	robh+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: correct gpio_pwrctrl1 typos on rk3588(s) boards
Date: Tue, 23 Apr 2024 17:39:15 +0200
Message-Id: <171388674748.2655666.197923029393759084.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240420130355.639406-1-jing@jing.rocks>
References: <20240420130355.639406-1-jing@jing.rocks>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 20 Apr 2024 22:03:55 +0900, Jing Luo wrote:
> gpio_pwrctrl2 gets duplicated by both rk806_dvs1_null and rk806_dvs2_null
> gpio_pwrctrl1 is unset. This typo appears in multiple files. Let's fix them.
> 
> Note: I haven't had the chance to test them all because I don't own all
> of these boards (obviously). Please test if it's needed.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: correct gpio_pwrctrl1 typos on rk3588(s) boards
      commit: d7f2039e5321636069baa77ef2f1e5d22cb69a88

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

