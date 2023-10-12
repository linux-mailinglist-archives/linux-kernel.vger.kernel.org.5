Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61F97C76C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442187AbjJLTaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441868AbjJLTaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:30:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CC8B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:30:20 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690bccb0d8aso1153077b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697139020; x=1697743820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zajPA0tvu72pt5bpzc8dJBpNP+YUOKi2eBcYHy9Hcw=;
        b=Si8r9BfDBfRo/07TbOXurfEXpVpk2YVQaEi60b/Lj35WBoQdbwBuUobcM0M7rBFdlL
         sMM4fyZVD+slnoSxaOzShM1AcItMD/fSw614qhQ909HzAtyDgrSzSLHJ53hXjjsb79Rt
         Te7FbWESWFO1+nLSINfB/pCqI2mjvVa+s/SRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697139020; x=1697743820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zajPA0tvu72pt5bpzc8dJBpNP+YUOKi2eBcYHy9Hcw=;
        b=Fyu7CQilhRzg+1OLgtlYfu8+0Itiowda6cl5TkCCbaUVvP4lgpEM4oTCVLu4hsUbhC
         mH5hex19sHcROAaTiWuGhlnJ1mjjzR5R4jSzdk+i9zdO77qwBwh3vdZu2Ux7Hxpojq4M
         8Stl3srJm6Xfd4D7OhLsXhL5WGLNeyugl2ptWSyxCdoQdOV+rtS+2lknSnba8NdmIokC
         3wqu6dO3ulmUl58YXwRSa/6EGJZKi5KbqSIn/RvgHYkxF4ntGU8OBP3iYrdf5Zm2esgW
         S9hP6iNpJo9M8S48G/wM+IKIJP1MZVcEOBxv77kLZtKP2IYPhTP6TBY9VBPxTl0xRDmW
         iRzw==
X-Gm-Message-State: AOJu0YxrFzsvG8aMKFPRhVoPuMXqMZz0iwvwIcB1A946Ny7GWtWduiP+
        E3pCTvnB4a7LxZRhc5PtttpoJw==
X-Google-Smtp-Source: AGHT+IGQ0RwNJUFNAfFTs8ORx9G7rtNQ3vswOKYBLEghqVny9C9HOny+VpEYKBxziFp2cu4/xvBl9g==
X-Received: by 2002:a05:6a20:6a23:b0:13e:9dba:ea52 with SMTP id p35-20020a056a206a2300b0013e9dbaea52mr27470979pzk.13.1697139019812;
        Thu, 12 Oct 2023 12:30:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:7c85:4a99:f03e:6f30])
        by smtp.gmail.com with ESMTPSA id b3-20020a639303000000b0057c25885fcfsm2075720pge.10.2023.10.12.12.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:30:19 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v3 2/5] r8152: Check for unplug in rtl_phy_patch_request()
Date:   Thu, 12 Oct 2023 12:25:01 -0700
Message-ID: <20231012122458.v3.2.I300ed6c3269c77756bdd10dd0d6f97db85470186@changeid>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012192552.3900360-1-dianders@chromium.org>
References: <20231012192552.3900360-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

(no changes since v2)

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
2.42.0.655.g421f12c284-goog

