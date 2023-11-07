Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5597E3CFF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjKGMYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbjKGMYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:24:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C884EED;
        Tue,  7 Nov 2023 04:13:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60660C433D9;
        Tue,  7 Nov 2023 12:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359194;
        bh=8JeZvfjb6rfqVSSk0FouKumdLVSOUEJ3eDb38o4FudQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPVv1wEXiCjOCJ1gXbraNfBPUYUMkaNZEGZ3fgT7NlwwgryD+isFMtzj1Kg4S5Zvk
         e+cLd4xY/uvcxp+nQiWZiq3lvrr0svFc2I/X/5H0r7lBd4w2MSELQDC5CyxRDZMbl4
         h93uTZZSzNsapVy1t6JX7b7uWwzHPZt+sCQBUuvZ6Y07+F8UJbt7RFJmYZO7GABCKk
         XeIKldkYXRYJ8rUn4mRHfdifZwED8siwAAkFqRq2c4sP9ZveHNjJNE0z9IHG5vXfO+
         PJ65CliCOCYSRFX35TxNgd8dF+BG/p59MRGIm+ZMuSaSps37HfjLhC5pncl0fYGbnB
         8rrOSFnHhIG4g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olli Asikainen <olli.asikainen@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, hmh@hmh.eng.br,
        hdegoede@redhat.com, markgross@kernel.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 9/9] platform/x86: thinkpad_acpi: Add battery quirk for Thinkpad X120e
Date:   Tue,  7 Nov 2023 07:12:52 -0500
Message-ID: <20231107121256.3758858-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121256.3758858-1-sashal@kernel.org>
References: <20231107121256.3758858-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.259
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

From: Olli Asikainen <olli.asikainen@gmail.com>

[ Upstream commit 916646758aea81a143ce89103910f715ed923346 ]

Thinkpad X120e also needs this battery quirk.

Signed-off-by: Olli Asikainen <olli.asikainen@gmail.com>
Link: https://lore.kernel.org/r/20231024190922.2742-1-olli.asikainen@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/thinkpad_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 5d114088c88fb..f0d6bb567d1dc 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9699,6 +9699,7 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
 	 * Individual addressing is broken on models that expose the
 	 * primary battery as BAT1.
 	 */
+	TPACPI_Q_LNV('8', 'F', true),       /* Thinkpad X120e */
 	TPACPI_Q_LNV('J', '7', true),       /* B5400 */
 	TPACPI_Q_LNV('J', 'I', true),       /* Thinkpad 11e */
 	TPACPI_Q_LNV3('R', '0', 'B', true), /* Thinkpad 11e gen 3 */
-- 
2.42.0

