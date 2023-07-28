Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8AB766C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjG1L7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjG1L7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:59:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F084135B5;
        Fri, 28 Jul 2023 04:59:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe1c285690so2254783e87.3;
        Fri, 28 Jul 2023 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690545586; x=1691150386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDnuB1L5Tw2IyQMhcLOBqrTGEqPdVpzZcBno1kfHReo=;
        b=S5nnCpo89YHDKQYtRAO/37tXtIavZx5Bxxqbu1XmdezqjZ01fmws5n0ddY9WQpoYPg
         Df7lt1hq0lIh+eC2tKaeTu3jfb+HpY5oDPVRj1RhgiIz6pFInC///eQ8xKMimUKt3875
         mKT4kwfDKWFj0MdocT+09FWZZLYmMRNlt7L8mdyFgaNeTcepRjFhDTqHx2L6cLRXh69b
         CPxKA5nZVQIUPLEOyZRzw0SbngtCnA8Z/4T5jHS32VXyntthcNIcWNXJqmVIwboGvVcT
         RqhMNnWF4NTDZ1BFfBFb0uz/b7P4qn9F4UpVSzz38Ey9WYX9dEzlpdBiTg5pFRnYt/eA
         h2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690545586; x=1691150386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDnuB1L5Tw2IyQMhcLOBqrTGEqPdVpzZcBno1kfHReo=;
        b=T7bVl+MbdVqUsaJU0dwshBHwqi3v98GDV5LyYO7kalpfqjmjjf4SYUaYOUbPtR3cFs
         F7KJZsEJdNRk9RV+ILqkFgyMloUIUMGDtXWMn70iPgXfCay8KRY1USm2MQSOJHuN7Kmg
         Buel1Ajp9wgM3PD3U1wYQ1UEJfeYHK8xwo4HKTMeXsLqYHZ0Fope7Q0ks8lJPgnuGL1e
         1uEN4VcNd8EJh7EylK7n8SUWrZC5m12dk6QddRSgmW5cQ5eeYWDaZxpXFY1NqUOJmb3C
         dKtF7q2EhtPvh7w6wiP7uilO0/z2fQAPsaH115zYhBfLNb4dq8a8X2qUGQ4rc8CqBGFZ
         TFdg==
X-Gm-Message-State: ABy/qLZ/ecNKX+4fWHeRbKcwCD0TsL3Sh1jf+skrgEN3fCa9eV2B7Rup
        4bMA/gKm4q2wAThVNaNtWfA=
X-Google-Smtp-Source: APBJJlFRqaQPCjb994vwv/hIbPMcaQpbrXftts6h0pcA1bwNAWXu9PIlybUqTEDv39n/fgGJWiaAHQ==
X-Received: by 2002:a05:6512:3495:b0:4fe:a2e:890c with SMTP id v21-20020a056512349500b004fe0a2e890cmr1367102lfr.49.1690545585751;
        Fri, 28 Jul 2023 04:59:45 -0700 (PDT)
Received: from ramazan-pc.synapse.com (d98-21.icpnet.pl. [77.65.98.21])
        by smtp.gmail.com with ESMTPSA id b8-20020ac25e88000000b004fb8668e6cfsm788321lfq.124.2023.07.28.04.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 04:59:45 -0700 (PDT)
From:   Ramazan Safiullin <ram.safiullin2001@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ramazan Safiullin <ram.safiullin2001@gmail.com>,
        Sabina Trendota <sabinatrendota@gmail.com>
Subject: [PATCH] docs: psi: use correct config name
Date:   Fri, 28 Jul 2023 13:56:00 +0200
Message-Id: <20230728115600.231068-1-ram.safiullin2001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2ce7135adc9a ("psi: cgroup support") adds documentation which refers
to CONFIG_CGROUP, but the correct name is CONFIG_CGROUPS.

Correct the reference to CONFIG_CGROUPS.

Co-developed-by: Sabina Trendota <sabinatrendota@gmail.com>
Signed-off-by: Sabina Trendota <sabinatrendota@gmail.com>
Signed-off-by: Ramazan Safiullin <ram.safiullin2001@gmail.com>
---
 Documentation/accounting/psi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/psi.rst
index df6062eb3abb..d455db3e5808 100644
--- a/Documentation/accounting/psi.rst
+++ b/Documentation/accounting/psi.rst
@@ -178,7 +178,7 @@ Userspace monitor usage example
 Cgroup2 interface
 =================
 
-In a system with a CONFIG_CGROUP=y kernel and the cgroup2 filesystem
+In a system with a CONFIG_CGROUPS=y kernel and the cgroup2 filesystem
 mounted, pressure stall information is also tracked for tasks grouped
 into cgroups. Each subdirectory in the cgroupfs mountpoint contains
 cpu.pressure, memory.pressure, and io.pressure files; the format is
-- 
2.25.1

