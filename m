Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911797D0556
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346638AbjJSXR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjJSXRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:17:25 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85855119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:17:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c8a1541232so1973215ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jade-fyi.20230601.gappssmtp.com; s=20230601; t=1697757441; x=1698362241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1SYtz8MTwaDmIrwT6SovO+Nj2e+MoTIYdmy9vtmT3Y=;
        b=K8UgYGnjyXVwpRN7hH1i8Zj+gvDrdndmiQGt3he/LQ4e4Elq/Z/9U0edPr0TCQfnQL
         I/ta43dsx8ke+Oh9K041AMXT6HoqQCtdf5MMSpzkfCBUIRCzPlhWpKEzfOJEklDp1vPu
         JwX4wEa+FxchR47hPPZSyCv3w9ay1qvmwExbaOMMMim5EbXSrHYHsYC/XyihlKsWj9fe
         UlYaNHG3bKcRXWohXz5EeshXamyT/c0EBqrPA52aMmI+CJZubizaJuxO0XSCvRmo10Av
         t9yNjDotrtWqxrNRGrA/7aPMyAjrLUaTsBpJE2vmTRHA1TQrnXnS6R0E3/7VM3Q0f0lN
         rZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697757441; x=1698362241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1SYtz8MTwaDmIrwT6SovO+Nj2e+MoTIYdmy9vtmT3Y=;
        b=ZVC8V+zzH2wwF1ZFSNkA83RbehOtWCcrv38CMRDtfobEu4EMapumUNgl2WPO8ldlem
         uS5GdajIikLQqeRP++UvHFYi2ePU6WHHXC3HXJ0dnuE5hfsMctxbLIoG4JyH+3LzV4ow
         QlVgKEb+k3E2hUOQgA8yOa1soD2rankac+NobTAif+pOqJ77fvlOPqt8H9Lt8SIyCvHR
         E1wn9fi/+08hfO4QChJG9tWBgWyAZZ6Wy3mIRb3snuy6RxxE+whQH9PHUZN26fbCF4Je
         I0u0n5sA2jqUjEkC+0nkAkU8wBNcjoxyTD9XABuYcIff4u/4fmkCQt38TyeaYeAz8ou6
         RjhA==
X-Gm-Message-State: AOJu0YwKwnR5QMpKXHS7CIM5oGG6GJkGoq730po3Ziu8iCLPePphHc0m
        uWGL07xLWV/VaaDFIMhxdCa4Eg==
X-Google-Smtp-Source: AGHT+IEW5YX38Eabky5xVaCufvHvIlXJGExjnzYhAwB0zziAcpYzwO8R/t4BbFQfx7dtvJyggWHipQ==
X-Received: by 2002:a17:903:200d:b0:1ca:754a:692e with SMTP id s13-20020a170903200d00b001ca754a692emr314766pla.30.1697757440882;
        Thu, 19 Oct 2023 16:17:20 -0700 (PDT)
Received: from localhost (172.103.222.8.cable.tpia.cipherkey.com. [172.103.222.8])
        by smtp.gmail.com with ESMTPSA id i17-20020a17090332d100b001c32fd9e412sm254637plr.58.2023.10.19.16.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 16:17:20 -0700 (PDT)
From:   Jade Lovelace <lists@jade.fyi>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: fix typo in dynamic-debug howto
Date:   Thu, 19 Oct 2023 16:16:55 -0700
Message-ID: <20231019231655.3162225-1-lists@jade.fyi>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jade Lovelace <lists@jade.fyi>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 0b3d39c610d9..0c526dac8428 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -259,7 +259,7 @@ Debug Messages at Module Initialization Time
 
 When ``modprobe foo`` is called, modprobe scans ``/proc/cmdline`` for
 ``foo.params``, strips ``foo.``, and passes them to the kernel along with
-params given in modprobe args or ``/etc/modprob.d/*.conf`` files,
+params given in modprobe args or ``/etc/modprobe.d/*.conf`` files,
 in the following order:
 
 1. parameters given via ``/etc/modprobe.d/*.conf``::
-- 
2.42.0

