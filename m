Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7DB7CB4E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjJPUsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjJPUsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:48:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9625A7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:48:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7c97d5d5aso76618647b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697489316; x=1698094116; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CfQG/UNYofASRrDwMjYhdG73TtrOn2QoLvMk2HP0VXc=;
        b=qw8HAanKN9J0CnkvOmauyxICekf1JNGafGHP89BpW0CRYA0k93PgmnEWgxBBSiNDRR
         txQk8XVhpHwnN9sW9oX6RGj4npBxp189Gsa2wl1Lcm42+CkkNJXpo8AjL94JjzEt5B4p
         IedMJohD99oKnEXqm5Ml/AEhI/prnXJGwKAdH5cRl4ob4hOGMHj2SkW4bJNLvMliSNMz
         aPKtk1XyWs1MmGTSUk7g5GAQw3RXJXRxAJ56mOvTr1nYf+7nGpfhhWtqu/DlIDF/emy8
         pbIO9PbChvrh+lgwqueCPueVcwpOZeCcWtqs6/ATBigopa/2czlc+seJvWdWXpmPP8Rq
         kEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697489316; x=1698094116;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CfQG/UNYofASRrDwMjYhdG73TtrOn2QoLvMk2HP0VXc=;
        b=FKk+NjZy7XtioiRSw8gPvnGNiaBSp4g5/qO7OoKLTfKhgYj62UOoqOIo25r6X4sHq+
         9kchcz5tse4XZkg+6s0N10RllNgxsf4NgDA20TcmqU75x5JwIuiwKmbpMmozbb1AlL0Z
         h/qLHp3JYdvWPOP6ujIzNwRVy4PyRrWsTYb1FEsA/NuoD68RInz9VEnAn4NbsEdN8KZg
         uaexAteHDv7D5yYecB68olKB3Qpxoi/4vWNN8SzHRink+XfHbb1DvMRBnfaEco0alCFv
         LANi7Z/PYa36+qxayea2qCo8+w44fyyqD9XSuNrxzajLjZE/Oc3J3bNGx2eMyUjTVery
         R+8g==
X-Gm-Message-State: AOJu0Yyyz7+8ao6sTAl4XaHBOa/kFnrrGUb0ejd7genXCsLTfjham8Yz
        e2R7Uixo66hz5TIdLSlnRxoPDv5GcV0DW98D1Q==
X-Google-Smtp-Source: AGHT+IH2PJXIzD1777emyZ8QgxBof1e9+NC8sANBlMDPZVkPlBXOSucoAmRsX92WHt/bfBbuNjB2JXxsXNlAElOfCw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:bfc3:0:b0:d9a:d233:b2a3 with SMTP
 id q3-20020a25bfc3000000b00d9ad233b2a3mr4826ybm.1.1697489316076; Mon, 16 Oct
 2023 13:48:36 -0700 (PDT)
Date:   Mon, 16 Oct 2023 20:48:35 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKKhLWUC/yWOQQ6CMBBFr0K6dpJOVdJ4FeOiDgNOYguZIaAh3
 N0Gd+/9zfubM1Zhc7dmc8qLmIylCp4aR69UBgbpqrvgwxk9tmCzFpq+0KksrAaFZ1hF+c1m8NQ xdTTmCpSjD4gH9TkRUD/8F4IUPPp4CdjGq6ulSbmXz/Hi/tj3Hzo06JCVAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697489315; l=2480;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=WWAYi+x4Dx7aKKvUgODBQGUZ3smVI6qfsI47zTN1ZUE=; b=0BH3zclS0YNxwd3Ilm6W6FhkdILNUqiYw4eIUHdosTMZ1W5xRLPQOCCPOGNQ/ocIalDesk+Jw
 BLI/L+ZPzwBAlD97aqRK/+kSE3oaxQemrHOIxxpWToj436kRGiVDq2h
X-Mailer: b4 0.12.3
Message-ID: <20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-v1-1-4234807ca07e@google.com>
Subject: [PATCH] brcmfmac: replace deprecated strncpy with strscpy
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect ifp->ndev->name to be NUL-terminated based on its use in
format strings within core.c:
via brcmf_ifname() ->
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

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231016-strncpy-drivers-net-wireless-broadcom-brcm80211-brcmfmac-cfg80211-c-a20108421685

Best regards,
--
Justin Stitt <justinstitt@google.com>

