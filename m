Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ACE7EB247
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjKNOgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjKNOfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:35:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F46E1732
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:35:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E02C433B7;
        Tue, 14 Nov 2023 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699972546;
        bh=BQwIlG0oOgH2zbKU3AwqILoaXU3JMfSvJqswNhTlD0w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=AmlkUwAWO2XqB5Mupah1fuEkJfhJfVXANP0fSOIWheOkkVyEjYgz9j3yvniTaEqo4
         Ry/qFI+imv6qgGXpOBByNfMkimEZKWOhV3FsiuTfmz5th39laHGXiEr2oVZw+e15vS
         EtZ26tvBObAmimNESFpf86DUkEiNBu0yN4EUnUTJ2f+ruHKJSCUH5px2P6xwl10VyY
         GavVQiOgexaYYyA7A4mgnR1FO8y8usaViy6rShuWdbth9CqRate8QOQjPMpp8l6fKj
         tXEJ3H/I2loXBwCWGEmSxjZEf1j3aKquS7WnOX7QXEfgoZRPj8NwMeYQIKRmXmvhez
         SwKH5B7uYA/gA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 14 Nov 2023 14:34:52 +0000
Subject: [PATCH v2 07/21] arm64/sysreg: Update HCRX_EL2 definition for
 DDI0601 2023-09
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-7-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=666; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BQwIlG0oOgH2zbKU3AwqILoaXU3JMfSvJqswNhTlD0w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WaHe/+M/b5X9jP1rg5p8morKdu1D8EE6Ahjim2
 yAvg02yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFmgAKCRAk1otyXVSH0J+2B/
 40ib/oULdd/d9oZVEuawOWDa+pD4lu3zatx1xVBQOmZy4xvOcIiLzhjp8vhx2C7aLHPkRYpIm9t0n0
 TCcHEMnJdWHJTLn6ovctmFh9B3ERG4KJ3n9ZkB2UTnMfxe7VGSFsVu4H7i3r0kmwIXzrqAQbxuis5E
 acPfNP0zEi+QM7eIrsTYq5TgIel0icPITsGchgTknOC89jSdgJ5xQHwlBGgbaaxUxLSPxMONxajjDR
 gRTbVr+wEkvkQ0HaFv7Ef7qQP+U1KvsRmaZGQTNEYa6Vdz++KvgMUO11ClQkFvs3jUsRhUYcgTKj0m
 LnS+mw+o0eDK+3veaphPvBhj2vW4Lf
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
index eea69bb48fa7..0b1a33a77074 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2412,7 +2412,9 @@ Fields	ZCR_ELx
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
2.30.2

