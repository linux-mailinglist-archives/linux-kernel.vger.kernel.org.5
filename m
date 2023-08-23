Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95C47860C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbjHWTi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbjHWTiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:38:21 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E14E60;
        Wed, 23 Aug 2023 12:38:16 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5711d5dac14so133657eaf.0;
        Wed, 23 Aug 2023 12:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692819496; x=1693424296;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZskeI5VBJZ+kmBGAo9rtf8wIll76iI315KkIphqhT4=;
        b=OBmonkxLZiyRzJ5KdCeJt2zEDuSlerHYF3ID+DdwtUvdhJ9MO7nlOB0BcpaUY2Rjm0
         G3orzfO3ott8GAas942L/g+Xj1TJMVjWWjzWHnEwrPuh50b5OmShFnr5dbqwnYLK3LZL
         P5CHuE8J8L3tcco2bWRhqZzF01yaAuIsBVQLvwGeaP+FBnaEbLykadLITcbE29dHFTzh
         uA7QL+BbgMgC8egeQFs2GGbPm0BS2KeU4/lS7NKeyayQrVo8Mn/eYRgCHiNPCOgvcXIJ
         I5XswzANG5f8slDmKr/7RRg1MtDPFup90C8j4Pu2Ag54t/t9fXVtqn7MMC+7dXL1qHlj
         uw6g==
X-Gm-Message-State: AOJu0YzSRVFl+AREjSHvN3fmtZgNq2dzMZ+z/ckDx8bP9s2e8TZQaEqM
        nM2yB/TOVA4FHIwLj5ic+a0ByGewNftDIY5cseQz5T7h16Q=
X-Google-Smtp-Source: AGHT+IEcSOiYBCMnEEjwBFNBFpOEGvFsSssxqncbGp0/1A77wpnheAtXfQK9G+FQ4FTWgWFnSFtGW4mHA/8YDKNLpco=
X-Received: by 2002:a4a:d137:0:b0:571:1906:47f0 with SMTP id
 n23-20020a4ad137000000b00571190647f0mr2178135oor.1.1692819495958; Wed, 23 Aug
 2023 12:38:15 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Aug 2023 21:38:04 +0200
Message-ID: <CAJZ5v0gGifSL5e30wYj7kRfAuzYerAH1hwkz3j8ayYZ7Y15LkQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.5-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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
 acpi-6.5-rc8

with top-most commit 453b014e2c294abf762d3bce12e91ce4b34055e6

 ACPI: resource: Fix IRQ override quirk for PCSpecialist Elimina Pro 16 M

on top of commit 706a741595047797872e669b3101429ab8d378ef

 Linux 6.5-rc7

to receive an ACPI fix for 6.5-rc8.

This makes an existing ACPI IRQ override quirk for PCSpecialist Elimina
Pro 16 M work as intended (Hans de Goede).

Thanks!


---------------

Hans de Goede (1):
      ACPI: resource: Fix IRQ override quirk for PCSpecialist Elimina Pro 16 M

---------------

 drivers/acpi/resource.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)
