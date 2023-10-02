Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A0C7B4ADE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 05:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbjJBDAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 23:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjJBDAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 23:00:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2378BA;
        Sun,  1 Oct 2023 20:00:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E24DC433C9;
        Mon,  2 Oct 2023 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696215628;
        bh=FLmuE+PPEGAv2iGMtU1eXSNUT5ya0cp/4+njJxMDSbA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=o5h3QlHyDbbMhwgUGSkiqsAFavTnUxqIcW/G1wkHH0/oVI6X0ufnEch8MN53Vpq08
         eYWGjA1l58LW47L+XU6QvH7aQ1LwM0UFe6XneDxPEO+y3myaNtDxft9m3m4lclNr8d
         u+iGfm4/38DOOHUS7LyUz4uTlHjf6unQH6sZ8TJ/1uSW0rUPcHd7pccV4hkfiyJM2j
         Zg8VR1wTe7gmnaflGzvAtiL/jElkl5yYm4X4b0pJwsufth62eb3x81geIpfqfIO0Cq
         tgym5V/2+wJz4/DA3H37vTCcczI9uIL+2rXJ2TfkJnwuZyluz2wGDn/3eI+qL+6Hxm
         JFFxe+p4uNkPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31B70C395C5;
        Mon,  2 Oct 2023 03:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/27] platform: Convert to platform remove callback returning
 void
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169621562819.8096.2360185583269694735.git-patchwork-notify@kernel.org>
Date:   Mon, 02 Oct 2023 03:00:28 +0000
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
To:     =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40pengutronix=2Ede=3E?=@ci.codeaurora.org
Cc:     bleung@chromium.org, tzungbi@kernel.org, pmalani@chromium.org,
        groeck@chromium.org, briannorris@chromium.org, zkhuang@hust.edu.cn,
        dzm91@hust.edu.cn, gregkh@linuxfoundation.org, hdegoede@redhat.com,
        ilpo.jarvinen@linux.intel.com, markgross@kernel.org,
        vadimp@nvidia.com, gerd.haeussler.ext@siemens.com,
        xingtong.wu@siemens.com, tobias.schaffner@siemens.com,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, kernel@pengutronix.de
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed, 27 Sep 2023 10:10:13 +0200 you wrote:
> Hello,
> 
> this series converts all platform drivers below drivers/platform to use
> .remove_new(). The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side.
> 
> [...]

Here is the summary with links:
  - [01/27] platform/chrome: cros_ec_chardev: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/f04410e7be65
  - [02/27] platform/chrome: cros_ec_debugfs: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/f366fa0064ef
  - [03/27] platform/chrome: cros_ec_lightbar: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/fa45583c3133
  - [04/27] platform/chrome: cros_ec_lpc: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/e02944e85169
  - [05/27] platform/chrome: cros_ec_sysfs: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/6478e302409a
  - [06/27] platform/chrome: cros_ec_vbc: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/58b15196b0ef
  - [07/27] platform/chrome: cros_typec_switch: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/ea4bad2badb7
  - [08/27] platform/chrome: cros_usbpd_logger: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/b6c1fea83550
  - [09/27] platform/chrome: cros_usbpd_notify: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/b98362be7c92
  - [10/27] platform/chrome/wilco_ec: core: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/48648504e488
  - [11/27] platform/chrome/wilco_ec: debugfs: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/1fca58f347d8
  - [12/27] platform/chrome/wilco_ec: telemetry: Convert to platform remove callback returning void
    https://git.kernel.org/chrome-platform/c/7396a5b980fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


