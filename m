Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78B27AEE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjIZNjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjIZNjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:39:13 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22695101
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:39:06 -0700 (PDT)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 26 Sep 2023 13:37:13 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org, Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 0/1] tools/nolibc: Support centos-7
Date:   Tue, 26 Sep 2023 15:36:46 +0200
Message-Id: <20230926133647.467179-1-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to use nolibc in runc[1] and I found that it doesn't work on
centos-7.

I don't know if you care about centos-7 support, let me know. But the fix is so
simple, that I'm just sending it.


Best,
Rodrigo

[1]: https://github.com/opencontainers/runc/pull/4024/

Rodrigo Campos (1):
  tools/nolibc: Add workarounds for centos-7

 tools/include/nolibc/statx.h | 218 +++++++++++++++++++++++++++++++++++
 tools/include/nolibc/sys.h   |   2 +-
 tools/include/nolibc/types.h |   2 +-
 3 files changed, 220 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/nolibc/statx.h

-- 
2.40.1

