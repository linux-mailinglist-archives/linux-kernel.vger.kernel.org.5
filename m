Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55221806C66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377559AbjLFKoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377467AbjLFKoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:44:01 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7579A1A2;
        Wed,  6 Dec 2023 02:44:06 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2887c3b6581so73738a91.1;
        Wed, 06 Dec 2023 02:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701859446; x=1702464246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aljc6V9KUR9EHwRroz8Dfq8Kofia3Bxxh3j61/z/E98=;
        b=WY4zOQE7oOXnztqH/bp0BuJSYxLSwR4vG0dPhe/iQ4EhM/cqV851okLgxqDZz05ilI
         ecVwynSKwv0zzZXX7xgz8rR9E/lnIi9bbhduXNr61VzULC+zpKxwWtd0WbR+3fE2etlh
         RxddVzMOdrmmgChoykN26OThSuQTEcNzpTA5FzxdgOJ2isvfaT0jH+Pw9spzxus9s1z5
         5LtxnptAuTDLBjNmPIwTumq2AX8zDLQDp3XlWhufkLtYtht+sUz1KGs9CunKpTzwAPKH
         R9suFryxnGkb3IU4NsI7wupQtSKi0JbqazlMNn2zPJY4gU1/iOUNfFJhFwUj9yB5bGET
         tyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701859446; x=1702464246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aljc6V9KUR9EHwRroz8Dfq8Kofia3Bxxh3j61/z/E98=;
        b=pgFPyrwYeMw9Pajus/VOvLaw4NAFSyNGNA+w/25PmpTDbX1QH+p1ZkEWGWCG+H1YPB
         iYtXJlPyYQcNRPZHmXgJuScTUPTqlG2QHGd0RDorRGjoJtDGU5KtIW7UmZI0ofdTP//q
         c1ClLrT7/fFB8jHOqKGMoIgdSn5BacPpMAx+Rsal3yRzCgXS5/btBsLmvFxaCPUepIwo
         YCQ1lqEc1qlkras/2qXnfNA3ccl4q6IJ09h9yAjyZ19XPjGI4X3LvewB3izrgSOyNv/P
         t9dYcNbG4lewdYbC+It4JMuLDP/4zCNcG3NTbEvStyYTxLVRF65sIRl/MeBXRoaOjAEu
         aWzQ==
X-Gm-Message-State: AOJu0YwpxaryVg46WFozuB6Ta0k6cphV5WU0eFr9F+FOsrS3p1tmvfTD
        JIl4+OXyziReyU2Sma1AchhFSXrZ260=
X-Google-Smtp-Source: AGHT+IGSQA3/38qPc8gCfK5Kx5gPpwLd7FVUiOGc9usg4H6/XujpBptIUXL6w1QoFktqeE4ojbP/RA==
X-Received: by 2002:a17:90a:195b:b0:288:7921:a744 with SMTP id 27-20020a17090a195b00b002887921a744mr188720pjh.89.1701859445695;
        Wed, 06 Dec 2023 02:44:05 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090a2a4b00b00286596548bcsm10020811pjg.37.2023.12.06.02.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:44:05 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 0/3] ACPI/NUMA: A few fixes and cleanups in drivers/acpi/numa/srat.c
Date:   Wed,  6 Dec 2023 18:43:15 +0800
Message-ID: <20231206104318.182759-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This series fixes an issue and does some cleanups in drivers/acpi/numa/srat.c.

Yuntao Wang (3):
  ACPI/NUMA: Remove unnecessary check in acpi_parse_gi_affinity()
  ACPI/NUMA: Optimize the check for the availability of node values
  ACPI/NUMA: Fix the logic of getting the fake_pxm value

 drivers/acpi/numa/srat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.43.0

