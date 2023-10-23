Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D317D2914
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjJWD3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjJWD3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:29:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24054D51;
        Sun, 22 Oct 2023 20:29:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-27d17f5457fso2852985a91.0;
        Sun, 22 Oct 2023 20:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698031777; x=1698636577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKMoisv4APMNvmaa7VcDuH3apsmnkAackD9YWfjsLis=;
        b=mbCC8ZIlCAg4WSvKYk6FynLv7TOd8FmSnkSagQt4mp2LQp1ByWNDdyk6O5+cdCaa6R
         nz8Iv06nJ2/qaK9vUucmGRbJQhQZAT7/MEqzyhDz8PYlpcY3HFdKTx0i3+rwX/YWyss5
         5L84yzm64XzkwjXKgwpLjYSDFkdAH3HY1nksMgnL//HCiPuAoLBNAmbn+5wi4TYXml95
         4+n1dsdkaUb7uFGlF2N7nO89RPM0HfVMBbzo6yjkEOQy0DyiJZkmzek73oUlLQY2Qbx8
         sKAAB9JFqKwgIZ0jDePVnbEbAp5BezEuVDIfTC99RnxfDBrbiga8akZQQ1CqepXThBHr
         XiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698031777; x=1698636577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKMoisv4APMNvmaa7VcDuH3apsmnkAackD9YWfjsLis=;
        b=TACQNhL48rAs43CiNAyIjVDEdfev/4i4ZHvgxy8aIiU0St2dfZGB2hP5AQhTe/TSR6
         g0pT+O2Wz4LjEplUvxK5bb0t86a6tnjSuCaOhfAI5XMrL63/zvZiyboZzhfC9g1V3Roy
         ecfZuUuT9WGzqTlUiIrE1YlUA6d1pHML3YHuB+Tc5EBWdHjMrhv4L1Bc2iX3K2EUrrWi
         rHA1MThr819eFyZ+qJJLhUYImnb3FxzcRMHlPIV4tifaITcx5iEAyQuKp5aDPrHIpuib
         PmWJltBlyNHQy8CLl7OZqxB6o3pEjKkNkCT9JvDPZXuyCOKjyZv9eh7m2dk1PrAI7HNs
         sf0w==
X-Gm-Message-State: AOJu0Yw2Sc9A163sislyipJThClCfS3Ndde6CvwHKd5+FHL+HbSVFwZR
        r3zLpDiW722qLLeXhL1HkdM=
X-Google-Smtp-Source: AGHT+IGxMSmKttS3qdtEKU9T0y1ZbNAmbb1RKkpO2VP3Ip+fTERHjUU8R4+qV8SejH10x3MxfYXecg==
X-Received: by 2002:a17:90a:ba15:b0:27d:1a75:5b98 with SMTP id s21-20020a17090aba1500b0027d1a755b98mr15437559pjr.12.1698031777457;
        Sun, 22 Oct 2023 20:29:37 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a1a4800b002776288537fsm5361684pjl.53.2023.10.22.20.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 20:29:37 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 290AB83AF05F; Mon, 23 Oct 2023 10:29:32 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net v2 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
Date:   Mon, 23 Oct 2023 10:29:04 +0700
Message-ID: <20231023032905.22515-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023032905.22515-2-bagasdotme@gmail.com>
References: <20231023032905.22515-2-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198; i=bagasdotme@gmail.com; h=from:subject; bh=AKGKW/qgr2xlsvLPK5475hdFwWwS2lFj2AVI3aefAZU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmmL2SfnJk8xbVSs+1t0ZrLrSl7/6YefB2dV7bk82/7i 86Lz5t96ihlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEmB4y/OG7WvySLytPzeZg 8ydDuTVNt6tPbNOoFbt1rTXLt/jMI3uG/2G15+4ts7ghPcUkOrJVsGTzDo133xv3Md5fJ7NVaW1 CMzMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emails to him bounce with 550 error code:

```
5.1.0 - Unknown address error 550-'5.1.1 <m.chetan.kumar@linux.intel.com>: Recipient address rejected: User unknown in virtual mailbox table'
```

It looks like he had left Intel, so move him to CREDITS.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 He is still listed by scripts/get_maintainer.pl, though (due to significant
 contribution):

 ```
 $ scripts/get_maintainer.pl drivers/net/wwan/iosm/
 ...
 M Chetan Kumar <m.chetan.kumar@linux.intel.com> (commit_signer:15/23=65%,authored:14/23=61%)
 ...
 ```

 If no one steps up maintaining IOSM, should INTEL WWAN IOSM DRIVER entry
 be removed then to get rid of him, like in [1]?

 [1]: https://lore.kernel.org/lkml/20210316081000.12596-1-krzysztof.kozlowski@canonical.com/

 CREDITS     | 5 +++++
 MAINTAINERS | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index f33a33fd237170..0472398b6aa7e9 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2191,6 +2191,11 @@ D: pirq addr, CS5535 alsa audio driver
 S: Gurgaon, India
 S: Kuala Lumpur, Malaysia
 
+N: M Chetan Kumar
+E: <m.chetan.kumar@intel.com>
+D: Intel WWAN IOSM driver
+D: Mediatek T7XX 5G WWAN reviewer
+
 N: Mohit Kumar
 D: ST Microelectronics SPEAr13xx PCI host bridge driver
 D: Synopsys DesignWare PCI host bridge driver
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a7bd8bd80e9f2..08a7be6a5680ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10879,7 +10879,6 @@ S:	Maintained
 F:	drivers/platform/x86/intel/wmi/thunderbolt.c
 
 INTEL WWAN IOSM DRIVER
-M:	M Chetan Kumar <m.chetan.kumar@intel.com>
 M:	Intel Corporation <linuxwwan@intel.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -13504,7 +13503,6 @@ M:	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
 M:	Intel Corporation <linuxwwan@intel.com>
 R:	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>
 R:	Liu Haijun <haijun.liu@mediatek.com>
-R:	M Chetan Kumar <m.chetan.kumar@linux.intel.com>
 R:	Ricardo Martinez <ricardo.martinez@linux.intel.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
An old man doll... just what I always wanted! - Clara

