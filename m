Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10B97A25D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbjIOSda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbjIOSdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:33:06 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8BDE6D;
        Fri, 15 Sep 2023 11:33:02 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-578a49f7e57so304010eaf.1;
        Fri, 15 Sep 2023 11:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694802781; x=1695407581;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQxok23OVhmpKFf5lD3gsNRkaNgeinQB3aGOcPM4h7Y=;
        b=Qqa0yUTAXIPTQ2jMegpe3OI0gIDDRWPWqtDfnlns8STbhr6tsmyaBN5PL01WaY8iv3
         tOStwljDjXe5ocNl+AxZ8QNNm+bG8ObnhuzS1vBq41c6fj2uosKLPyCsCG6HkPH2pgH7
         rxh2sQ5QMlvUMirjbVPn10mK5ragvS5M7z/dvSOD5uL+qEWazTuBVFRor6gjPe86bF3V
         P3p8nsABs+cK2vaLWpnt87ZFoJohNcKDqYokW11nGlhtdECHwfj5Pqs95Mn3kPpB1rea
         pQ9bInRN5rFs9d4PO4oWoR05Yzy0D46TqAixFb3v8hNzYfRAZdBDbf97tU5JtBP1THK0
         iqrQ==
X-Gm-Message-State: AOJu0Yz81t4Rgaek8i2UqkD5UEs0+a782P3VRaZtlccXrgrvK5e0wdQM
        u6SjCP/hLeYFpo0yELVoSiJhHnXueLN6mwp+Edp4RlV2j8I=
X-Google-Smtp-Source: AGHT+IEkc7ian7deqEVPC9xmT/T6UmtOCaqpYsSkhzTifKdPJFZkE0OxCpYRYxFKwhC3CFSoqCJFgMLYoRM6abmeElc=
X-Received: by 2002:a4a:de83:0:b0:56e:94ed:c098 with SMTP id
 v3-20020a4ade83000000b0056e94edc098mr2592363oou.0.1694802780978; Fri, 15 Sep
 2023 11:33:00 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Sep 2023 20:32:50 +0200
Message-ID: <CAJZ5v0hyW71qjqqMK2dkcVuxq5=U3gybUTKbLQyq-tsWiHR+dw@mail.gmail.com>
Subject: [GIT PULL] Power management updates for v6.6-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.6-rc2

with top-most commit 148b6f4cc3920e563094540fe1a12d00d3bbccae

 PM: hibernate: Fix the exclusive get block device in test_resume mode

on top of commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d

 Linux 6.6-rc1

to receive power management updates for 6.6-rc2.

These fix the handling of block devices in the test_resume mode of
hibernation (Chen Yu).

Thanks!


---------------

Chen Yu (2):
      PM: hibernate: Rename function parameter from snapshot_test to exclusive
      PM: hibernate: Fix the exclusive get block device in test_resume mode

---------------

 kernel/power/hibernate.c | 12 ++++++------
 kernel/power/power.h     |  4 ++--
 kernel/power/swap.c      | 14 ++++++++------
 3 files changed, 16 insertions(+), 14 deletions(-)
