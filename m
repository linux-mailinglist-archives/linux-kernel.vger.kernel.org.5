Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3AE76407F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGZU3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjGZU3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:29:31 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162A12719
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 13:29:26 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b8a7735231so1114185ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690403365; x=1691008165;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZHOHL6dHz0mueXCqOfwpE5t98+hSImY7RGUroXK09A=;
        b=BKeY+g6lhr2X6WEQ2+OZ44O7JMCHOjOOJPxnp5R08aMx6d0iKC/JDfdxrxXm3vNzIV
         +R7+zDYdwlH5e8EHgL3MPwRAr2kW9Ixan2O1K68/6YOxdVEqIb3m3dhO4Hlf5JJI8IVr
         CRGXOiIWnWocw8Y1aZKU01l3ZVWo/xJw1fcOsIB+r/36UNypApQ38o+gQ4f0Ua0U0c6X
         UPHJBX7BLra+Hc5cywuWiMnEin6e2J1tR+aWMXbtpHA3Fu1MIg3XI21MVpeyi6HdFkfL
         30xxOJ6gJsF62haSIST6Qo5CINFwhQw000oqOBahVCe8UNt8a+kgirjOuBZps6UpX57J
         XAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690403365; x=1691008165;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZHOHL6dHz0mueXCqOfwpE5t98+hSImY7RGUroXK09A=;
        b=J1p2TloCv9ER/BdaLcAfyvn3Q5N9x1fXf59j6D+VuV3vtP/YsY/Fcq+44A2MMK4U5G
         xIegiK+GQqT76M0co+xmK0inuXpGQhiBm6zRZzYm7dOKH5VFnR8x/7XRBO48H9/9TKoE
         xGpcy7hZHGg9kTqSqVqL0gMDt1GqSD4Q3afmEViEc4jTbm+NTrSdPIVa5W8U4s+FgSRI
         5zM51/PauWfM7NFw69GcG0jIwRLezQWIZQhH6VTFcaifY/gzIZ92mYaIE6RgZkH0UarZ
         pZruz7sht27y7V8nwmFzkTrtaqAzbLiXOKoEC7yBORjbJqOvIC0Hd2fV9LpIPX2LFGtn
         erVg==
X-Gm-Message-State: ABy/qLaQyiqVuRKrUQaXjPKhD1RjyBmBllXfrSuzHp9oyV3EHkXYbHOu
        1Gg8tjQ/83HEtWDM4T/rVOjw9B1xBoc=
X-Google-Smtp-Source: APBJJlGp6HaaBuzf0/8vVCK7xNuSSU5EzxsPa5nHomxhG3FI85zX74eYGuUkCMAJcMNOZ3IJ35vrfPYT2kA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4cd:b0:1bb:83ec:841 with SMTP id
 o13-20020a170902d4cd00b001bb83ec0841mr14025plg.6.1690403365543; Wed, 26 Jul
 2023 13:29:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 26 Jul 2023 13:29:20 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230726202920.507756-1-seanjc@google.com>
Subject: [PATCH v2] Revert "debugfs, coccinelle: check for obsolete
 DEFINE_SIMPLE_ATTRIBUTE() usage"
From:   Sean Christopherson <seanjc@google.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
Cc:     linux-kernel@vger.kernel.org, cocci@inria.fr,
        Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove coccinelle's recommendation to use DEFINE_DEBUGFS_ATTRIBUTE()
instead of DEFINE_SIMPLE_ATTRIBUTE().  Regardless of whether or not the
"significant overhead" incurred by debugfs_create_file() is actually
meaningful, warnings from the script have led to a rash of low-quality
patches that have sowed confusion and consumed maintainer time for little
to no benefit.  There have been no less than four attempts to "fix" KVM,
and a quick search on lore shows that KVM is not alone.

This reverts commit 5103068eaca290f890a30aae70085fac44cecaf6.

Link: https://lore.kernel.org/all/87tu2nbnz3.fsf@mpe.ellerman.id.au
Link: https://lore.kernel.org/all/c0b98151-16b6-6d8f-1765-0f7d46682d60@redhat.com
Link: https://lkml.kernel.org/r/20230706072954.4881-1-duminjie%40vivo.com
Link: https://lore.kernel.org/all/Y2FsbufV00jbyF0B@google.com
Link: https://lore.kernel.org/all/Y2ENJJ1YiSg5oHiy@orome
Link: https://lore.kernel.org/all/7560b350e7b23786ce712118a9a504356ff1cca4.camel@kernel.org
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v2: Fix a copy+paste goof in the changelog, add Greg's Ack.

 .../api/debugfs/debugfs_simple_attr.cocci     | 68 -------------------
 1 file changed, 68 deletions(-)
 delete mode 100644 scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

diff --git a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci b/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
deleted file mode 100644
index 7c312310547c..000000000000
--- a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
+++ /dev/null
@@ -1,68 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/// Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
-/// for debugfs files.
-///
-//# Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
-//# imposes some significant overhead as compared to
-//# DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().
-//
-// Copyright (C): 2016 Nicolai Stange
-// Options: --no-includes
-//
-
-virtual context
-virtual patch
-virtual org
-virtual report
-
-@dsa@
-declarer name DEFINE_SIMPLE_ATTRIBUTE;
-identifier dsa_fops;
-expression dsa_get, dsa_set, dsa_fmt;
-position p;
-@@
-DEFINE_SIMPLE_ATTRIBUTE@p(dsa_fops, dsa_get, dsa_set, dsa_fmt);
-
-@dcf@
-expression name, mode, parent, data;
-identifier dsa.dsa_fops;
-@@
-debugfs_create_file(name, mode, parent, data, &dsa_fops)
-
-
-@context_dsa depends on context && dcf@
-declarer name DEFINE_DEBUGFS_ATTRIBUTE;
-identifier dsa.dsa_fops;
-expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
-@@
-* DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
-
-
-@patch_dcf depends on patch expression@
-expression name, mode, parent, data;
-identifier dsa.dsa_fops;
-@@
-- debugfs_create_file(name, mode, parent, data, &dsa_fops)
-+ debugfs_create_file_unsafe(name, mode, parent, data, &dsa_fops)
-
-@patch_dsa depends on patch_dcf && patch@
-identifier dsa.dsa_fops;
-expression dsa.dsa_get, dsa.dsa_set, dsa.dsa_fmt;
-@@
-- DEFINE_SIMPLE_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
-+ DEFINE_DEBUGFS_ATTRIBUTE(dsa_fops, dsa_get, dsa_set, dsa_fmt);
-
-
-@script:python depends on org && dcf@
-fops << dsa.dsa_fops;
-p << dsa.p;
-@@
-msg="%s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
-coccilib.org.print_todo(p[0], msg)
-
-@script:python depends on report && dcf@
-fops << dsa.dsa_fops;
-p << dsa.p;
-@@
-msg="WARNING: %s should be defined with DEFINE_DEBUGFS_ATTRIBUTE" % (fops)
-coccilib.report.print_report(p[0], msg)

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.41.0.487.g6d72f3e995-goog

