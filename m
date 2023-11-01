Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC457DE827
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346021AbjKAWed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346019AbjKAWeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:34:31 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F87A12C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:34:27 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-579de633419so3911577b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 15:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698878066; x=1699482866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VF4uwbYIzZxVA4IRa0W7WHUlrQEG+ReHRfEP9dC90UI=;
        b=BoRlS0rrhfx9eHEt8Dl1nLcPX3eiELgxqgSylqQqAUfFsq2UGHNoIu8IahEpPDyKPH
         Y6PAJ5QRYhQr/JuFbYpremS59DC6ivU6QBbIUtJffuw3FVKwtc1RRb6EZEoPcX/r4be2
         kph/uzMGl+XW87K+/GzYP1H6oF1XUk2j9KtPKJCnzF9R9iJgbP5FCsLbs9uR5+55ZH7L
         LhzTAu+YMONeNJbAlnS7CiD8Eizp1QVwm93GYtSs7g2HcVCfh7iBRJAsHWq05eS0bYpe
         r1VtqrnmrGp9nqjq1oOxi+EZe2FenwXZvu0isvUusICCm8Wn0kPkS0EQ6e0QeWHAaxsg
         hYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698878066; x=1699482866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VF4uwbYIzZxVA4IRa0W7WHUlrQEG+ReHRfEP9dC90UI=;
        b=IwxjNETpOPutOP8yYEgoIN4CHbYsSqtB/tkaUt+8nyHaka9Iu0qFIZZNyZz/Ej7M1c
         h31WqIdcEZBtOR+Tg/0rJkHe/x0yC/e5a5vVKW0n/Ctod1jsoKTwBjpcagY02ZQvunUa
         2HClwelz5P9iGf/+n0o8hLrsqFuoHyYJt3vdnu0Voa1qalOTuMmAQDF+1pdHAZgk4xGU
         nQwbYGkRTV0XhphHyWIS601SfPDB4kJlItDrX06r4FoG/WG2sieuDAUCUynvoDQITybD
         tiHm6eWg+1EFEYTP4/cYJV6B5/SDQ+SFr6ciStZSPHPKQmVqjeDN5qeVN6dCPAcO1l6q
         a/Dg==
X-Gm-Message-State: AOJu0YxlahqY/VvB9r1F41StfQSACGOInVuHYUuSqjcO+2mE3PFDmApc
        AOugwxjN/a2/Ke1yJzJ7sV8=
X-Google-Smtp-Source: AGHT+IGLMCQq3CtBmlWy2/wTTBk6yCa89ODROsKKTW/TNynyeo/qmu9Sn7g2FMdQftJEMroVh2Jm0Q==
X-Received: by 2002:a0d:d904:0:b0:5a8:2b82:a031 with SMTP id b4-20020a0dd904000000b005a82b82a031mr18199516ywe.26.1698878066365;
        Wed, 01 Nov 2023 15:34:26 -0700 (PDT)
Received: from localhost ([50.221.102.30])
        by smtp.gmail.com with ESMTPSA id w4-20020a817b04000000b005a815346d95sm504272ywc.71.2023.11.01.15.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 15:34:26 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/4] lib/group_cpus: rework grp_spread_init_one() and make it O(1)
Date:   Wed,  1 Nov 2023 15:34:15 -0700
Message-Id: <20231101223419.49101-1-yury.norov@gmail.com>
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

