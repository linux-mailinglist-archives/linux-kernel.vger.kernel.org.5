Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1F97C7B44
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 03:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjJMBks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 21:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJMBkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 21:40:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99769C9;
        Thu, 12 Oct 2023 18:40:39 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27d11401516so1186783a91.2;
        Thu, 12 Oct 2023 18:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697161239; x=1697766039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYzTD01QiqtJTW8F2SBqx3+gh99zDS3mTK0fJJG0LNQ=;
        b=bseE1NkrXwOpqoTP/Qca9RQEFN1+onVjFUK9YLuqRtb0nKOd1ZdZVEefaby81CCx7C
         CDxogWtGh2ma2xerl5iRqxD8drcY+k51jt/SI2rVcsl0ZpDeXrMc2f87OX44pB6BVyCH
         ynuCX3K3hgfFI62gStQ6n7BG9ddz3oI+4oTfOgt0AZ61P4RSdcfHSNfKwhixie6kQWP6
         RHSxxvgRKfOZfetYB5bmM4jCZwe7uyOEL6UUAquuTnWgq8lthIdiOU1QuHk2IZ+AiWfN
         /TWMelYQ9EO2ieyss47u40UPFxeZchTgvIPF/S1+a665qVgm4zaXNd22mjYQ/bCRVXlu
         jZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697161239; x=1697766039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYzTD01QiqtJTW8F2SBqx3+gh99zDS3mTK0fJJG0LNQ=;
        b=EqqKb84N/GR9YsurgDUo83656Tdqq9MgQ/K2mxN+9MMLwDyFUcBsV85QGqqLFFsawN
         D9XpTb3EjExCLtxkjagC/Sq0id1HIZmcnJjwtBhJ3Bi/TdoQQ0gry3ZsDug0gYeuEbSS
         bI6JJac7FAEkcgXdXOqWbQ1tU1GVBXEuwCX8QsGIbZs85fpL8pQ6gkb3dyP0P6CORRt/
         4DiWbKA6bQMjd2V6JFlyC6a17aMRaIXst2SPa61TgNiuwL9CXcD23R1jxYiVz18uPlv3
         CYnfiaF8uhUhXkA/NXUetXxOZFnq1g8PauYe/79J/nfGErk22LKW7TRzLh3fmxvoJWWm
         zjQg==
X-Gm-Message-State: AOJu0YwIiTh5zbUuIb+tPyW9k4TWg8rqTEP/KwyD5Xc2og+RAyYITKC2
        gftvx7/CBykhxIzl6MnK+YCAuqAB0h8=
X-Google-Smtp-Source: AGHT+IH7Q6oQZNMW3cVdZZMkgAekKoImLvRyDkvvnbC6TY6tL4MoF7NoLXFSSaGYZLRNRZ2WWgvrDQ==
X-Received: by 2002:a17:90a:f48f:b0:268:557e:1848 with SMTP id bx15-20020a17090af48f00b00268557e1848mr22577277pjb.2.1697161239008;
        Thu, 12 Oct 2023 18:40:39 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id nr20-20020a17090b241400b0027d1366d113sm2463209pjb.43.2023.10.12.18.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 18:40:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 2A20995B3FA8; Fri, 13 Oct 2023 08:40:34 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Mat Martineau <martineau@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jesper Juhl <jesperjuhl76@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net 2/2] MAINTAINERS: Remove linuxwwan@intel.com mailing list
Date:   Fri, 13 Oct 2023 08:40:09 +0700
Message-ID: <20231013014010.18338-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013014010.18338-1-bagasdotme@gmail.com>
References: <20231013014010.18338-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=bagasdotme@gmail.com; h=from:subject; bh=0BU8oIvaaBmasfaj62J44NQ079dYR7WyaVRII9R8ttg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKkac6tlw98EazRsujZnQemStgkSjNa3V/9IfHH9yOKrk 5XUjXd4dJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiJvMYGX5IOMw69dy6XZzH 72nra8lF0amLRd4wHNtUc1TT7vnn7HBGhu1lX27NaTzK73NdSGXpvbN5Ocu/uKRlqOZ5XPNsnv3 AiRcA
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

Remove the ML to keep Cc: lists a bit shorter.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 785c8b13e74df6..096e6a4103c5ef 100644
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

