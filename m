Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C917DFD9C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjKCAmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 20:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKCAmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:42:51 -0400
X-Greylist: delayed 158698 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 17:42:45 PDT
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DF68E;
        Thu,  2 Nov 2023 17:42:45 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id C1DE3C01B; Fri,  3 Nov 2023 01:42:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698972163; bh=RzvmctwGXogr9xqojN5AbOAahcbtWaJOICtS6/njRvc=;
        h=From:To:Cc:Subject:Date:From;
        b=s2oS9b9bxlVxLoFQ9d4tf1Jjzo4rdoSVVf+o2u4Xus9xGYPpse+rlq+XtFbRj5Hoe
         j81SRfdn/TxyugMXHWPs/RcaLN71P6wLZHK6fsuQ+RiyHfiaH9NK0kdMYpfaov82VH
         WObH6AMZqXRdmTWysLtXybUJBwazYsMfBdRq7mVttYCr12f8J7/xkr3NwjYxVUYxa6
         v4V3VK98pQ1KhjDNw8lvvDdMKJHSRYIHRTYJTfpfHuMatjFI3ZqVi8g3mghU/usLIV
         wVTO3qW2nenn3PGRbqjisBeHy7PHZtfjNFerZQDMOh/GBn8B3nOsNUPLEB1MMbhTF4
         2rBwKLNko0pHQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id A5845C009;
        Fri,  3 Nov 2023 01:42:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698972156; bh=RzvmctwGXogr9xqojN5AbOAahcbtWaJOICtS6/njRvc=;
        h=From:To:Cc:Subject:Date:From;
        b=mFJcve/2F+O36Rp6Qmfj8LeJVMhFHnVkjvzFhV1qQcttGBOxebiIx77PJutNTFYsc
         ZP8nZTrU2eIarFyqR3oyp+9Yzba0BpKfbFoSsByy2vkW1wPKgE5E2ivfS58CfoNElD
         H9Hz9BdwWm5y7wzsn6C+do7YAGOoK0qHnYifvAFwAJ6Y2k5m65ypzwK0DTuiQAXqTh
         MjozQzkfAI1OEaN6mFbZF/QHJZO3J4pCIJvjvNs3MqP5+hI2tDn0v5gRSgj1uobjBg
         gvtKT6XmH1hAea9BAZqkz3zsT6yilG9qCHIvZ2xmhsNkARdpOS3LeraF7HzW9fG1UE
         OXORIJENXLntg==
Received: from gaia.codewreck.org (localhost.lan [::1])
        by gaia (OpenSMTPD) with ESMTP id 8f93054c;
        Fri, 3 Nov 2023 00:42:32 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <dominique.martinet@atmark-techno.com>,
        stable@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Alex Fetters <Alex.Fetters@garmin.com>
Subject: [PATCH] Revert "mmc: core: Capture correct oemid-bits for eMMC cards"
Date:   Fri,  3 Nov 2023 09:42:20 +0900
Message-ID: <20231103004220.1666641-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

This reverts commit 84ee19bffc9306128cd0f1c650e89767079efeff.

The commit above made quirks with an OEMID fail to be applied, as they
were checking card->cid.oemid for the full 16 bits defined in MMC_FIXUP
macros but the field would only contain the bottom 8 bits.

eMMC v5.1A might have bogus values in OEMID's higher bits so another fix
will be made, but it has been decided to revert this until that is ready.

Fixes: 84ee19bffc93 ("mmc: core: Capture correct oemid-bits for eMMC cards")
Link: https://lkml.kernel.org/r/ZToJsSLHr8RnuTHz@codewreck.org
Link: https://lkml.kernel.org/r/CAPDyKFqkKibcXnwjnhc3+W1iJBHLeqQ9BpcZrSwhW2u9K2oUtg@mail.gmail.com
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: stable@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alex Fetters <Alex.Fetters@garmin.com>
---
Here's the revert as discussed in "mmc: truncate quirks' oemid to 8
bits"' patch thread.
Feel free to ignore if you already have something, I just checked your
-next branch quickly and might have missed it.

 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4a4bab9aa726..89cd48fcec79 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -104,7 +104,7 @@ static int mmc_decode_cid(struct mmc_card *card)
 	case 3: /* MMC v3.1 - v3.3 */
 	case 4: /* MMC v4 */
 		card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
-		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 8);
+		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
 		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
 		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
 		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
-- 
2.41.0

