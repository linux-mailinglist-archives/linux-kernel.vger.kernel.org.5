Return-Path: <linux-kernel+bounces-78208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9BA861043
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 476EF286F1A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB82D763EF;
	Fri, 23 Feb 2024 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzAaElrm"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37A5D47A;
	Fri, 23 Feb 2024 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687361; cv=none; b=P2AdVud30w04aUWSIxnHnnGesgDvtQbba4ewZl2lJwDLOQskB7w0/SC8o8sc5oMK6w0x2UWgsyfHn0Gk/Iu7DSDGI3Ydzx1j11+OtU14BSzDah+qP6zrZF4c1pPUlZ1IO/fG4aM8SL6LDQsdQjgEspMRmm/RzeWfTggrLE1b35A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687361; c=relaxed/simple;
	bh=7UvKRmG7swJfDdVxCMKMXceTL0sGIOI++hM+zeNhxp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jeKMs0MvClxqMoTvC6gcrhoBmjzu1+z4N3ZOGXtiEXNlEuJyiX+tBjRPbfgocpDIAreNxOlI6yNJ03I421W8dD14PiOxT+3ZHGJGsMt7f/Wo0nHZws0AMoMHhG5paAA9oacn1FwjxJsaBF5dN/3jOjJiTcs34q9/2hFES32xQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzAaElrm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso743979a12.2;
        Fri, 23 Feb 2024 03:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708687358; x=1709292158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UkDOlwqdJKpgBN8ZxM5dkFMSj6BTyDau6P8LZmuFdvk=;
        b=ZzAaElrmn6VXvmqW+Mh9/JNXjD4EsUhGLoEjxI/6qmtZV4Cej7aq+ywteOPdFzbNOJ
         nEBqpJZFluWJEWs3Dpyxew3/ex9ZtBw1JvpY0Xga+laQ5Iy07ux2AvKDVFjf9qS4Bh8F
         HPaPk40jhak32bXucr/iDgEJ88KB/YlPZvcaH43qic/TGxmrZvpsu7/pGSJ3xHQASOCi
         iAcbKVVPbKz2GVJ+780K79yabmdJIovDEYzCEG/goHndFlywICPqgrS7ZAWiTEDy4E8n
         vJnl8TLBWcED1D7XX/KyDeBtrDaoF03IzL1ckyCiEfKqhgcUv5/pXn1ERLF8TYqpXkZ5
         GEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708687358; x=1709292158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkDOlwqdJKpgBN8ZxM5dkFMSj6BTyDau6P8LZmuFdvk=;
        b=erk4eG+of11IsXnwht97rL0B2xalgqEG2gi43HX9Rr5uo4inTQMF0ESRS22RzBXRRH
         31OEP+lHir3HiXzeaFyPnZcOQxdBdSJbAz3D6vrMZV5Cvzihl/IePSksOT9Rpq6QSwpl
         jv2jx4p5xo8vCByLhPSDljD5k8ZgGJqPxmvBwZrzfoRrMCu9N7BNh68TdT/yLxINQg3X
         CEPbSzdRyiX+Y8dVlm1OFBOG2QhfbqASt8phMuwRHh9TSX1jrOqDimGVzKBdio2m5pds
         xe4UHVCr4UYOqLUd70zd3xYjBFvlDoQqdL8tX7uEE9DN4RlJWX/yZS5miX4AG/JQBguD
         mLJA==
X-Forwarded-Encrypted: i=1; AJvYcCVANrWhMz1NUg884ApRvOJIPGRt5a5OTqwu1oyKWy4VSvqeFgboo+ELc6LiEjV/NeNLyyAZNeKcWrKxpUmqnl5WUWOWP4yM3Z5ZHPko5nPODIeTngkX9WPZ7QidWAYrsfpXOMhAi12/j16e8xV8iSd5NEKAsDFavKlXawoTeXOBQwuy7co=
X-Gm-Message-State: AOJu0Yz5aY/QMIiga3bsxzb/1jt0wO5RM2ig2ZmOmFGEBqh30t4Pnuck
	5UDyBZsIiY9EL3hAlA4YfBPt2IwltFdEz/MTbuU1dpYQJ4CkrJY3
X-Google-Smtp-Source: AGHT+IFZW7dV98KKwCf84FGK0/EQszkPfkxlwIa3iHUC9ZlPt9zPVQjeD12dAL2y7Blnw8IOmLtBfA==
X-Received: by 2002:aa7:d958:0:b0:564:5227:972 with SMTP id l24-20020aa7d958000000b0056452270972mr1045362eds.33.1708687357745;
        Fri, 23 Feb 2024 03:22:37 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id f23-20020a50a6d7000000b0056392b7d85fsm6776984edc.9.2024.02.23.03.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:22:35 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: leds: Add LED_FUNCTION_WAN_ONLINE for Internet access
Date: Fri, 23 Feb 2024 12:22:23 +0100
Message-Id: <20240223112223.1368-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

It's common for routers to have LED indicating link on the WAN port.

Some devices however have an extra LED that's meant to be used if WAN
connection is actually "online" (there is Internet access available).

It was suggested to add #define for such use case.

Link: https://lore.kernel.org/linux-devicetree/80e92209-5578-44e7-bd4b-603a29053ddf@collabora.com/T/#u
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 include/dt-bindings/leds/common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index c56785bb9c9c..ecea167930d9 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -100,6 +100,7 @@
 #define LED_FUNCTION_TX "tx"
 #define LED_FUNCTION_USB "usb"
 #define LED_FUNCTION_WAN "wan"
+#define LED_FUNCTION_WAN_ONLINE "wan-online"
 #define LED_FUNCTION_WLAN "wlan"
 #define LED_FUNCTION_WLAN_2GHZ "wlan-2ghz"
 #define LED_FUNCTION_WLAN_5GHZ "wlan-5ghz"
-- 
2.35.3


