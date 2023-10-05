Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9EF7BA887
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjJER5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjJER5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:57:44 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FE790;
        Thu,  5 Oct 2023 10:57:42 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id d4c20237a6c8e736; Thu, 5 Oct 2023 19:57:41 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 8E47F665C39;
        Thu,  5 Oct 2023 19:57:40 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev,
        Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, rui.zhang@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>
Subject: Re: [PATCH v1 2/9] docs: firmware-guide: ACPI: Clarify ACPI bus concepts
Date:   Thu, 05 Oct 2023 19:57:40 +0200
Message-ID: <2725050.mvXUDI8C0e@kreacher>
In-Reply-To: <20230925144842.586829-3-michal.wilczynski@intel.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com> <20230925144842.586829-3-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeggdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepudefpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhvughimhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgt
 phhtthhopehrrghfrggvlhdrjhdrfiihshhotghkihesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=13 Fuz1=13 Fuz2=13
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 25, 2023 4:48:35 PM CEST Michal Wilczynski wrote:
> Some devices implement ACPI driver as a way to manage devices
> enumerated by the ACPI. This might be confusing as a preferred way to
> implement a driver for devices not connected to any bus is a platform
> driver, as stated in the documentation. Clarify relationships between
> ACPI device, platform device and ACPI entries.
> 
> Suggested-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  Documentation/firmware-guide/acpi/enumeration.rst | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
> index 56d9913a3370..f56cc79a9e83 100644
> --- a/Documentation/firmware-guide/acpi/enumeration.rst
> +++ b/Documentation/firmware-guide/acpi/enumeration.rst
> @@ -64,6 +64,19 @@ If the driver needs to perform more complex initialization like getting and
>  configuring GPIOs it can get its ACPI handle and extract this information
>  from ACPI tables.
>  
> +ACPI bus
> +====================
> +
> +Historically some devices not connected to any bus were represented as ACPI
> +devices, and had to implement ACPI driver. This is not a preferred way for new
> +drivers. As explained above devices not connected to any bus should implement
> +platform driver. ACPI device would be created during enumeration nonetheless,
> +and would be accessible through ACPI_COMPANION() macro, and the ACPI handle would
> +be accessible through ACPI_HANDLE() macro. ACPI device is meant to describe
> +information related to ACPI entry e.g. handle of the ACPI entry. Think -
> +ACPI device interfaces with the FW, and the platform device with the rest of
> +the system.
> +
>  DMA support
>  ===========

I rewrote the above entirely, so here's a new patch to replace this one:

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 2/9] ACPI: docs: enumeration: Clarify ACPI bus concepts

In some cases, ACPI drivers are implemented as a way to manage devices
enumerated with the help of the platform firmware through ACPI.

This might be confusing, since the preferred way to implement a driver
for a device that cannot be enumerated natively, is a platform
driver, as stated in the documentation.

Clarify relationships between ACPI device objects, platform devices and
ACPI Namespace entries.

Suggested-by: Elena Reshetova <elena.reshetova@intel.com>
Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/firmware-guide/acpi/enumeration.rst |   43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

Index: linux-pm/Documentation/firmware-guide/acpi/enumeration.rst
===================================================================
--- linux-pm.orig/Documentation/firmware-guide/acpi/enumeration.rst
+++ linux-pm/Documentation/firmware-guide/acpi/enumeration.rst
@@ -64,6 +64,49 @@ If the driver needs to perform more comp
 configuring GPIOs it can get its ACPI handle and extract this information
 from ACPI tables.
 
+ACPI device objects
+===================
+
+Generally speaking, there are two categories of devices in a system in which
+ACPI is used as an interface between the platform firmware and the OS: Devices
+that can be discovered and enumerated natively, through a protocol defined for
+the specific bus that they are on (for example, configuration space in PCI),
+without the platform firmware assistance, and devices that need to be described
+by the platform firmware so that they can be discovered.  Still, for any device
+known to the platform firmware, regardless of which category it falls into,
+there can be a corresponding ACPI device object in the ACPI Namespace in which
+case the Linux kernel will create a struct acpi_device object based on it for
+that device.
+
+Those struct acpi_device objects are never used for binding drivers to natively
+discoverable devices, because they are represented by other types of device
+objects (for example, struct pci_dev for PCI devices) that are bound to by
+device drivers (the corresponding struct acpi_device object is then used as
+an additional source of information on the configuration of the given device).
+Moreover, the core ACPI device enumeration code creates struct platform_device
+objects for the majority of devices that are discovered and enumerated with the
+help of the platform firmware and those platform device objects can be bound to
+by platform drivers in direct analogy with the natively enumerable devices
+case.  Therefore it is logically inconsistent and so generally invalid to bind
+drivers to struct acpi_device objects, including drivers for devices that are
+discovered with the help of the platform firmware.
+
+Historically, ACPI drivers that bound directly to struct acpi_device objects
+were implemented for some devices enumerated with the help of the platform
+firmware, but this is not recommended for any new drivers.  As explained above,
+platform device objects are created for those devices as a rule (with a few
+exceptions that are not relevant here) and so platform drivers should be used
+for handling them, even though the corresponding ACPI device objects are the
+only source of device configuration information in that case.
+
+For every device having a corresponding struct acpi_device object, the pointer
+to it is returned by the ACPI_COMPANION() macro, so it is always possible to
+get to the device configuration information stored in the ACPI device object
+this way.  Accordingly, struct acpi_device can be regarded as a part of the
+interface between the kernel and the ACPI Namespace, whereas device objects of
+other types (for example, struct pci_dev or struct platform_device) are used
+for interacting with the rest of the system.
+
 DMA support
 ===========
 



