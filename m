Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E867DE868
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346145AbjKAW6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjKAW6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:58:30 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471EDC1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:58:28 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5b31c5143a0so4279337b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698879507; x=1699484307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VF4uwbYIzZxVA4IRa0W7WHUlrQEG+ReHRfEP9dC90UI=;
        b=Cwg5k63HzRppgKfPVytsNYU8xokuLmESh0Y8TkpZ9fXn/9cwhQltvgEeq7kR9qC+zb
         +hAH29FRR9xjW4jZgb91Jc1bK+wW7OPluCDRR1Xl/EYB491pEbRwQtv9GdpRekFSl4m+
         nkZMf5s6RvKpTZf5Itl9ndEpiYeMufHaLI0zltu1TLmVPydwh9KCUrVFk+pVgYCW6Owb
         eYM4zhxB2eJCMBgZJpP2Yj1Ww4TDm+UdGDB91AheA1I6R1j7NcDAlABWXa0FMBjxH3nI
         8sVgXVfP5/OTdhH47PxKHqJNdSCdunkEaDLWb4I9uOLCSpj/fZBJhGLdgpSkpLluhoRC
         LjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698879507; x=1699484307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VF4uwbYIzZxVA4IRa0W7WHUlrQEG+ReHRfEP9dC90UI=;
        b=mviXB7Uqof1TSd+cS6zCsRnRVIsj6YIFX7m/oqkm0ksWHCPlYFUVirSMt7uYn8ZznF
         h7seFyIIPq2veTaZBZj1IuAMweu0xD7MQU19atmZQYV5NV6BG5XqtChjY1mVk/WqZdQa
         7GtsYGJliYxT3h498XNSKV8jQIUfC4kovZ/vC5WXduXQ4zcelW5k4LnJye+XGCotlN3f
         LvC3FqlyYqgnN5RbVqAbj3s/wEsSrHwIRtCp3wmjJuT89NJpNPaAI7H6DZPM334ExjFX
         ZAbVjwxO/YhqwaRkgYhnuW/dxmXVZjitxuF57Ppz4ealEx7crgVJhqYuZSbwfL/BaVmw
         ew5w==
X-Gm-Message-State: AOJu0Yw2w89ShjoyI+ZW2N+y6LCIV5MTDTzx+PHnw5AL0ab8nVE6A9HL
        ivUgqmLXUoOC8zf11fu2lFE=
X-Google-Smtp-Source: AGHT+IHedWxUbsdmjGnOLQ5mn7neRiDb2ixy1UoJ/s62hUvhRyE5OP3XI7yYQ4Om6FwLPVwi1mE54w==
X-Received: by 2002:a81:a889:0:b0:595:8e80:30ef with SMTP id f131-20020a81a889000000b005958e8030efmr14295306ywh.51.1698879507402;
        Wed, 01 Nov 2023 15:58:27 -0700 (PDT)
Received: from localhost ([50.221.102.30])
        by smtp.gmail.com with ESMTPSA id u72-20020a0deb4b000000b0059f4f30a32bsm526804ywe.24.2023.11.01.15.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 15:58:26 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/4] lib/group_cpus: rework grp_spread_init_one() and make it O(1)
Date:   Wed,  1 Nov 2023 15:58:16 -0700
Message-Id: <20231101225820.51342-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

grp_spread_init_one() implementation is sub-optimal now because it
traverses bitmaps from the beginning, instead of picking from the
previous iteration.

Fix it and use find_bit API where appropriate.

Yury Norov (4):
  cpumask: introduce for_each_cpu_and_from()
  lib/group_cpus: relax atomicity requirement in grp_spread_init_one()
  lib/group_cpus: optimize inner loop in grp_spread_init_one()
  lib/group_cpus: optimize outer loop in grp_spread_init_one()

 include/linux/cpumask.h | 11 +++++++++++
 include/linux/find.h    |  3 +++
 lib/group_cpus.c        | 29 ++++++++++++-----------------
 3 files changed, 26 insertions(+), 17 deletions(-)

-- 
2.39.2

