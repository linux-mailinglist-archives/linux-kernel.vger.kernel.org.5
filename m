Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C23A7CCD99
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjJQULl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjJQULd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:11:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491EC6FAA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:11:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7bcbb95b2so93685087b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697573491; x=1698178291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U16d/1k+vtJxpQ32+/WF4Jgqek04k8/6Qv2CuyTmXCM=;
        b=GDEw2UZD8lhNP6ELGmB+xjB5hHNDqRBbdhGPd9h1sG3qFnW/nPWcOxYFXEZ+Wd9J/N
         lPlZkZPgX2mH6M5V46HwIGj+Nui06vZpUDlRdMhyL10A/rkUnYuQHwhUIhYkpHOGCUws
         /dd432KsbYNybH4owBweGCQJVzMEdNZRwIlH2/gO1oCsVtoudADx6YfHCg1ed9siU13J
         xuof9Gn1cEuw6PDxWcnBd/+IRqSiXvuz1rLOanse6ob7Qvv6lDZMANcWcKl7C3DYZgOD
         tfDBPzctQg5MZAmdHt+iGEtkD34/lvmuQwPl028phrBANLBjZrdU21FeRzhC/sc0ng3E
         RC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697573491; x=1698178291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U16d/1k+vtJxpQ32+/WF4Jgqek04k8/6Qv2CuyTmXCM=;
        b=YLrI3sZiOLNpy7e0jPlt2JB2GmjR3k4ngjaHgYMiRMNqLJydz9yvGlhrvRrB7f5gzC
         0+T+irqnuSthUbg27R7/zIlP/fBo8gOQ+onCYcxdOAZdem8y5QEC2lmZTpGLDkdotEU8
         yp8xGdo/AafKWVmTMWV88CohnNDYkKJMa4WkLcsrE60TRYNDvwWaeEzvXkYoF2wEeaOe
         30rfq62VbSH/Q0I3HcpKYuR30ArX+GBRVuxlXnr3cwFyuCn31KOn12RF3Rdr9QRxsfTN
         OQwPT5f3nfX4BRcz2Iojuk/0PmWz4ivU622RBP6LHuVW8O2HXjHS1u0CcDDN2H7bN0xm
         SoJA==
X-Gm-Message-State: AOJu0YyhLkLAGGB1qwjA1fF9aFgJoJJ1aW0AsKBKm9uweuCMOBxOjhx6
        B2FpASrtuIjX9r7laxdYIQg0T4iV7fJRyK+Jdw==
X-Google-Smtp-Source: AGHT+IGpHQMAlN9H+dIGsgef4tZ3F2beOgDLdbLhwLbsk5LDWsH2GwN5lcJpP9ul6mWvpEKLa973Tu7cXXdTrNS5Nw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:84c8:0:b0:59b:eb63:4beb with SMTP
 id u191-20020a8184c8000000b0059beb634bebmr71930ywf.7.1697573491197; Tue, 17
 Oct 2023 13:11:31 -0700 (PDT)
Date:   Tue, 17 Oct 2023 20:11:29 +0000
In-Reply-To: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-0-af780d74ae38@google.com>
Mime-Version: 1.0
References: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-0-af780d74ae38@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697573487; l=2638;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=zJRX9bfYMLnf8bwx/y1SqZRLrWT3yCChHrc9KJ+aw0g=; b=36Wx10SOxayn+TXLBPF3Sdbo+ZOjyWFKEXOZQUWfzf/HDZaBLlDvUd/FbJiQtsFySN1BKVG9K
 S2f9g+oP7StAX9U5Iv2XSJNPkbxap07eIIAsrMoZPt/V36oDC327Jgg
X-Mailer: b4 0.12.3
Message-ID: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-2-af780d74ae38@google.com>
Subject: [PATCH v3 2/2] wifi: brcmsmac: replace deprecated strncpy with memcpy
From:   Justin Stitt <justinstitt@google.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move away from using strncpy and instead use the more obvious
interface for this context.

For wlc->pub->srom_ccode, we're just copying two bytes from ccode into
wlc->pub->srom_ccode with no expectation that srom_ccode be
NUL-terminated:
wlc->pub->srom_ccode is only used in regulatory_hint():
1193 |       if (wl->pub->srom_ccode[0] &&
1194 |           regulatory_hint(wl->wiphy, wl->pub->srom_ccode))
1195 |               wiphy_err(wl->wiphy, "%s: regulatory hint failed\n", __func__);

We can see that only index 0 and index 1 are accessed.
3307 |       int regulatory_hint(struct wiphy *wiphy, const char *alpha2)
3308 |       {
...  |          ...
3322 |          request->alpha2[0] = alpha2[0];
3323 |          request->alpha2[1] = alpha2[1];
...  |          ...
3332 |       }

Since this is just a simple byte copy with correct lengths, let's use
memcpy(). There should be no functional change.

In a similar boat, both wlc->country_default and
wlc->autocountry_default are just simple byte copies so let's use
memcpy. However, FWICT they aren't used anywhere. (they should be
used or removed -- not in scope of my patch, though).

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
index 5a6d9c86552a..f6962e558d7c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
@@ -341,7 +341,7 @@ struct brcms_cm_info *brcms_c_channel_mgr_attach(struct brcms_c_info *wlc)
 	/* store the country code for passing up as a regulatory hint */
 	wlc_cm->world_regd = brcms_world_regd(ccode, ccode_len);
 	if (brcms_c_country_valid(ccode))
-		strncpy(wlc->pub->srom_ccode, ccode, ccode_len);
+		memcpy(wlc->pub->srom_ccode, ccode, ccode_len);
 
 	/*
 	 * If no custom world domain is found in the SROM, use the
@@ -354,10 +354,10 @@ struct brcms_cm_info *brcms_c_channel_mgr_attach(struct brcms_c_info *wlc)
 	}
 
 	/* save default country for exiting 11d regulatory mode */
-	strncpy(wlc->country_default, ccode, ccode_len);
+	memcpy(wlc->country_default, ccode, ccode_len);
 
 	/* initialize autocountry_default to driver default */
-	strncpy(wlc->autocountry_default, ccode, ccode_len);
+	memcpy(wlc->autocountry_default, ccode, ccode_len);
 
 	brcms_c_set_country(wlc_cm, wlc_cm->world_regd);
 

-- 
2.42.0.655.g421f12c284-goog

