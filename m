Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF3C80AB58
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574616AbjLHRzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574565AbjLHRzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:55:25 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA411BDB;
        Fri,  8 Dec 2023 09:55:22 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b9ed8c3472so139222b6e.0;
        Fri, 08 Dec 2023 09:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702058122; x=1702662922;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2XnUIO85S9Vv/y91WVe+8zICvCHe8gdFTvWXN/hchU=;
        b=dcrBCUi1jX2aD0HlUB2zPFMf4lCv4oFCB8dcLcBq1NsOnKuF/2Ub4+z6ZBQRX0azRB
         Tpb/xtZ2GaEXFYKi6DHydxbtX+JM9LnSFBvWL8UaZxHd1PGYcawUXH1MtbqM5YXqrmSH
         95K/oLVSn6gQfoUVAhmLQgFW/Rgi2Ed1Be8UfmSFcUWxcKzBny4G7PdyAd/24cGRhYp5
         3OXrrPX/NMeDGSL4WBdSB8SLNoKPgwnK5HEr5U0O9ypuYIqBVBunUhgLcEPaxgutAAvj
         Zb4EfXIMtAitV5KVonRGDiO9myWlm7I+RRMD8Y3g68S7jcMF51+bz0Gjq+6AJTv8Ueug
         J95A==
X-Gm-Message-State: AOJu0YygBuY2BGQanKjc8iAT8UaVrwa4twy1VMwN2Eg9/hwiFCaXxNdQ
        I002m8OCINiyhub4fbWlMZlAnoLOZVUXLoQiH4eT0Vvzlg0=
X-Google-Smtp-Source: AGHT+IHDcFDkG49lcJEtsG52jAMkoEt6RjVXF+xQLNquPvULvLOjwKbU9q+HpDuBeJdKHDZKHHsBreo+bRDFpQBr7Fw=
X-Received: by 2002:a05:6808:1307:b0:3b8:98f0:3c2 with SMTP id
 y7-20020a056808130700b003b898f003c2mr806681oiv.4.1702058121958; Fri, 08 Dec
 2023 09:55:21 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Dec 2023 18:55:09 +0100
Message-ID: <CAJZ5v0ja548sr4QjzTgpNHZLMsNC_r8GY6Jys3sH1Y3jsXqK3w@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.7-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.7-rc5

with top-most commit 8f0b960a42badda7a2781e8a33564624200debc9

 ACPI: utils: Fix error path in acpi_evaluate_reference()

on top of commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a

 Linux 6.7-rc4

to receive an ACPI fix for 6.7-rc5.

This fixes a possible crash on an attempt to free unallocated memory
in the error path of acpi_evaluate_reference() that has been introduced
by one of the recent changes (Rafael Wysocki).

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: utils: Fix error path in acpi_evaluate_reference()

---------------

 drivers/acpi/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
