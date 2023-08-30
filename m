Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B1878E218
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236043AbjH3WJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244935AbjH3WJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:09:17 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0179EA8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:08:48 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Rbd320NjLz9y;
        Wed, 30 Aug 2023 23:38:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693431534; bh=NbXR0AO83UXMG8y8s//Dy4duP9lJLolOMNifSPMBuD4=;
        h=Date:Subject:From:To:Cc:From;
        b=h0lvqrfqShmsJAvHGc49UygWA0zxx2drJ/+2eruaQJZ+I1e25fpDoyIaU07JZFPh3
         ZBIi9RldEBcth0Jpcfo3acvmVAi5jyV1FK/sOEKeUQ99Znf2OjMOgk6XmFNcPcI8Sb
         XX/NC3n4kIW46r9/Y19JTLhdj91RLwxKZFL75SoAboCE99NJnMys12fIvm53w0EOyy
         1ZnydvJtl7XkhKYLqN5VMRmf+bZErX9gLW89PIU+zodW/B0kseB5k1MsGVSePtey8o
         sVmOaMFaEZwEEisM4xMJtXSfQbW/uCNd2c5u4bdCwP+IR33PTJ71mfSiprezHG/Q3f
         Zt1y7mxKLbRTA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Wed, 30 Aug 2023 23:38:53 +0200
Message-Id: <cover.1693431144.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/9] regulator/core: Trivial cleanups and improvements
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a random set of cleanups, dead code removal and minor optimizations.
Most patches are applicable independently; those that aren't share a bit
of context, but are nevertheless logically separate.

Michał Mirosław (9):
  regulator/core: _regulator_get: simplify error returns
  regulator/core: set_consumer_device_supply: remove `has_dev`
  regulator/core: of_get_child_regulator: remove goto
  regulator/core: regulator_bulk_get: remove redundant NULL stores
  regulator/core: regulator_ena_gpio_ctrl: pull in ena_gpio state
    handling
  regulator/core: remove regulator_init callback
  regulator/core: remove regulator_get_init_drvdata()
  regulator/core: set_consumer_device_supply: avoid copying const data
  regulator/core: make regulator_class const

 drivers/regulator/core.c          | 93 ++++++++++---------------------
 drivers/regulator/internal.h      |  2 +-
 include/linux/regulator/driver.h  |  1 -
 include/linux/regulator/machine.h |  7 +--
 4 files changed, 33 insertions(+), 70 deletions(-)

-- 
2.39.2

