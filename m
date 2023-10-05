Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079437B9943
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 02:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbjJEAa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 20:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbjJEAaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 20:30:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D527C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 17:30:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a1f12cf1ddso13067707b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 17:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696465819; x=1697070619; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z9CoIYBwy9paxLnmDstL0tKAJy9h7YqHeLlFxLDJHMU=;
        b=JEP1Q4ODGE5fcLMCkUqZ0c1QuktvoQvuYVTsfhSiG4KidVawy7KKL3FptUsFCE77XV
         kuNwTnsXqWoW4IxZzhw8DfIAUxRNU6XY4pzURg40OSBI2GSBXq/xVY1BieRJ2pMTC12h
         MGZN4X6zTNgaq1NEpdrJzLhLe0iIQ/DD3hR0HJnCDm2l2rL0RdodaOWkBKlPcNMsrVzs
         Fv8EoVVKKkeht2Ei+cmOUKLaq6GO0J1Rtg6nRYJRG42CjKp5kvlLQtSfdZ1WQJ2E0Zr1
         B8XJxHCToyJ7wN6qNNs0eHNdC+al1kHx54iHfvtBCMSLdA5a71FhrD7JHTQTWYcJA9Of
         rFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696465819; x=1697070619;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z9CoIYBwy9paxLnmDstL0tKAJy9h7YqHeLlFxLDJHMU=;
        b=Ij6RKJ1H9ihyozSZWZXbhmEBtUxh8aYh6r6wc4fSqR6a6Yy9MxubsUPK0UReA6I2AX
         O6xowtu4RuvWSoExsvLALpPgIZP+M58J8to2jOuTjkH9CitLjY/u6gbCwkhX0o6ZuCFO
         CnVuLZrmfAW2PfqKSvnJQIt6c5dA+Kh7XdtY5nWyVOnXjZ26woVXHQFzGlCfM9jXfylS
         KqiaDLHSd7ul0BOZnlfmlCyT7fY4KUSTkYqchELDf17YIwBBtaZooE2SMtck2VZK8G6r
         Xpaja1DobKWdPR2q8hVxnUctHlAEaOfmO82lbeklWsKP5EK31w9ZObddYYBlM1OocZ5+
         uoow==
X-Gm-Message-State: AOJu0YwQ7WsTghfgOk4FHwrqr9zSWw9ROTX3WIEA/KmPv180zg9kHA00
        zaBqd+9intQEQ2958lG1dP4+HE17BpaUSwHT5A==
X-Google-Smtp-Source: AGHT+IG0es9PxjtNd90XgRPnwu44HS8DYm3gD4DhHoBDUsXrvHL8ssHqt8naJhqssuQu0/Hywy4s6PDhIf5KwkbN6A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:c04:b0:595:7304:68e5 with
 SMTP id cl4-20020a05690c0c0400b00595730468e5mr25561ywb.0.1696465819306; Wed,
 04 Oct 2023 17:30:19 -0700 (PDT)
Date:   Thu, 05 Oct 2023 00:30:18 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJkDHmUC/x3NwQrCMAyA4VcZORvoWjqqryIeSho1INlIxpiMv
 bvF43f5/wOcTdjhNhxgvInLrB3jZQB6V30xSuuGGGIaQ8joqyktX2wmG5uj8orNK36qXlNISLM xEk6pTCUXzhQj9Nhi/JT9P7o/zvMHaoGrR3gAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696465818; l=1658;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=bsKNbLzu3Ry5CEVwYR5pkDz3ZbDhkIowy3jtYMWC4UU=; b=ibUfNayaIATafgTAMuJ6HX3fgX+SPnajRCu3PTyOpaKrLLvonFUzzZJj5z8G4VBo1QBRXRPfx
 GxtwDu8o5ulDTLISW/SBzvFSNNvL/dlNf+TQdK8bXC5sCzPDKsDoyae
X-Mailer: b4 0.12.3
Message-ID: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v1-1-5a66c538147e@google.com>
Subject: [PATCH] net: dsa: lan9303: replace deprecated strncpy with memcpy
From:   Justin Stitt <justinstitt@google.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous
interfaces.

Let's opt for memcpy as we are copying strings into slices of length
`ETH_GSTRING_LEN` within the `data` buffer. Other similar get_strings()
implementations [2] [3] use memcpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://elixir.bootlin.com/linux/v6.3/source/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c#L167 [2]
Link: https://elixir.bootlin.com/linux/v6.3/source/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c#L137 [3]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/dsa/lan9303-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
index ee67adeb2cdb..665d69384b62 100644
--- a/drivers/net/dsa/lan9303-core.c
+++ b/drivers/net/dsa/lan9303-core.c
@@ -1013,8 +1013,8 @@ static void lan9303_get_strings(struct dsa_switch *ds, int port,
 		return;
 
 	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++) {
-		strncpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
-			ETH_GSTRING_LEN);
+		memcpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
+		       ETH_GSTRING_LEN);
 	}
 }
 

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231005-strncpy-drivers-net-dsa-lan9303-core-c-6386858e5c22

Best regards,
--
Justin Stitt <justinstitt@google.com>

