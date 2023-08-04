Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5ED77041C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjHDPLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjHDPL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:11:28 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2074C31;
        Fri,  4 Aug 2023 08:11:15 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so35203721fa.2;
        Fri, 04 Aug 2023 08:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691161873; x=1691766673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/APqukGeAaASUv2YUg1QGqAC+pq6Ub8PvVlBR+Veo8=;
        b=MuYfZnGHZFKdLXm1bZSLsTiE6SriVsPjt4MCHM4vSiHUn8GNiFRKgdlzoEMXZu7IeQ
         +V4PCCfOwA4YegCRuIVfgXiSQh/rjq5VCZl9TkV2SuuyHNCix/FjDeJkK1813jx8FUMF
         X9fcnkO7PuKWuZ4jgafku/7pYq6RpUjMmF2SKtTRBv4yESoN3pceRtkYEOo4U1/DyEcB
         Z1YHyD+06Oauj3UQRnUpO+xg5MkIitpcB/gMGlS1/BTTuDqMZ1OiJEx7k0pzYDcRZqh2
         K+ibZ38wDSaI0YOcslXVRymVZTtAAvruAG3dtn8gRC8G18cDqNxrmCJacQDsxDqJSLJ9
         a1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691161873; x=1691766673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/APqukGeAaASUv2YUg1QGqAC+pq6Ub8PvVlBR+Veo8=;
        b=PJm7mFgmVOPnNwr9l1eXC/1O92rv3lhAzjVrznlUTR1dUkqMqAp1Oa9PqhxrwzQAgN
         bHI5c8B+OmsH4j3JgD7eazuJxfjZGd05WUqXE9NqvVCRXYwd2T9WejARXcgCwFkYP82V
         JamMfZfeodSSsW4PYA4PPWeuPWpwOav2ubcqx4UGKI8Z8I7NOvsbEddsK/9SdgdAK4IU
         l1mnGw3cwng678K039OXqtsH4tv4xu60lVZp7+PUDOXN1WEMaN+sN4ERmLdVvGNn0yxX
         jSgI+5fkULeMRDC8VtSUTvphisP3IGoLdc2DYv0m6Yhy2DjzEKm9vDF41EgH8uJGLnG1
         QKBw==
X-Gm-Message-State: AOJu0YyyyH5ttusZZizZ8v1YK7PicdBVNydhbJtghvH/Y5q23dTGLlKA
        KGZ7ldhTH8rRJx4ePYJoIGB3okvcZt8=
X-Google-Smtp-Source: AGHT+IF1+DVK3U8TTYJYza7JWURur+pYHxLnYZ4P9wt4JRQsmJ5KVZ1b2gnaSwrcvdAMBxuVjzwVLA==
X-Received: by 2002:a05:6512:65:b0:4fb:89f2:278e with SMTP id i5-20020a056512006500b004fb89f2278emr1490230lfo.68.1691161873024;
        Fri, 04 Aug 2023 08:11:13 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id e14-20020a50fb8e000000b0051df67eaf62sm1392368edq.42.2023.08.04.08.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:11:12 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.5-rc5
Date:   Fri,  4 Aug 2023 17:10:58 +0200
Message-ID: <20230804151059.712246-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

Hi Linus,

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.5-rc5

for you to fetch changes up to e6e2843230799230fc5deb8279728a7218b0d63c:

  libceph: fix potential hang in ceph_osdc_notify() (2023-08-02 09:07:34 +0200)

----------------------------------------------------------------
Two patches to improve RBD exclusive lock interaction with
osd_request_timeout option and another fix to reduce the potential for
erroneous blocklisting -- this time in CephFS.  All going to stable.

----------------------------------------------------------------
Ilya Dryomov (2):
      rbd: prevent busy loop when requesting exclusive lock
      libceph: fix potential hang in ceph_osdc_notify()

Xiubo Li (1):
      ceph: defer stopping mdsc delayed_work

 drivers/block/rbd.c   | 28 +++++++++++++++-------------
 fs/ceph/mds_client.c  |  4 ++--
 fs/ceph/mds_client.h  |  5 +++++
 fs/ceph/super.c       | 10 ++++++++++
 net/ceph/osd_client.c | 20 ++++++++++++++------
 5 files changed, 46 insertions(+), 21 deletions(-)
