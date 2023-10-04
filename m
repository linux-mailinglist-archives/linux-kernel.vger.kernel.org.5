Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1BF7B8D5A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbjJDT1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244240AbjJDT05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:26:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652A2E9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 12:26:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so154020b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696447612; x=1697052412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvVPnlQORTCK7kqZ53cdR5dJ01wpTJ+M1zt/QBCKOzQ=;
        b=aVnDf9y9ppcLZrN0TfKGyYX1Agu3ULIUVQcZD0//g5CNVy8EK8vseFYuKlT5OtvBq7
         w2ThnvRjVQLSH4Jh03j4SDvO6avZNJwmQFxTPCsZhvToA12XzvFcHSfXbLesNrJVa/MS
         gCw/fkN29F1tJmDV5lQ0OISzxdQCgt7V/4dHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696447612; x=1697052412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvVPnlQORTCK7kqZ53cdR5dJ01wpTJ+M1zt/QBCKOzQ=;
        b=lSBvA2+UPM1nIc/+ZqzKZbLidFo0tfu6/od+KxwdUIJHPPM3kc55aXr7sGF4KMitRt
         DAOWBIuOCB9C9KgZCa2URM+ohGn43DmolTcAamoMXwfgUw1tLIJd3ak0UvPwcrROzf2b
         5n+7Jd4LH+pdO+AVL0TEbst2ipfdukz8WdF3jYUeOMKeu5D/4X0L5Va6D5skTai+TkKK
         wvWy0faU63WI3HjRJOIeOoLgtdOPavFimu3k8/jXGK8PolsgYd5fZXJiZD7PG0lVgXYN
         UwiWb0QjxQIEXw1TJHgTj/x5MjdPRKfABuBIoIBJacrWb/Er+xSoD09fFeZtmNFI7epT
         SVSQ==
X-Gm-Message-State: AOJu0Yzpw8/KsnOD2RucWvhWv8wplheUa+Oi4pXocfb3sA59o3iLDfM3
        hSe1ZGeHZhWBoCvO2uLXcb33Xw==
X-Google-Smtp-Source: AGHT+IGNHTwRI7vfmNQwD3lLL9cQeBWB7/sSsJb5Q+btfuk283ZdK7ymWVQN2uz9BobRw7b9uN7UmA==
X-Received: by 2002:a05:6a21:6811:b0:15e:b8a1:57b0 with SMTP id wr17-20020a056a21681100b0015eb8a157b0mr2585287pzb.39.1696447611832;
        Wed, 04 Oct 2023 12:26:51 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9cce:13a8:f2b8:b799])
        by smtp.gmail.com with ESMTPSA id d190-20020a6336c7000000b0057c29fec795sm3649151pga.37.2023.10.04.12.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 12:26:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2 2/5] r8152: Check for unplug in rtl_phy_patch_request()
Date:   Wed,  4 Oct 2023 12:24:39 -0700
Message-ID: <20231004122435.v2.2.I300ed6c3269c77756bdd10dd0d6f97db85470186@changeid>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231004192622.1093964-1-dianders@chromium.org>
References: <20231004192622.1093964-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the adapter is unplugged while we're looping in
rtl_phy_patch_request() we could end up looping for 10 seconds (2 ms *
5000 loops). Add code similar to what's done in other places in the
driver to check for unplug and bail.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- ("Check for unplug in rtl_phy_patch_request()") new for v2.

 drivers/net/usb/r8152.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 482957beae66..fff2f9e67b5f 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4046,6 +4046,9 @@ static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
 	for (i = 0; wait && i < 5000; i++) {
 		u32 ocp_data;
 
+		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+			break;
+
 		usleep_range(1000, 2000);
 		ocp_data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
 		if ((ocp_data & PATCH_READY) ^ check)
-- 
2.42.0.582.g8ccd20d70d-goog

