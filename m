Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A6C7AA92B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 08:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjIVGhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 02:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjIVGg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 02:36:58 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589B6194
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=gkz2W+yEGWK0D1GovLU70p5L1fltJzO4Pxo6rs+vakE=; b=LpbW5J
        DwH7UYRFK91DiuRY7IRowz2k4edQIN9soeQwBOVe6i18ZXBazkSY2GCaoPJzmbf4
        DwiKU5b7NsIB/lVNDFIX+zRxhSKcypdjWJbQvpqLlxpXY0dwVTNLTMCappiKPEoI
        IucOGbG/peaooRHfZnHOhidXfUm8P2PMBVXE4w9r4an0JBSakfa3sD+jemlZajza
        G9GwbzOCc1Fo2HPnV+hbTk+I2qZuTEJac4gz3aKy5/ign6TqkSYeU/nC0Y/RkMz1
        xpRfn+CLTRMvPKC2R3QRqwX+dAqTrGzgRS2ZAcq740KqRxWMv4BuRP5YfUtISzHv
        +F+urR2mEehC9A1A==
Received: (qmail 1276389 invoked from network); 22 Sep 2023 08:36:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2023 08:36:50 +0200
X-UD-Smtp-Session: l3s3148p1@IrNY1ewFaroujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 1/2] serial: core: remove cruft from uapi header
Date:   Fri, 22 Sep 2023 08:36:41 +0200
Message-Id: <20230922063642.4120-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230922063642.4120-1-wsa+renesas@sang-engineering.com>
References: <20230922063642.4120-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the GPL boilerplate since we have a valid SPDX entry. Also,
remove the outdated filename from the comment.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/uapi/linux/serial_core.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index add349889d0a..92e3dd56f631 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -1,22 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
 /*
- *  linux/drivers/char/serial_core.h
- *
  *  Copyright (C) 2000 Deep Blue Solutions Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #ifndef _UAPILINUX_SERIAL_CORE_H
 #define _UAPILINUX_SERIAL_CORE_H
-- 
2.35.1

