Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8307CB662
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjJPWOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPWOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:14:34 -0400
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA34AC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:14:32 -0700 (PDT)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-1bf00f8cf77so7057979fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697494471; x=1698099271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ALxTMHKSX9vk9LInFGXIsQlmMV2+SYhgETcxWL9x/EE=;
        b=V5Apc0xzqaOQbvtUB53YlnDjhvDY+irp2i3O+b04eR8IZOS9xyE4uVUESYiDCcdewA
         jqTlMiWlAJ/P37vr3A5hAKFRZYE7Vvf58meZc/vwts5IIrlg42/gH2W2Am4uYwwzX+Jd
         WmEV2bIyj1pjylMeJjx9BhmnUbPv75HzfgNjrTBS9DUcYmdzIXjtlGvHtFy0xxTT5XNV
         aC0C+XH1xaguL+5kFUIeJen/2hIDAQfrSmWbnvIoeVIY0cJG+MvdYmVJAF4m4Fco/pEW
         XCdcKqJaW/mrPxq7EvCmXF6aDEEXaT7o/tt8untE+1amPtoMbUj2x2SejkKdobaOOiq1
         RokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697494471; x=1698099271;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALxTMHKSX9vk9LInFGXIsQlmMV2+SYhgETcxWL9x/EE=;
        b=YeoGF+k7x3M4EXOF8kHJgbakHCfmOe7FuJaHnnc/E9bW3Q+x2LURPsviky9Jzz97G+
         LcsxV61d2NxmcTZdgQpLqky0sV8qeFWZsVZy8dIvUiUcgHYYUp36eSm/+TP6Oyxqqdvz
         pQRr3BHpua1PvN7ranZTUj0NB+w5hXQu/vhhzdMdkcJjBKGnt42UPZLsXCv9PD7S/ovN
         eGvRjfgffEB3YIY5+YTMlEUiS2inIOrW2s262gYWYLq6zOEt2mARQIj7sbpEAkyG5b8B
         auPexm7VtJ9mdznhC1iDBLEzj2KKJOyu3jKIqeix8rIoyk+qDBWmJIwdGQHPMPDTXa8i
         hsrg==
X-Gm-Message-State: AOJu0YwPJF7FCcTTPDD4IFj2GYfayOe35tP/vKSIlXSdgxVIkFH2NRK1
        /36C+QyJBUV8eF5j6WhfBrXhyRfk4BTblFeMyg==
X-Google-Smtp-Source: AGHT+IGTkjig8ugPvK85JlzEG2yFhqIXubRd7Jd2JB/wxjUE5zKQN2nA8oXT08qQRlvT5ondf1fmt/E24ve9DaydGQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:f14d:b0:1e9:ee3f:4c7c with
 SMTP id l13-20020a056870f14d00b001e9ee3f4c7cmr191133oac.2.1697494471600; Mon,
 16 Oct 2023 15:14:31 -0700 (PDT)
Date:   Mon, 16 Oct 2023 22:14:30 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMW1LWUC/62OQQ6CMBBFr2K6dkynIDSuvIdhUctQmgAlU1Ilh
 Ltb8Qru3vvJz/+biMSeoridNsGUfPRhyqLOJ2F7MzkC32YXSqoCJVYQF57svELLPhFHmGiBl2c
 aKEZ4cjCtDWMGO2qpEA/qRmPBdu6XWDBKotSlwkpfRV6amTr/Pl48muy9j0vg9TiV8Jv+dz8hI JSqKLWsrZE13V0IbqBLropm3/cP8FA8kxcBAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697494469; l=8326;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=x6UyWSnThuXH9c2MRuctGdlyru9O2YWpxiOjh3U5t6w=; b=4kTogY9/mozkZBn6aXlySV3d0PM4HHnjkJ/jTCsj9agkf5mWF14vf29nvu4sLRN4Xnke/uhp/
 twkvb6GcJ6jBM/Mw5TVhgo5SUrlzyEKSXh8YBUccPuIb5WVew1aGpO4
X-Mailer: b4 0.12.3
Message-ID: <20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v2-1-6c7567e1d3b8@google.com>
Subject: [PATCH v2] brcmfmac: replace deprecated strncpy
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

This patch replaces multiple strncpy uses. For easier reading, I'll list
each destination buffer and mention whether it requires either
NUL-termination or NUL-padding.

1) ifp->ndev->name

We expect ifp->ndev->name to be NUL-terminated based on its use in
format strings within core.c:
67 |       char *brcmf_ifname(struct brcmf_if *ifp)
68 |       {
69 |       	if (!ifp)
70 |       		return "<if_null>";
71 |
72 |       	if (ifp->ndev)
73 |       		return ifp->ndev->name;
74 |
75 |       	return "<if_none>";
76 |       }
...
288 |       static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
289 |       					   struct net_device *ndev) {
...
330 |       brcmf_dbg(INFO, "%s: insufficient headroom (%d)\n",
331 |                 brcmf_ifname(ifp), head_delta);
...
336 |       bphy_err(drvr, "%s: failed to expand headroom\n",
337 |                brcmf_ifname(ifp));

In this context, a suitable replacement is `strscpy` [2] due to the fact
that it guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

2) wlc->pub->srom_ccode

We're just copying two bytes from ccode into wlc->pub->srom_ccode with
no expectation that srom_ccode be NUL-terminated.
wlc->pub->srom_ccode is only used in regulatory_hint():
1193 |       if (wl->pub->srom_ccode[0] &&
1194 |           regulatory_hint(wl->wiphy, wl->pub->srom_ccode))
1195 |               wiphy_err(wl->wiphy, "%s: regulatory hint failed\n", __func__);

We can see that only index 0 and index 1 are accessed.
3307 |       int regulatory_hint(struct wiphy *wiphy, const char *alpha2)
3308 |       {
...  |          ...
3322 |       	request->alpha2[0] = alpha2[0];
3323 |       	request->alpha2[1] = alpha2[1];
...  |          ...
3332 |       }

Since this is just a simple byte copy with correct lengths, let's use
memcpy(). There should be no functional change.

3) wlc->country_default, 4) wlc->autocountry_default

FWICT, these two aren't used anywhere. At any rate, let's apply the same
reasoning as above and just use memcpy().

5) di->name

We expect di->name to be NUL-terminated based on its usage with format
strings:
|       brcms_dbg_dma(di->core,
|                     "%s: DMA64 tx doesn't have AE set\n",
|                     di->name);

Looking at its allocation we can see that it is already zero-allocated
which means NUL-padding is not required:
|       di = kzalloc(sizeof(struct dma_info), GFP_ATOMIC);

6) wlc->modulecb[i].name

We expect each name in wlc->modulecb to be NUL-terminated based on their
usage with strcmp():
|       if (!strcmp(wlc->modulecb[i].name, name) &&

NUL-padding is not required as wlc is zero-allocated in:
brcms_c_attach_malloc() ->
|       wlc = kzalloc(sizeof(struct brcms_c_info), GFP_ATOMIC);

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- add other strncpy replacements
- Link to v1: https://lore.kernel.org/r/20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v1-1-4234807ca07e@google.com
---
Note: build-tested only.

I've grouped these all into a single patch instead of a series as many
of the replacements are related to others and rely on context from one
another to justify changes.
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c      | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c  | 6 +++---
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c      | 3 +--
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c     | 4 ++--
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 2a90bb24ba77..7daa418df877 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -866,7 +866,7 @@ struct wireless_dev *brcmf_apsta_add_vif(struct wiphy *wiphy, const char *name,
 		goto fail;
 	}
 
-	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
+	strscpy(ifp->ndev->name, name, sizeof(ifp->ndev->name));
 	err = brcmf_net_attach(ifp, true);
 	if (err) {
 		bphy_err(drvr, "Registering netdevice failed\n");
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index d4492d02e4ea..6e0c90f4718b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -2334,7 +2334,7 @@ struct wireless_dev *brcmf_p2p_add_vif(struct wiphy *wiphy, const char *name,
 		goto fail;
 	}
 
-	strncpy(ifp->ndev->name, name, sizeof(ifp->ndev->name) - 1);
+	strscpy(ifp->ndev->name, name, sizeof(ifp->ndev->name));
 	ifp->ndev->name_assign_type = name_assign_type;
 	err = brcmf_net_attach(ifp, true);
 	if (err) {
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
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
index b7df576bb84d..3d5c1ef8f7f2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c
@@ -584,8 +584,7 @@ struct dma_pub *dma_attach(char *name, struct brcms_c_info *wlc,
 		      rxextheadroom, nrxpost, rxoffset, txregbase, rxregbase);
 
 	/* make a private copy of our callers name */
-	strncpy(di->name, name, MAXNAMEL);
-	di->name[MAXNAMEL - 1] = '\0';
+	strscpy(di->name, name, sizeof(di->name));
 
 	di->dmadev = core->dma_dev;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
index b3663c5ef382..34460b5815d0 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
@@ -5551,8 +5551,8 @@ int brcms_c_module_register(struct brcms_pub *pub,
 	/* find an empty entry and just add, no duplication check! */
 	for (i = 0; i < BRCMS_MAXMODULES; i++) {
 		if (wlc->modulecb[i].name[0] == '\0') {
-			strncpy(wlc->modulecb[i].name, name,
-				sizeof(wlc->modulecb[i].name) - 1);
+			strscpy(wlc->modulecb[i].name, name,
+				sizeof(wlc->modulecb[i].name));
 			wlc->modulecb[i].hdl = hdl;
 			wlc->modulecb[i].down_fn = d_fn;
 			return 0;

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-a20108421685

Best regards,
--
Justin Stitt <justinstitt@google.com>

