Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67987BA4ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbjJEQNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbjJEQMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDEA20657
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:29:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2AAC433C8;
        Thu,  5 Oct 2023 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696519748;
        bh=RrgokZIbawNcYj1Hub++fDHue36t3n7WgTCbcoHbyDE=;
        h=Date:From:To:Cc:Subject:From;
        b=k9095fMg/unoHqm4RC/C+IkpwWHeq8wccyDp8x3AbaP9I0g34QhWsVVe7JmeiHf1s
         WsD1S8lh2+NClg+t1qCJLG/tw7US3ywNl6JPPte5eCPRF9niAZcmwtN6qW3jPrlc01
         MLs4GHfafEWWW81PqiovLlZOBDOzOhGYyOs/SzOGk7c+QlXlQuCXbkLyY2BUCQR2Ys
         sw4NLiyDS2Tf4pm+3XklrUtCanxsayn6mXm2U/ULzOJTgnj+6ddo3x1mcS30VD2UB5
         daE2SDOqrkdcsrVaGWuU8eoghXgo5GiBgATzhvBBIcwDxSamXJe/iq3W39Wo+k07/f
         979ugMQKfDWwg==
Date:   Thu, 5 Oct 2023 16:29:04 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD fixes for v6.6
Message-ID: <20231005152904.GA808963@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening Linus,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-6.6

for you to fetch changes up to c7f5bd9f3aa04a5d0ced8c8f7835bead62380fa6:

  dt-bindings: mfd: Revert "dt-bindings: mfd: maxim,max77693: Add USB connector" (2023-09-20 10:54:16 +0100)

----------------------------------------------------------------
Couple of small fixes, including:

  - Potential build failure in CS42L43
  - Device Tree bindings clean-up for a superseded patch

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      dt-bindings: mfd: Revert "dt-bindings: mfd: maxim,max77693: Add USB connector"

Woody Zhang (1):
      mfd: cs42l43: Fix MFD_CS42L43 dependency on REGMAP_IRQ

 Documentation/devicetree/bindings/mfd/maxim,max77693.yaml | 4 ----
 drivers/mfd/Kconfig                                       | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

-- 
Lee Jones [李琼斯]
