Return-Path: <linux-kernel+bounces-167600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3199A8BABC8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09B62854F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B56152E1E;
	Fri,  3 May 2024 11:38:56 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30701153505;
	Fri,  3 May 2024 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736335; cv=none; b=aK/qmvD3pzQB+tKE+nl5lUKhUkGoM+dC0x7R0Mu2je8YBoiqiX2KUMO+ogRwkIOns2XUuUA12kTdnhWsD1WI4uXC0j6k6uq6BLQxkMjEqNdfi7dwVRjhjNu+sOXnI9ygHe8z+s1cFnTNQcxpA8FoVHflsUVzysGUn3loYOpNSdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736335; c=relaxed/simple;
	bh=mLWfIIvgdFVeHlAQC8RgX1zO0cqtrny715a0zLwvSC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRt4NQJ0l/MAkSvfiAV4jAnUaVAXxtqJGjfOKWy0VnuRouTr7e0Fv7rUokYh+030sEmyvAnbTfFo+OW3YnDlxQUbYYTAPncRhrJhSftQaA1dY0GYrADDw0Pk25O/r9AovuGlOoK+43fKcPQuNPeuuhAD0L05F9HEJ/U/KJdEolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.sntech)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s2rFP-0000Tc-U2; Fri, 03 May 2024 13:38:40 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Anand Moon <anand@edgeble.ai>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Jagan Teki <jagan@edgeble.ai>
Subject: Re: [PATCH v1 1/2] arm64: dts: rockchip: Support poweroff on Edgeble Neural Compute Module
Date: Fri,  3 May 2024 13:38:21 +0200
Message-Id: <171473602992.3469033.9822124851399795331.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502094246.4695-1-anand@edgeble.ai>
References: <20240502094246.4695-1-anand@edgeble.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 2 May 2024 09:42:37 +0000, Anand Moon wrote:
> On Edgeble Neural Compute Module add system-power-controller
> property to RK806 pmic so that these chips can power off the device.
> 
> 

Applied, thanks!

[1/2] arm64: dts: rockchip: Support poweroff on Edgeble Neural Compute Module
      commit: 3cd1ed57ce70dd64bd1dfb69cbb3173bf4fe0582
[2/2] arm64: dts: rockchip: Add USB3 on Edgeble NCM6A-IO board
      commit: 7676e12650055f4eff5f2cccdf9903981619553e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

