Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57975DEB1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjGVVyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGVVyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:54:12 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2744D10FB
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:54:12 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34617b29276so10341495ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690062851; x=1690667651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9FhzjLfl4fSYGH5UbNVsYq5D9vHHykt+h8l2ZdR56A=;
        b=YoMngk95JITerUrexXkhCSPWWii3zUHq6ljWr8sTbh9YjLI4DILtX1aa0yurWH3tbV
         2iIIKNt0HxnT4obnVubT4BBtk9PQ6E5ngEcN1igajP08KspVK4SubKM/yiIF3i30Tss7
         IApJdp3NRJeUtTu3vTKYh1HHsvareZtfrX5/3ds1XLC61R/cWMiHL+nc5H7EAOp7uEtm
         U54hAbqFTVrPzMBH9rcsyYG6ef++9swW7Y3g0ygI6SFNq5pJrZK5PywqHZqIS4gZq608
         CbNyRmRAcZzsSY6iNh5osP4s59hY1mifj2bNP2Ayl0YlbTCgN0xn+jkboQGLFvJ03+t3
         jWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690062851; x=1690667651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9FhzjLfl4fSYGH5UbNVsYq5D9vHHykt+h8l2ZdR56A=;
        b=g/uVcDKhSRjwJ4NRTLGuc94uZYD+FO1Bzx66u4dV6If/1ct348F2vF5X7DaWL/twAp
         VMmWPbOE4xzMcVDUUrpelUXHp0mR/9s/T+vwAJ7jqR41a9X2MSDNsWJZ6/Bk2WoC34+a
         Hq756f18LnsceDqHKrQDP6NixoqOjvUIMomxQIHhLvPrW4bhsab7p+sq8gAMxU2UN2zz
         SpAkIvyIq1NRRG5/QHtGAHx6sH253OzuaoJWv/jy3BlVWjX7+DAx3tFjI+qKW3Y98l4F
         DwzP0Krs6KGP2y8+48BfVVp+pPJfdSI31A1ZCO7AfdzV2y/1EGj/rhU4bhqUT8dyrzVF
         QuEg==
X-Gm-Message-State: ABy/qLal8DQ8EJr+lEdqDKjKk+XHF5indadY0QMbQEfGKBtu/gReaF7v
        fgfR4O0FBg7T9NxePhXrXT0=
X-Google-Smtp-Source: APBJJlF9+MtlbWiIguzIDzEWOTGPycVaLnMT8a7GagVAQwC2YthJVAy49NJTXsA5sdv3HPgdPoUIaA==
X-Received: by 2002:a05:6e02:1d01:b0:346:23b0:3725 with SMTP id i1-20020a056e021d0100b0034623b03725mr2214985ila.13.1690062851351;
        Sat, 22 Jul 2023 14:54:11 -0700 (PDT)
Received: from localhost.localdomain ([161.97.244.155])
        by smtp.gmail.com with ESMTPSA id k11-20020a02a70b000000b0042b45475212sm1929783jam.81.2023.07.22.14.54.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Jul 2023 14:54:10 -0700 (PDT)
From:   Franziska Naepelt <franziska.naepelt@googlemail.com>
To:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@googlemail.com>
Subject: [PATCH 0/9] staging: rtl8723bs: ioctl_linux: Fix checkpatch issues
Date:   Sat, 22 Jul 2023 23:53:30 +0200
Message-Id: <20230722215330.4114-1-franziska.naepelt@googlemail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of patches to fix some trivial checkpatch issues. Not all
issues have been fixed.

Testing:
* Build the module
* Boot the kernel with busybox in initramfs
* Load the module

Franziska Naepelt (9):
  staging: rtl8723bs: ioctl_linux: Fix else on next line
  staging: rtl8723bs: ioctl_linux: Fix code indent
  staging: rtl8723bs: ioctl_linux: Fix block comment alignment
  staging: rtl8723bs: ioctl_linux: Remove multiple blank lines
  staging: rtl8723bs: ioctl_linux: Remove unnecessary blank lines
  staging: rtl8723bs: ioctl_linux: Remove unnecessary parentheses
  staging: rtl8723bs: ioctl_linux: Fix alignment on open parenthesis
  staging: rtl8723bs: ioctl_linux: Add preferred spaces
  staging: rtl8723bs: ioctl_linux: Fix comparison to false

 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 161 +++++++-----------
 1 file changed, 58 insertions(+), 103 deletions(-)

--
2.39.2 (Apple Git-143)

