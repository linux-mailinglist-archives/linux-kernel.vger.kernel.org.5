Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAFE80A321
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjLHMZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLHMZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:25:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA15AD;
        Fri,  8 Dec 2023 04:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702038333; x=1733574333;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iFM6QWXztFxAu/wiWgDOnvUc9r/V18pkQZWgPrB80Jo=;
  b=RjRs9rRTqJ0c1zBpBt34zYD3HAxG8d/nS6V6Vn2s+44yLtIiGIMNo6Hn
   hyfzGvn2CwMNIHZRsr8ahE82xLLlYkWUPxXH7W139zJjUGvdJdTtApfZe
   +5HR8BTODYLA8rdxir2Tkm3gacZs1HD+P90nwAQUBSx0TfwdIRhmq8mCa
   99kxtYIW09XKy+znW0JJtewBZVYN4ifPJu6eF/6m4NMbLuVwwCGv5CCQj
   Xw4Ib3NOnfGCb3h44Zhii+cwHP+LmS7WJW68SZmNLdhkoozft2I7KRYvh
   F+oOXAWMsE7QV3U0Mcp6YKuxE670KTq5HESZ0W4WGQQzUcFCifzn1Ya97
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1278028"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="1278028"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 04:25:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="765476120"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="765476120"
Received: from smatua-mobl.ger.corp.intel.com ([10.251.223.110])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 04:25:30 -0800
Date:   Fri, 8 Dec 2023 14:25:27 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Armin Wolf <W_Armin@gmx.de>
cc:     Hans de Goede <hdegoede@redhat.com>, corbet@lwn.net,
        Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] platform/x86: wmi: Add driver development guide
In-Reply-To: <20231207222623.232074-6-W_Armin@gmx.de>
Message-ID: <aefc53a4-2472-4613-ef9d-5d3ad972bef3@linux.intel.com>
References: <20231207222623.232074-1-W_Armin@gmx.de> <20231207222623.232074-6-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023, Armin Wolf wrote:

> Since 2010, an LWN article covering WMI drivers exists:
> 
> 	https://lwn.net/Articles/391230/
> 
> Since the introduction of the modern bus-based interface
> and other userspace tooling (fwts wmi, bmfdec, ...), this
> article is outdated and causes people to still submit new
> WMI drivers using the deprecated GUID-based interface.
> Fix this by adding a short guid on how to develop WMI drivers

Too used to typing guid(?), here you want "guide" instead. :-D (I know 
that feeling when my fingers type something else than I think).

> using the modern bus-based interface.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  .../wmi/driver-development-guide.rst          | 126 ++++++++++++++++++
>  Documentation/wmi/index.rst                   |   1 +
>  2 files changed, 127 insertions(+)
>  create mode 100644 Documentation/wmi/driver-development-guide.rst
> 
> diff --git a/Documentation/wmi/driver-development-guide.rst b/Documentation/wmi/driver-development-guide.rst
> new file mode 100644
> index 000000000000..a831e2728d25
> --- /dev/null
> +++ b/Documentation/wmi/driver-development-guide.rst
> @@ -0,0 +1,126 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +============================
> +WMI driver development guide
> +============================
> +
> +The WMI subsystem provides a rich driver api for implementing WMI drivers,

API

> +documented at Documentation/driver-api/wmi.rst. This document will serve
> +as an introductory guide for WMI driver writers using this API. It is supposed
> +t be an successor to the original `LWN article <https://lwn.net/Articles/391230/>`_

t -> to

> +which deals with WMI drivers using the deprecated GUID-based WMI interface.

> +
> +Optaining WMI device information

Obtaining

> +--------------------------------
> +
> +Before developing an WMI driver, information about the WMI device in question
> +must be optained. The `lswmi <https://pypi.org/project/lswmi>`_ utility can be

obtained

> +used to display detailed WMI device information using the following command:
> +
> +::
> +
> +  lswmi -V
> +
> +The resulting output will contain information about all WMI devices inside a given
> +machine, plus some extra information.
> +
> +In order to find out more about the interface used to communicate with a WMI device,
> +the `bmfdec <https://github.com/pali/bmfdec>`_ utilities can be used to decode
> +the Binary MOF information used to describe WMI devices. The ``wmi-bmof`` driver

(Managed Object Format)

> +exposes this information to userspace, see Documentation/ABI/stable/sysfs-platform-wmi-bmof.

This should use a true link to the file.

> +In order to retrieve the decoded Binary MOF information, use the following command (requires root):
> +
> +::
> +
> +  ./bmf2mof /sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]/bmof
> +
> +Sometimes, looking at the disassembled ACPI tables used to describe the WMI device
> +helps in understanding how the WMI device is supposed to work. To find out which
> +ACPI method handles which WMI device, the `fwts <https://github.com/fwts/fwts>`_
> +program can be used with the following command (requires root):
> +
> +::
> +
> +  fwts wmi -
> +
> +Basic WMI driver structure
> +--------------------------
> +
> +The basic WMI driver is build around the struct wmi_driver, which is then bound
> +to matching WMI devices using an struct wmi_device_id table. Please note that each

an struct -> a struct

> +WMI driver should be able to be instantiated multiple times.
> +
> +::
> +
> +  static const struct wmi_device_id foo_id_table[] = {
> +         { "936DA01F-9ABD-4D9D-80C7-02AF85C822A8", NULL },
> +         { }
> +  };
> +  MODULE_DEVICE_TABLE(wmi, foo_id_table);
> +
> +  static struct wmi_driver foo_driver = {
> +        .driver = {
> +                .name = "foo",
> +                .probe_type = PROBE_PREFER_ASYNCHRONOUS,        /* optional */
> +                .pm = pm_sleep_ptr(&foo_dev_pm_ops),            /* optional */
> +        },
> +        .id_table = foo_id_table,
> +        .probe = foo_probe,
> +        .remove = foo_remove,         /* optional, devres is preferred */
> +        .notify = foo_notify,         /* optional, for event handling */
> +  };
> +  module_wmi_driver(foo_driver);
> +
> +If your WMI driver is not using any deprecated GUID-based WMI functions and is
> +able to be instantiated multiple times, please add its GUID to ``allow_duplicates``
> +inside drivers/platform/x86/wmi.c, so that the WMI subsystem does not block duplicate
> +GUIDs for it.

Just voicing wouldn't it be more useful to not burden new stuff with this 
at all and construct the opposite list instead with the GUIDs that have 
a driver that don't support duplicates? It's the existing set of GUIDs we 
have in-tree minus those currently on the list, correct?

> +WMI method drivers
> +------------------
> +
> +WMI drivers can call WMI device methods using wmidev_evaluate_method(), the
> +structure of the ACPI buffer passed to this function is device-specific and usually
> +needs some tinkering to get right. Looking at the ACPI tables containing the WMI
> +device usually helps here. The method id and instance number passed to this function
> +are also device-specific, looking at the decoded Binary MOF is usually enough to
> +find the right values.
> +The maximum instance number can be retrieved during runtime using wmidev_instance_count().
> +
> +Take a look at drivers/platform/x86/inspur_platform_profile.c for an example WMI method driver.
> +
> +WMI data block drivers
> +----------------------
> +
> +WMI drivers can query WMI device data blocks using wmidev_block_query(), the
> +structure of the returned ACPI object is again device-specific. Some WMI devices
> +also allow for setting data blocks using wmidev_block_set().
> +The maximum instance number can also be retrieved using wmidev_instance_count().
> +
> +Take a look at drivers/platform/x86/intel/wmi/sbl-fw-update.c for an example
> +WMI data block driver.
> +
> +WMI event drivers
> +-----------------
> +
> +WMI drivers can receive WMI event notifications by providing the notify() callback
> +inside the struct wmi_driver. The WMI subsystem will then take care of setting
> +up the WMI event accordingly. Plase note that the ACPI object passed to this callback

Plase -> Please

> +is optional and its structure device-specific. It also does not need to be freed,

structure is device-specific.

> +the WMI subsystem takes care of that.

I'd state the freeing part more strongly:

Releasing the ACPI object is handled by the WMI subsystem, not the driver.

> +
> +Take a look at drivers/platform/x86/xiaomi-wmi.c for an example WMI event driver.
> +
> +Things to avoid
> +---------------
> +
> +When developing WMI drivers, there are a couple of things which should be avoid
> +if feasible:
> +
> +- usage of the deprecated GUID-based WMI interface

It would be nice to be more specific because it's far from obvious at this 
point how to differentiate. So perhaps adding something like this would 
help:

(avoid functions with wmi_ prefix that input GUID converting it into 
a wmi_device using wmi_find_device_by_guid()).

> +- bypassing of the WMI subsystem when talking to WMI devices
> +- WMI drivers which cannot be instantiated multiple times.
> +
> +Many older WMI drivers violate one or more points from this list. The reason for
> +this is that the WMI subsystem evolved significantly over the last two decades,
> +so there is a lot of legacy cruft inside older WMI drivers.


-- 
 i.

