Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7248977975C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbjHKSx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbjHKSx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:53:27 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87842D7;
        Fri, 11 Aug 2023 11:53:26 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-56d75fb64a6so433561eaf.0;
        Fri, 11 Aug 2023 11:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691780006; x=1692384806;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdcsZOOFhEeWZqhLiC+0+fFuu6bjcWEXFGlC9mcIT98=;
        b=C4+RHkQzz8LUIVSeClldhvkpUkvOl1vi7VdgpbgNX4uNnm06wQIZ109D+Mb4g+aVdU
         TYkeqAQZbRLDhfmpn8Ak7+rphmZKmadUACwcxTHBCkZugRzp8dkiNCRxCOmXb2ubjatA
         imfcpKahLxASYCXi7CEQ31uBFaBizQVYkt0cdXxu2NZoe0CwoCQgC3Egpi67B3FvKpeN
         /ASjn+G0Y9vN2ibjzhkZtqub3N6CL4Mrwr3Ox7wWfJUd2MbaU5wEzebynAH1fmZxV1KX
         Ig8nvrrLFCWUaUgeW7lgmbmDUERFF20SuIKl4eUBnS1a2gcyOz4+GV8vopbF70nYHCG6
         yv1A==
X-Gm-Message-State: AOJu0Yz8AIf6UroeYB2q0cCMKmGW/xOnDPB7qB+Vnb4bksA/vknHLW2z
        uA8dP1JyrfWJAE2xZAA/8a/vxHJH6M/3EPzpi20m6ntf5O4=
X-Google-Smtp-Source: AGHT+IFWIcp8hXhWx2rklGQE2gY8/NcQ6tbJ/t59+q0cAkzobBpwaSOQ86dDBm9YCNeAFkxkx7hE1fio4xSsQ446Iho=
X-Received: by 2002:a05:6820:1687:b0:566:951e:140c with SMTP id
 bc7-20020a056820168700b00566951e140cmr2648843oob.1.1691780005647; Fri, 11 Aug
 2023 11:53:25 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 20:53:14 +0200
Message-ID: <CAJZ5v0ik0R89HH2fMGV9YP=Poc+5fyjpSkFcMYLU-wSFEVcttg@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.5-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.5-rc6

with top-most commit 56fec0051a69ace182ca3fba47be9c13038b4e3f

 ACPI: resource: Add IRQ override quirk for PCSpecialist Elimina Pro 16 M

on top of commit 52a93d39b17dc7eb98b6aa3edb93943248e03b2f

 Linux 6.5-rc5

to receive ACPI fixes for 6.5-rc6.

These rework the handling of interrupt overrides on AMD Zen-based
machines to avoid recently introduced regressions (Hans de Goede).

Note that this is intended as a short-term mitigation for 6.5 and
the long-term approach will be to attempt to use the configuration
left by the BIOS, but it requires more investigation.

Thanks!


---------------

Hans de Goede (4):
      ACPI: resource: revert "Remove "Zen" specific match and quirks"
      ACPI: resource: Always use MADT override IRQ settings for all
legacy non i8042 IRQs
      ACPI: resource: Honor MADT INT_SRC_OVR settings for IRQ1 on AMD Zen
      ACPI: resource: Add IRQ override quirk for PCSpecialist Elimina Pro 16 M

---------------

 arch/x86/include/asm/acpi.h |  2 ++
 arch/x86/kernel/acpi/boot.c |  4 +++
 drivers/acpi/resource.c     | 64 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)
