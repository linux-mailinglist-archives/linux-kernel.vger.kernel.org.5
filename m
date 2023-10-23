Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905417D2910
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjJWD3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjJWD3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:29:39 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F703188;
        Sun, 22 Oct 2023 20:29:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9a1762b43so23271565ad.1;
        Sun, 22 Oct 2023 20:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698031776; x=1698636576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WE+2ax+ckyyK0GydSOksCqTiRS2Um4EHTAoyLLZfmB4=;
        b=Yi/1+i9JuDAiNLqCAhyoAXByJNCgoen+LFceGP15b9YQJIH4IaXUKfZA+MYWdAEWu+
         Y6ManBez0d7BY/ALwUnsldCLuLzsO5YTZuU9lonQiG+5xmTBm8djUEuP+ebQWwgvrgmt
         IiRBIJ6cA694i8B275ZZZNGlFUiJyLWGPNXDK2PoBmPoW35G2dL4hFrxFfz9Dv3dTRJ2
         NwJZqnBPteOGvW9WWupRcUP7WyHVbB0BjAXKX7w+MS7+5l+rS8LrMlFMwu/MXnihIwWK
         JDV7KKgzCoALYq7nnhs9tmRKrdkbVNga+JktH6EhUZjNC3a2fGSRVv5KH0CYSLWGHR8B
         hOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698031776; x=1698636576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WE+2ax+ckyyK0GydSOksCqTiRS2Um4EHTAoyLLZfmB4=;
        b=ww27MGy4OL0JEE83Ew4MyRrfRSBIAZv/NWkPMA5BgCLKP6Bj/gHoqeJ2jnOopuFFUk
         +LbEaN/HgtfrhhnGc5S+Ktsv+7yZSrYfp8lmkDuAILOS9Cyo4+j+gKvcxDvJIQFAJTfG
         NSLlzq84jVWda3ChX1XmEqhGuyXMJS46LzKFqLuAZZ4zl3x56AAvromj+JyAp5bB0vXv
         6oaL6+R4q8jBodT6yV2QUlRkQpRVzyalngqiPB/YjdQXHOhK7iQxcdiBefT9H49gZilF
         iO5Q1QEoiQTFL/wBiJrjoHhv5Y2rVNeOHPuPeaZy+ZCrWSpIrVt3YHa98NgFduoiG66Q
         Cpcw==
X-Gm-Message-State: AOJu0YyszTSe9wWzcKoGhCNvKraPt6uLrIqKWWUjaaK6jeMou5sNErve
        n1ZHEU0tIxPCyuFybSbAtG0=
X-Google-Smtp-Source: AGHT+IHOhKRMAo6KBlUi+MNLra7QroMOI7iaq9QGsi0kTMHEdxpSyWt9YCF22sVWqUuTCrSIba66Zg==
X-Received: by 2002:a17:903:1c8:b0:1c9:bf02:6638 with SMTP id e8-20020a17090301c800b001c9bf026638mr8846162plh.51.1698031776385;
        Sun, 22 Oct 2023 20:29:36 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b001c727d3ea6bsm5014253plh.74.2023.10.22.20.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 20:29:35 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 397B88055D5A; Mon, 23 Oct 2023 10:29:32 +0700 (WIB)
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
Subject: [PATCH net v2 2/2] MAINTAINERS: Remove linuxwwan@intel.com mailing list
Date:   Mon, 23 Oct 2023 10:29:05 +0700
Message-ID: <20231023032905.22515-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023032905.22515-2-bagasdotme@gmail.com>
References: <20231023032905.22515-2-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1582; i=bagasdotme@gmail.com; h=from:subject; bh=nrzzUcakoOgJE4YQn7XXEJJt4nFmk1Y6mNvMO2ZAmRo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmmL2Q5ruZv4bmSJczhHJh05bXqnwbDgC0lZy2ubHVdO et3i5tmRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbiXs/wVyK6ZcmlLfd4cvYx 5k+98nb5nuK4dNEPJ9ZO/2IfHsa4jZeRYaHKkqLO3B+37nAsltasdz1gOzM+7qno7vCLC+YpiJl vZwIA
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

Messages submitted to the ML bounce (address not found error). In
fact, the ML was mistagged as person maintainer instead of mailing
list.

Remove the ML to keep Cc: lists a bit shorter and not to spam
everyone's inbox with postmaster notifications.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Intel people, if you still want to maintain int1092 (aka IOSM), please
 let me know.

 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 08a7be6a5680ed..f164e573abdae8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10450,7 +10450,6 @@ F:	drivers/platform/x86/intel/atomisp2/led.c
 
 INTEL BIOS SAR INT1092 DRIVER
 M:	Shravan Sudhakar <s.shravan@intel.com>
-M:	Intel Corporation <linuxwwan@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel/int1092/
@@ -10879,9 +10878,8 @@ S:	Maintained
 F:	drivers/platform/x86/intel/wmi/thunderbolt.c
 
 INTEL WWAN IOSM DRIVER
-M:	Intel Corporation <linuxwwan@intel.com>
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/net/wwan/iosm/
 
 INTEL(R) TRACE HUB
@@ -13500,7 +13498,6 @@ F:	net/dsa/tag_mtk.c
 
 MEDIATEK T7XX 5G WWAN MODEM DRIVER
 M:	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
-M:	Intel Corporation <linuxwwan@intel.com>
 R:	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>
 R:	Liu Haijun <haijun.liu@mediatek.com>
 R:	Ricardo Martinez <ricardo.martinez@linux.intel.com>
-- 
An old man doll... just what I always wanted! - Clara

