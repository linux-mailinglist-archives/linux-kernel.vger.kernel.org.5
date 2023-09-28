Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3FB7B1902
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjI1LD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjI1LDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:03:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1631A3;
        Thu, 28 Sep 2023 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695898998; x=1727434998;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=68Uv63OTysgsKzAlmtZlN6445TXxfX8CsAF94hkyCV0=;
  b=GNBHJUexQ0PRilvfO4rndpNtZ+r/6+txo/eqlkrtSt/d8LHUW6NvD6K/
   ply5SnGwaUDACS7QSou79TQsdebp931kVPCXBqu2jLgvETKVfOEwybBfC
   OJ3UdliMAIUcmOA3MpoJY17HAqLY3sxrKwPrke6a4l0h2KAlFSWIeUisU
   klu9W0TJV9AWuiFSgL2kkmZHXfVqhON0GqKoKyRhOmQq3kRDeWBDnSuj2
   +xJnxiFpNcaRt+XuWrxA1EQl0iwHJeVoc27Q5ODi3x75X1rRSngIvI7pv
   x+Bav0CqUVy+bAbBRCTcE2Rc56/1MezHMBfneXVxs20BIWPbOhCMx5ufa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="3591468"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="3591468"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 04:03:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="752926285"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="752926285"
Received: from vshampor-mobl2.ger.corp.intel.com ([10.249.33.15])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 04:03:12 -0700
Date:   Thu, 28 Sep 2023 14:03:10 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Zhengkang Huang <zkhuang@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        chrome-platform@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 00/27] platform: Convert to platform remove callback
 returning void
In-Reply-To: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
Message-ID: <c7ab93d-fe24-da35-4581-87e3d5fe612d@linux.intel.com>
References: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1237872873-1695898996=:1701"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1237872873-1695898996=:1701
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 27 Sep 2023, Uwe Kleine-König wrote:

> Hello,
> 
> this series converts all platform drivers below drivers/platform to use
> .remove_new(). The motivation is to get rid of an integer return code
> that is (mostly) ignored by the platform driver core and error prone on
> the driver side.
> 
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
> 
> As there is no single maintainer team for drivers/platform, I suggest
> the individual maintainers to pick up "their" patches. The only
> inter-dependency in this series is that the patches #24 - #27 depend on
> #23. Otherwise there are no inter-dependencies, so that should work
> fine. As there are still quite a few drivers to convert in other areas
> than drivers/platform, I'm happy about every patch that makes it in and
> there is no need for further coordination. So even if there is a merge
> conflict with one patch until you apply or a subject prefix is
> suboptimal, please don't let you stop by negative feedback for other
> patches (unless it applies to "your" patches, too, of course).
> 
> Best regards and thanks for considering,
> Uwe
> 
> Uwe Kleine-König (27):
>   platform/chrome: cros_ec_chardev: Convert to platform remove callback
>     returning void
>   platform/chrome: cros_ec_debugfs: Convert to platform remove callback
>     returning void
>   platform/chrome: cros_ec_lightbar: Convert to platform remove callback
>     returning void
>   platform/chrome: cros_ec_lpc: Convert to platform remove callback
>     returning void
>   platform/chrome: cros_ec_sysfs: Convert to platform remove callback
>     returning void
>   platform/chrome: cros_ec_vbc: Convert to platform remove callback
>     returning void
>   platform/chrome: cros_typec_switch: Convert to platform remove
>     callback returning void
>   platform/chrome: cros_usbpd_logger: Convert to platform remove
>     callback returning void
>   platform/chrome: cros_usbpd_notify: Convert to platform remove
>     callback returning void
>   platform/chrome/wilco_ec: core: Convert to platform remove callback
>     returning void
>   platform/chrome/wilco_ec: debugfs: Convert to platform remove callback
>     returning void
>   platform/chrome/wilco_ec: telemetry: Convert to platform remove
>     callback returning void
>   platform/goldfish: goldfish_pipe: Convert to platform remove callback
>     returning void
>   platform/mellanox: mlxbf-bootctl: Convert to platform remove callback
>     returning void
>   platform/mellanox: mlxbf-tmfifo: Convert to platform remove callback
>     returning void
>   platform/mellanox: mlxreg-hotplug: Convert to platform remove callback
>     returning void
>   platform/mellanox: mlxreg-io: Convert to platform remove callback
>     returning void
>   platform/mellanox: mlxreg-lc: Convert to platform remove callback
>     returning void
>   platform/mellanox: nvsw-sn2201: Convert to platform remove callback
>     returning void
>   platform/x86/intel: bytcrc_pwrsrc: Convert to platform remove callback
>     returning void
>   platform/x86: mlx-platform: Convert to platform remove callback
>     returning void
>   platform/x86: sel3350-platform: Convert to platform remove callback
>     returning void
>   platform/x86/siemens: simatic-ipc-batt: Simplify
>     simatic_ipc_batt_remove()
>   platform/x86/siemens: simatic-ipc-batt: Convert to platform remove
>     callback returning void
>   platform/x86/siemens: simatic-ipc-batt-apollolake: Convert to platform
>     remove callback returning void
>   platform/x86/siemens: simatic-ipc-batt-elkhartlake: Convert to
>     platform remove callback returning void
>   platform/x86/siemens: simatic-ipc-batt-f7188x: Convert to platform
>     remove callback returning void

Thanks for the patches.

I don't know if you got the auto generated thank you email as it seemed to 
hit a character encoding problem while sending the email out.

But in any case, I've applied patches 14-27 to my local review-ilpo branch 
(they will eventually appear on the public repo too and propagate to 
for-next).


-- 
 i.

--8323329-1237872873-1695898996=:1701--
