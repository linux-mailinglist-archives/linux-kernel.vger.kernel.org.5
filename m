Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31537A0147
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbjINKJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbjINKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:09:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09A51BE5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:09:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5195FC433D9;
        Thu, 14 Sep 2023 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694686189;
        bh=Ph1QIKdVjkVEt01kGS7XEed/+iwNMPsBtoTj3MTHHHI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=qDEb9gH4XcGOGQe2i4YMDoc8b83InYT3V44DQ07XkusTeAswpTLO97KvQjoV8Uq3P
         YXyHjheyrrk9bX5J3Quj2YeQ8NIroFJ6DYHedVFOYRVk7nKd3c2GGqgd0zF3dBldbC
         1JsrKKNUKJoo2TXZAQJrBjPrs2CgsxUsal0ajfphUnzvUka1Iosw8lFy+j7P6yWDMz
         X8KEZvjxN3xNmtX64q45r19DsQpc4DIWO0EkVqkqCAUevai+t4/57O/xn2Jxx+hbq7
         YWwt/Jx8FPu5Azpb3RN3sqZBrH32c04dDWjV8+Xcu3GOcaEVtYJF2Q0oc9lyEJ0gPK
         J4OIOYhyaQ0VQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 14 Sep 2023 11:09:30 +0100
Subject: [PATCH 2/2] arm64: Document missing userspace visible fields in
 ID_AA64ISAR2_EL1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-arm64-feat-hbc-doc-v1-2-797d25f06897@kernel.org>
References: <20230914-arm64-feat-hbc-doc-v1-0-797d25f06897@kernel.org>
In-Reply-To: <20230914-arm64-feat-hbc-doc-v1-0-797d25f06897@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ph1QIKdVjkVEt01kGS7XEed/+iwNMPsBtoTj3MTHHHI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlAtvnxkbRuK5kzDGrpuzJocjYG1wDTV4U7dUAphnm
 BfoLhu6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZQLb5wAKCRAk1otyXVSH0MSDB/
 9/1jsK6N4aj9djEDGml1hVJPM35zpQFTaP5eJ0eQKaI7hyNK0QKAY1tVu3bUZR5aURmQORMed4X+Av
 qX2iywDncNL6oZxVr/Ww0R13/ouJzC9IDGZx4KwDTZxkSidOIUyx3qDJVVwOohV04nsnN8vUcsBSQ8
 zpc45DSC9YyIzRMEBX1SF/ZT1xNwooLB996cpkbzUSZj1kGb0l9+wyYO4B9CUQFmwLldd4SF/H4Mrd
 rUT0NCtQT3Zst8skkSLY3FB/XahSySu+/Y22NBBpqmKseiY2PzE1cfDpH669UD2Fg4MpLML3xP+l68
 vzgBL68ul55XlLbFRP7jThVfpqqfFP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have exposed a number of fields in ID_AA64ISAR2_EL1 to usersapce without
adding the matching documentation in cpu-feature-registers.rst, update it
to match the implementation.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/cpu-feature-registers.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arch/arm64/cpu-feature-registers.rst b/Documentation/arch/arm64/cpu-feature-registers.rst
index 4e4625f2455f..46fd82acafab 100644
--- a/Documentation/arch/arm64/cpu-feature-registers.rst
+++ b/Documentation/arch/arm64/cpu-feature-registers.rst
@@ -288,8 +288,18 @@ infrastructure:
      +------------------------------+---------+---------+
      | Name                         |  bits   | visible |
      +------------------------------+---------+---------+
+     | CSSC                         | [55-52] |    y    |
+     +------------------------------+---------+---------+
+     | RPRFM                        | [51-48] |    y    |
+     +------------------------------+---------+---------+
+     | BC                           | [23-20] |    y    |
+     +------------------------------+---------+---------+
      | MOPS                         | [19-16] |    y    |
      +------------------------------+---------+---------+
+     | APA3                         | [15-12] |    y    |
+     +------------------------------+---------+---------+
+     | GPA3                         | [11-8]  |    y    |
+     +------------------------------+---------+---------+
      | RPRES                        | [7-4]   |    y    |
      +------------------------------+---------+---------+
      | WFXT                         | [3-0]   |    y    |

-- 
2.30.2

