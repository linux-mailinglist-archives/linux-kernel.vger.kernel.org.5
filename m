Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494057E3C99
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjKGMSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjKGMRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:17:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C9347AE;
        Tue,  7 Nov 2023 04:12:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD14C433D9;
        Tue,  7 Nov 2023 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359145;
        bh=zfKJ+5U7ja/wVd7W5lmV5jCJWYxwoIg6HNWEDMykYbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPF/fjRUNnzEqcgtcbF6fWr9aQJuMfpMIJzWip6aC25Ane+a7PGBPVPzC9M5ym5I/
         lDKDXQ7GyN995788xNCSejMNWrf//SvZHhjxMIbG9jkDq67qTypnC9R2W7SZN/2kXx
         HbTC4XmFdtvfc5z3ptpSrnAzj1oZkLGLU/yYVh4sRM24EeZIAXcwxQLYkhDEPIWuFU
         6dJwYMEl63I1Fd1+DSI+cXMvE6IeFPn1j2BlGrkzGg60SAWiu65lxH0ztvZapBs42v
         Qmn0s/vOZPZZEAbd+PNGVQRqyeXt+r+BXgNL6b/DVwl76LWKP3AjzziJ3q3cAumhTH
         jj/c0V0wB8xqw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olli Asikainen <olli.asikainen@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, hmh@hmh.eng.br,
        hdegoede@redhat.com, markgross@kernel.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 12/12] platform/x86: thinkpad_acpi: Add battery quirk for Thinkpad X120e
Date:   Tue,  7 Nov 2023 07:11:49 -0500
Message-ID: <20231107121158.3758348-12-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121158.3758348-1-sashal@kernel.org>
References: <20231107121158.3758348-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
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
index 3dc055ce6e61b..99c19a0b91513 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9766,6 +9766,7 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
 	 * Individual addressing is broken on models that expose the
 	 * primary battery as BAT1.
 	 */
+	TPACPI_Q_LNV('8', 'F', true),       /* Thinkpad X120e */
 	TPACPI_Q_LNV('J', '7', true),       /* B5400 */
 	TPACPI_Q_LNV('J', 'I', true),       /* Thinkpad 11e */
 	TPACPI_Q_LNV3('R', '0', 'B', true), /* Thinkpad 11e gen 3 */
-- 
2.42.0

