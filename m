Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0696810FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjLML1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjLML1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:27:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6D7B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:27:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A67C433C8;
        Wed, 13 Dec 2023 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702466830;
        bh=uIKdDJmnkUDlqqMHVML0moikRxt70qnwcQT97kZOri8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OC9cKVkVDywW6xaGaXoi8zCcpo6w8f4SSLtROXV2o2QlFza6tYh2C+a6RiQ1UXN0C
         D1hNOd02ZFswKVi4+H2gEutM1zX3AHH5fe/mOtC22aSBNqskXa3ag8aJCa3JgzlmWB
         EVdDgAMStBGs3r0Pd4ysYDff3Ql2B/ygoCzTZ0p5l+5cs1OGJRWZoeJiJTlmEJsMDD
         N3QUV7hS1ukReKrBvsjKnXNMd7agAhqnwXqSY1XPRIVoOJyzyuuUMPDTRn96J+4we1
         Z3M01LFDJo79kylZzx4v1uhK6fEr2s/KUmAm0OJaY4/pXWJh+YIu+HIfw4XvsAQ/EK
         /X4TWXBj3uIag==
Date:   Wed, 13 Dec 2023 11:27:05 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Andrew Lunn <andrew@lunn.ch>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
Subject: [GIT PULL] Immutable branch between LEDs and NetDev due for the v6.8
 merge window:wq
Message-ID: <20231213112705.GI111411@google.com>
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
 <170142826116.3357002.9561246405642038358.b4-ty@kernel.org>
 <6577315e.050a0220.50f30.0122@mx.google.com>
 <20231211084656.26578d89@kernel.org>
 <657784f6.5d0a0220.617b5.20ee@mx.google.com>
 <20231211140546.5c39b819@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231211140546.5c39b819@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023, Jakub Kicinski wrote:

> On Mon, 11 Dec 2023 22:53:55 +0100 Christian Marangi wrote:
> > Soo that it's problematic to also have on net-next? (Sorry for the
> > stupid question)
> 
> Unless I pull from Lee the patch would be duplicated, we'd have two
> commits with different hashes and the same diff. And if I pull we'd
> get a lot of netdev-unrelated stuff into net-next:
> 
> $ git merge f07894d3b384344c43be1bcf61ef8e2fded0efe5
> Auto-merging drivers/leds/trigger/ledtrig-netdev.c
> Merge made by the 'ort' strategy.
>  .../ABI/testing/sysfs-class-led-trigger-netdev     |  39 ++
>  .../ABI/testing/sysfs-class-led-trigger-tty        |  56 ++
>  .../bindings/leds/allwinner,sun50i-a100-ledc.yaml  | 137 +++++
>  Documentation/devicetree/bindings/leds/common.yaml |   2 +-
>  drivers/leds/Kconfig                               |  21 +
>  drivers/leds/Makefile                              |   2 +
>  drivers/leds/leds-max5970.c                        | 109 ++++
>  drivers/leds/leds-sun50i-a100.c                    | 580 +++++++++++++++++++++
>  drivers/leds/leds-syscon.c                         |   3 +-
>  drivers/leds/leds-tca6507.c                        |  30 +-
>  drivers/leds/rgb/leds-qcom-lpg.c                   |  52 +-
>  drivers/leds/trigger/ledtrig-gpio.c                |  26 +-
>  drivers/leds/trigger/ledtrig-netdev.c              |  32 +-
>  drivers/leds/trigger/ledtrig-tty.c                 | 247 +++++++--
>  drivers/tty/tty_io.c                               |  28 +-
>  include/linux/leds.h                               |   3 +
>  include/linux/tty.h                                |   1 +
>  17 files changed, 1247 insertions(+), 121 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/leds/allwinner,sun50i-a100-ledc.yaml
>  create mode 100644 drivers/leds/leds-max5970.c
>  create mode 100644 drivers/leds/leds-sun50i-a100.c

No, please don't do that.  None of the branches I maintain are stable.

It allows me to do things like this:

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git ib-leds-netdev-v6.8

for you to fetch changes up to ee8bfb47222a5cc59dee345b7369c5f2068e78cd:

  docs: ABI: sysfs-class-led-trigger-netdev: Add new modes and entry (2023-12-13 11:24:55 +0000)

----------------------------------------------------------------
Immutable branch between LEDs and NetDev due for the v6.8 merge window

----------------------------------------------------------------
Daniel Golle (2):
      leds: trigger: netdev: Extend speeds up to 10G
      docs: ABI: sysfs-class-led-trigger-netdev: Add new modes and entry

 .../ABI/testing/sysfs-class-led-trigger-netdev     | 39 ++++++++++++++++++++++
 drivers/leds/trigger/ledtrig-netdev.c              | 32 +++++++++++++++++-
 include/linux/leds.h                               |  3 ++
 3 files changed, 73 insertions(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]
