Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E227CCD98
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbjJQULf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQULc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:11:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BC16FAD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:11:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9b9f568f27so4077892276.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697573490; x=1698178290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui+yzBeCi4InBjuyJPgf+DR/WwQH9rt9/DWplSIMOHU=;
        b=ZCuy4p31X0jloLomlNs8XJvcVmD3ttbQZNyoTaVJtOPWzGnvcoBOUQ2e/4YMwqDivW
         pChbMBubGifg0+wkZkXMzdTiOKUuB2aHMAmxB/9Mv8KsYLbxxdet6YiS9GbpB9OwWGP+
         sJ9MQKnRqO6kmkX16VHGXNBm/5FFiL5LcC/s7VEtw2d3fSgO08wVJjvOUoXGe3acumjv
         EkufxrbqH+2EIGEBN4qJjUPQvmH6LXMlXY/gUAso3wV6XIzldjhKz1I+tgIm3AbKrm/+
         UZ2/G73GkTq6YTO+i+aw3ZLEmZZDdVslZk+qd691sC6QrCIlIg/kQrVi4wKYfOZuE0he
         fBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697573490; x=1698178290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui+yzBeCi4InBjuyJPgf+DR/WwQH9rt9/DWplSIMOHU=;
        b=g9sMQ5/hA/dR22G/EXkv8/0Dgx0uk17drcDfw630JB5hPk4AROSS3WqEhylSMoRr3Q
         azgVTzXygB46/Xu74d0DeoxPszHQatx747dHiJ2ExD9XntGaiEWht2/M8UqK5lLmrRst
         4T9lbhLoYjOlXL519NLt5V8Br9YHL0y0Bom+BcErNZFbwS0yKs8pWI6b5MXaeEIeFQat
         0pwcwpW6LLXxpLi0dT7XOYbg+yXd1GR8RK9wBmGiSR/hQJnAvf6vLddkuOHJZSyqB5x9
         ZnaDgzlm/qU+caVs/iR0w/QcdFru9MBpzwMn0KlsTmhyIDKzMWp6gkKB5dNLt2dFaxKh
         EoTg==
X-Gm-Message-State: AOJu0YxbbtgQRIs/mrV8rJnSOVtfBo1MD/eq7MZJGigGJ5YSwONGtd6c
        wm1AOxfNIlF4vbuBDTN9OrRZbXh8pqlgenW2Jw==
X-Google-Smtp-Source: AGHT+IFdwSVFWDCbuxt9p23HfZYWm/J4eAdvM+BOXOvX8s65kb3vTO6keHsPW31fPGnVCQ1IRGQlfmNgVa+/ISopmw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1346:b0:d9a:54e7:e910 with
 SMTP id g6-20020a056902134600b00d9a54e7e910mr71519ybu.4.1697573490059; Tue,
 17 Oct 2023 13:11:30 -0700 (PDT)
Date:   Tue, 17 Oct 2023 20:11:28 +0000
In-Reply-To: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-0-af780d74ae38@google.com>
Mime-Version: 1.0
References: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-0-af780d74ae38@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697573487; l=4966;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=gHDinb9a9sswIvj29QskOHXNeesA8YN3gdLsehwyx1o=; b=nAmbdGpBqSQNB9t1IYFTrpRaeC1QGXnuDgq0waS/15OL6TsrXeiVeYGUhvKYWMguhBQNEWYZk
 gJw9TTzVK+NDSiJlDVIqhgFT6x7JwDNKYduhIJHm8v3luvNPMUIb0OH
X-Mailer: b4 0.12.3
Message-ID: <20231017-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v3-1-af780d74ae38@google.com>
Subject: [PATCH v3 1/2] wifi: brcm80211: replace deprecated strncpy with strscpy
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

Let's move away from using strncpy and instead favor a less ambiguous
and more robust interface.

For ifp->ndev->name, we expect ifp->ndev->name to be NUL-terminated based
on its use in format strings within core.c:
67 |       char *brcmf_ifname(struct brcmf_if *ifp)
68 |       {
69 |            if (!ifp)
70 |                    return "<if_null>";
71 |
72 |            if (ifp->ndev)
73 |                    return ifp->ndev->name;
74 |
75 |            return "<if_none>";
76 |       }
...
288 |       static netdev_tx_t brcmf_netdev_start_xmit(struct sk_buff *skb,
289 |                                              struct net_device *ndev) {
...
330 |       brcmf_dbg(INFO, "%s: insufficient headroom (%d)\n",
331 |                 brcmf_ifname(ifp), head_delta);
...
336 |       bphy_err(drvr, "%s: failed to expand headroom\n",
337 |                brcmf_ifname(ifp));

For di->name, we expect di->name to be NUL-terminated based on its usage
with format strings:
|       brcms_dbg_dma(di->core,
|                     "%s: DMA64 tx doesn't have AE set\n",
|                     di->name);

Looking at its allocation we can see that it is already zero-allocated
which means NUL-padding is not required:
|       di = kzalloc(sizeof(struct dma_info), GFP_ATOMIC);

For wlc->modulecb[i].name, we expect each name in wlc->modulecb to be
NUL-terminated based on their usage with strcmp():
|       if (!strcmp(wlc->modulecb[i].name, name) &&

NUL-padding is not required as wlc is zero-allocated in:
brcms_c_attach_malloc() ->
|       wlc = kzalloc(sizeof(struct brcms_c_info), GFP_ATOMIC);

For all these cases, a suitable replacement is `strscpy` due to the fact
that it guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c      | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/dma.c      | 3 +--
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c     | 4 ++--
 4 files changed, 5 insertions(+), 6 deletions(-)

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

-- 
2.42.0.655.g421f12c284-goog

