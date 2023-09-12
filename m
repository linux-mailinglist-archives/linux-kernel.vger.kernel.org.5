Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132C279D339
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjILOHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjILOHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:07:41 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3196D10D0;
        Tue, 12 Sep 2023 07:07:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c1ff5b741cso51351935ad.2;
        Tue, 12 Sep 2023 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694527656; x=1695132456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUhyRSqjAJMHfchXSv8vB6A2VUPoLZLC4S3Qj9415dE=;
        b=XG86PwzQ+t7k8IhfWQSvZcrkSvW30Hy+v/GbUhIEAdxnUbGqtUroxcEcok61X3/2cR
         WaqVXMhoCBsUThD77qldz1iDpBMbHvHPExGYadGiIkFY8TnJCYox2JJA1ER75odL0j2P
         Bghas5nm31LfwZt8CeLbbXDZPj6L2VFf8rkKIMGxOFTN79CebJwBEmlxv99UWz1AZNoy
         QoZTqB3ROlYWe8ZoCA7rBTkVXhTlRcwWPY1d/5c2xZfVqo6xkWPqfi9bKuYhS0osbwvE
         YPAKejYk4rkCLhB08K4wlQatWCZrAwrZo7/uN2V58b5kHlafbbXj4QLAiCgSk3fTcZnv
         vH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694527656; x=1695132456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUhyRSqjAJMHfchXSv8vB6A2VUPoLZLC4S3Qj9415dE=;
        b=ZNo0zbq23aA71nTuWzZMPShBo0CVBYFZzIg4QGVzyKGTZ5uYbL/AFCwwOHgllnk86c
         rQhlhq3rNWZNYbwHiPkGiUv+WMBITo9XP1VWZR3VcbOAqhWrXobpNm6W1j+lXj8mWSYm
         vRvoonshAC5RbvAHx5Un4xEGxIjRk6gPAHSdjlDxBVILZmDGDfOTJY37kVSN+GwXzQru
         j8lMo8OgIa+vb6Wci0n75Ln+ZbzY5guYs7jMVVkPU+1tQmf/KiAr/c2yKVnDdpP1f/4l
         nsBsDUUUVF7QV+gNryn/ZAPNWSycvDxmL1IldDWP6lgdb2miaLLWK0HtZeOeQLmrmkRd
         c9gg==
X-Gm-Message-State: AOJu0Yx8bHeXrATAnJJ87mmlqJ/fkvavLZe6dmD1y23pEpH1XgL46Rqn
        +6skYb3553qWPO6vWmFjMkUX/zla5+w=
X-Google-Smtp-Source: AGHT+IHXvjk+tZSSBEb6ffotvkMtR8CMbCOjafTNW6qXt3LTUbTa1WVbgUKpMeGmB758hjn/I+dyow==
X-Received: by 2002:a17:902:e5cc:b0:1c1:f6d1:3118 with SMTP id u12-20020a170902e5cc00b001c1f6d13118mr19644997plf.27.1694527656627;
        Tue, 12 Sep 2023 07:07:36 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id jb11-20020a170903258b00b001ae0a4b1d3fsm6357762plb.153.2023.09.12.07.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 07:07:36 -0700 (PDT)
From:   yangchen.openbmc@gmail.com
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     patrick@stwcx.xyz, Jerry.Lin@quantatw.com, Eddie.Chen@quantatw.com,
        EasonChen1@quantatw.com, yangchen.openbmc@gmail.com
Subject: [PATCH 0/2] Add CMC of Facebook Minerva platform
Date:   Tue, 12 Sep 2023 22:05:30 +0800
Message-Id: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Chen <yangchen.openbmc@gmail.com>

Add linux device tree entry related to Minerva Chassis Management Controller
(CMC) specific devices connected to the Aspeed SoC (AST2600).

Yang Chen (2):
  dt-bindings: arm: aspeed: document board compatibles
  ARM: dts: aspeed: Minerva: Add Facebook Minerva CMC board

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed-bmc-facebook-minerva-cmc.dts       | 265 ++++++++++++++++++
 3 files changed, 267 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts

-- 
2.34.1

