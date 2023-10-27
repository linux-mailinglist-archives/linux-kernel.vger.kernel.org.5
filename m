Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411D97DA31B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346639AbjJ0WFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346583AbjJ0WFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:05:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F29D42
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 15:05:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7af69a4baso22500537b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698444339; x=1699049139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DdSXo05ZDTrQ0bolpnGX21EQgcBZaNy4lNpYoejJ8s8=;
        b=E2pKeo2kJ+akmSA0cTcgJnKx2HqrpUfZMJBQkdGOkG4lo4t1/d1iDTMNiye3crt/kS
         4KhXKu6jnn2TZyWIi4PP9GzSwkGYjxlL1byrichhJqDdCjs58WmH0fkDOmiREC1NUuYp
         JrU4OF1egBvbBx2KALePsiGZg4nMeIWvtF6xGjcVyZNlaiWLPkjEkkfTxzH2N0wyzrnf
         5DXJO0/C5d455+ANJtcfF+DPDnCteV4tJWMinMfw7JQQaBAdUt7S2dkwZxO8tSzZr0mp
         MoB0Rg29bAt9wMndQwtqQyScTqqzSJtD70YA/V/gGOouZ4cJ+pzzW3CpP2Vi2VwMtcQq
         Sg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698444339; x=1699049139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdSXo05ZDTrQ0bolpnGX21EQgcBZaNy4lNpYoejJ8s8=;
        b=JSudh2+/P3hfJ+nn5J96wioe2cAdF2md+mtnYbV6soFH2OCg0hWMUTMDDbgfJLaMmq
         tG3meGnaDGa9OK1m4D5LKH4ZErnndTms+wsCgtFhnQMwjzGm8JxZXA4tsYHs7+bDxISY
         HcFG0HQYGD1BXsOOHWRKyVcuL6qrND1Ff503keTZ/TOFxUkBIrEHiGeOv1VraGT6OeSp
         g4ZdoolzKXTwoNr9pyKBGdVGtD5pqYRqaeEMGc01ZJngH5CJYpJW2gEwjhLeLkychdZm
         HmaOdJtfG6CWTX7SpltvcQO4R6Fj7rq22FFAJqCXBcxfIqfbx074t4Tb0qQbLJX1rdD9
         GE1g==
X-Gm-Message-State: AOJu0YyVEA+h7ZeexkrUfE1KAGzWxNJ3JA7BrdXuBrBAdFuyAnN28vkB
        hiHu11bBIQjggQ2pA9qVN4yQKFLQBbFccCU+Jw==
X-Google-Smtp-Source: AGHT+IEGanE/VPWiVGsYQnojjV2LR5zrl1qUYV/9Hzl9G6z+NxdeOgXz6WlWY7Ge6EIQf809mb8uIRPVcG/rsXoCAQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1746:b0:d9a:59cb:8bed with
 SMTP id bz6-20020a056902174600b00d9a59cb8bedmr69382ybb.5.1698444338644; Fri,
 27 Oct 2023 15:05:38 -0700 (PDT)
Date:   Fri, 27 Oct 2023 22:05:34 +0000
In-Reply-To: <20231027-ethtool_puts_impl-v3-0-3466ac679304@google.com>
Mime-Version: 1.0
References: <20231027-ethtool_puts_impl-v3-0-3466ac679304@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698444334; l=1990;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=Peahw3CmOtnUj2I89Tjap4JSwacXUbTFJpotNKfpIAo=; b=/dV8JH6sg2K0SMzdRYoIByKAm/hZGtV2i2RyZ0hRiSo1vOQmFG+LMPEoIUTIwPdSxZVjgBWW9
 AOzrjCPUG+eCexFWJvZZE9e0rOdmAbkRvivrtrYWEohlds40p4HoDCE
X-Mailer: b4 0.12.3
Message-ID: <20231027-ethtool_puts_impl-v3-2-3466ac679304@google.com>
Subject: [PATCH net-next v3 2/3] checkpatch: add ethtool_sprintf rules
From:   Justin Stitt <justinstitt@google.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some warnings for using ethtool_sprintf() where a simple
ethtool_puts() would suffice.

The two cases are:

1) Use ethtool_sprintf() with just two arguments:
|       ethtool_sprintf(&data, driver[i].name);
or
2) Use ethtool_sprintf() with a standalone "%s" fmt string:
|       ethtool_sprintf(&data, "%s", driver[i].name);

The former may cause -Wformat-security warnings while the latter is just
not preferred. Both are safely in the category of warnings, not errors.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 scripts/checkpatch.pl | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7d16f863edf1..9369ce1d15c5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7020,6 +7020,25 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
+# ethtool_sprintf uses that should likely be ethtool_puts
+		if ($line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
+			if (WARN("PREFER_ETHTOOL_PUTS",
+				 "Prefer ethtool_puts over ethtool_sprintf with only two arguments\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\bethtool_sprintf\s*\(\s*($FuncArg)\s*,\s*($FuncArg)/ethtool_puts($1, $7)/;
+			}
+		}
+
+		# use $rawline because $line loses %s via sanitization and thus we can't match against it.
+		if ($rawline =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*\"\%s\"\s*,\s*$FuncArg\s*\)/) {
+			if (WARN("PREFER_ETHTOOL_PUTS",
+				 "Prefer ethtool_puts over ethtool_sprintf with standalone \"%s\" specifier\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\bethtool_sprintf\s*\(\s*($FuncArg)\s*,\s*"\%s"\s*,\s*($FuncArg)/ethtool_puts($1, $7)/;
+			}
+		}
+
+
 # typecasts on min/max could be min_t/max_t
 		if ($perl_version_ok &&
 		    defined $stat &&

-- 
2.42.0.820.g83a721a137-goog

