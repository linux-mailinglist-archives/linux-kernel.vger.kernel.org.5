Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05EC8051C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376910AbjLELPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345052AbjLELPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:15:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571289A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:15:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBD6C433C7;
        Tue,  5 Dec 2023 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701774919;
        bh=Tbzzrz0GhjjdIHOAsVLhTZq78N+oP5wAxgm97zPGVsc=;
        h=From:To:Cc:Subject:Date:From;
        b=NFYFnmuKS0WzyxOfAAasCNC/vmQ9bdu3V3dv4Q9p5PyEi9wTW/ulnWoPWDk+VBS7p
         Id/S65IC4aLXQTpVDMX6mmlCw17Pkus2m5j7xtWZAulSLby+akXoZWV+kzmzjse+L5
         NKu9v78OqIreSTKzBSf3vKlrHqQ8v0seet4qRcZRNnRGuhn60RZexC0I8UnjgjTrLH
         K+bsprx8/Bd4b0b+l3PI4sXQsf0J/c/YJmfdW/zq+QRkT7Ns388ZwCJcnX8Ue/SzAM
         aB1XZnmuz5R641+bVSevJ+hb4EDMLUCXZSNktWPU7ZOt5mMOW64jxNIf/OHyoUQZip
         X3UEPoJhshlLQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Felix Fietkau <nbd@openwrt.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] ath5k: remove unused ath5k_eeprom_info::ee_antenna
Date:   Tue,  5 Dec 2023 12:15:15 +0100
Message-ID: <20231205111515.21470-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FUZZY_SPRM,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-struct [1] found that ee_antenna in struct ath5k_eeprom_info is
unused. The commit 1048643ea94d ("ath5k: Clean up eeprom
parsing and add missing calibration data") added it, but did not use it
in any way. Neither, there is a later user.

So remove that unused member.

[1] https://github.com/jirislaby/clang-struct

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Felix Fietkau <nbd@openwrt.org>
Cc: Nick Kossifidis <mickflemm@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/ath/ath5k/eeprom.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/eeprom.h b/drivers/net/wireless/ath/ath5k/eeprom.h
index 693296ee9693..e85b713950b1 100644
--- a/drivers/net/wireless/ath/ath5k/eeprom.h
+++ b/drivers/net/wireless/ath/ath5k/eeprom.h
@@ -489,7 +489,4 @@ struct ath5k_eeprom_info {
 
 	/* Spur mitigation data (fbin values for spur channels) */
 	u16	ee_spur_chans[AR5K_EEPROM_N_SPUR_CHANS][AR5K_EEPROM_N_FREQ_BANDS];
-
-	/* Antenna raw switch tables */
-	u32	ee_antenna[AR5K_EEPROM_N_MODES][AR5K_ANT_MAX];
 };
-- 
2.43.0

