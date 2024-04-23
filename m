Return-Path: <linux-kernel+bounces-155446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5B48AEAA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA1528876F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BE413E02F;
	Tue, 23 Apr 2024 15:15:49 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944AA13DBA2;
	Tue, 23 Apr 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885349; cv=none; b=CK0BILpkEgsFKAvnSHMYMPY1WXe8KVEYdD8N6zj7LvUTw80p5+DzxyoPzHw3QNY7T6O5+NDp8Ezcc9OtsKeGTMsBkd1iaPXUHs57VXcmXVrgA5IElzCH/YMTjNLVyyW7eF1b+hTOf+3zsRpJS0h/eWj4ht+JN01q73H0tXUdYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885349; c=relaxed/simple;
	bh=rNLMrMNl5u+YaPBSylRvR65dH9Jx9iRKCP/yMTCqWN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHfd7Y2KEGjvahnUlsELlPukJmqEQUYXr5h0nOT3m1pVvop6yYl9+8yzJkq2/xSuwviri+p6hW4v+HttZyDGn15Wmh7zpXv/sy9wFh1zeq4+HF5qj7uXfxbQiVDyJptCzMrOngrTkWPKoudu+g2qJAgmht1WwEemtf8DVgNyAR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d9e.versanet.de ([94.134.29.158] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rzHrv-0007PZ-6j; Tue, 23 Apr 2024 17:15:39 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/1] arm64: dts: rockchip: correct the model name for Radxa ROCK 3A
Date: Tue, 23 Apr 2024 17:15:31 +0200
Message-Id: <171388532518.2652222.5651556523830397668.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419103019.992586-1-amadeus@jmu.edu.cn>
References: <20240419103019.992586-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 19 Apr 2024 18:30:17 +0800, Chukun Pan wrote:
> Changes in v2:
>   Collected Reviewed-by.
>   Remove changes to compatible.
> 

Applied, thanks!

[1/2] dt-bindings: arm: rockchip: correct the model name for Radxa ROCK 3A
      commit: fac5b3381639a504cd0e8c015242622331cc7a52
[2/2] arm64: dts: rockchip: correct the model name for Radxa ROCK 3A
      commit: 626a479873b6a680b3227c4852bde4a1f2c17fdf

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

