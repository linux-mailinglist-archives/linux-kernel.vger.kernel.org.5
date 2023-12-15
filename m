Return-Path: <linux-kernel+bounces-1083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD7B814A11
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC073285FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945BA30355;
	Fri, 15 Dec 2023 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=6tel.net header.i=@6tel.net header.b="hi9nMHU8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2A3035B;
	Fri, 15 Dec 2023 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=6tel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6tel.net
Received: from mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:96a1:0:640:9109:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTP id 491F55EAF4;
	Fri, 15 Dec 2023 16:55:59 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id VtlX2gDOoGk0-mNhFxpE2;
	Fri, 15 Dec 2023 16:55:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=6tel.net; s=mail;
	t=1702648558; bh=tCST9mJ/gflIVf+DhlVo0Uo/peyZKqwGk/Zu1s1LBcs=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=hi9nMHU8ztTIEhTHwvKPw/q4RsMrH8boma7k2OXDJb6887JZIe+SWXWs6qnBWhmCB
	 e/irka2kmzEFaizmu8iSpVhb3mK7hM+SDlaeGWYpmClEhLBJBR8vPm5umAIeK/d0Tk
	 Oq/3weDvKaDoltBQPHqHad0beOYxc/VvA6uZ0Jyc=
Authentication-Results: mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net; dkim=pass header.i=@6tel.net
From: efectn@6tel.net
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	sebastian.reichel@collabora.com,
	jonas@kwiboo.se,
	Muhammed Efe Cetin <efectn@protonmail.com>
Subject: [PATCH 1/3] dt-bindings: arm: rockchip: Add NanoPi R6 series boards
Date: Fri, 15 Dec 2023 16:55:21 +0300
Message-ID: <b74f5b91693d9b1ec525fb22e06c0a8311c7cf05.1702647349.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702647349.git.efectn@protonmail.com>
References: <cover.1702647349.git.efectn@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

Signed-off-by: Muhammed Efe Cetin <efectn@protonmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ee92f0535..07c4eb828 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -225,6 +225,13 @@ properties:
               - friendlyarm,nanopi-r5s
           - const: rockchip,rk3568
 
+      - description: FriendlyElec NanoPi R6 series boards
+        items:
+          - enum:
+              - friendlyarm,nanopi-r6c
+              - friendlyarm,nanopi-r6s
+          - const: rockchip,rk3588s
+
       - description: FriendlyElec NanoPC T6
         items:
           - const: friendlyarm,nanopc-t6
-- 
2.43.0


