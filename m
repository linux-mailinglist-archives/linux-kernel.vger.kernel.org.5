Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156C37BE942
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377445AbjJIS3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376869AbjJIS3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:29:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF7E9D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:29:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a4fb3e096so109176276.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876160; x=1697480960; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XDBK5Er15QvjGUwykMjw01laGvht+dhKObLHHzorKRg=;
        b=4MWOpEQarFiFDsKFVaQ3aoc0aWArpmmCr7Ejvi4R/zOtf5bc8UbGT44Rrg0MGMt3Oz
         hyIVziMJ0YlKpmUSit0Pyf/82m/G8SER7+pvfPLFs7u23uW4ENwws2JaUtFHvWihoUtR
         GCh0MZSyIlnxKstdd1EUdkYUV9wkB2UZSWZ0P+EvekUJspb9SpD0emiBSYa1oINLj1t5
         vEZMkasLTdNMBgkjyWVfE0og4PRW+zTmWuqSu2pdi3yn/9WIVc3zo0KHZ8i/nnGyUBu+
         OxHrqFra5yltxWydL1Lhc5Zt+evYp6nNniS3gWKvbS0QltS5Xdr33rifFmUXRyWLVQJg
         tOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876160; x=1697480960;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XDBK5Er15QvjGUwykMjw01laGvht+dhKObLHHzorKRg=;
        b=cswZYC3djGBUDSaS5r205cqs/+TcYgQU/KgUTbb87RwGvYsT+94NC31+T0UCb/sD9Y
         jSNTdxj2Uv3lEX2WYki7dlTL8etNy/eRotDMHsf75/r3rfvUKD+XnAJ5x5ilB+SgyC82
         NuFnG4PTM1ZwRMk/zqXG9fgEtYEas1heU9xJRBpLQFhLVtvQxfhvEE3GG8dxx/tiho6v
         F9Tvsv5kX49c+jVOyLPMfrb6QnPrlZ4rYBh4+BCSLDMcQAoL9gdHTi8PaINxQ/bPGCR/
         c5HvV5dDrbj+uIB/0/4BO5T2yMTwB3iQNUJYc89WBWvCRTw0efV+RYfPXz7lNdq1ERsh
         DGTQ==
X-Gm-Message-State: AOJu0Yzz+kQjce0Eog9qP72Ae5wI4NHDJhI2UZdX7JqJJqVX8dCcnT2Y
        G3+HCIUNY4809XlKcf5gbiZGgxq1WhXIes6qHg==
X-Google-Smtp-Source: AGHT+IFEYT/za4QVR6fR/MF5JyjgO5M3AWWvhyO5pPz0UrgbgMOrmr3zJveczQ1Hka+kDj8XsImbs1hJdUTnEIDEMA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ad50:0:b0:d78:2c3:e633 with SMTP
 id l16-20020a25ad50000000b00d7802c3e633mr230976ybe.2.1696876159847; Mon, 09
 Oct 2023 11:29:19 -0700 (PDT)
Date:   Mon, 09 Oct 2023 18:29:19 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAH5GJGUC/x3NPQ6DMAxA4asgz7VkCNCfq6AOUexSD02RHSEQ4
 u6NOn7Lewe4mIrDoznAZFXXb65oLw2kd8yzoHI1dNSFluiOXiynZUc2XcUcsxRkj/gp1yEQJuw pRQ63MA49Q80sJi/d/ovpeZ4/gDTkfnIAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696876158; l=1437;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=njDv3GAGmhVrExshk0hx5o9AbY/WD0+6gqoo2bn4Yhg=; b=1J2L7iU0ES7zC7vWFtN9NFGtdF0F81pv/JVQhRo8NZAZIpsJ+gGWhuCDrgOKhESE8tZUUsU3U
 d4Z2vnQKmFuD4VoXPdHgoaiP7YfJE2TD1dTaO5uvm7QNv0tFHL7+jAu
X-Mailer: b4 0.12.3
Message-ID: <20231009-strncpy-drivers-net-dsa-mt7530-c-v1-1-ec6677a6436a@google.com>
Subject: [PATCH] net: dsa: mt7530: replace deprecated strncpy with ethtool_sprintf
From:   Justin Stitt <justinstitt@google.com>
To:     "=?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?=" <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
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

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

ethtool_sprintf() is designed specifically for get_strings() usage.
Let's replace strncpy in favor of this more robust and easier to
understand interface.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/net/dsa/mt7530.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 035a34b50f31..e00126af8318 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -836,8 +836,7 @@ mt7530_get_strings(struct dsa_switch *ds, int port, u32 stringset,
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(mt7530_mib); i++)
-		strncpy(data + i * ETH_GSTRING_LEN, mt7530_mib[i].name,
-			ETH_GSTRING_LEN);
+		ethtool_sprintf(&data, "%s", mt7530_mib[i].name);
 }
 
 static void

---
base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
change-id: 20231009-strncpy-drivers-net-dsa-mt7530-c-40cad383654d

Best regards,
--
Justin Stitt <justinstitt@google.com>

