Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943527696AF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjGaMqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjGaMpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:45:38 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAA81732;
        Mon, 31 Jul 2023 05:45:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36VCjLVG052749;
        Mon, 31 Jul 2023 07:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690807521;
        bh=0SPxnqfcfXqJPJHs3ZuUuj1K0BeWP3lEXqx31mscRxs=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=NWHNiKj0EA7uEIJz3quLOuXfpVBFR2EkLXL+PMM8ysxheJYi/g4MJTuR4ZCgx9cZN
         IHZGPw05uQfn84/PQhmXq0iteslspKCm0xu5TLMLBt0kV+sOjgrlSot432mX5pFh3X
         9xKjzj2y6U2Br3NvyM/66dce6lvzXoTEs7JEpSz8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36VCjLuP129524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 07:45:21 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 07:45:20 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 07:45:20 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36VCjJLZ053839;
        Mon, 31 Jul 2023 07:45:19 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Mon, 31 Jul 2023 18:14:42 +0530
Subject: [PATCH 5/5] arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230731-mcasp_am62a-v1-5-8bd137ffa8f1@ti.com>
References: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
In-Reply-To: <20230731-mcasp_am62a-v1-0-8bd137ffa8f1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=819; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=0ijyOKlC5ndUpjhAONPKbgHmRC/lYyw8qmoHFT7gdmc=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx6zaQrBUCUwdQO74KzDtYXrr5YpgT68L0VR/J
 v0FSy7sMzOJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMes2gAKCRBD3pH5JJpx
 RS0eD/0QjulXmCkUghLeoQFqcpKeHNiDXqjyJ7oULO4akslP8vI1WvxjVyzt+7wvYsbNcqlJDEe
 lMdPSLO1A2NM3R6LQ0BvA5baX8qGvfeAuPV+k3GA/lnbzwPz62TABPU4s7CzrP425vdGvso529z
 /AjBA+tAh/HioHc957AatgMDJKUPtImLIFh6X2YPKmn6rpXnjq9nyyIJn2mqiUEo8heazSyIprG
 2gR/Fhe4sN96CyBhpifckYcvb2zLLZUOZnuzi5nHq37jT/Y/ExP7/AbguGjmtLrbzPiTbDaflBx
 t15EySsAL4JMdSJDY6htUm2bP58HXNWKbPUlymec86N7s8+vDUzv4cN1x7Rq61ByDyXVP+JwC/8
 NhoBRjbYfRypxsUHVSTR2TV5s/3ORC9zdRylISpYZXKuvZNFahExeJfM9Nn+6PqnocWcv8bptqP
 COUNLgdKijt+zzJnLr7NepMbj16CHUmrx8h72ZBQkNSe8cQTjJZCwmwxjQmL29LguUuv6j4xGDu
 zU1ph4x6YxZ3efvvz2GI1uKnSUv/VZyymhYLQoib4PrVj+0ZU002RxW6sDBT+CLSD6p7ZUR0Hri
 yCIwyoTKnf9jMsTDIjmUAWBEgfX2DiPFLH5eFIi7ys+mgd/o++kojGYyU/qRe9lCQQSNJgN4HHN
 2Qr2w3WALwCNHpQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SK-AM62A-LP uses TPS6593x PMIC (interfaced over I2C) to power the SoC
and various other peripherals on the board [1].

Specifically, the audio codec (TLV320AIC3106) on the board relies on the
PMIC for the DVDD (1.8V) supply.

[1]: https://www.ti.com/lit/zip/sprr459

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 03fce1752521..9bcfa9b50876 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -714,6 +714,7 @@ CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_SL28CPLD=y
 CONFIG_RZ_MTU3=y
 CONFIG_MFD_TPS65219=y
+CONFIG_MFD_TPS6594_I2C=m
 CONFIG_MFD_TI_AM335X_TSCADC=m
 CONFIG_MFD_ROHM_BD718XX=y
 CONFIG_MFD_WCD934X=m

-- 
2.41.0

