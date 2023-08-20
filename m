Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9278203C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 23:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjHTVx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 17:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjHTVx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 17:53:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C229D;
        Sun, 20 Aug 2023 14:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51621617D6;
        Sun, 20 Aug 2023 21:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894C8C433C7;
        Sun, 20 Aug 2023 21:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692568406;
        bh=pG6Dbt7KF1bL8ZHkF3gct1/+V8tfHhqi4itJ8MBQNCk=;
        h=Date:From:To:Cc:Subject:From;
        b=p+IDxK8Gev4UxFqAgjkBxe4ET/wifwBb3/r2RmijA3di5EPCiYFTUgJCIYRVc4Scx
         XhZXNzI1pQujcGHUCc4S8MYS0aD2UP1maPguCyfnu6+QfafYcvNYF/RChAWN44eLvK
         QBIh2O8qP6VFah8JWWdBs7O04F1YbI4uEL5HUf272dIItMBX/PVND1Lh8YvjOh6m7d
         Ff0eE67wKBHPFyneosMl4IiWx6B0qfGMkhbFArItp1gfSUbCyweN1wwZtPhr7uNWcy
         ZF2xb/2GWVN28+GQJrOjYUxpNxP42QQNSUDjNRYw4PHsxl4CeFrZ6hNn5nWixMtqde
         hNctVHDfXasvg==
Message-ID: <acaa61be-aa68-22bc-4838-e345de13d2b0@kernel.org>
Date:   Mon, 21 Aug 2023 06:53:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [GIT PULL] devfreq next for 6.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v6.6. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi

The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.6

for you to fetch changes up to 5693d077595de721f9ddbf9d37f40e5409707dfe:

  PM / devfreq: Fix leak in devfreq_dev_release() (2023-08-10 22:48:16 +0900)

----------------------------------------------------------------
Update devfreq next for v6.6

Detailed description for this pull request:
- Include correct DT header including explicitly for imx-bus/imx8m-ddrc/
  mtk-cci/tegra30 tegra drivers.

- Reword the kernel-doc comment for devfreq_monitor_start() API using to specify
the default timer as deferrable timer because devfreq core supports both delayed
timer and deferrable timer according to devfreq device profile.

- Add missing srcu_cleanup_notifier_head() when releasing devfreq device.
: srcu_init_notifier_head() allocates resources that need to be released
with a srcu_cleanup_notifier_head() call.
----------------------------------------------------------------
Boris Brezillon (1):
      PM / devfreq: Fix leak in devfreq_dev_release()

Manivannan Sadhasivam (1):
      PM / devfreq: Reword the kernel-doc comment for devfreq_monitor_start() API

Rob Herring (1):
      PM / devfreq: Explicitly include correct DT includes

 drivers/devfreq/devfreq.c         | 10 ++++++----
 drivers/devfreq/imx-bus.c         |  2 +-
 drivers/devfreq/imx8m-ddrc.c      |  2 +-
 drivers/devfreq/mtk-cci-devfreq.c |  1 -
 drivers/devfreq/tegra30-devfreq.c |  2 +-
 5 files changed, 9 insertions(+), 8 deletions(-)
