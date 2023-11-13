Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0666E7EA044
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjKMPlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjKMPlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:41:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93949D67;
        Mon, 13 Nov 2023 07:41:10 -0800 (PST)
Received: from arisu.mtl.collabora.ca (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 56BD96606EE0;
        Mon, 13 Nov 2023 15:41:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699890069;
        bh=Ct0vREwCV/y48Ltfl5ZejvVpefPCrB296PF5Yd+AOXw=;
        h=From:To:Cc:Subject:Date:From;
        b=LmQZNs6mikEo7iX/OkglMpMY2mThLAIE2h0t3Rs5E+UGoFFU47Mar3EO2XQpHJefX
         xA7B31YUvVK7+rPy9lZEDCj0tXZc/8mLNDMYQqgAfnTlX4YLdS7cd1I6msPI5Xyp1h
         C+UaG3peq96JcMQ+iENs8Ljp9vGVqfXgrYIPJ4ij2C1j0iHdYA3yA7vbZNqmsL4nLO
         tylmt5keTMLWHWbbJgRgQKtOzQp+g8qvKGG1aWuP0mCSdvVIXQFX03enz8eV3aXeRX
         TkKRU39ITHU5OKYe3c3USBmcddQIvofYu7sm/Ccl5TdUV+3M5/2DcfIWsEP9hCx10F
         o05m8PugfoTGA==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 0/2] visl: Add support for AV1
Date:   Mon, 13 Nov 2023 10:39:57 -0500
Message-ID: <20231113154109.114488-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AV1 support is missing in the visl test driver.
Add it and adapt documentation.

The traces are missing for some fields, basically:
- multi-dimensional arrays
- arrays of flags
- enums
which don't have a __print_* macro.

Changes since v1:
- Rebased on media_tree/master

Detlev Casanova (2):
  visl: Add AV1 support
  doc: visl: Add AV1 support

 Documentation/admin-guide/media/visl.rst      |   2 +
 drivers/media/test-drivers/visl/visl-core.c   |  21 ++
 drivers/media/test-drivers/visl/visl-dec.c    |  70 +++-
 drivers/media/test-drivers/visl/visl-dec.h    |   8 +
 .../media/test-drivers/visl/visl-trace-av1.h  | 314 ++++++++++++++++++
 .../test-drivers/visl/visl-trace-points.c     |   1 +
 drivers/media/test-drivers/visl/visl-video.c  |  18 +
 drivers/media/test-drivers/visl/visl-video.h  |   1 +
 drivers/media/test-drivers/visl/visl.h        |   1 +
 9 files changed, 435 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/test-drivers/visl/visl-trace-av1.h

-- 
2.41.0

