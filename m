Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F10D7F9679
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 00:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjKZX2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 18:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjKZX2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 18:28:17 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F0F13D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:28:21 -0800 (PST)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BF4CF3F18D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701041299;
        bh=O3TPicaObXUf+CQ2/13bF4S5EM9ZMGJpI/eXjOZpsCQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=USWA50dviKu0ODjnStxQ60N4E+f8SjbFwNwDDVLiIrVYhRORgfsiYUX5/sOvV9Ghg
         NMGNopa+TC+kpym7UssVLMivTbm7UhptxPPap6oDi4uwfgouGTA3bTDQuIy8t1j7ut
         ZrOCi0Vy6bUFJ24TWfpNJx0voiCHDXFgC7D3nmUzeGUsDj91KKHdyae3ZRU0LDeBhv
         wIanGTdK47sawznoTpUQi+50wYdYpKplSzyZeE/KM0+XA9X0NL19h2eXzbdrR0PCLy
         IaqfOF9WT49ahcqsHQq1IZvIz2z5QVKtkPIYCqmwBGsRWJR07ZkoVTD781KZkskIxO
         HJV4fH3Z1rDsQ==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1cfbce9218bso15850075ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 15:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701041298; x=1701646098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3TPicaObXUf+CQ2/13bF4S5EM9ZMGJpI/eXjOZpsCQ=;
        b=r8F5+fG2972hQBfqXzlFaqEHAl90r3QrgL8eV8Sq/CLHnDnidh2BBgGoMFgJyqFE2a
         pTUcI/jJq/Fidusvjy/Gtif4+Cnzts/Kd3g/7PKNLFz4rHzvDM6g+j9NGHWmghZaengB
         zWSvwA7gnkx0NK4bu3xYpsFDtpp/LkGn9DAZ2r23gzGEWtKxfcvpzHyN2zsid9rxZLB1
         NNv0199ohbPV8vU2gs325p9TCyMuVrC38eU0hpVHxv3zrG3YO/y/L5zV1m0EhjOXhpxw
         QVOtHe3q6qV+N+UXvoNbJ4vVRbtb2C/OuxNp06m9duGiB39yhJD1NK6cKbzHbxPASnVZ
         v+eg==
X-Gm-Message-State: AOJu0Yw6pvHFIceq8vAYDy7pBq36NeLZk3gyeADpOo6iPNb+vz0MBVQ8
        cQHfuW+Uo010vDMVZU/TFLAKa5Cl355XCVm8mTgtAcpuCN16T1zW/fX1yWGDrQBYmq0MxJ0wy8n
        BBUVn96/PwIYICXvQRESVAxq+XG7ekn5051z1VBP1Qw==
X-Received: by 2002:a17:902:be08:b0:1cf:747e:89c6 with SMTP id r8-20020a170902be0800b001cf747e89c6mr8786551pls.26.1701041298544;
        Sun, 26 Nov 2023 15:28:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFuQM7m8wCn6b39aPT5b9YXgOSCYAQDDWmZ8ylvHuaFNyspEtnWGrMk3kxYgR8lkzRlvz2bg==
X-Received: by 2002:a17:902:be08:b0:1cf:747e:89c6 with SMTP id r8-20020a170902be0800b001cf747e89c6mr8786540pls.26.1701041298276;
        Sun, 26 Nov 2023 15:28:18 -0800 (PST)
Received: from stitch.. ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902b48a00b001cfb52ebffesm3123853plr.147.2023.11.26.15.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 15:28:17 -0800 (PST)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v1 3/8] riscv: dts: starfive: Mark the JH7100 as having non-coherent DMAs
Date:   Mon, 27 Nov 2023 00:27:41 +0100
Message-Id: <20231126232746.264302-4-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
References: <20231126232746.264302-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

The StarFive JH7100 SoC has non-coherent device DMAs, so mark the
soc bus as such.

Link: https://github.com/starfive-tech/JH7100_Docs/blob/main/JH7100%20Cache%20Coherence%20V1.0.pdf
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
index a40a8544b860..7c1009428c1f 100644
--- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
@@ -144,6 +144,7 @@ soc {
 		interrupt-parent = <&plic>;
 		#address-cells = <2>;
 		#size-cells = <2>;
+		dma-noncoherent;
 		ranges;
 
 		clint: clint@2000000 {
-- 
2.40.1

