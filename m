Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14060807C1E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377549AbjLFXQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjLFXQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:16:10 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820C5B9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:16:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db5508d1beeso391710276.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 15:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701904575; x=1702509375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/7eYcPC4ZNNyPcPPs0B5tDplF0arxw3r0vINNNou0rY=;
        b=sMUeie/TxdytzC0EyT11QWi1TqTtiv7KCTs1F2vLmUUvPKNA3+1MHFo8ECW+0gQuDE
         FGrgdZKGK5mXQgkF0N3JiSLvKO8tpQOIB57JLCG5IVy5dr2vVv0ExU3Dag2Cc4oBIBIO
         w/cH95O1oPlvluIpATmAsxenVr7mFomU63BqYiRGLaEhWeb2hJ636GO8lubtsDfdFFoi
         GPOL2tQwV93VnqmywBBpFaNAULN0UoCFhfkKv5prvpkXq19sWI7zyorVZ+rdTYem5m4T
         dXsDaLXPtC3Dh2JOad1duSQIah/wCHYYUcV3IoFhwj2y0Uk/TTCrnZPORweSADcEy6Ho
         vDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701904575; x=1702509375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7eYcPC4ZNNyPcPPs0B5tDplF0arxw3r0vINNNou0rY=;
        b=bGBol5UTuZEdsDO/0cq8Cq1WCdtF3+T9fiUO9jkFFYyxRaU053g5U5lMM0Idw8F44U
         WztkZqyOqzSAWIld1PvFQjW9IXIBAvxTM+wVrxA21FzYQGhxm91TRXcoJXWvjwdLbQm6
         5jQpEjZoNf8SIC7We2uP9JMxDNUPMBDmj9fovUYGb6Ich+c4Q7YD4exFLDRmNEdqcg3P
         /ehmd2QSdPmbwgmvajSuvjuO4vxv2D6NCcnAFms/hnn7b2vpUdb/F2WxGiVaH7Qc6JhU
         jv338k3wYsLgN6tzuOY5rmuFWXGD/8HoMsTelSIMgiztXCgWMBRm3paKySYGsl6+PFvK
         EubQ==
X-Gm-Message-State: AOJu0YxuErh/0qOICxy2/EG1romutnD66P9K5ma0pmycJBcRik5MsRt3
        i5SPuFha0Yq+gJvyezpbWZJ6OKxdGVaqVke3Cw==
X-Google-Smtp-Source: AGHT+IFRXxBV6JuX5Cl/k2o1+WKkCwkR8j20MJSkmoGCedPAtqFttH8OVh1/6vdfnq8MPN++A2h89peZQhyG8OsJ8A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:dac7:0:b0:da0:3117:f35 with SMTP
 id n190-20020a25dac7000000b00da031170f35mr28652ybf.3.1701904575576; Wed, 06
 Dec 2023 15:16:15 -0800 (PST)
Date:   Wed, 06 Dec 2023 23:16:10 +0000
In-Reply-To: <20231206-ethtool_puts_impl-v5-0-5a2528e17bf8@google.com>
Mime-Version: 1.0
References: <20231206-ethtool_puts_impl-v5-0-5a2528e17bf8@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701904573; l=1840;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=UMdetIL2ZsPIkSodqhw2fM21NHJVjCu0lRImFuNhVoM=; b=a8rMnXfVVQ5gsxHWG4WRMwOLxZgflqXZtNuKx26vv4DwYvvCtCiYjl3f1frOjV/Ul2kaxq5g/
 b/UOv678JKCDASVokxG5GJifAnU7/kqRxdhcwfRkrD8RUfcsmiZOfyF
X-Mailer: b4 0.12.3
Message-ID: <20231206-ethtool_puts_impl-v5-1-5a2528e17bf8@google.com>
Subject: [PATCH net-next v5 1/3] ethtool: Implement ethtool_puts()
From:   justinstitt@google.com
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Dimitris Michailidis <dmichail@fungible.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Louis Peens <louis.peens@corigine.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Ronak Doshi <doshir@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "=?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?=" <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "=?utf-8?q?Alvin_=C5=A0ipraga?=" <alsi@bang-olufsen.dk>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, Jiawen Wu <jiawenwu@trustnetic.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
        linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, bpf@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use strscpy() to implement ethtool_puts().

Functionally the same as ethtool_sprintf() when it's used with two
arguments or with just "%s" format specifier.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 include/linux/ethtool.h | 13 +++++++++++++
 net/ethtool/ioctl.c     |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 689028257fcc..2480a4e4a331 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1053,6 +1053,19 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
  */
 extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...);
 
+/**
+ * ethtool_puts - Write string to ethtool string data
+ * @data: Pointer to a pointer to the start of string to update
+ * @str: String to write
+ *
+ * Write string to *data without a trailing newline. Update *data
+ * to point at start of next string.
+ *
+ * Prefer this function to ethtool_sprintf() when given only
+ * two arguments or if @fmt is just "%s".
+ */
+extern void ethtool_puts(u8 **data, const char *str);
+
 /* Link mode to forced speed capabilities maps */
 struct ethtool_forced_speed_map {
 	u32		speed;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b0ce4f81c01..abdf05edf804 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1991,6 +1991,13 @@ __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...)
 }
 EXPORT_SYMBOL(ethtool_sprintf);
 
+void ethtool_puts(u8 **data, const char *str)
+{
+	strscpy(*data, str, ETH_GSTRING_LEN);
+	*data += ETH_GSTRING_LEN;
+}
+EXPORT_SYMBOL(ethtool_puts);
+
 static int ethtool_phys_id(struct net_device *dev, void __user *useraddr)
 {
 	struct ethtool_value id;

-- 
2.43.0.rc2.451.g8631bc7472-goog

