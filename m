Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87C67CDFE0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjJROc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345445AbjJROcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:32:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD4424F0E
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:23:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0134C433C7;
        Wed, 18 Oct 2023 14:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638984;
        bh=Ql0n1qi7j6kr59m6JNEoxmRGvU/bSZBIKkd9QIFK+AY=;
        h=From:To:Cc:Subject:Date:From;
        b=steRXFs3Xbus/glmOBtdW3+5cyNgZ97CmLlk9+AvcSJ2IbCvGDwyzigpmmZn3AZyc
         UXkNX+Cs0/HLfDHGVvCNjH6oPOd6f15zn2IQ6IbyBp75jpfbo8ZLzwP6Vs/d2pw9GY
         BtSFIpsu4QBMy252Ax93JGrGcdkn0kxcZFwUdYWn6soFdSbgJLwDSLOWJXrTvzQUsR
         0+MOLHMI85io+/3Nv9r2JKvjTxMbUMlMFql1TuHTeNqCi/7wn8pFe8Pk7b8SHBvb6O
         KUSbeaYHlGUpfChUIA0q1ukdMLFI+roA3T9L4v1vGvpeGhHOm9hvBuPZhFb1F+5xkY
         RWVEIbdc74KLQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v6.6-rc6
Date:   Wed, 18 Oct 2023 15:22:43 +0100
Message-Id: <20231018142303.D0134C433C7@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7a795ac8d49e2433e1b97caf5e99129daf8e1b08:

  regmap: rbtree: Fix wrong register marked as in-cache when creating new node (2023-09-22 16:54:00 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.6-rc6

for you to fetch changes up to c6df843348d6b71ea986266c12831cb60c2cf325:

  regmap: fix NULL deref on lookup (2023-10-09 13:13:53 +0100)

----------------------------------------------------------------
regmap: Fix for v6.6

A straightforward fix from Johan for a long standing bug in cases where
we both have regmaps without devices and something is using
dev_get_regmap().

----------------------------------------------------------------
Johan Hovold (1):
      regmap: fix NULL deref on lookup

 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
