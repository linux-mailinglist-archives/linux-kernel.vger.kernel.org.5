Return-Path: <linux-kernel+bounces-51929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE62F84911E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C86C1F2199A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A1EBA57;
	Sun,  4 Feb 2024 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="E2T6QHwc"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B71BA33
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707086386; cv=none; b=FGhCjkJrX/QjvoO2F8ArIMNbq4dIn2ro7ZTw7407BreB6QYeCwyyDZd1UNsx9q8FnfOb9gSRUq8EUC+sruPj5rO0CQa7vVsBP7nHb5qI8uYVjjf2e4egHwNX3HdVSEiJ7llj6WNcLHEbsJSktvezWZG9xPjYI8rZC90ZXGc3QwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707086386; c=relaxed/simple;
	bh=E3+fGJTw11gLhJoIv/Sv+UemlQN5/hDRbtSdJqXXq50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=llNomi7Uodp2Y4F5m/VVfxczJS9SevMiIE0KpD6qknVtWTBclm4MM/k+Yy4OPoR49LB3RWNP1+n1/LwhBpHxxVRQ4HBek9GfYyLJptjwWBCwVwFhl84ixDyoe9FgQr6cbE9qCTAC670xRuXvMXlFdgYIUHbE7jJ2KwbMWs9pX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=E2T6QHwc reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so3610296a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 14:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707086384; x=1707691184;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oFIcO3bTpeRHX/1kF5/ionptaHBgQNeWXLilOBjdVI=;
        b=EvGB78Jh8wBcYHuYD5RnX4+2cd7kKDjxXMZsCwXLm8YFeu1YiosMxhGFoe2SwdqHOu
         Oc/7pOAVPCNFhjyR3wzq4E3qSg7d6767fezrz0XkXaVHJTwPzIti7sR3iL5gvBSE30mc
         JknXH+OKQcOpgEIA0bMWzUd9N8pl0OCP4LhS/Xyz7+G2aJQkvkNo+TR+4ItCMANNqgmp
         qOFAerpUZr9eX2rcsDKLEPVctf755E4Y8oS6LunWdSEKdvu1Oam4rxg4J2PjBQts0cd1
         90XSzBcqjLXqKrVkFgkLeBQ4rQRIXVdwfXqlccJ18bJZrjR+00N5+k346Q0p/+gWAB7/
         69qA==
X-Gm-Message-State: AOJu0Yw8hd8grYVGKLuwWGldyZKjLkzTEyCGJFBbeIci4Pbtb8jBYVXx
	6wBOxt4Dk4EK1NO0vVGDgaHpWB/lpa3jujSyQXGjVKd1XhkNcDQf
X-Google-Smtp-Source: AGHT+IHP2rtw8i/j0mM/nuWPZXe96bE0Pg4GZXvEx2TGxp+5GXMx0tamGBVvwvPVABM92npC1+/emg==
X-Received: by 2002:a17:902:784a:b0:1d7:67ed:f359 with SMTP id e10-20020a170902784a00b001d767edf359mr12525460pln.4.1707086384004;
        Sun, 04 Feb 2024 14:39:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWKXmXtrgZfifYUFhZbXaxCZWXoUfnpJGYMWtWBXTr4vO8azsrctF2DWkSyf14O7BXB55eDeP58pR5J0CqdVqRO5BCisIot+71ZleMoV96FAYO2cKqyWPjHkMxwDEq3xoU0kZBZCFiMGGtSTp1i9vs5FPAO178PxWC+siVtiWzm5o5rE09avi0uT4qN6GjNaZ1Kz0LPhUdajaA3JkMLd1ShfOT9VYc=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090282c100b001d74502d261sm4872595plz.115.2024.02.04.14.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 14:39:43 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707086382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3oFIcO3bTpeRHX/1kF5/ionptaHBgQNeWXLilOBjdVI=;
	b=E2T6QHwcieY8NFyHcw++9onHaKOOYuGQ6ISHdDudrPHWHfdG0a1BuwkOeYQ/kXIpzoowa7
	U//KSN7ZKCcWRBtJa9c0KO9m5dLN39ha0OIshkHzBLmxZSZmRD8LsaHf4NGdgSGHBZviDp
	aNtr/XaudWiwIyW0DlQs+tjjzIxl7S2KyqR3QjifjGiY67tQcPBrXfQFJ2lEppgDHBjOCy
	lhLJz5mHdpuubqcPf2voujQyQt6qIYWN0upprVqYMIG5S0YPbRYMLlfliVLCd1b2RHqI1m
	H70kZB6AwhBVCJvcd9+kqhUkJ150pyIuiYDDwesIURzY4AKgAc4rFTcg++38DA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 19:39:57 -0300
Subject: [PATCH] const_structs.checkpatch: add bus_type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240204-bus_cleanup-checkpatch-v1-1-8d51dcecda20@marliere.net>
X-B4-Tracking: v=1; b=H4sIADwSwGUC/x3MQQqEMAxA0atI1lOIQUf0KiLSyUQblFpaHQTx7
 pZZvsX/FySJKgm64oIoP026+YzyVQA762cx+s0GQqqQsDKfI428ivVHMOyEl2B3dqYpW/smwpZ
 qhByHKJOe/3E/3PcDujVLB2gAAAA=
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=963; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=E3+fGJTw11gLhJoIv/Sv+UemlQN5/hDRbtSdJqXXq50=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlwBJM6jPu7QV6G2FPX76xRLbvjPu3XArJwwg2I
 ZCLhctfbtyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcASTAAKCRDJC4p8Y4ZY
 prb1D/9Rg/IYRVfQb6asZKcfBuv5avmWb4FWaQMA15Yl7CrkNdDmhBTIh4i5OncMtZA/ZbQUyFn
 4Po8tAViLs8QtunHZ292GFQa2OsY99tzeVMCN2Vb6eMEbDEiLDUg/5c6y9Uk/eojI4tlrUhHQWr
 Vbtr17RoK160lJLTSvxA8EGBz1U+v5PGh1GWhwFI4dOnXYJ+8WCC8yHhHtm5nO7u7IQgMHqtes6
 pmh8qrMNWc4U4N9ED8ZznUoAAFvFx8hnHhA3jH7N/UVjxHGI/BSQgb8CBUNrz3c0ykH8KciXFOk
 h0eF5I/uxuT9IDSoSux31+azZvSZk48I1dCZMUSB0SMdxYHPQZWHcV7BrIllEubLiYLnJSVRa8L
 U7ys0ZOQSjvszPVfzJCuerly+U/+NPDRRg4haCunqJ92P+p2zlCyn0YWmHXzlkMFZIfay0IWAaP
 mgu6b2MWyY8+nFfymEGV8Z+LtqRBtETCluej2stuop3zpVYKdLhJJtgkAPWRYmSksHh3ayvJbbQ
 dy2CG0KMh6atavYirWwXjV0xDTR8G6X1YJFCssy5swA74SZxFMEwHooEipZvBoTa30vRQufSYdn
 7XAgm11wgSLshzwdArDe8dxmB3qjGyOAkVEOMSANzlOfK/h6QlMURXX4DwDRIcNuxrnkqyK+11Q
 PgGeo2/+yRRwPGg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
a const *"), the driver core can properly handle constant struct
bus_type. Make sure that new usages of the struct already enter the tree
as const.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index 188412aa2757..7427313adc7a 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -2,6 +2,7 @@ acpi_dock_ops
 address_space_operations
 backlight_ops
 block_device_operations
+bus_type
 clk_ops
 comedi_lrange
 component_ops

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-checkpatch-719a62209250

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


