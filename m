Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F10F7B2957
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjI2AHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjI2AHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:07:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD71180;
        Thu, 28 Sep 2023 17:07:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so360335e9.3;
        Thu, 28 Sep 2023 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695946059; x=1696550859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg6m2EjjbiYtqCsw8AOrTuHGKcD7Fqnb3Sq4Z2r1iXQ=;
        b=mXqrv6xXmzzedcFAqe0Pr+PdE0cu7x1G6L2T9hBySdc0JHuU7DhHT6CsNOHwwWde64
         dVvbf4T4gOBBFajOOT0Y1S3ER/qDGdqYuE1aRrdfiGn5H8+QIj28Tgk+g4OnBcY8KoJl
         6BjWNkBwLSPOJQt/5+1Ub+6tIjsS4XH+eRjyciAPLOMlF+NZXpm2b0Da3t44DYdPaJx+
         KdT2qLtq0vwM8OlQDa9XB2K2oNgbCZnsxUCkhhhIX/tVtPmBZqMwQwVirTGbz4wEtuJe
         eFC1VfIlfQgM2YIVemnhOUvQ/3jcGTZWWvH5dnZMpWEnNdEWI6rC1BIA3TlZcxAkRsCh
         MvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695946059; x=1696550859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jg6m2EjjbiYtqCsw8AOrTuHGKcD7Fqnb3Sq4Z2r1iXQ=;
        b=DBf2NSylPTYth88JPW9HDNLS/ZlusMy1Bb0/mWod70VSbx3MmeUgJSxQrMwiDahMYo
         cl8XRDOcBW1TPYnYFkIJsVZ/DRrwgQLOr/APf9qXIHREEOwxK9t+UejoTEtSVWX+Rci8
         5WRHBBat++AJmKrCbo2VvmRoqL0YawW3hPNGTKjZ11jpaRpMEhCC64BQetXoGDNJ9DAx
         POLx9AMsFlrnE5aif5eFBQtu2hc+2sG/nqvTVkVz04+FrhemF2jIDSqlfmAN1kc/Q0B0
         cHA8KXClJtwqs6VopSCHWGj18kduM0kMa4TvrBxW/HeTddoeJZVdgHisjNzR0ZwlCo8n
         Hu9Q==
X-Gm-Message-State: AOJu0Yz0ZqGJUIOGL2hK/waAKi4vJKm1Z2/+SYqLfKy55xDb2ATFX+J7
        3ams4sMYst2b3+VVDFMGfp0=
X-Google-Smtp-Source: AGHT+IEGAB6L//kDZLyguasSEjhI9XkPX5IsinA20g0k8iBjOCXCgphovzf/UhPDNxE5yXRjG9y0JQ==
X-Received: by 2002:a05:600c:2242:b0:401:bf87:9898 with SMTP id a2-20020a05600c224200b00401bf879898mr2654028wmm.25.1695946058991;
        Thu, 28 Sep 2023 17:07:38 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fe98:5e2c:1821:4cb6])
        by smtp.gmail.com with ESMTPSA id y20-20020a7bcd94000000b004030e8ff964sm245667wmj.34.2023.09.28.17.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:07:38 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/5] riscv: dts: renesas: r9a07g043f: Add L2 cache node
Date:   Fri, 29 Sep 2023 01:07:00 +0100
Message-Id: <20230929000704.53217-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add L2 cache node for RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
index 6ec1c6f9a403..c8d63a8f7d86 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -29,6 +29,7 @@ cpu0: cpu@0 {
 			i-cache-line-size = <0x40>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <0x40>;
+			next-level-cache = <&l2cache>;
 			clocks = <&cpg CPG_CORE R9A07G043_CLK_I>;
 			operating-points-v2 = <&cluster0_opp>;
 
@@ -56,4 +57,15 @@ plic: interrupt-controller@12c00000 {
 		resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
 		interrupts-extended = <&cpu0_intc 11 &cpu0_intc 9>;
 	};
+
+	l2cache: cache-controller@13400000 {
+		compatible = "andestech,ax45mp-cache", "cache";
+		reg = <0x0 0x13400000 0x0 0x100000>;
+		interrupts = <SOC_PERIPHERAL_IRQ(476) IRQ_TYPE_LEVEL_HIGH>;
+		cache-size = <0x40000>;
+		cache-line-size = <64>;
+		cache-sets = <1024>;
+		cache-unified;
+		cache-level = <2>;
+	};
 };
-- 
2.34.1

