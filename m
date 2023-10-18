Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4CE7CEB08
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjJRWO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjJRWO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:14:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A931C115
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:14:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7ed6903a6so111710727b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697667296; x=1698272096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PlQsMleo8ndyb1BkvS8psG/NpipwSb1Ibvd6wvaptgE=;
        b=rpD9nXDr8ZV4X1Zjrx1Lpkbi8PcVhM+FAsPQEkE/bgGqvJdPH1dZ/7vggwFyV7nhEA
         X8bQ+c4ABe5Lv0Lx4UdVxd3dONLa3xGFTYGjnsytjjaPuWHDgsSwaDQqOqxNYmUHL3E8
         fd6cI8mvnnYu0l+EvsSOxOG18UhCTsNL6jB/fhq9pjPCpnyyxwUQHxSZ87gnNTZIS6r+
         iRqmgKZXyA5v+lImVMteIruljC+BI0JQ11H/uZKwoOFulZPDL9CV4UpMWYejLAO+vAfZ
         /dHi5bk0o61IOex9EqNmqWyAwgpM35REgb1kPuw72D9Xa/TL/git7S9ZvXE7Ceui1EnK
         6sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697667296; x=1698272096;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PlQsMleo8ndyb1BkvS8psG/NpipwSb1Ibvd6wvaptgE=;
        b=nq9CnByXr/798ODj/VQlAzdXLHO5zqK9joSo8R6PGS6PY9edQSAidNnEt4grslwe6v
         ffuSilYDpzAArqj5NmaXICVTOTNvCDCO6O1PbZ7grPnQbJdGR7qxUUQSBBPfZqlxIqfl
         +KKli2IxKHrH0gvkyGKjEO3Nw2n1aFGE8mFJalpLeXHcdnokMYM1+t715hzLjI66r/1L
         Hu0qe8/kLe/nKFA18PipOUyr2ASODZ5qyyYh3oenAAoujpqGCItv8+Y3VoLi0svX8y+d
         7cAbXnlshvGd7IagDqbIK/2v0zEaMoObCtf2Uf4ddOdjU1eiZ3D6CXi1fSl11+et9uau
         Psmw==
X-Gm-Message-State: AOJu0YwKYck43ERUfRtKzo7bJzGRtwhv+RI+ZitXH3Qq+yq1aE9PJ05+
        WDQjTpeNfsi8dpRmg6R8kpw0YphhRovYtHrKbA==
X-Google-Smtp-Source: AGHT+IFCGhabYMIAAC6XiL9TzzjSCY6BQgj3jImjG5X7Fcyl/tbrVb3NWUepotJZi0+qdYwrlX/ZrUxtd4WudCjg7Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:d9d2:0:b0:5a7:be10:461d with SMTP
 id b201-20020a0dd9d2000000b005a7be10461dmr15636ywe.2.1697667295839; Wed, 18
 Oct 2023 15:14:55 -0700 (PDT)
Date:   Wed, 18 Oct 2023 22:14:55 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN5YMGUC/x2NywrCMBAAf6Xs2YU8oIi/IlJCsqkLGsNuaJXSf
 2/qbeYys4GSMCnchg2EFlb+lC72MkB8hjITcuoOzjhvjb2iNimx/jAJLySKhRquaygo9a3zdOI Um7wwos+jMyHk5N0IPViFMn//s/tj3w8hAG6ffAAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697667294; l=2364;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=+RiFAuTFDYeSx5+FsqkeyVgCujTXIxMDn3P2javi3XY=; b=123OWlCw+sopcVGOlRvo8H8eZ3pupMbwmZbCt7KUM82cnX6fdX3BK+EJUTP0xC4c1b3gbO3IB
 1w6u2cozf6AB/MUjQvfMIuLfOn9l4T+IXmXkdkHqvfMcPANOo65c801
X-Mailer: b4 0.12.3
Message-ID: <20231018-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-v1-1-4e343270373a@google.com>
Subject: [PATCH] net: wwan: replace deprecated strncpy with strscpy_pad
From:   Justin Stitt <justinstitt@google.com>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect chinfo.name to be NUL-terminated based on its use with format
strings and sprintf:
rpmsg/rpmsg_char.c
165:            dev_err(dev, "failed to open %s\n", eptdev->chinfo.name);
368:    return sprintf(buf, "%s\n", eptdev->chinfo.name);

... and with strcmp():
|  static struct rpmsg_endpoint *qcom_glink_create_ept(struct rpmsg_device *rpdev,
|  						    rpmsg_rx_cb_t cb,
|  						    void *priv,
|  						    struct rpmsg_channel_info
|  									chinfo)
|  ...
|  const char *name = chinfo.name;
|  ...
|  		if (!strcmp(channel->name, name))

Moreover, as chinfo is not kzalloc'd, let's opt to NUL-pad the
destination buffer

Similar change to:
Commit 766279a8f85d ("rpmsg: qcom: glink: replace strncpy() with strscpy_pad()")
and
Commit 08de420a8014 ("rpmsg: glink: Replace strncpy() with strscpy_pad()")

Considering the above, a suitable replacement is `strscpy_pad` due to
the fact that it guarantees both NUL-termination and NUL-padding on the
destination buffer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wwan/rpmsg_wwan_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/rpmsg_wwan_ctrl.c b/drivers/net/wwan/rpmsg_wwan_ctrl.c
index 86b60aadfa11..39f5e780c478 100644
--- a/drivers/net/wwan/rpmsg_wwan_ctrl.c
+++ b/drivers/net/wwan/rpmsg_wwan_ctrl.c
@@ -37,7 +37,7 @@ static int rpmsg_wwan_ctrl_start(struct wwan_port *port)
 		.dst = RPMSG_ADDR_ANY,
 	};
 
-	strncpy(chinfo.name, rpwwan->rpdev->id.name, RPMSG_NAME_SIZE);
+	strscpy_pad(chinfo.name, rpwwan->rpdev->id.name, sizeof(chinfo.name));
 	rpwwan->ept = rpmsg_create_ept(rpwwan->rpdev, rpmsg_wwan_ctrl_callback,
 				       rpwwan, chinfo);
 	if (!rpwwan->ept)

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231018-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-3f620aafd326

Best regards,
--
Justin Stitt <justinstitt@google.com>

