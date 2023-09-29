Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119EC7B3636
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjI2PAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjI2PAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:00:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3B4D6;
        Fri, 29 Sep 2023 08:00:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-405524e6768so121690015e9.2;
        Fri, 29 Sep 2023 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695999611; x=1696604411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CtPe4mjTardTaVM0JtiSOk4fBe7BJmu4yN+2BTI0yDU=;
        b=N31BcFz9vk+bO0sUbGGnImpfbPWKN1MM955bZxskf22aS6YBsuJ89HaWCd4rKx8p7P
         U60QUGQTp7bWP+21BRgKQMbzkXam4s92sk6V91AonMuvLRXoMHXhLyg0UP5VYiJl1HS3
         bRbGwcfaEs2MBQ5zB2Fo9NvbXyQHxIDxzBnmkEYmaf4+MhJhM+1h3eGKBJo0XUGIda8t
         6i36KzOXNUSbQjBEDHpuc7E4LCsS2fr6SDaL8iXMkLYANUKdz6+oQ+hj4dL13vm/HxbI
         X55kb8i9MUpbiJS5YrXp37MIMW5F7TcOmGD6c1fOY3i/qoqe+QGd8PqnMJXBq7EpWphQ
         g4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695999611; x=1696604411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtPe4mjTardTaVM0JtiSOk4fBe7BJmu4yN+2BTI0yDU=;
        b=sXEbhtL98x50CDRxyK2Gzc0zyV5cjM6I1W8MdsY1B94AEM21PHzkK9PSKDVr1VyWsz
         RIxr8Wt+5PTh6kgARnJmtIUlp9HraEYHPNfntPpB8hBC7eHw/O+K/6WdaIJvpuYrDb8u
         EuVmw8aqbhhdfnYOpa4Rx+XplzVvUZR9I0FDE3Cc/D7AINUaEFcBXVDRDqlDs5tfonb6
         iUR0fNOj0oeYLZbVa3IsaRx1gyNoQnfItxFhll6Zh0/fdYudIyYM5YFR08FhtQ/4o8Vh
         dB3AiXP4+oetu702UUK1H3KBJio9Yq5vebiFNT6o51K0GuLRTEu30KbSHKP6dCVp7CFO
         LhGg==
X-Gm-Message-State: AOJu0YzFhXojiXDeYFEmExs5EPr0nhn/YWN2HjpcclmedZowtK6HfY2V
        GyX/tjCYlilPbI4iONhbRkSCwgRMuMg=
X-Google-Smtp-Source: AGHT+IEY0iJeYu40MKHev3OBO5axsCc2X6iUOEOfqpcrY9gX7BGj+BUdoZeo/vaq7741RJXLA4cUgQ==
X-Received: by 2002:a1c:7704:0:b0:401:dc7c:2494 with SMTP id t4-20020a1c7704000000b00401dc7c2494mr4246521wmi.27.1695999610365;
        Fri, 29 Sep 2023 08:00:10 -0700 (PDT)
Received: from zambezi.redhat.com (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b00406447b798bsm1581016wmg.37.2023.09.29.08.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:00:09 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.6-rc4
Date:   Fri, 29 Sep 2023 16:59:36 +0200
Message-ID: <20230929150002.264424-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Linus,

The following changes since commit ce9ecca0238b140b88f43859b211c9fdfd8e5b70:

  Linux 6.6-rc2 (2023-09-17 14:40:24 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.6-rc4

for you to fetch changes up to 0b207d02bd9ab8dcc31b262ca9f60dbc1822500d:

  rbd: take header_rwsem in rbd_dev_refresh() only when updating (2023-09-26 10:33:19 +0200)

----------------------------------------------------------------
A series that fixes an involved "double watch error" deadlock in RBD
marked for stable and two cleanups.

----------------------------------------------------------------
Ilya Dryomov (5):
      Revert "ceph: make members in struct ceph_mds_request_args_ext a union"
      rbd: move rbd_dev_refresh() definition
      rbd: decouple header read-in from updating rbd_dev->header
      rbd: decouple parent info read-in from updating rbd_dev
      rbd: take header_rwsem in rbd_dev_refresh() only when updating

Luís Henriques (1):
      ceph: remove unnecessary check for NULL in parse_longname()

 drivers/block/rbd.c          | 412 +++++++++++++++++++++++--------------------
 fs/ceph/crypto.c             |   6 +-
 include/linux/ceph/ceph_fs.h |  24 ++-
 3 files changed, 238 insertions(+), 204 deletions(-)
