Return-Path: <linux-kernel+bounces-134554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C9289B2F4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30962828D2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F453BBC0;
	Sun,  7 Apr 2024 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oxFkrIqF"
Received: from out203-205-251-72.mail.qq.com (out203-205-251-72.mail.qq.com [203.205.251.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CE139AEC;
	Sun,  7 Apr 2024 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507409; cv=none; b=KwKB5hXZgiWmDVGvACvaSOR34Oa/3HW/DeO9SLSiUSo4vuwTAIovAoxxcHtaOzIT31eAaj3HETydwZLHhXEBFLWbr9yCdLoudSeHK7F1WAMPMpMVRq8hE7NyVjH12eNcbLD71V+2iPzxgbBaYKoJY2m0bra9nUKaw14ZsvHLdN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507409; c=relaxed/simple;
	bh=YrnSblpCCIOE+CI9ZbEsUtTl6sf+3gUImYGBmMUfvJQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QZv+PS6kvur3A7phXnRF64Y1xLJH5PHWvoD70m9j20ideXgKa+TLcpNggIbZyeF22VLsSbo9wLN7NaqvnNg5stCzbDaUyAF6Cz749zhg7fhAgvuyprNBT4qCA0v+de+xihVX7RNeRtiJQ5H4ul4j25s5e5c8xMg6GV7RtgsqVug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oxFkrIqF; arc=none smtp.client-ip=203.205.251.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712507400; bh=k2XCyj2HtiyDsP/ZIm+qg3j+A+CGArLiMKptqsaRcss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oxFkrIqFTwDCxoynXY+TNWH3MtEgMCErno9fpszip8G3GUcapkF/4zJHboa9vXh8J
	 KmZnoOLgh6fBhq8kBspUGm8sA9OO5cIPijH1FOjfCu+586Z9ewmoXOyilrhw3JfsRw
	 8DGdU63ehZ2ynrup3uJRkbfMOm/tycgDfuZEB9DQ=
Received: from cyy-pc.lan ([240e:379:225a:6d00:f878:7a6f:5832:7f4d])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 726A94B5; Mon, 08 Apr 2024 00:28:38 +0800
X-QQ-mid: xmsmtpt1712507329te5faxais
Message-ID: <tencent_444C9BD6510E173A262A84AA919D0F449005@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujUM20gunPaMcDELA5CKx/0jtaWZDjXoyAIsc/x+iKqTXBOy9PIA
	 ZOq8R7uN+6n1l4+1ybvkutPK0qsTqXW9JncdjaYy5yfxUTt86vJ0M75UwcDJfllnICH7HUEjDvd4
	 xSzl7HCR7aJiG39kJgcDEqh0KqPV7ctYVhVZfOtaNeRcRAiGJLeScddDYxi10tInAGbPXRYTHXKs
	 5Nr/3N9x5sOMHOJU7wCVSIgeudORwZPRmEGnGqo/doLXsOIJQXaTRskVnhNX8cNQltVmVsot2bVC
	 tq/iN7O8KJuFeOvRZSVZAXC5xTnKwL0roWq1xnbFHwVdaWgnNe1FbXXNRB7rAt1iDp/Nvgef7ftN
	 pABhkspOgU7m1m5VWszMymI3eNRd/m6N0jW0arWtkAKVi+AwbivAvMPaEXsHUl4knouI47YcnJdZ
	 +P94hdDcGeZn/9kJD7Mkob8ukzcHGzab3IBo8ZxgRX1ixsxUq4soLbFGeC8AW67H3aykxvFtvOl5
	 JLzG9zdew2FHl6XhS/Bkv8eiVjPTeMlcwutYUNmZDqWsBYYjJOQScdwC7/i93QYnxaHzvLroQZAt
	 31UBGNpnZqsHLUyK8tATC/oe7/6RUtA2uKiZevVXI8Nub7SUQ5cCeZBCqmEEHWt8pOwTimcNT8eh
	 7Ejp3qFMJvPrZMDbPZFpMCXs7aZZ5wHfOFcpnOVdWYzBsFxgE0SBPZdsDKRdr84TIHJaRVU5dPUK
	 2lkKoyRW6qCWWbEjRZ7NlTjESIWA5IEvsUoqxxv07x2Lgi3HLzUluR41cctwhJFXT3TmJt8jxsRQ
	 lZyKs8DvkHQ1LAoy+1d4B8eG9zUMhvFu42+5L7m+YKrPhCQ9W1xeg+oU6g96T72x9dhDbVphIkvc
	 SFVL8FnVuds7SDh03vzb30MScnoEjSPCMHJqpmVHV5pN4/vxqW8suRxkdMKu4/FH130Lz9oKEPmC
	 INDInv+6GVRdpLbykoS/HGGzYru5ewrCOzIBhA/i+PqYizwhDZ7F7nTr9oAjDiyg1evVnylIa+7q
	 tz8A3i55u+1+OT5YL2NUCOpMBu2a79ANzv6sFhWuTzI2VAJ7CDIsonUjU0Tbs=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH RESEND v8 6/6] riscv: config: enable ARCH_CANAAN in defconfig
Date: Mon,  8 Apr 2024 00:28:35 +0800
X-OQ-MSGID: <20240407162835.3199788-6-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since K230 has been supported, allow ARCH_CANAAN to be selected to build dt
and drivers for it in defconfig.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index fc0ec2ee13bc..27bea8296b9d 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -33,6 +33,7 @@ CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_THEAD=y
 CONFIG_SOC_VIRT=y
+CONFIG_ARCH_CANAAN=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PM=y
-- 
2.43.0


