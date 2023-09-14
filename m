Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC2A7A00DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbjINJwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjINJwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:52:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB39BB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:52:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52c4d3ff424so864403a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1694685160; x=1695289960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TS/7vUKah3wQsVKISaCeppACKo70oIuxqL7ut4bD3Rk=;
        b=xGwjr3phX8gp72gugG2KxS/G3qPUnC0ft0Nk1cC3TVAieRanHF2fZbH3a8bG+xLXPp
         HoyDcytJWFBzN/Xy5+BIZB6Kp1EjQ1aIZbxrNj16Vo+nsWe8keJ5W65RggmQl3w0p+GI
         uQXFvNSteukdIejx0CRWnuXP6KHaXqceMG5GGEPE5LYK5PZczZnrtScY9+9f3k4+Pisa
         IsaBQF9mhDjtCeI+SymsGcD1DJImDn7mu02uVccjvaPGBS0fEQZNQr0GhQ0+dkeRt/O5
         zdbObr5/JXOd3QREFOzXztWp4sTUuo0+PzTEfGoAgFym7JKvh/M9qvdLvzn8QSgzcEh6
         RrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694685160; x=1695289960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TS/7vUKah3wQsVKISaCeppACKo70oIuxqL7ut4bD3Rk=;
        b=IDXm1C4ef7G2HTH+zdmoqD2y+JnT6m/dJ72VgS9K4dG9qVMfQIK1IpfYdZpJenOtXL
         cxOf6p2q9hPNiKHtjOZYGBAYjWzu7kn4abnMzobmrrLVTWUzlTJo5HZwf3w4aIGkytqw
         D3pUisi09vGRuVffA9DiZ7ivFJn+9PiWYkbxUbv+0Q2ya2GWH8qKRldBeozvYEzHBkgR
         sV7CVRHQ0w02ziVhxFNMxn99UUtpeox/zexg5INrWzjFREWkvmDqv+EFocuUoyZOPoM8
         VBddznIjcS6l1QjE891oXv7HGBTv1SV96+Pa4zyZpVP+Th8DvFtOQ40+l28jnyIQkyQl
         Dekg==
X-Gm-Message-State: AOJu0Yy/4AXt8WhnUITCc4angUlZXl8WIvDRiKery5hnso/oT3yPyCS3
        HsqqKMCrvxsRzGy8MRngT2p5Zg==
X-Google-Smtp-Source: AGHT+IEFepv2UEjgFQD6ZD46b4UWZ4owTGR65FwbhUcsgG4wuC+yA3aFsYEQKuS2o0dYU/jP4mPqTw==
X-Received: by 2002:a17:906:73c3:b0:9a1:e613:2569 with SMTP id n3-20020a17090673c300b009a1e6132569mr4048315ejl.16.1694685159753;
        Thu, 14 Sep 2023 02:52:39 -0700 (PDT)
Received: from fedora.. (dh207-96-100.xnet.hr. [88.207.96.100])
        by smtp.googlemail.com with ESMTPSA id i21-20020a170906851500b009894b476310sm760072ejx.163.2023.09.14.02.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:52:39 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/2] MAINTAINERS: uDPU: make myself maintainer of it
Date:   Thu, 14 Sep 2023 11:51:57 +0200
Message-ID: <20230914095236.1601639-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir is no longer at the company, so I am stepping up to maintain the
Methode boards.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa7487b7729b..e0c4cf40cbb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13873,7 +13873,7 @@ F:	Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
 F:	drivers/staging/media/meson/vdec/
 
 METHODE UDPU SUPPORT
-M:	Vladimir Vid <vladimir.vid@sartura.hr>
+M:	Robert Marko <robert.marko@sartura.hr>
 S:	Maintained
 F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
 
-- 
2.41.0

