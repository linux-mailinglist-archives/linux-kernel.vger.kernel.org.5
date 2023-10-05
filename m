Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0688E7BAE32
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjJEVzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjJEVzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:55:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD6B9E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:55:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d91c3b26c9eso1350717276.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 14:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696542907; x=1697147707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=15N1cZsxfmEbv2x0hxsW9ZXAdYEMZDd2ct4HcMI5LaA=;
        b=t/xvbDfxHrSLeKTjuoFd34jmqVuNPi5stRvxijdXe65BY87jpk4/+tYPoC0i0fdoS6
         SGbJF7g3BTrAOoz3C6ftD7wwP7nlZd6T4kXuWZwO8g5eb8QmT5Fr21gTyGJErqfrjGOa
         wZvmcmw00Oq8p//67yQqCbi42V1W1KKYjw2aqtzCWvAhz4J1yI8sdqjn5ZvvWSOOufvK
         A6AR6jEtdqnFBq0Fm8neFYixKuo28W5Vccv5olkTEYpCcTC6PWC/Ot22fNNC6iH/z8GS
         S7/lNMAJYlAVpXKQt8kkTGIkzYl/0j4WKeR3MPAKw73qEvCOnDHa/0IAuUdDQ21Df4cX
         cL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696542907; x=1697147707;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15N1cZsxfmEbv2x0hxsW9ZXAdYEMZDd2ct4HcMI5LaA=;
        b=YScFHyBXhYNFckPQm9Vge8kmgCYCDpn3MRgwMKCyAyDIIM+tolJAq6d3KWzh/Ywk6Q
         sClVf2zcUIIczgeCozjGqExTDyv666AFfuvFcvY0T3JQsCwcyYaxBvzE15uzLOKwsDcw
         3wHJ+pfABBPh8VejlKt4IVndn29etH8eI49Rez2RmE3kgr8TzbAUuwZahvlWFKTr6afj
         R9cF8BsPcSJiryyGMX2zcklY4HdIZgH6eJxCm5ccdXGTDzKBAWLuhdQeY2qZz/DjcPv0
         ideSllHc9Q0k4CMwawmXKAtat64AzDBWDzfRxaOwA6anP8jtg+cowpcmf05m0Wq60eGK
         2umg==
X-Gm-Message-State: AOJu0YyV8ZZT3WF3iAmqFEEqtaGG0awp8sV6vJtodd4MQqIFCOp594TS
        yzbvVqr+MvPpVChK/CK0WgJFGBqP7m24q0YKAg==
X-Google-Smtp-Source: AGHT+IH5kmRWTxHnbOHdcVuA+Thho6voAhFH0EXqlEnU/rGEgIjyx1taDbBJdWNEnWATXo/uaqRozazszc/sPEmxyg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:dcd0:0:b0:d7b:89af:b153 with SMTP
 id y199-20020a25dcd0000000b00d7b89afb153mr86513ybe.5.1696542907205; Thu, 05
 Oct 2023 14:55:07 -0700 (PDT)
Date:   Thu, 05 Oct 2023 21:55:06 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALkwH2UC/x2NQQ7CIBAAv9Ls2U0oWE39ijFNC1u7iQIulGia/
 l30NnOZ2SCRMCW4NBsIFU4cfJX20IBdRn8nZFcdtNKmVarDlMXb+EEnXEgSespIeSH5gR0Lr09 88Gtlx6FCGMo8CEW0OGnTnc7TUfemh9qPQjO//+/rbd+/cdJAXYsAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696542906; l=1813;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=C3xl2J3v8gwUN0HU8+dA4WXLs/v1+iBpCZbkeacUwtw=; b=KPY5MJEWqGL5WHVZsLvPbRYVOUHno7nU5umJO/gm3OQgFouMAf3NVUYZm4NefBHbah92WVVAO
 tojH7L8NeE7AtbzYIPVMs+OSU1U+HvhZRhzdhy4pfuZYpecxKULJA3f
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_vf_rep-c-v1-1-92123a747780@google.com>
Subject: [PATCH] liquidio: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

NUL-padding is not required as rep_cfg is memset to 0:
|       memset(&rep_cfg, 0, sizeof(rep_cfg));

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
index 600de587d7a9..aa6c0dfb6f1c 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c
@@ -638,7 +638,8 @@ lio_vf_rep_netdev_event(struct notifier_block *nb,
 	memset(&rep_cfg, 0, sizeof(rep_cfg));
 	rep_cfg.req_type = LIO_VF_REP_REQ_DEVNAME;
 	rep_cfg.ifidx = vf_rep->ifidx;
-	strncpy(rep_cfg.rep_name.name, ndev->name, LIO_IF_NAME_SIZE);
+	strscpy(rep_cfg.rep_name.name, ndev->name,
+		sizeof(rep_cfg.rep_name.name));
 
 	ret = lio_vf_rep_send_soft_command(oct, &rep_cfg,
 					   sizeof(rep_cfg), NULL, 0);

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-ethernet-cavium-liquidio-lio_vf_rep-c-b23567b42939

Best regards,
--
Justin Stitt <justinstitt@google.com>

