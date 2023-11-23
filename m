Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CA47F65E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjKWSC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjKWSCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:02:55 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A97AD41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:03:01 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6D0DA40DB3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1700762579;
        bh=WP2gJh9IkDa2VdWPrUfJ2njFac/+S8Z+9AfzFJLFWoY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=f5Ldjv9pUGqSgaGbA0bva+KuxN5R/wfZYGWZigFaI5BSBiBxH5oMVv05vSdDwbbGs
         mNaUtc1uuRJCKiYgpDsyQd/OoRMZ1QaIQ8omijKEgphE2HYNWknfB/lb7KqU9YKWUx
         LTRgA9iDA1Jbs37JEMpXifXhsrJhZiEYRBNrwjGuJd/QdiJtNUPtykA9Brsfp4beyE
         ewqFqJeEg6KZgHTj+O1O2lIEHv+Tqql/n/5+jrJ4INwwng/+PKAIh7XT7QzENIyD2h
         bxRq/hdl+oPi26s8TSnyTSRqTG/LdE5RrPo2RFDBrHSHjGOT5n2zlMh8A555wk2zPH
         5WyGIAsIyw4tw==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b310b5453so6026615e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700762579; x=1701367379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WP2gJh9IkDa2VdWPrUfJ2njFac/+S8Z+9AfzFJLFWoY=;
        b=GQKw/mYVJRHMP0aKKc04GR3Qj6Gyypc7yX74KtpBK98AueMB9hQejI9FMEINCsjRd/
         EzPqjGTE0x+LaYNX8CpOJ4nV6bKkvj/qE0IBOSJgd/hdek6IJib3sG5TfoNengODCDtu
         BVkMAjJIVsYv3e7e/KUcTMlwHy8X7U+99hOoPBPepfb2uJE4Nsvf2GxslZykYtx1yL6V
         0MzSG4qX8nUpEilyOv4dtREugWSEtCj0hbLsYX2nIx99ex3lNR00GlcJ4WSYkyUzedXD
         hd1reXix/rIc1UXgJQXZ63eRFjbyqTvTHJRB7gl/FbL7BpxcCraWVisLQi1HaI9Barkj
         zaLQ==
X-Gm-Message-State: AOJu0Yz91RWp4mU8nTZiRfz4eik1SDI4GRiKc+8ClfsbjOPRXohMPDTt
        D0Z2dHAlndPWmvZoVZWuIvak/10Z/k6TzVmG8Yb20ys1AS+Mn2d18A/F2EZ0r2d4HJyqEVnj2s1
        /1cIBDFYmE0MWCgE9aWdy1Xc7otUIOc4N7rviokGWSg==
X-Received: by 2002:a5d:69cd:0:b0:332:c548:3ea4 with SMTP id s13-20020a5d69cd000000b00332c5483ea4mr141112wrw.49.1700762578974;
        Thu, 23 Nov 2023 10:02:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOXAShpF/8xaYBusYO0OA7vURr5brTXNPfzFyM6rdfglnmH7BI/RAPLtjwFbymjOjB7sGNUg==
X-Received: by 2002:a5d:69cd:0:b0:332:c548:3ea4 with SMTP id s13-20020a5d69cd000000b00332c5483ea4mr141097wrw.49.1700762578644;
        Thu, 23 Nov 2023 10:02:58 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id j14-20020adff54e000000b0032db8cccd3asm2302599wrp.114.2023.11.23.10.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:02:58 -0800 (PST)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] remove the last bits of a.out support
Date:   Thu, 23 Nov 2023 18:02:40 +0000
Message-Id: <20231123180246.750674-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was working on how linux-libc-dev headers are shipped in Ubuntu and
stumbled upon seemingly unused and useless linux/a.out.h header. It
seems like it is an accidental leftover at this point.

Dimitri John Ledkov (5):
  alpha: remove a.out support from tools/objstrip
  alpha: stop shipping a.out.h uapi headers
  m68k: stop shipping a.out.h uapi headers
  x86: stop shipping a.out.h uapi headers
  uapi: remove a.out.h uapi header

 arch/alpha/boot/tools/objstrip.c    |  52 +-----
 arch/alpha/include/uapi/asm/a.out.h |  92 ----------
 arch/m68k/include/uapi/asm/a.out.h  |  21 ---
 arch/x86/include/uapi/asm/a.out.h   |  21 ---
 include/uapi/Kbuild                 |   4 -
 include/uapi/linux/a.out.h          | 251 ----------------------------
 6 files changed, 6 insertions(+), 435 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/a.out.h
 delete mode 100644 arch/m68k/include/uapi/asm/a.out.h
 delete mode 100644 arch/x86/include/uapi/asm/a.out.h
 delete mode 100644 include/uapi/linux/a.out.h

-- 
2.34.1

