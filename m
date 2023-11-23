Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6636E7F5A21
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344950AbjKWIfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 03:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKWIfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 03:35:18 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7DEA3;
        Thu, 23 Nov 2023 00:35:22 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cf61eed213so5220715ad.2;
        Thu, 23 Nov 2023 00:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700728522; x=1701333322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P+ePl85i/Re/poRcEUXCR+kOqp02ehB66V8Z/F/iETU=;
        b=P7m2US17Rig8Bfk+hbMHDjyKnGQpvoLezHzaVriKGs9EF2w7bzbaKrav3i0uXr5RDY
         zbFPteErg99I/+2m0TQoDOMPfQCKPa2WcWH9OeqLzzRsk5J4rye5yFZSkPDyuHSlzhtA
         tRvDN9i3J1KJlZA+wLpkr8JAYndKKt2R6AndjtnUka+tiCv0EntFQyc8udlESsE/gBSV
         RsYBc+2vy1yTLqFrUIjDhlS1/zXTMYXcheqB4ltl3xgJOS6u9JvrNCGW2LvCSplwcQC4
         GHoMeBFzfJJR/2RsQ1rmHtxeXmCBy1X46q/mIsGzAsHxEAEfkCsCUfdh8q+fLBpgzX8V
         dWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700728522; x=1701333322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+ePl85i/Re/poRcEUXCR+kOqp02ehB66V8Z/F/iETU=;
        b=uikkyHI+ykLZAbqQqWXHYn1O2qOZjixxpXS1u0sbNCZUjeR03UgEmqShcZtpeYn/LW
         PAVdJ1dy51ZjKAXPvKlWvAnCZPmwVAt2kCFY+gOk7zAZigd+VAvs+sy3yxnEOHMDUH+n
         01IUlB6jy11gNHImf3iYJgUv7sBV3u6EJfjNR6TKBcC0Wglq/daaolDl8dsEUk+0aNt/
         XlmLBO2025rS60NNatySQUWTAI/w2IER6vZjBUDHK9mzVf8+WaXVCvschMUOXetD3dhK
         hcGvmI93Z37d7TdMneXAS6sisXCHOxiuUg3Jx115fGxgdWjYSbtrgeF8f/vDa2nzJOrn
         Tycw==
X-Gm-Message-State: AOJu0Yyxb4kVtLpV+xJkAXF/8sERlpktOUOWFxa+YddmnZI5LsD+FtXU
        CNlc2tdOOJ68k+2oEXfRm2U=
X-Google-Smtp-Source: AGHT+IFjXHU1gr/2iPKHRsm/ZJzrbEmDVs+Z83B5YqlUVCClP1Qhj6B+Mz30No3awDSJ1jZyuKkIoA==
X-Received: by 2002:a17:902:b417:b0:1cf:6d26:9de3 with SMTP id x23-20020a170902b41700b001cf6d269de3mr5062654plr.39.1700728521988;
        Thu, 23 Nov 2023 00:35:21 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902c38d00b001c0a414695bsm788707plg.43.2023.11.23.00.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 00:35:21 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id F07EF1024DA1A; Thu, 23 Nov 2023 15:35:17 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Staging Drivers <linux-staging@lists.linux.dev>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Soumya Negi <soumya.negi97@gmail.com>,
        Alexon Oliveira <alexondunkan@gmail.com>,
        Matt Jan <zoo868e@gmail.com>,
        Jonathan Bergh <bergh.jonathan@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Bruno Moreira-Guedes <codeagain@codeagain.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH v2] MAINTAINERS: Mark VME subsystem as orphan
Date:   Thu, 23 Nov 2023 15:34:03 +0700
Message-ID: <20231123083406.12129-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2181; i=bagasdotme@gmail.com; h=from:subject; bh=RF8BTmAc6aqA8QPnd9h43mZ5xpWxpB+c0g20PoeJqZE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKnxvD+m9P+Y3hk5q/oUo9mztxMOFDkEHDzEJzqv50pJY 53BG56ZHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIpgmMDEuDckT8Z2y4Zy/F zl6qFq7x7+QEkcdK1/o00qO+HGpzYWFkePHAetUP27eHWF8dMiyT33pyjTJ7YseHlfe1eebIs56 +yQoA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martyn Welch lost his access to VME hardware [1]; and Manohar Vanga has been
MIA since early January 2014 (his last message was [2]). Martyn admitted
that the subsystem is basically orphan, so mark it as such. As a bonus,
add CREDITS entries for the former subsystem maintainers.

Link: https://lore.kernel.org/r/fe8ac0db-d6cc-41bc-b926-484b418e1720@collabora.com/ [1]
Link: https://lore.kernel.org/r/CAEktxaFL=3cmU4vZS2akiAR2vG-3d+9HwTZvBvf5JXuThHoOKg@mail.gmail.com/ [2]
Cc: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [3]:

 * Orphanize the subsystem (Martyn)
 * Sort Manohar's CREDITS entry

[3]: https://lore.kernel.org/linux-staging/20231122094156.30642-1-bagasdotme@gmail.com/

 CREDITS     | 8 ++++++++
 MAINTAINERS | 5 +----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/CREDITS b/CREDITS
index f33a33fd237170..ba6eb6274f8bed 100644
--- a/CREDITS
+++ b/CREDITS
@@ -3916,6 +3916,10 @@ S: 21513 Conradia Ct
 S: Cupertino, CA 95014
 S: USA
 
+N: Manohar Vanga
+E: manohar.vanga@gmail.com
+D: VME subsystem maintainer
+
 N: Thibaut Varène
 E: hacks+kernel@slashdirt.org
 W: http://hacks.slashdirt.org/
@@ -4016,6 +4020,10 @@ D: Fixes for the NE/2-driver
 D: Miscellaneous MCA-support
 D: Cleanup of the Config-files
 
+N: Martyn Welch
+E: martyn@welchs.me.uk
+D: VME subsystem maintainer
+
 N: Matt Welsh
 E: mdw@metalab.unc.edu
 W: http://www.cs.berkeley.edu/~mdw
diff --git a/MAINTAINERS b/MAINTAINERS
index ea790149af7951..ff083d12001489 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23234,11 +23234,8 @@ F:	include/linux/vmalloc.h
 F:	mm/vmalloc.c
 
 VME SUBSYSTEM
-M:	Martyn Welch <martyn@welchs.me.uk>
-M:	Manohar Vanga <manohar.vanga@gmail.com>
-M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 L:	linux-kernel@vger.kernel.org
-S:	Odd fixes
+S:	Orphan
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 F:	Documentation/driver-api/vme.rst
 F:	drivers/staging/vme_user/

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
An old man doll... just what I always wanted! - Clara

