Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D597B2714
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjI1VGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjI1VGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:06:13 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CB51B4;
        Thu, 28 Sep 2023 14:06:06 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RxQxl0yqczBf;
        Thu, 28 Sep 2023 23:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1695935163; bh=55XpWhNKMX1xJec8+ShthJVwuaVBpCPUQ0HDAw6jCkg=;
        h=Date:Subject:From:To:Cc:From;
        b=WA3voBpiNjLNFqPEg2TF9J2XkWbjHG91hI2h8oawyNxRVzVQHuWCtnAh18TuDyso6
         W0xy4zUUtbnGN+xUQG6ywnK1cewkRa7DcvWpGOLcXDLiGJ9L+pkAvyRK/xVduw/YiE
         oNqOMmXUAjg8LWAQFPVcxsXXpOg8NWTY2PD4PAUkajg/yk/EfHBne2vhZ4/0N/6Iql
         /8osQLy72ReWUk+rGMwD7ye/tjPkD8UvwTO5sX9XRgw1ZT3bf3rkB5OKhLsWZ2N/to
         m0BW11VrJd7GRkpGfAEdPnZKYkAj4w39kHZAvjL4Wpey6xbtDIkQ5qwuxz8Ei7S3JI
         Zv1wprVlqaNfA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.10 at mail
Date:   Thu, 28 Sep 2023 23:06:02 +0200
Message-Id: <cover.1695934946.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 0/3] usb: chipidea: An USB DMA fix + cleanups for Tegra
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From:   =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a fix for a DMA buffer overflow in Tegra USB driver
followed by a cleanup of the DMA bounce buffer code and another cleanup
to make probe() consistently use dev_err_probe() for error printk()s.

v2: reworded the commit message in patch #1

Michał Mirosław (3):
  usb: chipidea: Fix DMA overwrite for Tegra
  usb: chipidea: Simplify Tegra DMA alignment code
  usb: chipidea: tegra: Consistently use dev_err_probe()

 drivers/usb/chipidea/ci_hdrc_tegra.c | 16 ++++------
 drivers/usb/chipidea/host.c          | 48 ++++++++++++----------------
 2 files changed, 27 insertions(+), 37 deletions(-)

-- 
2.39.2

