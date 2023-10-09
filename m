Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B157BEEAD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378949AbjJIXFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjJIXFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:05:51 -0400
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BD1D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:05:42 -0700 (PDT)
Received: by mail-ot1-x34a.google.com with SMTP id 46e09a7af769-6c70e93400bso6662349a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696892742; x=1697497542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sf7f7SSFEcioOL4lOh7uG5FMec4NdhZBqO0ftggHptY=;
        b=LwRVFeYE/YD3ecpcJUBp5ofm5vl2PimabMq29CWUZNbuDyrvHWIPBsHUbI4/sfsVFj
         Dh5f+pAQX10Az7hZzHBgqjaKqpzG33QfypHaxKIbV9J0Iq0p1jsxh0rg95ZQxbfjCHir
         uggvJjPVkB/5MnVLDLV5UggUbB+CPYZUrKGi+WZjSBE9sXP37Wirymfmh1prk5fdMJQc
         mFddu5tb80h7pqzOoXu/YjziCpSGd4k9ueqUkoweQRmiiFOrmj2V3Mlao7Vvs8HK7XWC
         GVqH1aj++MP6bkUcAxiYET6uRD0AqCgiYHlBjGdxQ/SQ18TFm+OILALK42BkXHPfkSX1
         XI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892742; x=1697497542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sf7f7SSFEcioOL4lOh7uG5FMec4NdhZBqO0ftggHptY=;
        b=bK8/TJ1sYoCm1eZgLXavixFbgqhdgoUdJ9eCb+hfD2lHpxzbrBESlljn4v+N2Cxl8h
         TC0/dQ3nmw4W0K+wKlxjPk6xOavGcV22X47OhYRxMsQE5KPZyDNCT5I/ZjoYeq2h/FqN
         FZ8C+pe4Cb3LalhHVbp1128f9aG3nFtoWCH292latjN4ftKNdzXJLRABI7Ae3S26Zqiv
         nfiBLCdcjjfDHkacboEm/Z55fNH4Uy+1sdGw/W2Y4zRmwRwXXe/tpGAPbMy5JCxCI2ZO
         SAZUJVrsV5wc4s/AZxUbexHZHSfkVoVphfOjfTp92ek2nOPBInxlHgDxwi0fwlJqqSpx
         u3Uw==
X-Gm-Message-State: AOJu0YzT8BBqx6U0+5CxxTs305/2zrXHllDmJCxBtcr+EDgbMUGoVkpV
        CFkyYaTOwUzcJaABcQ2/cqdEsCdgSSoVql+tkg==
X-Google-Smtp-Source: AGHT+IGFgXj6rSXctich+As11kiZfkGnKpf2oXnUdgRc45Epz4XWQpAHX2HulJczcCRybPr4tjMVvrV0XhkuaFFRQw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6870:5a9a:b0:1e1:82c6:33f9 with
 SMTP id dt26-20020a0568705a9a00b001e182c633f9mr7399939oab.6.1696892742303;
 Mon, 09 Oct 2023 16:05:42 -0700 (PDT)
Date:   Mon, 09 Oct 2023 23:05:41 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAESHJGUC/x2NwQrCMBAFf6Xs2YWk8aD+ioiE9K1d0Fh2S6mU/
 rvR28xlZiOHKZwu3UaGRV3ftUk8dFTGXB9gHZpTH/oUQzizz1bL9OHBdIE5V8yMeYT9QAzwkp9 gQbm/slYufDpKSCKSQ4rUupNBdP0/r7d9/wLeKqFqgwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696892741; l=1913;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=b46EvaWEvLxv9FsIZoOXRs8eHWo6xtQQKTHMNok8KSk=; b=I1zIPrcYrC6V+htWsXEMmmSTST/RmDVaCy58n10tqsm8+ntpoa4LnmiS37cPkusLtOQ0/Iumf
 omEl4t6dkYhAIRCLgVsvvoMW5H1hqfyd88cYBQN9rR7tOLGSn1wrk55
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-ethernet-freescale-fec_main-c-v1-1-4166833f1431@google.com>
Subject: [PATCH] net: fec: replace deprecated strncpy with ethtool_sprintf
From:   Justin Stitt <justinstitt@google.com>
To:     Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy in favor of this more robust and easier to
understand interface.

Also, while we're here, let's change memcpy() over to ethtool_sprintf()
for consistency.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/freescale/fec_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 77c8e9cfb445..78bddcbfb5d9 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2907,12 +2907,10 @@ static void fec_enet_get_strings(struct net_device *netdev,
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < ARRAY_SIZE(fec_stats); i++) {
-			memcpy(data, fec_stats[i].name, ETH_GSTRING_LEN);
-			data += ETH_GSTRING_LEN;
+			ethtool_sprintf(&data, "%s", fec_stats[i].name);
 		}
 		for (i = 0; i < ARRAY_SIZE(fec_xdp_stat_strs); i++) {
-			strncpy(data, fec_xdp_stat_strs[i], ETH_GSTRING_LEN);
-			data += ETH_GSTRING_LEN;
+			ethtool_sprintf(&data, "%s", fec_xdp_stat_strs[i]);
 		}
 		page_pool_ethtool_stats_get_strings(data);
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-ethernet-freescale-fec_main-c-84f03fffa031

Best regards,
--
Justin Stitt <justinstitt@google.com>

