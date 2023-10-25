Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960EA7D6CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjJYNE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbjJYNE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:04:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C06111;
        Wed, 25 Oct 2023 06:04:24 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c0ecb9a075so40658115ad.2;
        Wed, 25 Oct 2023 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698239064; x=1698843864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aItnBr/Ps6QJrhOth2m6UNiWmsSsRn+ai7RbjQVNy3k=;
        b=aOQ4Ct/Lkb+ImmXUyABdX8BX+OY5XDK/ZVev6goepLAR5pd+d1vpqZGuATC1p4JXPb
         D55SHTTklIeC/+VSgLjbpj+Ejl+yRGE6S43Z6gd/FFJkIzUPnExgzn3+Fcy5PxPaRlXu
         br9HwR2nYrRJEKPOmLXNAoD2rI9ptwG9ThM0wZLfHLs0+erbxqGvO9Wn9rW++BiHoMGh
         cpDb+ZrjnSVKiU9t3xUF6d2+oiT7Vu+7ub108l+6/XiR+46/xiGaclSBhj3LQw9m+tC7
         ou0wTolMpj79P417dQAJFoGpBN/1FO+04PQTnYJGmNK+RvWVXBjanjwZE7/f2ETR5lMM
         HoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698239064; x=1698843864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aItnBr/Ps6QJrhOth2m6UNiWmsSsRn+ai7RbjQVNy3k=;
        b=nEcD+Mhs8fuxTRX6dMZMbErRQ82lC9G6aB5yh/dZWMVOsqLscxlxJj+q0+EKbn7FPk
         dH5Hewpai8Eh9L2dd/UTBT5C5jFxALNBXF3TLN2Mt+RuTDKC4sI+2aJHtNlTQW4n6GPi
         1z6yQ5iw6LNuFGBFRIlOj9JQPR27a7zp49Zk7co0acpTKylc81Sj/Gf9vm69HYHzgt/x
         pQ4Xwf+SFFJqK40/byc3NwIt/lmn16YPtH/W3HHx2bSxDygKIQFan6Uv0Wsj3jzfKMY1
         IQR5zMP0YIXd8hvdbYu3nZT+mKypId3HHcqqnDL4bQ8SJ9fLVAlXKBX6sLTYAOirHLWs
         2m/w==
X-Gm-Message-State: AOJu0YwIbq8BFa2J6kiZEureYzB7orJTOEErx9W2ApJ//+BqienR6Yqf
        QCbNBGOJnFzOMKEkz+YJ1m8=
X-Google-Smtp-Source: AGHT+IFqT2sVfFYt+JtemJ5Ozilk0GHFzrUmXb3j9fH8lnSXfEzRxGcF8IKSN6AIghnqT7OtdMZ/GQ==
X-Received: by 2002:a17:902:e80d:b0:1bf:d92e:c5a7 with SMTP id u13-20020a170902e80d00b001bfd92ec5a7mr14682876plg.28.1698239063240;
        Wed, 25 Oct 2023 06:04:23 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902da8c00b001c61afa7009sm9155213plx.114.2023.10.25.06.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:04:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6FBB6819CFF3; Wed, 25 Oct 2023 20:04:05 +0700 (WIB)
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
Subject: [PATCH net v3] MAINTAINERS: Remove linuxwwan@intel.com mailing list
Date:   Wed, 25 Oct 2023 20:03:32 +0700
Message-ID: <20231025130332.67995-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1789; i=bagasdotme@gmail.com; h=from:subject; bh=A2cdFzhNhGYYt9DxpQC5lHsdcQnAd6421LmrVFSMjlM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmWgj5XUx6m7e7/6G721bRp7b6Fjx8IV0UZ/t3WvT/08 LQr26vdO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjARE3aGn4zH4wJXvq6YwLje +Pr2VMspe4uTz7icyE4vS3pwylfA6w0jw8tfa03n/s47v05Ars/gw0uRfra9PUXuza8XF/qK95u wswMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 Changes since v2 [1]:

   * Keep M Chetan Kumar in MAINTAINERS, as Johannes is trying to
     keep in touch with him. As a result, this v3 is reduced to a
     single patch.

 [1]: https://lore.kernel.org/netdev/20231023032905.22515-2-bagasdotme@gmail.com/

 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a7bd8bd80e9f2..2618f3f55080d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10450,7 +10450,6 @@ F:	drivers/platform/x86/intel/atomisp2/led.c
 
 INTEL BIOS SAR INT1092 DRIVER
 M:	Shravan Sudhakar <s.shravan@intel.com>
-M:	Intel Corporation <linuxwwan@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel/int1092/
@@ -10880,7 +10879,6 @@ F:	drivers/platform/x86/intel/wmi/thunderbolt.c
 
 INTEL WWAN IOSM DRIVER
 M:	M Chetan Kumar <m.chetan.kumar@intel.com>
-M:	Intel Corporation <linuxwwan@intel.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/wwan/iosm/
@@ -13501,7 +13499,6 @@ F:	net/dsa/tag_mtk.c
 
 MEDIATEK T7XX 5G WWAN MODEM DRIVER
 M:	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
-M:	Intel Corporation <linuxwwan@intel.com>
 R:	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>
 R:	Liu Haijun <haijun.liu@mediatek.com>
 R:	M Chetan Kumar <m.chetan.kumar@linux.intel.com>

base-commit: 1711435e3e67e079d6a2bce54d96d1af21c7ef2c
-- 
An old man doll... just what I always wanted! - Clara

