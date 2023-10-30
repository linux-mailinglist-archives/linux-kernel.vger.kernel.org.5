Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4D17DC090
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjJ3TeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3TeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:34:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56439A9;
        Mon, 30 Oct 2023 12:33:58 -0700 (PDT)
Received: from arisu.hitronhub.home (unknown [23.233.251.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2979C6607392;
        Mon, 30 Oct 2023 19:33:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698694437;
        bh=ahnTelEXG01rwNePCrXmDyqjE42txSlbUhezqbVf4V4=;
        h=From:To:Cc:Subject:Date:From;
        b=SRumtA5+ByCMxAbR76CSZDkpKxbtWKyrwhaEI7ZR2MwnrWIhOBj2PdRofJJCmgB+a
         Q2ikBWlbHdMeCHshtPb7WQmrUx8EpsdL51+Idv4eCPVuYdVCHow9Tjukr7WPlW4veu
         axffcbfrZlnQn1+bxFEC+km+pZgHQe0YfahtqNQHytAlY4n9+ixBwloJtCgY28BWaR
         8JHrAgdOBngOxQVd0d1J4TzziZ4ta2SQVwtuRgDrkwXzJTvAXELOFlsSAWvb7N7qh1
         5+4uxNpqPWdBWk3Rhz/3R9H2S8IrIPfODVn6wOKMEA8NJJT6w4xrvzFmtrelJ8eTlM
         9RvCStuJvXRXw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 0/2] visl: Add support for AV1
Date:   Mon, 30 Oct 2023 15:27:54 -0400
Message-ID: <20231030193406.70126-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AV1 support is missing in the visl test driver.
Add it and adapt documentation.

The traces are missing some fields, basically:
- multi-dimensional arrays
- arrays of flags
- enums
which don't have a __print_* macro.

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

