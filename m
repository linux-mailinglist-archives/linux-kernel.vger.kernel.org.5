Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50F776F5F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjHCXEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjHCXEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:04:07 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6096826B6;
        Thu,  3 Aug 2023 16:03:34 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bbd2761f1bso12862535ad.2;
        Thu, 03 Aug 2023 16:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691103814; x=1691708614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCqXZ3aIK41APZmJUyJtIADVAZfdOyyUdWhlq/zah+A=;
        b=fDdnhKSG4bsPDkze8O0TyzQZbYZp6PewHRUfNahc+nCM4/zHnU/hC33jgPCn8WxNGI
         PanrrHiN2ixafjxeVoWpUTdFgrePLV5gljn6hX41bIvgcyVDvYdy9XdEa8pJU6hb8p91
         825Npwd8BrAs603s0OCIFp3X0lc1NvYzCIULip3Nu7I2+n4zfoFsJVAL0uKGqS8WTL6G
         F1Pos0eVj3+fxcFo1XvpMnHv8NS/0a2uJwr1ULwQoq3UzFKmu/HOuh/0VoAkS0xmaKZ/
         aYTcwtExKf8TMofcCaOzFse9RiByWN0X9J+52yaIupkdwp7d/FyXlocqIpbB1pb+iJKi
         pidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691103814; x=1691708614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCqXZ3aIK41APZmJUyJtIADVAZfdOyyUdWhlq/zah+A=;
        b=REyDZYHhKdN4EmU3pZYQHEQhsH9li7BIYEM38ttgWAoPXlbjTYozgbzm/q4CdycilJ
         0XJvwo7x21Rhz0kCcdDJdTjy7OEmfibGJOkqIfb+/LeG9dhBp0R8DI9CLnl65/A7FmOL
         0J7gl49AMXkrTa+H0lLsfK/rQJxoulc7jAlWYQZSEwKODN6LXTEfEooCGSn0CFFv57pZ
         4sHssr+bDsdz6fbpw4Ffq60CQI2QRkYHawPCauQVj84V/NU+Dr9KJYT1VGqNNW5ZCZNU
         4c8CkNm9JdgPSb6FZ7KJWLBv8cXNyeTUlpg8okne90m3uzY1uOI6uYyHeqGlx0dSnYXq
         lIHw==
X-Gm-Message-State: AOJu0YyhLpcnKVq8hdye1hrd2jjpYRKmSuBNqTBI3OhpivXzqwcilTMh
        fql9OzQOw/acmteVJ3DNxDLsm95Un+R7aw==
X-Google-Smtp-Source: AGHT+IFw83JkMH1zRFqh+nnFbGXM33XYKbnbZ7+OTETUvcthEPrk5UoB/wpJrlNmpd81eYTIu+evLw==
X-Received: by 2002:a17:902:7d91:b0:1bb:9c45:130f with SMTP id a17-20020a1709027d9100b001bb9c45130fmr94201plm.69.1691103813895;
        Thu, 03 Aug 2023 16:03:33 -0700 (PDT)
Received: from taoren-fedora-PC23YAB4.thefacebook.com ([2620:10d:c090:500::5:e60a])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090322c700b001bbb598b8bbsm372349plg.41.2023.08.03.16.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 16:03:33 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        taoren@meta.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 2/3] ARM: dts: aspeed: wedge400: Enable more ADC channels
Date:   Thu,  3 Aug 2023 16:03:23 -0700
Message-Id: <20230803230324.731268-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803230324.731268-1-rentao.bupt@gmail.com>
References: <20230803230324.731268-1-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Enable ASPEED-ADC channels 5-8 to support voltage monitoring of all the
Wedge400 hardware revisions.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
index ed305948386f..5c55afed946f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
@@ -59,7 +59,8 @@ chosen {
 
 	ast-adc-hwmon {
 		compatible = "iio-hwmon";
-		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>;
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
+			      <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>;
 	};
 
 	/*
-- 
2.40.1

