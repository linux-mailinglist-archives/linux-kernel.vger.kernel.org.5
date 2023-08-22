Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECDD78489C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjHVRnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHVRnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:43:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5302A173C;
        Tue, 22 Aug 2023 10:43:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA8B465971;
        Tue, 22 Aug 2023 17:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C281FC433C8;
        Tue, 22 Aug 2023 17:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692726210;
        bh=B/I+W82urXGkGytJ3YPnKlcsllquQv/pg6z2/vC+pXk=;
        h=Date:From:To:Cc:Subject:From;
        b=M9jGZUPoJq853sHfYH6yypp1LNWddPGwJxGgc9SkNlRvdR55eFEegboDIqCM3cTOO
         6cVU4WM+2UJ8Sd3URxm34qR+/fcZ0nRd9+1U4Z92lClMosOMejGYz7YgR5ZA/yeTp0
         LmoisYO/m5P1nllfq5Kz3WqWmClF09XpXH9hMVbv/phxOIrVsT84BVKMpKzu9UBf0b
         uKvuugEEg01dMlJAxHdgNK7ZFJ518rNIEXgMv67eOE/qkekuY681y92aXKwQAbxREQ
         OrhEV6nhzisMC3PZ2/rFna6Ddl2kdM3R0wfGCUY87Gnd5a+mFg9jBT71O67tB9m6XM
         wT2tGoCTi6eQg==
Received: (nullmailer pid 424743 invoked by uid 1000);
        Tue, 22 Aug 2023 17:43:28 -0000
Date:   Tue, 22 Aug 2023 12:43:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.5, take 2
Message-ID: <20230822174328.GA385825-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a few more DT fixes for 6.5.

Rob


The following changes since commit ffc59c6414f9ffd52591786efe3e62e145563deb:

  dt-bindings: serial: Remove obsolete nxp,lpc1850-uart.txt (2023-07-21 13:39:12 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.5-2

for you to fetch changes up to 7882541ca06d51a6c12d687827176c16d5e05f65:

  of/platform: increase refcount of fwnode (2023-08-21 16:12:28 -0500)

----------------------------------------------------------------
Devicetree fixes for v6.5, part 2:

- Fix DT node refcount when creating platform devices

- Fix deadlock in changeset code due to printing with devtree_lock held

- Fix unittest EXPECT strings for parse_phandle_with_args_map() test

- Fix IMA kexec memblock freeing

----------------------------------------------------------------
Peng Fan (1):
      of/platform: increase refcount of fwnode

Rik van Riel (1):
      mm,ima,kexec,of: use memblock_free_late from ima_free_kexec_buffer

Rob Herring (2):
      of: unittest: Fix EXPECT for parse_phandle_with_args_map() test
      of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock

 drivers/of/dynamic.c  | 31 +++++++++----------------------
 drivers/of/kexec.c    |  3 ++-
 drivers/of/platform.c |  4 ++--
 drivers/of/unittest.c |  4 ++--
 4 files changed, 15 insertions(+), 27 deletions(-)
