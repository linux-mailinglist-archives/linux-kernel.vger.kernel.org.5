Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBEB7588CA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjGRW4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGRW4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:56:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54005E0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:56:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cad564b45e1so5245153276.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689721003; x=1692313003;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JKTsUBdHf6mjrglthc3JKXEbljqtwfJ0Wa0XKyAwGoA=;
        b=DsAK+7b+KhUIfLn5uvVmAgBbjA/+sjrZYzO4DVVMQgvgR3oP5/HamLWwUMfW1p5vok
         eRsHnOVW+5VV+uausCTw6SL5XiZlNjdNj3b5wiTmrC5I+IW0xaK4M/17h45cIXAzHFI8
         FmwNcBBLJgZZHLHgQw3ENz2EXvLg0+pq5KJkFotTQoyH0EgwOkpKFGo2Hw7jK2ZmC0qo
         o8KBqCPmk4efYXUGj8axuFWt0iOYHltU5W7qjDQAQjfE+Am2aN202o4UpFdySp2gzpAz
         C4jdMGG9X7Ghk3sHwhYODDiarfsuVr17ViucIN7TMsUeViiorpy3x1TRqzfuKClOVxWL
         jYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689721003; x=1692313003;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JKTsUBdHf6mjrglthc3JKXEbljqtwfJ0Wa0XKyAwGoA=;
        b=j38XIu20r3DT6DpF/j/VwqDtSNykT/okNWwvAynhucyUBiqs2Syd5SlPiLg1Vb4y3V
         yMKJvHFsY8kU4jhaTcUDs0rZNiQlDFPB5aNtD1LTzI4pCUkMsfXtN6EZDK38u9PZdJlv
         2Krima/mZXunWzZ2CNkSP0mxgf4fNaZrq40NtpG0JRSb0xbyaUpuB0YK/Uoz8D4DJ0tr
         x7coyDszuu4L5UcTxizygD8bNzCaGgS63IzZvqVPTnqm4rEeFk64cugjpQFrme7mQxtV
         S24KplVJi2Xe9HyQNoEdF/pz7zGVAeHSB0Pn3UCgD0v0ZxTGm/MjxQK8PYtmpfQv8yE8
         anYQ==
X-Gm-Message-State: ABy/qLbeWQ3I08YlmyKjKMx72GqTlEPo3sdRg8+K4K2eBSLhACmkunP5
        qMVwqWUOnARSHg//yIyPNRwsbZgZA4Ys/tA78A==
X-Google-Smtp-Source: APBJJlG2mNbB4+Ix6MIAKLP7DuY2hzs2vLvOCZP+vbbUQfM+4tAASi3Fq8EglGyCjjc1QqUMspm/luv4/NVC7wQH/w==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:b2a4:0:b0:ce8:f8ac:c979 with SMTP
 id k36-20020a25b2a4000000b00ce8f8acc979mr10152ybj.1.1689721003510; Tue, 18
 Jul 2023 15:56:43 -0700 (PDT)
Date:   Tue, 18 Jul 2023 22:56:38 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKUYt2QC/5WNQQ7CIBBFr2JYiykMdNCV9zAuEKYtiRYDTaMxv
 bvYlYtq0tm9Sd77L5YpBcrssHmxRGPIIfYF5HbDXGf7lnjwhZmsJFQokPc0cJ8tz0Pq3f3JjVL
 OinJ0kaxY90RNeMzF07lwF/IQ03MeGMXn+7s1Ci64lIigrdh70Mc2xvZKOxdvn/Z/EaXzjWr22 nuzSrSgsQYgkJeVi84AOLBCV9WyaJZFMqquFSpEAd/ieZqmN/O1LpeTAQAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689721002; l=2431;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=12Invee2F46gxBoPTo2ea7wJxLDZIoaUSVi90l6hl/A=; b=OYb+IwNf7reduFC3/7/pdOdfLntzT7A3k9gUneK/SJVzEuBJVWxUB8X0Z+RkaQuyzFJGnvMqW
 cc9BBYDEykPD6lvE+aIwAq9EDEj96mvNmkhMsqlw5EjWsnUBN4FlXPc
X-Mailer: b4 0.12.3
Message-ID: <20230718-net-dsa-strncpy-v2-1-3210463a08be@google.com>
Subject: [PATCH v2] net: dsa: remove deprecated strncpy
From:   justinstitt@google.com
To:     Justin Stitt <justinstitt@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

Even call sites utilizing length-bounded destination buffers should
switch over to using `strtomem` or `strtomem_pad`. In this case,
however, the compiler is unable to determine the size of the `data`
buffer which renders `strtomem` unusable. Due to this, `strscpy`
should be used.

It should be noted that most call sites already zero-initialize the
destination buffer. However, I've opted to use `strscpy_pad` to maintain
the same exact behavior that `strncpy` produced (zero-padded tail up to
`len`).

Also see [3].

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: elixir.bootlin.com/linux/v6.3/source/net/ethtool/ioctl.c#L1944
[3]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Link: https://github.com/KSPP/linux/issues/90
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- include string header (thanks Nick)
- add reviewed-by trailers
- Link to v1: https://lore.kernel.org/r/20230718-net-dsa-strncpy-v1-1-e84664747713@google.com
---
 net/dsa/slave.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 527b1d576460..48db91b33390 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -21,6 +21,7 @@
 #include <linux/if_hsr.h>
 #include <net/dcbnl.h>
 #include <linux/netpoll.h>
+#include <linux/string.h>
 
 #include "dsa.h"
 #include "port.h"
@@ -1056,10 +1057,10 @@ static void dsa_slave_get_strings(struct net_device *dev,
 	if (stringset == ETH_SS_STATS) {
 		int len = ETH_GSTRING_LEN;
 
-		strncpy(data, "tx_packets", len);
-		strncpy(data + len, "tx_bytes", len);
-		strncpy(data + 2 * len, "rx_packets", len);
-		strncpy(data + 3 * len, "rx_bytes", len);
+		strscpy_pad(data, "tx_packets", len);
+		strscpy_pad(data + len, "tx_bytes", len);
+		strscpy_pad(data + 2 * len, "rx_packets", len);
+		strscpy_pad(data + 3 * len, "rx_bytes", len);
 		if (ds->ops->get_strings)
 			ds->ops->get_strings(ds, dp->index, stringset,
 					     data + 4 * len);

---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230717-net-dsa-strncpy-844ca1111eb2

Best regards,
-- 
Justin Stitt <justinstitt@google.com>

