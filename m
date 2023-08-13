Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F7277A5F6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 12:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjHMKRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 06:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHMKRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 06:17:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F689170A;
        Sun, 13 Aug 2023 03:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A85516227F;
        Sun, 13 Aug 2023 10:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127BDC433C7;
        Sun, 13 Aug 2023 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691921828;
        bh=8oA71DqvMO3aszAWCCGwfO+pbJIuGxTjTwftxEV1LDo=;
        h=From:Date:Subject:To:Cc:From;
        b=lsUZHZOik2WEQDjUtdrdIFYKdzjXBJeHR77FEEDWBsr/27gSw4hzzw89xOvtMo7YK
         SOn9SY/VJqeyF4eqxAH0hDMbPVkTnFPO7lq+k0EMr7eAfLs6V0i9Oao4AzqjOInZYF
         0wj5twDGL2LYLZMfopfugloLBVHOzbYy55HZq5VfqR5I4u9sRDxXY8ncZWShr+Ev5U
         Q5hdEuhm2q7bSAM7RKpJQtPvzVenl8L59+yKacL7Hfol9MXRVocX8kd8JIjtXQxx9q
         wHM8P/agDZd+Yi8HarwTP9hwZZ2pXJwpAbUFrJW+9o68dTtbPtZ59mTI99aV+Anau+
         ngipLWLgeATMw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-56ca1eebcd7so2596767eaf.0;
        Sun, 13 Aug 2023 03:17:08 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyiep/xOsU/DNzGiHnkKlp2KgrEYxv0gdUTqbBzxcQRst2Xz2Fy
        PMwMwMcieCi+ikH3wTUTsUO3RIkPcCQ7eQChv00=
X-Google-Smtp-Source: AGHT+IGaojI37y1ku1P6BuJTuqH5LsFBn91KBDwFPBjTISfIIkdhdoiU5ORyJi+fRFLaY1rh8g6KpyguemkxKwq30/E=
X-Received: by 2002:a05:6870:9629:b0:1bb:bcc3:c96 with SMTP id
 d41-20020a056870962900b001bbbcc30c96mr7182130oaq.33.1691921827249; Sun, 13
 Aug 2023 03:17:07 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 13 Aug 2023 19:16:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARMSv2B8WJ+rZZXeHCCWtcREn_XZuH5qgZNr8wavWR3cg@mail.gmail.com>
Message-ID: <CAK7LNARMSv2B8WJ+rZZXeHCCWtcREn_XZuH5qgZNr8wavWR3cg@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v6.5-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull some Kbuild fixes.

Thank you.


The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v6.5-2

for you to fetch changes up to 6ccbd7fd474674654019a20177c943359469103a:

  alpha: remove __init annotation from exported page_is_ram()
(2023-08-10 03:06:14 +0900)

----------------------------------------------------------------
Kbuild fixes for v6.5 (2nd)

 - Clear errno before calling getline().

 - Fix a modpost warning for ARCH=alpha

----------------------------------------------------------------
James Clark (1):
      scripts/kallsyms: Fix build failure by setting errno before
calling getline()

Masahiro Yamada (1):
      alpha: remove __init annotation from exported page_is_ram()

 arch/alpha/kernel/setup.c | 3 +--
 scripts/kallsyms.c        | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)



--
Best Regards
Masahiro Yamada
