Return-Path: <linux-kernel+bounces-91276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320B7870C2C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57961F249CB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589797C08C;
	Mon,  4 Mar 2024 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="nzGyLKnP"
Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8547BAFB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586402; cv=none; b=lip9W/Q3oK+BzXp+7cuQx0GCTtEboq4rrFEUoYKxOufbQgEcrwYab2PC4nrNVDAyt4td3o8j6WuuNFZ7Lah3Hntvw8iMtf2FVj1SGyths59xkUlVwFJw1noHk4C79WAsHVQiejJyBXmqPRBsXJIwBYVoA9h67AV7E0gPMHJGsYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586402; c=relaxed/simple;
	bh=P8jNX7CJX28JnzDnoqwlE54sj83Ai0UkkAgdRX77wpA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fxJVBNPABfMSbw0s77ytdrKk4g355DAWqwc9Ec+PNi2PSkLaFQOj3YHUypMpbOYHgwAAbJe24owE8Ns8vzGzHKcCIim91P9sSjrG9t3UTWVY/WlpqLjj1mVqVQK6ufz0W8e1HaUncw6OPP6DYVQibXg0Hke0gZC/I6R43Ngnz7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=nzGyLKnP; arc=none smtp.client-ip=203.205.251.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709586398; bh=ZIJLq3BiSFnxhdHDEf99zRwFrDLRKM6iSM1wB2EtUew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nzGyLKnPoGwBIxlwfAUkuIQaPJA9KVS2EVwhIN+BOpCesuCz0Torj02Xss3nbkPkN
	 KWd69ANDZl307XhIZylOq5CSU0Hz1gAZUEteiBbMBSTqcoOtehKwF1xTZSMrGN9yM+
	 GrVImA5ab/6WEg6pJoSoWl0+Ge8K2nBmcEEM2hMI=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 1953A8D2; Tue, 05 Mar 2024 05:06:21 +0800
X-QQ-mid: xmsmtpt1709586396tlqjaady1
Message-ID: <tencent_E2812086B695A334EE5E8C70C85CA3171F06@qq.com>
X-QQ-XMAILINFO: OOPJ7pYMv25tJaZk7lZP4Q8/mDJpXDiT5T4zZuM22dEU2c/Gy7TSuOPa/AA6bu
	 CpJhKfQjQJeyJPTNUNGRG2pPp6A2yctjqvUlxBJeAR5MVOUPMLUyufmP5Xl2lsP8bMG26G8oHdoy
	 bWNkiPHu9SK6l5PYmClXHLRkHYRSxMeHn6ic6toVKBXjVUQkWhTCnDx8yofLUVXv3BMk9mAPxMt/
	 ardIAzSS/Bxv6LPxdswI/Xq5er/yWIxI8iNiC3bX42yEpNRABbNbOlM2X01nR0i0peEpV9VCidWG
	 SmRfDuSENS7VykPyUNhLUpL+w1YHbalNtuiVt/RqpO2OgPLEN+IQ5a1vLUd+igd8tHaNz2+QJ6L4
	 ZXCySTc+oe/MSNMBW/1g0KiJAvDcQWs9cYwCU7QrdgW4VId7FnLcfIv6QqDUw7oNcyLWS/UqK9JW
	 W9XyGDpbQzF6d2nL8FV/P58/6IbQMh3aIgkl6GaT1CcW+ccfHxl95/uEg9XA/nsXF862Q3ExJmW5
	 6fVVWWkOoOKHLb3dJB0P3q0lGkCwALjBzGl2QUgBFR3HxdB7kweRDhoiRcpL8tpbOgdZVxu2zYRq
	 WjoV4jvBFBCGB1CkRi9tQgT2RErH5mtk69d8yYcNC/a4QUObCIQo0W7n3rWf9uXJi7qkK6eUVSKt
	 WvRxwEzmbHn266f4AS5slz29IDA9ElFbKIO6kUWNFLK41//9a4Qf44bG7qNUgkNM0MnrlYUR3eZh
	 E1HzGvnKgM4cgfxCROws6zzowP+OouIYRKwqh6JMw/46RK2fXwAezH/S0UyyE61R/uD7ry1ckW8H
	 f3YJPg+lHw8hRbNeBSqaTYIypSTS6xB4lBl7Z/QnMAaVURaC8pn2Gmty6X9fEQOkIanniTuCgw8p
	 HHSNzNHwQKb6F1tTdl25fiMRzzwT5bUAOzedonNPjYyzVe9KHUa3+hvLiyO8bs6grusXlvS3ZAVx
	 WX/AaIZD6SRoQWqhKFiiOuGY7TdUWiPL1quwVLV9PugG9+cf++uink06Z28C0eKdufxYybiEyH+A
	 vC3+rb/94l24P7q9OyoNhrQ18Y2uRKKRewkX1alGFpxdjvvBTNy7IGyJ8UgwlxfdaQ7Ckw9RP/0B
	 57rk/F
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 7/7] riscv: config: enable SOC_CANAAN in defconfig
Date: Tue,  5 Mar 2024 05:06:01 +0800
X-OQ-MSGID: <20240304210601.777883-7-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since K230 has been supported, allow SOC_CANAAN to be selected to build dt
and drivers for it in defconfig.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 89a009a580fe..20b557ec28df 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -33,6 +33,7 @@ CONFIG_SOC_STARFIVE=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_THEAD=y
 CONFIG_SOC_VIRT=y
+CONFIG_SOC_CANAAN=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_PM=y
-- 
2.43.0


