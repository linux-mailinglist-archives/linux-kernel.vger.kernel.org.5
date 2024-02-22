Return-Path: <linux-kernel+bounces-76899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C55D85FE5C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8B61C25641
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131758C0B;
	Thu, 22 Feb 2024 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv/VWJu1"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53811552E7;
	Thu, 22 Feb 2024 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620280; cv=none; b=u2D4psykWxVuH6f6SxeMhT85YfTlv/Tp8etApndNodvXOTXMgs802HAm+zhLN5d/q2n9YR/WmSQUkHo4sAqiiYXc5Ywe/YMtS5wOkI3jMxI0PpDfB7KFnJWiPOJDfySE9rL1q+YZnVlBI02CLpFcJcYE2BnM9wZDWnrsFoP4EBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620280; c=relaxed/simple;
	bh=Z430PI7b/xHtUxak96DMBj+edhpX9NXBhwZDo/BO8nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C6687DrZ6UYsaRO5YJmyoz4geTbo2mugeJ1GsYhQ0AKPzAgRBON6hpUZMxt0Fg6H7fV1HBoe/fWG2X3LrTD57snN6N5KlB/QfHKj4QJLcJV/9BPxg+G7lA1/nhs3Wv2ljgcXIuJNT8xC7aHfoWK+ObPUliLe/quxjMUkPjQ754g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv/VWJu1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41275971886so15806215e9.3;
        Thu, 22 Feb 2024 08:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708620277; x=1709225077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJbQ3RMr2l9g2dwn49+72QIs9q2n9zDfNSkTMBZwZqU=;
        b=gv/VWJu1r5WqmV3RjbJbfEqoqWXn532ayLMEmzDVqvp8rwFgp5IRfQySmg/dyMZVeo
         KSELY32dwnDhJG863c+dfkGztbfW77Pw0+NVl24sptgYZSRdK9oMdYLzXCRVvWqOuxfJ
         Y9/K9CjxKg0i166VnGShNjTFk8bBsCW6loHzSx/rzQhlYjW18FCkZcWOSM2QnV9CBuSo
         7zRVOq6bu2yrxXfpwtqpKFG3jLYtJbeAH+c9KzNH0hABIqP/MyeLgXXjeZvs5rSt2QR4
         B9GcUI14sJY4KaRBBNnoAqsMtlVt5itT6M9k6A8AXG/nRJ7/VRk7g05JX7zEfVvU4Hxw
         1mAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620277; x=1709225077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJbQ3RMr2l9g2dwn49+72QIs9q2n9zDfNSkTMBZwZqU=;
        b=WfOBgaPY+DtnkMRYX5cUrgPCldHIY9h0grDXIpKXCOH/d8l6j6qBMHGVCZO6br1zDA
         kqivA7MmwkqflhxQqgz+NLn38q0l45cgyme8PKymwDooDFXBbhJJQEAb/9ZvOLI/V+WP
         V6Fsdr4UavE57QOLs1NR/iDoOirTzq7RtbNpf/+NB37rdi7zadWgKL7MAy/B2pmysHG9
         iGfJD/b3nrsJQHAVq6dOVBQBH8U+lDPPXhgwIZFZ+sCHCDNKJwUklZ0MdN38yCc1uGkM
         K841Jx0r1ZjKxdNCt4H+bFqAZZ4HAsPoc5qPhjFRuOhCeZGcPFNHq94uNytE5fKk7TW4
         9nMA==
X-Forwarded-Encrypted: i=1; AJvYcCXyO897fLvC+URLr0cVvDozO48InzeXQCddY4gLhOaHDbOLvHHKh1VicsL2GX8daFvmKEWf5zDaptzH3kX4ZSwcggOViyyR8t1coKLD4gwL83UDkMj/iM2DqsoInFpT2BlJvt1BZ9wtjg==
X-Gm-Message-State: AOJu0Yw+0KoFQgkKlrn1KfxYTzhlWUp2Xl0WVEdqLuDGA/6lUE90ratc
	CkLynIchYFW7WDja6VazLOgqnx5iApbqtSDaLUvsw/YOQJWP1S/M
X-Google-Smtp-Source: AGHT+IFzXwKQPSxSSxzZqbXiZzBKkMFdfxPv4JL+1o3Iq/5dLUL4kB+1nHUcUFbHgsQgjKD2SH3foA==
X-Received: by 2002:a05:600c:1c1e:b0:412:1d7d:6c51 with SMTP id j30-20020a05600c1c1e00b004121d7d6c51mr16054487wms.6.1708620277066;
        Thu, 22 Feb 2024 08:44:37 -0800 (PST)
Received: from localhost.localdomain ([90.255.110.157])
        by smtp.googlemail.com with ESMTPSA id r2-20020a05600c35c200b004123b049f86sm22800420wmq.37.2024.02.22.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:44:36 -0800 (PST)
From: Adam Green <greena88@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: greena88@gmail.com
Subject: [PATCH v2 2/2] dt-bindings: display: st7701: Add Hardkernel ODROID-GO Ultra panel
Date: Thu, 22 Feb 2024 16:43:14 +0000
Message-ID: <20240222164332.3864716-3-greena88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222164332.3864716-1-greena88@gmail.com>
References: <20240221194528.1855714-1-greena88@gmail.com>
 <20240222164332.3864716-1-greena88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ODROID-GO Ultra panel is a panel specific to the Hardkernel
ODROID-GO Ultra. It is 5 inches in size (diagonally) with a
resolution of 480x854.

Signed-off-by: Adam Green <greena88@gmail.com>
---
 .../devicetree/bindings/display/panel/sitronix,st7701.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
index b348f5bf0a98..3eb306161f1a 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
@@ -30,6 +30,7 @@ properties:
           - anbernic,rg-arc-panel
           - densitron,dmt028vghmcmi-1a
           - elida,kd50t048a
+          - hardkernel,odroid-go-ultra-panel
           - techstar,ts8550b
       - const: sitronix,st7701
 
-- 
2.43.0


