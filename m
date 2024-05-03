Return-Path: <linux-kernel+bounces-167598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6008BABC3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A574C2855B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930DA153572;
	Fri,  3 May 2024 11:38:54 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CF152E1E;
	Fri,  3 May 2024 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736334; cv=none; b=Nvx8tUrStc70g/MlCtgZN3uJu+nr9SaaPIctCEOTi2a3whNS2nW3iTPFQ7KgGLiI9kpN7M7wNXqvHFPQbH0yWWCVoBzsaXtW8303NU1cWkK/U6hKu6W414W+PFW/7fKP8ixZHAPZT5WsVQLKa9baButuhJiwpJAw9bKRyVxnzWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736334; c=relaxed/simple;
	bh=YfT5yN5pZ4h0Bo+Ad66JKWwANI6a04BdGtGFkOec2fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkxN4fAUcVSkQADuuwvaw3j+0w/xPjA5xXmnW9A9um5xRlu9v6pf/Qnn1rqWZwBE9+wVYqq5X9qVHWhLR7ek+SysxPZw5L803qjfk+yVeHvJbDFmCR27HsR9JmXBYenMFmEmaqhoVkL+3xtJx7WrYMSQ/xO5UXvlnvdAJ4kp8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.sntech)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s2rFO-0000Tc-LC; Fri, 03 May 2024 13:38:38 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [v2 0/1] arm64: dts: rockchip: enable onboard spi flash for rock-3a
Date: Fri,  3 May 2024 13:38:20 +0200
Message-Id: <171473602995.3469033.6999294628253231263.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409120003.309358-1-amadeus@jmu.edu.cn>
References: <20240409120003.309358-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 9 Apr 2024 20:00:02 +0800, Chukun Pan wrote:
> Changes in v2:
>   Add missing cells count.
>   Increase spi max frequency to 104MHz.
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: enable onboard spi flash for rock-3a
      commit: 6c7676a2d3cde81f02e2cb7ac40ca5a99c107dec

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

