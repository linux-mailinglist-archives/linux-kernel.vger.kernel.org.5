Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13B97D83F6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345132AbjJZNzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjJZNzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:55:40 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C182D4D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:55:36 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:32d3:3cb9:edce:43ae])
        by xavier.telenet-ops.be with bizsmtp
        id 2dva2B0082XL1Wb01dvaKi; Thu, 26 Oct 2023 15:55:34 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qw0pa-007YxJ-1x;
        Thu, 26 Oct 2023 15:55:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qw0ph-00HArs-VU;
        Thu, 26 Oct 2023 15:55:33 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] scripts: dt_to_config: Fix nul-separated compatible values
Date:   Thu, 26 Oct 2023 15:55:30 +0200
Message-Id: <cover.1698328110.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

Due to a not-so-recent change in dtc, the dt_to_config script no longer
works well when used on a DTB instead of on a DTS file.  The first patch
fixes that, the second patch fixes the rather odd spacing in that
script.

To not hamper backporting the fix, I put the reformatting patch last.

Thanks for your comments!

P.S. Apparently I had fixed the similar issue in my own out-of-tree
     linux-config-from-dt script in a slightly different way.
     https://github.com/geertu/linux-scripts/commit/56ade26c032c45e9353334384643d190d34b89fb

Geert Uytterhoeven (2):
  scripts: dt_to_config: Fix nul-separated compatible values
  scripts: dt_to_config: Fix odd formatting

 scripts/dtc/dt_to_config | 1765 +++++++++++++++++++-------------------
 1 file changed, 879 insertions(+), 886 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
