Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB347838BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 06:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjHVEIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 00:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjHVEIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 00:08:09 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C00E133;
        Mon, 21 Aug 2023 21:08:07 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-570c36ec14bso1334935eaf.2;
        Mon, 21 Aug 2023 21:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692677287; x=1693282087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=T288SDKA+dAUp3epFi2zz0EN87ulU7VPbJPxlcFLbGA=;
        b=T89ypOk2hpwV6Dx4wUCcqyCkVcBK/nQK8phU5cs5DWUgRIbi3APg6XUUI05yQHdw5S
         qhM7hRiYKS4TvkJ+122wDsG/qkNyTIRfxHp6NhgoSkfSnk5/waj9Dlp+7rGrBwoC7ITk
         ER6yLtKJr6JxO7f1hVM3qbJQ9w4ovF0mc7fOJaApL8AIWdDpH49CHf7Fh74uuYRx0ihM
         qhrAZfx02faO1Dq6198Pnl8zgCK9SOhZDw46exMygQ5iQgAyx3UF5midYiLvfEGC8lGO
         9xfnln3wC1aYsYKrmHrHDMBnRzBkQPXpvUFoqRD4xtJYM2YFKjKrHIa1Ue7jF0OKEj6m
         H4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692677287; x=1693282087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T288SDKA+dAUp3epFi2zz0EN87ulU7VPbJPxlcFLbGA=;
        b=LDMan8wv3YLzPkrppodA3ffCQgyCmRVX3/ANCLJAMpGBZD+AzTsceM5mzSiTV5IwXW
         Cm5As0fRLUo/VXDzuSHAbcUGl62MOm71LOyccsmQGCl6lBjurPwfRZ49J+eb1509xomp
         9BEam9UeiLPXPff/Qh9tlr7GrLCWO+eQd8zymVDfhFJa3bvROq5gWaHzhLVDcsXy3UkN
         GxiNLQidLdeN0JWk6aZszQOjs3rA5k2b7zQ8DDPBby0teCipM/keJuzp9mfcmJK9aW31
         qjNzc8SYidC2KFd5M+XjV4+vtRZBrwRht1D8UF6rpw8GoDOZSx24nKrpl/Z5UfPtCMG+
         22Ag==
X-Gm-Message-State: AOJu0YxFVQRTCz5IaqiZTSnI08y1y3NZZ77lryj33DXBZWlUXdQgpKWR
        veYJW33tNXDTQDlZ7MeKn84=
X-Google-Smtp-Source: AGHT+IFtkj1uqd0tVjj77tv5Sy69QQ422mMgrAf1KMyrBuevpizi6m2H5Jnne4BPH89MOet5kHJRWA==
X-Received: by 2002:a05:6358:342a:b0:127:f2fb:d103 with SMTP id h42-20020a056358342a00b00127f2fbd103mr8798856rwd.16.1692677286669;
        Mon, 21 Aug 2023 21:08:06 -0700 (PDT)
Received: from sultan-box.localdomain ([142.147.89.200])
        by smtp.gmail.com with ESMTPSA id j15-20020a63b60f000000b0055b44a901absm6329974pgf.70.2023.08.21.21.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 21:08:06 -0700 (PDT)
Sender: Sultan Alsawaf <sultan.kerneltoast@gmail.com>
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: mvm: fix power save for MLD
Date:   Mon, 21 Aug 2023 21:07:41 -0700
Message-ID: <20230822040745.260086-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

The conversion from bss_info_changed() to vif_cfg/link_info_changed()
removed a call to iwl_mvm_bss_info_changed_station_common() from what
became the vif_cfg_changed() path. As a result, BSS_CHANGED_PS and other
power save changes sent via ieee80211_vif_cfg_change_notify() are ignored
for MLD, which breaks power save entirely. This has a noticeable impact on
power consumption, causing idle package power to hover at 10 W on my
i9-13980HX laptop with an AX210 while connected to WiFi.

Add the missing iwl_mvm_bss_info_changed_station_common() call to the
vif_cfg_changed() path to fix power save for MLD. This brings idle package
power down to 1 W on my laptop, a 9 W improvement.

Fixes: 22c588343529 ("wifi: iwlwifi: mvm: replace bss_info_changed() with vif_cfg/link_info_changed()")
Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 8b6c641772ee..6abc05976870 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -731,6 +731,8 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 
 	mvmvif->associated = vif->cfg.assoc;
 
+	iwl_mvm_bss_info_changed_station_common(mvm, vif, &vif->bss_conf,
+						changes);
 	if (!(changes & BSS_CHANGED_ASSOC))
 		return;
 
-- 
2.41.0

