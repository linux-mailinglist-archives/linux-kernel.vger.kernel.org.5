Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4352B80B136
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575001AbjLIBEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbjLIBD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:03:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B71119BA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:03:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185BDC433BB;
        Sat,  9 Dec 2023 01:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702083831;
        bh=h41/yEXI+o50Oc3NG9xANl2JpB+4l5IG+bShc1ZdP70=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ZtItTxVWzNIHlFRmSWpUEjBpP/tPeb5t1s8wELIkkpgq1cbtLD6hWyGKkI/PWvNHl
         DwnjI47uCAT+5CZzPzcrVGVFJmVvlbVr44vNs3DegTwjnoiWjQ9+w7o47X2CMTnI8F
         ZO5YBxhnC/9JRtzVLgaYrUujc162bBYo3q6E/I+zT9TZLMV8wmlm5G6Af/S85YP0oF
         VVBqFuaA864tC8f+yw7LpX50XlT9EzJIrPtFmujq05d38Ctk4RBB3ITIsPW67ajige
         OOGwH2BBLzi4OHwp/oCwlhXGjGXsljZtFzyqDsk/eehkDjzIjOC6JMTrTOtZMhvxp0
         kr3QpN83DyCHA==
From:   Mark Brown <broonie@kernel.org>
Date:   Sat, 09 Dec 2023 01:02:57 +0000
Subject: [PATCH 11/13] arm64/sysreg: Update HCRX_EL2 definition for DDI0601
 2023-09
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231209-b4-arm64-sysreg-additions-v1-11-45284e538474@kernel.org>
References: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
In-Reply-To: <20231209-b4-arm64-sysreg-additions-v1-0-45284e538474@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=666; i=broonie@kernel.org;
 h=from:subject:message-id; bh=h41/yEXI+o50Oc3NG9xANl2JpB+4l5IG+bShc1ZdP70=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlc7zc1MnIaV8NZplKHG5RkwOvCuQ35Q0T8zRek
 aT9ZNM1arSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZXO83AAKCRAk1otyXVSH
 0EQ5B/4/b8gbAtO+26fOdwf4u5pUh0MYeFHA3AMLqvdJ/JcZ8bN/C+GzJcpyWjVUGkPQeMmDHXR
 BH0J0cKuOka9iWXTEwnnmiwH9mRvsiQOIF1B9m7jUF6XxFYN9mApwqo+ou4388aq4+mYIuZ/iqD
 cS2KZSVy5Q9KERwvOAjjZ9Q1nP/hVgtNJ4n9zJiqo2JVYE7lA6LhxAlVatCJYoKCJdBRsqky77r
 IhJS4xG9C8i0Pu813Zn4u5q8p2fVRn9cArpku8I+8sC7GURP6w5bk5fX9cmplCeyFSyrZ+Xrvzw
 Qsde5v1kEwMmF9AUj0Gow4HQ5UZp4Ty6TU14vbrixYapjXLZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DDI0601 2023-09 defines new fields in HCRX_EL2 controlling access to new
system registers, update our definition of HCRX_EL2 to reflect this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 4137179e7570..1acec8f5c37d 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2458,7 +2458,9 @@ Fields	ZCR_ELx
 EndSysreg
 
 Sysreg	HCRX_EL2	3	4	1	2	2
-Res0	63:23
+Res0	63:25
+Field	24	PACMEn
+Field	23	EnFPM
 Field	22	GCSEn
 Field	21	EnIDCP128
 Field	20	EnSDERR

-- 
2.39.2

