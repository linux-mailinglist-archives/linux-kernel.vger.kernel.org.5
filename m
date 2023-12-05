Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220C3805C4A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345145AbjLEQvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbjLEQvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:51:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A211DD48
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:51:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD1DC433C9;
        Tue,  5 Dec 2023 16:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701795094;
        bh=BQwIlG0oOgH2zbKU3AwqILoaXU3JMfSvJqswNhTlD0w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=jqyb5YMtNSsewilq3YgjUOLKB+5TZZxOhPMYtacsADuHV8SBMnhdKtzSjTyhHZzEm
         oHXzvNzWcQ35s5gb0XHhcwYsPuCIfmzAWUOjxccMbJ7aLMNYNu7h5m7yhO69cr6X8t
         LsO6yW8ieiimIM9EXiu1nACFt0WA42BnELODdvKRUqRokUjAT/C5ykYMeifPEIqOBW
         mIYJ54EZGqaRkHnYm0SqWHEbfLZ0M3trtrhBndFjMptqvobpIvoDWlQ9L2I03m/Cc+
         5Wh2CroQRUBi4vwTtvYR6gBzWxLVb/qKP15pjJVdEWF2Zt2yeRzVQmoSGbJNUieP+I
         Z810MDLonuF4w==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 05 Dec 2023 16:48:05 +0000
Subject: [PATCH v3 07/21] arm64/sysreg: Update HCRX_EL2 definition for
 DDI0601 2023-09
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-arm64-2023-dpisa-v3-7-dbcbcd867a7f@kernel.org>
References: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
In-Reply-To: <20231205-arm64-2023-dpisa-v3-0-dbcbcd867a7f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-5c066
X-Developer-Signature: v=1; a=openpgp-sha256; l=666; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BQwIlG0oOgH2zbKU3AwqILoaXU3JMfSvJqswNhTlD0w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlb1TuD6frcSkllH1UYYR40YWIjqreDBRNueDypCOq
 XjYki6OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZW9U7gAKCRAk1otyXVSH0BxSB/
 9+aykVaLXXkovSxvPoWNp/dLjsV1+Cm+xxFo/z24bos92b6gHOP83wnIEddgbLtyoJtveduZ+hsSeY
 ZvnCX1wUSAZLjZhpk0cj+8IlJE+GzQjGOBch6dmNJyy6GxvrkJ7rgbtuzUcPbRRKC1awZTD+zZbthm
 deDPd8ar/7eFE3e+/XV6heK4bWGNaXJWPHZin6myifMPB5U5pES0DduUMSnGzZiFqX8Qg6jGZqOB29
 BgYGCxIQOyEwNsIHOblnca6qoeB9K3jKV+u6VV3dz4NqhWWYFSmOor2/jrtkJKriL0HyUcNpUb8NKt
 M2wHrXrpV/8B2oTE7OBLn+RVW6XABe
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

