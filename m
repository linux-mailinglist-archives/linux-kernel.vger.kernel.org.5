Return-Path: <linux-kernel+bounces-128711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B76895E7E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26F21F26182
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4006615E5B0;
	Tue,  2 Apr 2024 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fj3Cjnl7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9F115ADB1;
	Tue,  2 Apr 2024 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092583; cv=none; b=SH8mb72JxfBuXywxImhNgE0GewqYYttA7uwPLFDAULvSHTYYdyScypS4DMtzciQWMZUfdvR0Jep9eTsXPyqcmYg1CAZ1oTFfII1Yrqplr3D6o3WwcsxcwUnti5sXbQi18FdVcRq33kAGW0CprFcnM+J/8tLH9crpAxq3AHeEuAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092583; c=relaxed/simple;
	bh=X3VZ6npZQzckzPwMwoU3Fg+1K/GTEYupbhuCvZ8/KA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfGb7OBjidzjPAY+486JTw8kRIUO9Mhwc7eDorwbb/qa+UwWDv66OEmn6kiWgwKYjLTy7iIlbSNf7bvYHcduwdmL6gnxg5l8+tcbzEei1KYvOMBlwKZjgZUzeIRQpEVGWbrN3rwFUHXcgbMA9uPL4fc4dT63fBQHeivFRCcEOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fj3Cjnl7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712092581; x=1743628581;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X3VZ6npZQzckzPwMwoU3Fg+1K/GTEYupbhuCvZ8/KA8=;
  b=Fj3Cjnl7UyNbjcgpsO6hcx/j1rSOxr/NGruflfNzunCxsZOyF6rznve8
   N+mAPuBJIZJQlE277137pRA7yz2KxGV7Dhtcrf+oKTA2lW0zldwcmG5Gm
   6O0sci2VrwvoK3f8dZFWCbC0vkQu59cprjxBduOPUbzJu2Li3jGSLVb05
   RnxwX+KszpIydVfco/75mJvjwS4n57C02aATVX1urTkRx3atYyO4Rv3xR
   jQVS89aq65KX6Ps1+XfO83n1H88h2AQ1EXqXE91S87163dJN7K8W/l5FX
   fYTzYTpeenLI1c+UTT7ta1sVxRotzSYt2BhDiylJJUB+wdgPIBaJBsuQt
   g==;
X-CSE-ConnectionGUID: +w8D/8jpQvKsRcxhCLbeNw==
X-CSE-MsgGUID: JdiHH6YiSxW6lNXvpx1WmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="11114877"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="11114877"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:16:20 -0700
X-CSE-ConnectionGUID: pnUMbvePRpSvbr1aLBWtww==
X-CSE-MsgGUID: NEB0yKCwTWGx0ul98JVOGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="18654012"
Received: from ooginni-mobl.amr.corp.intel.com (HELO [10.209.114.45]) ([10.209.114.45])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 14:16:20 -0700
Message-ID: <ef3457fb-f1ae-4ab2-a040-d2e6990d6952@linux.intel.com>
Date: Tue, 2 Apr 2024 14:16:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] platform/x86: wmi: Add driver development guide
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240402143059.8456-1-W_Armin@gmx.de>
 <20240402143059.8456-4-W_Armin@gmx.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240402143059.8456-4-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/2/24 7:30 AM, Armin Wolf wrote:
> Since 2010, an LWN article covering WMI drivers exists:
>
> 	https://lwn.net/Articles/391230/
>
> Since the introduction of the modern bus-based interface
> and other userspace tooling (bmfdec, lswmi, ...), this
> article is outdated and causes people to still submit new
> WMI drivers using the deprecated GUID-based interface.
> Fix this by adding a short guide on how to develop WMI drivers
> using the modern bus-based interface.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---

LGTM

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Changes since v1:
> - use footnote for lwn article link
> - wording fixes
> ---
>  .../wmi/driver-development-guide.rst          | 178 ++++++++++++++++++
>  Documentation/wmi/index.rst                   |   1 +
>  2 files changed, 179 insertions(+)
>  create mode 100644 Documentation/wmi/driver-development-guide.rst
>
> diff --git a/Documentation/wmi/driver-development-guide.rst b/Documentation/wmi/driver-development-guide.rst
> new file mode 100644
> index 000000000000..429137b2f632
> --- /dev/null
> +++ b/Documentation/wmi/driver-development-guide.rst
> @@ -0,0 +1,178 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +============================
> +WMI driver development guide
> +============================
> +
> +The WMI subsystem provides a rich driver API for implementing WMI drivers,
> +documented at Documentation/driver-api/wmi.rst. This document will serve
> +as an introductory guide for WMI driver writers using this API. It is supposed
> +to be a successor to the original LWN article [1]_ which deals with WMI drivers
> +using the deprecated GUID-based WMI interface.
> +
> +Obtaining WMI device information
> +--------------------------------
> +
> +Before developing an WMI driver, information about the WMI device in question
> +must be obtained. The `lswmi <https://pypi.org/project/lswmi>`_ utility can be
> +used to extract detailed WMI device information using the following command:
> +
> +::
> +
> +  lswmi -V
> +
> +The resulting output will contain information about all WMI devices available on
> +a given machine, plus some extra information.
> +
> +In order to find out more about the interface used to communicate with a WMI device,
> +the `bmfdec <https://github.com/pali/bmfdec>`_ utilities can be used to decode
> +the Binary MOF (Managed Object Format) information used to describe WMI devices.
> +The ``wmi-bmof`` driver exposes this information to userspace, see
> +Documentation/wmi/devices/wmi-bmof.rst.
> +
> +In order to retrieve the decoded Binary MOF information, use the following command (requires root):
> +
> +::
> +
> +  ./bmf2mof /sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]/bmof
> +
> +Sometimes, looking at the disassembled ACPI tables used to describe the WMI device
> +helps in understanding how the WMI device is supposed to work. The path of the ACPI
> +method associated with a given WMI device can be retrieved using the ``lswmi`` utility
> +as mentioned above.
> +
> +Basic WMI driver structure
> +--------------------------
> +
> +The basic WMI driver is build around the struct wmi_driver, which is then bound
> +to matching WMI devices using a struct wmi_device_id table:
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
> +                .probe_type = PROBE_PREFER_ASYNCHRONOUS,        /* recommended */
> +                .pm = pm_sleep_ptr(&foo_dev_pm_ops),            /* optional */
> +        },
> +        .id_table = foo_id_table,
> +        .probe = foo_probe,
> +        .remove = foo_remove,         /* optional, devres is preferred */
> +        .notify = foo_notify,         /* optional, for event handling */
> +        .no_notify_data = true,       /* optional, enables events containing no additional data */
> +        .no_singleton = true,         /* required for new WMI drivers */
> +  };
> +  module_wmi_driver(foo_driver);
> +
> +The probe() callback is called when the WMI driver is bound to a matching WMI device. Allocating
> +driver-specific data structures and initialising interfaces to other kernel subsystems should
> +normally be done in this function.
> +
> +The remove() callback is then called when the WMI driver is unbound from a WMI device. In order
> +to unregister interfaces to other kernel subsystems and release resources, devres should be used.
> +This simplifies error handling during probe and often allows to omit this callback entirely, see
> +Documentation/driver-api/driver-model/devres.rst for details.
> +
> +Please note that new WMI drivers are required to be able to be instantiated multiple times,
> +and are forbidden from using any deprecated GUID-based WMI functions. This means that the
> +WMI driver should be prepared for the scenario that multiple matching WMI devices are present
> +on a given machine.
> +
> +Because of this, WMI drivers should use the state container design pattern as described in
> +Documentation/driver-api/driver-model/design-patterns.rst.
> +
> +WMI method drivers
> +------------------
> +
> +WMI drivers can call WMI device methods using wmidev_evaluate_method(), the
> +structure of the ACPI buffer passed to this function is device-specific and usually
> +needs some tinkering to get right. Looking at the ACPI tables containing the WMI
> +device usually helps here. The method id and instance number passed to this function
> +are also device-specific, looking at the decoded Binary MOF is usually enough to
> +find the right values.
> +
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
> +
> +The maximum instance number can also be retrieved using wmidev_instance_count().
> +
> +Take a look at drivers/platform/x86/intel/wmi/sbl-fw-update.c for an example
> +WMI data block driver.
> +
> +WMI event drivers
> +-----------------
> +
> +WMI drivers can receive WMI events via the notify() callback inside the struct wmi_driver.
> +The WMI subsystem will then take care of setting up the WMI event accordingly. Please note that
> +the structure of the ACPI object passed to this callback is device-specific, and freeing the
> +ACPI object is being done by the WMI subsystem, not the driver.
> +
> +The WMI driver core will take care that the notify() callback will only be called after
> +the probe() callback has been called, and that no events are being received by the driver
> +right before and after calling its remove() callback.
> +
> +However WMI driver developers should be aware that multiple WMI events can be received concurrently,
> +so any locking (if necessary) needs to be provided by the WMI driver itself.
> +
> +In order to be able to receive WMI events containing no additional event data,
> +the ``no_notify_data`` flag inside struct wmi_driver should be set to ``true``.
> +
> +Take a look at drivers/platform/x86/xiaomi-wmi.c for an example WMI event driver.
> +
> +Handling multiple WMI devices at once
> +-------------------------------------
> +
> +There are many cases of firmware vendors using multiple WMI devices to control different aspects
> +of a single physical device. This can make developing WMI drivers complicated, as those drivers
> +might need to communicate with each other to present a unified interface to userspace.
> +
> +On such case involves a WMI event device which needs to talk to a WMI data block device or WMI
> +method device upon receiving an WMI event. In such a case, two WMI drivers should be developed,
> +one for the WMI event device and one for the other WMI device.
> +
> +The WMI event device driver has only one purpose: to receive WMI events, validate any additional
> +event data and invoke a notifier chain. The other WMI driver adds itself to this notifier chain
> +during probing and thus gets notified every time a WMI event is received. This WMI driver might
> +then process the event further for example by using an input device.
> +
> +For other WMI device constellations, similar mechanisms can be used.
> +
> +Things to avoid
> +---------------
> +
> +When developing WMI drivers, there are a couple of things which should be avoided:
> +
> +- usage of the deprecated GUID-based WMI interface which uses GUIDs instead of WMI device structs
> +- bypassing of the WMI subsystem when talking to WMI devices
> +- WMI drivers which cannot be instantiated multiple times.
> +
> +Many older WMI drivers violate one or more points from this list. The reason for
> +this is that the WMI subsystem evolved significantly over the last two decades,
> +so there is a lot of legacy cruft inside older WMI drivers.
> +
> +New WMI drivers are also required to conform to the linux kernel coding style as specified in
> +Documentation/process/coding-style.rst. The checkpatch utility can catch many common coding style
> +violations, you can invoke it with the following command:
> +
> +::
> +
> +  ./scripts/checkpatch.pl --strict <path to driver file>
> +
> +References
> +==========
> +
> +.. [1] https://lwn.net/Articles/391230/
> diff --git a/Documentation/wmi/index.rst b/Documentation/wmi/index.rst
> index 537cff188e14..fec4b6ae97b3 100644
> --- a/Documentation/wmi/index.rst
> +++ b/Documentation/wmi/index.rst
> @@ -8,6 +8,7 @@ WMI Subsystem
>     :maxdepth: 1
>
>     acpi-interface
> +   driver-development-guide
>     devices/index
>
>  .. only::  subproject and html
> --
> 2.39.2
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


