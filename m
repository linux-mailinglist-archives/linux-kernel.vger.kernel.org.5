Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9435D7684AA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 11:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjG3JkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 05:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG3Jj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 05:39:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F27E1BDA;
        Sun, 30 Jul 2023 02:39:56 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-317715ec496so3845921f8f.3;
        Sun, 30 Jul 2023 02:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690709994; x=1691314794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0o7VzxAYYYRY+ih+jmVhcGfTwDx92myBTFzgRxJi4g=;
        b=eDCyRE4PUu0oXJ4JpVM96uLRV/9x/dZihtzq8iNCND0fPYQ7XiGgVSsUwPvayG7ORH
         M9gHKOw62H/RVqC3WhXKNb3CP1ErlLFJc9vgv7s0WiKz1VQlN0B738hwQT3MW2idV4h/
         tHXHDmT2dCpQu8WFQV9M4nw3jaUxHAfMs8ViaCwwxvI0TNu8eDuyfwGYL34dJiir7wDF
         xRsZ9fzVsqk3DSRuVVFoxzwwDYzMlkjNKAR3Z1ZZ2oEQm38tAnlApt/9mJNnQfgtHs/I
         MWXSVoIcF/rzOex8A1LpqamC2yzD0ajLWR02k49C7BX3aD2FbadZztHWYy5wV5G0zROl
         ZmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690709994; x=1691314794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0o7VzxAYYYRY+ih+jmVhcGfTwDx92myBTFzgRxJi4g=;
        b=ZrwwsKLtYoVddDuN7Crq2oHUCbkWuGKXlrShJ5rKTzzZ09KFCONXP1j90+Z1zmKeMy
         uPT2MdcfNEvm0xKZH6k5oIrpzMwUV49NL5vu/06lYxP05svKSn3WO7cpgP0hnepVQCR8
         AawBuqlb2URHp1OaJI6EMQqm5cKbCv69L1LwFaNy+l/I01CzqQI9P5aDDdOYfc7nWp+g
         XTmJ1QI7cs3erEvJl1ahzbOP89VVXmUFyjDQ+Lx0IppmzbH/CkH7YPqRQz3ImXFOgj5m
         X14xV1JMu9ZbWq78dINEcAXvo83J6kpuqiSBD4pPz8NSxYbX10Uv31DGLwHmLHB64C0E
         EtcA==
X-Gm-Message-State: ABy/qLbIdzFqqUPdbyYC5IgXrKCzbl0qUArpXHrG17ACcU9O5Q4KWYA4
        Bxs4HxP+nglX94kSY5ZEuY4=
X-Google-Smtp-Source: APBJJlHKHdBB5Zm5VqaYpOotpQHNX7+/lrVqRpF5YyLynQgIuzcVBj1jOu+3tDZaNdxAoCCNm4FDZQ==
X-Received: by 2002:a5d:4746:0:b0:314:2e77:afec with SMTP id o6-20020a5d4746000000b003142e77afecmr6107859wrs.57.1690709994376;
        Sun, 30 Jul 2023 02:39:54 -0700 (PDT)
Received: from localhost.localdomain (host-87-11-86-47.retail.telecomitalia.it. [87.11.86.47])
        by smtp.googlemail.com with ESMTPSA id h16-20020adffa90000000b0031423a8f4f7sm9574599wrr.56.2023.07.30.02.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 02:39:54 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Atin Bainada <hi@atinb.me>,
        Michal Kubiak <michal.kubiak@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Simon Horman <simon.horman@corigine.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [net-next PATCH v3 3/5] net: dsa: qca8k: limit user ports access to the first CPU port on setup
Date:   Sun, 30 Jul 2023 09:41:11 +0200
Message-Id: <20230730074113.21889-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230730074113.21889-1-ansuelsmth@gmail.com>
References: <20230730074113.21889-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for multi-CPU support, set CPU port LOOKUP MEMBER outside
the port loop and setup the LOOKUP MEMBER mask for user ports only to
the first CPU port.

This is to handle flooding condition where every CPU port is set as
target and prevent packet duplication for unknown frames from user ports.

Secondary CPU port LOOKUP MEMBER mask will be setup later when
port_change_master will be implemented.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
changes v2:
- Add review tag

 drivers/net/dsa/qca/qca8k-8xxx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 31552853fdd4..6286a64a2fe3 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1850,18 +1850,16 @@ qca8k_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
+	/* CPU port gets connected to all user ports of the switch */
+	ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(cpu_port),
+			QCA8K_PORT_LOOKUP_MEMBER, dsa_user_ports(ds));
+	if (ret)
+		return ret;
+
 	/* Setup connection between CPU port & user ports
 	 * Configure specific switch configuration for ports
 	 */
 	for (i = 0; i < QCA8K_NUM_PORTS; i++) {
-		/* CPU port gets connected to all user ports of the switch */
-		if (dsa_is_cpu_port(ds, i)) {
-			ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
-					QCA8K_PORT_LOOKUP_MEMBER, dsa_user_ports(ds));
-			if (ret)
-				return ret;
-		}
-
 		/* Individual user ports get connected to CPU port only */
 		if (dsa_is_user_port(ds, i)) {
 			ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(i),
-- 
2.40.1

