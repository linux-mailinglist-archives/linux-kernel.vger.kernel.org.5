Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C13C7F0B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 06:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjKTFFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 00:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTFFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 00:05:39 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0ECF2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 21:05:32 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-45f19811ae5so2439519137.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 21:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700456731; x=1701061531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l/TFvhLb0xnkqv1FD/FHE4F/HboCjUp8WQ3ECUs/3ak=;
        b=IbpImFnTivLII0uqAZ5L1vVj2NVCMiNSvRH2Mfr8BRW80G2sye1NCcJlO98yviWRIP
         XSMR2+cwnMbsdmNURHavPT7ArFlQHYjptSNuoZfNHUKJyV16eu4Wn/GbZrEYLaw+0pUb
         qffZK1vLKeRh7BZkN62HFNjMptF09DLOp6KcGN8+r7f4RO7X7x4wutDERuAF7NSwGPJv
         3KZ63WFDS7HjbPnCmdeI8EhUkmSco3GEadinC4HvtQGmC3/Zatc/TaF2Msl99zif7rC3
         AXgACH6VXNz/dS4u6m76fcot2CNLNqqMAIuV0QnOYJjTQehz7teGIztDqW1kepPy+Wsj
         H/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700456731; x=1701061531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/TFvhLb0xnkqv1FD/FHE4F/HboCjUp8WQ3ECUs/3ak=;
        b=OBC6iHyME4kv8qb0TWaLpdVk8IgyeZeWTOxX/r1nmeTnXu0uG6Yeitd8YweD4BxU4L
         Fdsdm5B/GfEJ2yPgX0hZKpI7e/Ecxzj3+QBvyAMCpY4gCHKg/pHAevo/gc7d/K8E/lg7
         Go7WSgqjjagFzBdP05S/IzJEZhbXsHTUDWLuMF4vwqThUNSLtkRCdF3n5QgGNsx5Ulvr
         geC/lBd9Vh4KBSHAHQjth8/l3tecXfX/NGJxMoZ8E8suuZ/5WxwGsSsZnfNt7ejMnGV0
         xSEnG03/IQSy44Xw+PV7Z9dt8qEf8zPVAyO1xMKcEE4GAI0GAKL+jVEOk/WEQ/o9y3Pf
         4iVA==
X-Gm-Message-State: AOJu0YwYxaps7iMT/8A/FA1fY9FsUtcahvMFNaRDa5RAmwfuyJygjKv9
        a/SV+FtnCXfQQ5g9eTf/ne5ykUE0sfTo9W69Q6enCfHBqnHWR9dP
X-Google-Smtp-Source: AGHT+IHh6RejaCtMSY7zPcDnGGTivDUHJk6lS0OKjTAztji6DtlMogFHQSbsZToO8G3TWHPtkDJvJP+zAwikeYqTXkU=
X-Received: by 2002:a05:6102:579a:b0:45d:773b:f57b with SMTP id
 dh26-20020a056102579a00b0045d773bf57bmr10896778vsb.17.1700456730698; Sun, 19
 Nov 2023 21:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20231103061715.196294-1-sumit.garg@linaro.org>
In-Reply-To: <20231103061715.196294-1-sumit.garg@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 20 Nov 2023 10:35:19 +0530
Message-ID: <CAFA6WYNW_cAFVMTpqPQjwBASKDp_b=CpccCzx23jHn_+qoJrDQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: Destage TEE subsystem documentation
To:     corbet@lwn.net
Cc:     jens.wiklander@linaro.org, vegard.nossum@oracle.com,
        Rijo-john.Thomas@amd.com, balint.dobszay@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Fri, 3 Nov 2023 at 11:47, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Add a separate documentation directory for TEE subsystem since it is a
> standalone subsystem which already offers devices consumed by multiple
> different subsystem drivers.
>
> Split overall TEE subsystem documentation modularly where:
> - The userspace API has been moved to Documentation/userspace-api/tee.rst.
> - The driver API has been moved to Documentation/driver-api/tee.rst.
> - The first module covers the overview of TEE subsystem.
> - The further modules are dedicated to different TEE implementations like:
>   - OP-TEE
>   - AMD-TEE
>   - and so on for future TEE implementation support.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v2:
> - Move userspace API to Documentation/userspace-api/tee.rst.
> - Move driver API to Documentation/driver-api/tee.rst.
>
>  Documentation/driver-api/index.rst    |   1 +
>  Documentation/driver-api/tee.rst      |  66 +++++
>  Documentation/staging/index.rst       |   1 -
>  Documentation/staging/tee.rst         | 364 --------------------------
>  Documentation/subsystem-apis.rst      |   1 +
>  Documentation/tee/amd-tee.rst         |  90 +++++++
>  Documentation/tee/index.rst           |  19 ++
>  Documentation/tee/op-tee.rst          | 166 ++++++++++++
>  Documentation/tee/tee.rst             |  22 ++
>  Documentation/userspace-api/index.rst |   1 +
>  Documentation/userspace-api/tee.rst   |  39 +++
>  MAINTAINERS                           |   4 +-
>  12 files changed, 408 insertions(+), 366 deletions(-)
>  create mode 100644 Documentation/driver-api/tee.rst
>  delete mode 100644 Documentation/staging/tee.rst
>  create mode 100644 Documentation/tee/amd-tee.rst
>  create mode 100644 Documentation/tee/index.rst
>  create mode 100644 Documentation/tee/op-tee.rst
>  create mode 100644 Documentation/tee/tee.rst
>  create mode 100644 Documentation/userspace-api/tee.rst
>

If you are fine with this destaging TEE documentation patch then will
you be picking up this patch? Or would you like Jens to pick it up
with your Ack?

-Sumit

> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index 1e16a40da3ba..b4214d98d7b5 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -114,6 +114,7 @@ available subsections can be seen below.
>     zorro
>     hte/index
>     wmi
> +   tee
>
>  .. only::  subproject and html
>
> diff --git a/Documentation/driver-api/tee.rst b/Documentation/driver-api/tee.rst
> new file mode 100644
> index 000000000000..5eaeb8103988
> --- /dev/null
> +++ b/Documentation/driver-api/tee.rst
> @@ -0,0 +1,66 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================================
> +TEE (Trusted Execution Environment) driver API
> +===============================================
> +
> +Kernel provides a TEE bus infrastructure where a Trusted Application is
> +represented as a device identified via Universally Unique Identifier (UUID) and
> +client drivers register a table of supported device UUIDs.
> +
> +TEE bus infrastructure registers following APIs:
> +
> +match():
> +  iterates over the client driver UUID table to find a corresponding
> +  match for device UUID. If a match is found, then this particular device is
> +  probed via corresponding probe API registered by the client driver. This
> +  process happens whenever a device or a client driver is registered with TEE
> +  bus.
> +
> +uevent():
> +  notifies user-space (udev) whenever a new device is registered on
> +  TEE bus for auto-loading of modularized client drivers.
> +
> +TEE bus device enumeration is specific to underlying TEE implementation, so it
> +is left open for TEE drivers to provide corresponding implementation.
> +
> +Then TEE client driver can talk to a matched Trusted Application using APIs
> +listed in include/linux/tee_drv.h.
> +
> +TEE client driver example
> +-------------------------
> +
> +Suppose a TEE client driver needs to communicate with a Trusted Application
> +having UUID: ``ac6a4085-0e82-4c33-bf98-8eb8e118b6c2``, so driver registration
> +snippet would look like::
> +
> +       static const struct tee_client_device_id client_id_table[] = {
> +               {UUID_INIT(0xac6a4085, 0x0e82, 0x4c33,
> +                          0xbf, 0x98, 0x8e, 0xb8, 0xe1, 0x18, 0xb6, 0xc2)},
> +               {}
> +       };
> +
> +       MODULE_DEVICE_TABLE(tee, client_id_table);
> +
> +       static struct tee_client_driver client_driver = {
> +               .id_table       = client_id_table,
> +               .driver         = {
> +                       .name           = DRIVER_NAME,
> +                       .bus            = &tee_bus_type,
> +                       .probe          = client_probe,
> +                       .remove         = client_remove,
> +               },
> +       };
> +
> +       static int __init client_init(void)
> +       {
> +               return driver_register(&client_driver.driver);
> +       }
> +
> +       static void __exit client_exit(void)
> +       {
> +               driver_unregister(&client_driver.driver);
> +       }
> +
> +       module_init(client_init);
> +       module_exit(client_exit);
> diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
> index ded8254bc0d7..71592f3ce89b 100644
> --- a/Documentation/staging/index.rst
> +++ b/Documentation/staging/index.rst
> @@ -12,5 +12,4 @@ Unsorted Documentation
>     rpmsg
>     speculation
>     static-keys
> -   tee
>     xz
> diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> deleted file mode 100644
> index 22baa077a3b9..000000000000
> --- a/Documentation/staging/tee.rst
> +++ /dev/null
> @@ -1,364 +0,0 @@
> -=============
> -TEE subsystem
> -=============
> -
> -This document describes the TEE subsystem in Linux.
> -
> -A TEE (Trusted Execution Environment) is a trusted OS running in some
> -secure environment, for example, TrustZone on ARM CPUs, or a separate
> -secure co-processor etc. A TEE driver handles the details needed to
> -communicate with the TEE.
> -
> -This subsystem deals with:
> -
> -- Registration of TEE drivers
> -
> -- Managing shared memory between Linux and the TEE
> -
> -- Providing a generic API to the TEE
> -
> -The TEE interface
> -=================
> -
> -include/uapi/linux/tee.h defines the generic interface to a TEE.
> -
> -User space (the client) connects to the driver by opening /dev/tee[0-9]* or
> -/dev/teepriv[0-9]*.
> -
> -- TEE_IOC_SHM_ALLOC allocates shared memory and returns a file descriptor
> -  which user space can mmap. When user space doesn't need the file
> -  descriptor any more, it should be closed. When shared memory isn't needed
> -  any longer it should be unmapped with munmap() to allow the reuse of
> -  memory.
> -
> -- TEE_IOC_VERSION lets user space know which TEE this driver handles and
> -  its capabilities.
> -
> -- TEE_IOC_OPEN_SESSION opens a new session to a Trusted Application.
> -
> -- TEE_IOC_INVOKE invokes a function in a Trusted Application.
> -
> -- TEE_IOC_CANCEL may cancel an ongoing TEE_IOC_OPEN_SESSION or TEE_IOC_INVOKE.
> -
> -- TEE_IOC_CLOSE_SESSION closes a session to a Trusted Application.
> -
> -There are two classes of clients, normal clients and supplicants. The latter is
> -a helper process for the TEE to access resources in Linux, for example file
> -system access. A normal client opens /dev/tee[0-9]* and a supplicant opens
> -/dev/teepriv[0-9].
> -
> -Much of the communication between clients and the TEE is opaque to the
> -driver. The main job for the driver is to receive requests from the
> -clients, forward them to the TEE and send back the results. In the case of
> -supplicants the communication goes in the other direction, the TEE sends
> -requests to the supplicant which then sends back the result.
> -
> -The TEE kernel interface
> -========================
> -
> -Kernel provides a TEE bus infrastructure where a Trusted Application is
> -represented as a device identified via Universally Unique Identifier (UUID) and
> -client drivers register a table of supported device UUIDs.
> -
> -TEE bus infrastructure registers following APIs:
> -
> -match():
> -  iterates over the client driver UUID table to find a corresponding
> -  match for device UUID. If a match is found, then this particular device is
> -  probed via corresponding probe API registered by the client driver. This
> -  process happens whenever a device or a client driver is registered with TEE
> -  bus.
> -
> -uevent():
> -  notifies user-space (udev) whenever a new device is registered on
> -  TEE bus for auto-loading of modularized client drivers.
> -
> -TEE bus device enumeration is specific to underlying TEE implementation, so it
> -is left open for TEE drivers to provide corresponding implementation.
> -
> -Then TEE client driver can talk to a matched Trusted Application using APIs
> -listed in include/linux/tee_drv.h.
> -
> -TEE client driver example
> --------------------------
> -
> -Suppose a TEE client driver needs to communicate with a Trusted Application
> -having UUID: ``ac6a4085-0e82-4c33-bf98-8eb8e118b6c2``, so driver registration
> -snippet would look like::
> -
> -       static const struct tee_client_device_id client_id_table[] = {
> -               {UUID_INIT(0xac6a4085, 0x0e82, 0x4c33,
> -                          0xbf, 0x98, 0x8e, 0xb8, 0xe1, 0x18, 0xb6, 0xc2)},
> -               {}
> -       };
> -
> -       MODULE_DEVICE_TABLE(tee, client_id_table);
> -
> -       static struct tee_client_driver client_driver = {
> -               .id_table       = client_id_table,
> -               .driver         = {
> -                       .name           = DRIVER_NAME,
> -                       .bus            = &tee_bus_type,
> -                       .probe          = client_probe,
> -                       .remove         = client_remove,
> -               },
> -       };
> -
> -       static int __init client_init(void)
> -       {
> -               return driver_register(&client_driver.driver);
> -       }
> -
> -       static void __exit client_exit(void)
> -       {
> -               driver_unregister(&client_driver.driver);
> -       }
> -
> -       module_init(client_init);
> -       module_exit(client_exit);
> -
> -OP-TEE driver
> -=============
> -
> -The OP-TEE driver handles OP-TEE [1] based TEEs. Currently it is only the ARM
> -TrustZone based OP-TEE solution that is supported.
> -
> -Lowest level of communication with OP-TEE builds on ARM SMC Calling
> -Convention (SMCCC) [2], which is the foundation for OP-TEE's SMC interface
> -[3] used internally by the driver. Stacked on top of that is OP-TEE Message
> -Protocol [4].
> -
> -OP-TEE SMC interface provides the basic functions required by SMCCC and some
> -additional functions specific for OP-TEE. The most interesting functions are:
> -
> -- OPTEE_SMC_FUNCID_CALLS_UID (part of SMCCC) returns the version information
> -  which is then returned by TEE_IOC_VERSION
> -
> -- OPTEE_SMC_CALL_GET_OS_UUID returns the particular OP-TEE implementation, used
> -  to tell, for instance, a TrustZone OP-TEE apart from an OP-TEE running on a
> -  separate secure co-processor.
> -
> -- OPTEE_SMC_CALL_WITH_ARG drives the OP-TEE message protocol
> -
> -- OPTEE_SMC_GET_SHM_CONFIG lets the driver and OP-TEE agree on which memory
> -  range to used for shared memory between Linux and OP-TEE.
> -
> -The GlobalPlatform TEE Client API [5] is implemented on top of the generic
> -TEE API.
> -
> -Picture of the relationship between the different components in the
> -OP-TEE architecture::
> -
> -      User space                  Kernel                   Secure world
> -      ~~~~~~~~~~                  ~~~~~~                   ~~~~~~~~~~~~
> -   +--------+                                             +-------------+
> -   | Client |                                             | Trusted     |
> -   +--------+                                             | Application |
> -      /\                                                  +-------------+
> -      || +----------+                                           /\
> -      || |tee-      |                                           ||
> -      || |supplicant|                                           \/
> -      || +----------+                                     +-------------+
> -      \/      /\                                          | TEE Internal|
> -   +-------+  ||                                          | API         |
> -   + TEE   |  ||            +--------+--------+           +-------------+
> -   | Client|  ||            | TEE    | OP-TEE |           | OP-TEE      |
> -   | API   |  \/            | subsys | driver |           | Trusted OS  |
> -   +-------+----------------+----+-------+----+-----------+-------------+
> -   |      Generic TEE API        |       |     OP-TEE MSG               |
> -   |      IOCTL (TEE_IOC_*)      |       |     SMCCC (OPTEE_SMC_CALL_*) |
> -   +-----------------------------+       +------------------------------+
> -
> -RPC (Remote Procedure Call) are requests from secure world to kernel driver
> -or tee-supplicant. An RPC is identified by a special range of SMCCC return
> -values from OPTEE_SMC_CALL_WITH_ARG. RPC messages which are intended for the
> -kernel are handled by the kernel driver. Other RPC messages will be forwarded to
> -tee-supplicant without further involvement of the driver, except switching
> -shared memory buffer representation.
> -
> -OP-TEE device enumeration
> --------------------------
> -
> -OP-TEE provides a pseudo Trusted Application: drivers/tee/optee/device.c in
> -order to support device enumeration. In other words, OP-TEE driver invokes this
> -application to retrieve a list of Trusted Applications which can be registered
> -as devices on the TEE bus.
> -
> -OP-TEE notifications
> ---------------------
> -
> -There are two kinds of notifications that secure world can use to make
> -normal world aware of some event.
> -
> -1. Synchronous notifications delivered with ``OPTEE_RPC_CMD_NOTIFICATION``
> -   using the ``OPTEE_RPC_NOTIFICATION_SEND`` parameter.
> -2. Asynchronous notifications delivered with a combination of a non-secure
> -   edge-triggered interrupt and a fast call from the non-secure interrupt
> -   handler.
> -
> -Synchronous notifications are limited by depending on RPC for delivery,
> -this is only usable when secure world is entered with a yielding call via
> -``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from secure
> -world interrupt handlers.
> -
> -An asynchronous notification is delivered via a non-secure edge-triggered
> -interrupt to an interrupt handler registered in the OP-TEE driver. The
> -actual notification value are retrieved with the fast call
> -``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE``. Note that one interrupt can represent
> -multiple notifications.
> -
> -One notification value ``OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF`` has a
> -special meaning. When this value is received it means that normal world is
> -supposed to make a yielding call ``OPTEE_MSG_CMD_DO_BOTTOM_HALF``. This
> -call is done from the thread assisting the interrupt handler. This is a
> -building block for OP-TEE OS in secure world to implement the top half and
> -bottom half style of device drivers.
> -
> -OPTEE_INSECURE_LOAD_IMAGE Kconfig option
> -----------------------------------------
> -
> -The OPTEE_INSECURE_LOAD_IMAGE Kconfig option enables the ability to load the
> -BL32 OP-TEE image from the kernel after the kernel boots, rather than loading
> -it from the firmware before the kernel boots. This also requires enabling the
> -corresponding option in Trusted Firmware for Arm. The Trusted Firmware for Arm
> -documentation [8] explains the security threat associated with enabling this as
> -well as mitigations at the firmware and platform level.
> -
> -There are additional attack vectors/mitigations for the kernel that should be
> -addressed when using this option.
> -
> -1. Boot chain security.
> -
> -   * Attack vector: Replace the OP-TEE OS image in the rootfs to gain control of
> -     the system.
> -
> -   * Mitigation: There must be boot chain security that verifies the kernel and
> -     rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
> -     modifying it in the rootfs.
> -
> -2. Alternate boot modes.
> -
> -   * Attack vector: Using an alternate boot mode (i.e. recovery mode), the
> -     OP-TEE driver isn't loaded, leaving the SMC hole open.
> -
> -   * Mitigation: If there are alternate methods of booting the device, such as a
> -     recovery mode, it should be ensured that the same mitigations are applied
> -     in that mode.
> -
> -3. Attacks prior to SMC invocation.
> -
> -   * Attack vector: Code that is executed prior to issuing the SMC call to load
> -     OP-TEE can be exploited to then load an alternate OS image.
> -
> -   * Mitigation: The OP-TEE driver must be loaded before any potential attack
> -     vectors are opened up. This should include mounting of any modifiable
> -     filesystems, opening of network ports or communicating with external
> -     devices (e.g. USB).
> -
> -4. Blocking SMC call to load OP-TEE.
> -
> -   * Attack vector: Prevent the driver from being probed, so the SMC call to
> -     load OP-TEE isn't executed when desired, leaving it open to being executed
> -     later and loading a modified OS.
> -
> -   * Mitigation: It is recommended to build the OP-TEE driver as builtin driver
> -     rather than as a module to prevent exploits that may cause the module to
> -     not be loaded.
> -
> -AMD-TEE driver
> -==============
> -
> -The AMD-TEE driver handles the communication with AMD's TEE environment. The
> -TEE environment is provided by AMD Secure Processor.
> -
> -The AMD Secure Processor (formerly called Platform Security Processor or PSP)
> -is a dedicated processor that features ARM TrustZone technology, along with a
> -software-based Trusted Execution Environment (TEE) designed to enable
> -third-party Trusted Applications. This feature is currently enabled only for
> -APUs.
> -
> -The following picture shows a high level overview of AMD-TEE::
> -
> -                                             |
> -    x86                                      |
> -                                             |
> - User space            (Kernel space)        |    AMD Secure Processor (PSP)
> - ~~~~~~~~~~            ~~~~~~~~~~~~~~        |    ~~~~~~~~~~~~~~~~~~~~~~~~~~
> -                                             |
> - +--------+                                  |       +-------------+
> - | Client |                                  |       | Trusted     |
> - +--------+                                  |       | Application |
> -     /\                                      |       +-------------+
> -     ||                                      |             /\
> -     ||                                      |             ||
> -     ||                                      |             \/
> -     ||                                      |         +----------+
> -     ||                                      |         |   TEE    |
> -     ||                                      |         | Internal |
> -     \/                                      |         |   API    |
> - +---------+           +-----------+---------+         +----------+
> - | TEE     |           | TEE       | AMD-TEE |         | AMD-TEE  |
> - | Client  |           | subsystem | driver  |         | Trusted  |
> - | API     |           |           |         |         |   OS     |
> - +---------+-----------+----+------+---------+---------+----------+
> - |   Generic TEE API        |      | ASP     |      Mailbox       |
> - |   IOCTL (TEE_IOC_*)      |      | driver  | Register Protocol  |
> - +--------------------------+      +---------+--------------------+
> -
> -At the lowest level (in x86), the AMD Secure Processor (ASP) driver uses the
> -CPU to PSP mailbox register to submit commands to the PSP. The format of the
> -command buffer is opaque to the ASP driver. It's role is to submit commands to
> -the secure processor and return results to AMD-TEE driver. The interface
> -between AMD-TEE driver and AMD Secure Processor driver can be found in [6].
> -
> -The AMD-TEE driver packages the command buffer payload for processing in TEE.
> -The command buffer format for the different TEE commands can be found in [7].
> -
> -The TEE commands supported by AMD-TEE Trusted OS are:
> -
> -* TEE_CMD_ID_LOAD_TA          - loads a Trusted Application (TA) binary into
> -                                TEE environment.
> -* TEE_CMD_ID_UNLOAD_TA        - unloads TA binary from TEE environment.
> -* TEE_CMD_ID_OPEN_SESSION     - opens a session with a loaded TA.
> -* TEE_CMD_ID_CLOSE_SESSION    - closes session with loaded TA
> -* TEE_CMD_ID_INVOKE_CMD       - invokes a command with loaded TA
> -* TEE_CMD_ID_MAP_SHARED_MEM   - maps shared memory
> -* TEE_CMD_ID_UNMAP_SHARED_MEM - unmaps shared memory
> -
> -AMD-TEE Trusted OS is the firmware running on AMD Secure Processor.
> -
> -The AMD-TEE driver registers itself with TEE subsystem and implements the
> -following driver function callbacks:
> -
> -* get_version - returns the driver implementation id and capability.
> -* open - sets up the driver context data structure.
> -* release - frees up driver resources.
> -* open_session - loads the TA binary and opens session with loaded TA.
> -* close_session -  closes session with loaded TA and unloads it.
> -* invoke_func - invokes a command with loaded TA.
> -
> -cancel_req driver callback is not supported by AMD-TEE.
> -
> -The GlobalPlatform TEE Client API [5] can be used by the user space (client) to
> -talk to AMD's TEE. AMD's TEE provides a secure environment for loading, opening
> -a session, invoking commands and closing session with TA.
> -
> -References
> -==========
> -
> -[1] https://github.com/OP-TEE/optee_os
> -
> -[2] http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
> -
> -[3] drivers/tee/optee/optee_smc.h
> -
> -[4] drivers/tee/optee/optee_msg.h
> -
> -[5] http://www.globalplatform.org/specificationsdevice.asp look for
> -    "TEE Client API Specification v1.0" and click download.
> -
> -[6] include/linux/psp-tee.h
> -
> -[7] drivers/tee/amdtee/amdtee_if.h
> -
> -[8] https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_model.html
> diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
> index 90a0535a932a..1666f11de8df 100644
> --- a/Documentation/subsystem-apis.rst
> +++ b/Documentation/subsystem-apis.rst
> @@ -86,3 +86,4 @@ Storage interfaces
>     misc-devices/index
>     peci/index
>     wmi/index
> +   tee/index
> diff --git a/Documentation/tee/amd-tee.rst b/Documentation/tee/amd-tee.rst
> new file mode 100644
> index 000000000000..51500fde7038
> --- /dev/null
> +++ b/Documentation/tee/amd-tee.rst
> @@ -0,0 +1,90 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============================================
> +AMD-TEE (AMD's Trusted Execution Environment)
> +=============================================
> +
> +The AMD-TEE driver handles the communication with AMD's TEE environment. The
> +TEE environment is provided by AMD Secure Processor.
> +
> +The AMD Secure Processor (formerly called Platform Security Processor or PSP)
> +is a dedicated processor that features ARM TrustZone technology, along with a
> +software-based Trusted Execution Environment (TEE) designed to enable
> +third-party Trusted Applications. This feature is currently enabled only for
> +APUs.
> +
> +The following picture shows a high level overview of AMD-TEE::
> +
> +                                             |
> +    x86                                      |
> +                                             |
> + User space            (Kernel space)        |    AMD Secure Processor (PSP)
> + ~~~~~~~~~~            ~~~~~~~~~~~~~~        |    ~~~~~~~~~~~~~~~~~~~~~~~~~~
> +                                             |
> + +--------+                                  |       +-------------+
> + | Client |                                  |       | Trusted     |
> + +--------+                                  |       | Application |
> +     /\                                      |       +-------------+
> +     ||                                      |             /\
> +     ||                                      |             ||
> +     ||                                      |             \/
> +     ||                                      |         +----------+
> +     ||                                      |         |   TEE    |
> +     ||                                      |         | Internal |
> +     \/                                      |         |   API    |
> + +---------+           +-----------+---------+         +----------+
> + | TEE     |           | TEE       | AMD-TEE |         | AMD-TEE  |
> + | Client  |           | subsystem | driver  |         | Trusted  |
> + | API     |           |           |         |         |   OS     |
> + +---------+-----------+----+------+---------+---------+----------+
> + |   Generic TEE API        |      | ASP     |      Mailbox       |
> + |   IOCTL (TEE_IOC_*)      |      | driver  | Register Protocol  |
> + +--------------------------+      +---------+--------------------+
> +
> +At the lowest level (in x86), the AMD Secure Processor (ASP) driver uses the
> +CPU to PSP mailbox register to submit commands to the PSP. The format of the
> +command buffer is opaque to the ASP driver. It's role is to submit commands to
> +the secure processor and return results to AMD-TEE driver. The interface
> +between AMD-TEE driver and AMD Secure Processor driver can be found in [1].
> +
> +The AMD-TEE driver packages the command buffer payload for processing in TEE.
> +The command buffer format for the different TEE commands can be found in [2].
> +
> +The TEE commands supported by AMD-TEE Trusted OS are:
> +
> +* TEE_CMD_ID_LOAD_TA          - loads a Trusted Application (TA) binary into
> +                                TEE environment.
> +* TEE_CMD_ID_UNLOAD_TA        - unloads TA binary from TEE environment.
> +* TEE_CMD_ID_OPEN_SESSION     - opens a session with a loaded TA.
> +* TEE_CMD_ID_CLOSE_SESSION    - closes session with loaded TA
> +* TEE_CMD_ID_INVOKE_CMD       - invokes a command with loaded TA
> +* TEE_CMD_ID_MAP_SHARED_MEM   - maps shared memory
> +* TEE_CMD_ID_UNMAP_SHARED_MEM - unmaps shared memory
> +
> +AMD-TEE Trusted OS is the firmware running on AMD Secure Processor.
> +
> +The AMD-TEE driver registers itself with TEE subsystem and implements the
> +following driver function callbacks:
> +
> +* get_version - returns the driver implementation id and capability.
> +* open - sets up the driver context data structure.
> +* release - frees up driver resources.
> +* open_session - loads the TA binary and opens session with loaded TA.
> +* close_session -  closes session with loaded TA and unloads it.
> +* invoke_func - invokes a command with loaded TA.
> +
> +cancel_req driver callback is not supported by AMD-TEE.
> +
> +The GlobalPlatform TEE Client API [3] can be used by the user space (client) to
> +talk to AMD's TEE. AMD's TEE provides a secure environment for loading, opening
> +a session, invoking commands and closing session with TA.
> +
> +References
> +==========
> +
> +[1] include/linux/psp-tee.h
> +
> +[2] drivers/tee/amdtee/amdtee_if.h
> +
> +[3] http://www.globalplatform.org/specificationsdevice.asp look for
> +    "TEE Client API Specification v1.0" and click download.
> diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst
> new file mode 100644
> index 000000000000..a23bd08847e5
> --- /dev/null
> +++ b/Documentation/tee/index.rst
> @@ -0,0 +1,19 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +TEE Subsystem
> +=============
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   tee
> +   op-tee
> +   amd-tee
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   =======
> +
> +   * :ref:`genindex`
> diff --git a/Documentation/tee/op-tee.rst b/Documentation/tee/op-tee.rst
> new file mode 100644
> index 000000000000..b0ac097d5547
> --- /dev/null
> +++ b/Documentation/tee/op-tee.rst
> @@ -0,0 +1,166 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================================================
> +OP-TEE (Open Portable Trusted Execution Environment)
> +====================================================
> +
> +The OP-TEE driver handles OP-TEE [1] based TEEs. Currently it is only the ARM
> +TrustZone based OP-TEE solution that is supported.
> +
> +Lowest level of communication with OP-TEE builds on ARM SMC Calling
> +Convention (SMCCC) [2], which is the foundation for OP-TEE's SMC interface
> +[3] used internally by the driver. Stacked on top of that is OP-TEE Message
> +Protocol [4].
> +
> +OP-TEE SMC interface provides the basic functions required by SMCCC and some
> +additional functions specific for OP-TEE. The most interesting functions are:
> +
> +- OPTEE_SMC_FUNCID_CALLS_UID (part of SMCCC) returns the version information
> +  which is then returned by TEE_IOC_VERSION
> +
> +- OPTEE_SMC_CALL_GET_OS_UUID returns the particular OP-TEE implementation, used
> +  to tell, for instance, a TrustZone OP-TEE apart from an OP-TEE running on a
> +  separate secure co-processor.
> +
> +- OPTEE_SMC_CALL_WITH_ARG drives the OP-TEE message protocol
> +
> +- OPTEE_SMC_GET_SHM_CONFIG lets the driver and OP-TEE agree on which memory
> +  range to used for shared memory between Linux and OP-TEE.
> +
> +The GlobalPlatform TEE Client API [5] is implemented on top of the generic
> +TEE API.
> +
> +Picture of the relationship between the different components in the
> +OP-TEE architecture::
> +
> +      User space                  Kernel                   Secure world
> +      ~~~~~~~~~~                  ~~~~~~                   ~~~~~~~~~~~~
> +   +--------+                                             +-------------+
> +   | Client |                                             | Trusted     |
> +   +--------+                                             | Application |
> +      /\                                                  +-------------+
> +      || +----------+                                           /\
> +      || |tee-      |                                           ||
> +      || |supplicant|                                           \/
> +      || +----------+                                     +-------------+
> +      \/      /\                                          | TEE Internal|
> +   +-------+  ||                                          | API         |
> +   + TEE   |  ||            +--------+--------+           +-------------+
> +   | Client|  ||            | TEE    | OP-TEE |           | OP-TEE      |
> +   | API   |  \/            | subsys | driver |           | Trusted OS  |
> +   +-------+----------------+----+-------+----+-----------+-------------+
> +   |      Generic TEE API        |       |     OP-TEE MSG               |
> +   |      IOCTL (TEE_IOC_*)      |       |     SMCCC (OPTEE_SMC_CALL_*) |
> +   +-----------------------------+       +------------------------------+
> +
> +RPC (Remote Procedure Call) are requests from secure world to kernel driver
> +or tee-supplicant. An RPC is identified by a special range of SMCCC return
> +values from OPTEE_SMC_CALL_WITH_ARG. RPC messages which are intended for the
> +kernel are handled by the kernel driver. Other RPC messages will be forwarded to
> +tee-supplicant without further involvement of the driver, except switching
> +shared memory buffer representation.
> +
> +OP-TEE device enumeration
> +-------------------------
> +
> +OP-TEE provides a pseudo Trusted Application: drivers/tee/optee/device.c in
> +order to support device enumeration. In other words, OP-TEE driver invokes this
> +application to retrieve a list of Trusted Applications which can be registered
> +as devices on the TEE bus.
> +
> +OP-TEE notifications
> +--------------------
> +
> +There are two kinds of notifications that secure world can use to make
> +normal world aware of some event.
> +
> +1. Synchronous notifications delivered with ``OPTEE_RPC_CMD_NOTIFICATION``
> +   using the ``OPTEE_RPC_NOTIFICATION_SEND`` parameter.
> +2. Asynchronous notifications delivered with a combination of a non-secure
> +   edge-triggered interrupt and a fast call from the non-secure interrupt
> +   handler.
> +
> +Synchronous notifications are limited by depending on RPC for delivery,
> +this is only usable when secure world is entered with a yielding call via
> +``OPTEE_SMC_CALL_WITH_ARG``. This excludes such notifications from secure
> +world interrupt handlers.
> +
> +An asynchronous notification is delivered via a non-secure edge-triggered
> +interrupt to an interrupt handler registered in the OP-TEE driver. The
> +actual notification value are retrieved with the fast call
> +``OPTEE_SMC_GET_ASYNC_NOTIF_VALUE``. Note that one interrupt can represent
> +multiple notifications.
> +
> +One notification value ``OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF`` has a
> +special meaning. When this value is received it means that normal world is
> +supposed to make a yielding call ``OPTEE_MSG_CMD_DO_BOTTOM_HALF``. This
> +call is done from the thread assisting the interrupt handler. This is a
> +building block for OP-TEE OS in secure world to implement the top half and
> +bottom half style of device drivers.
> +
> +OPTEE_INSECURE_LOAD_IMAGE Kconfig option
> +----------------------------------------
> +
> +The OPTEE_INSECURE_LOAD_IMAGE Kconfig option enables the ability to load the
> +BL32 OP-TEE image from the kernel after the kernel boots, rather than loading
> +it from the firmware before the kernel boots. This also requires enabling the
> +corresponding option in Trusted Firmware for Arm. The Trusted Firmware for Arm
> +documentation [6] explains the security threat associated with enabling this as
> +well as mitigations at the firmware and platform level.
> +
> +There are additional attack vectors/mitigations for the kernel that should be
> +addressed when using this option.
> +
> +1. Boot chain security.
> +
> +   * Attack vector: Replace the OP-TEE OS image in the rootfs to gain control of
> +     the system.
> +
> +   * Mitigation: There must be boot chain security that verifies the kernel and
> +     rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
> +     modifying it in the rootfs.
> +
> +2. Alternate boot modes.
> +
> +   * Attack vector: Using an alternate boot mode (i.e. recovery mode), the
> +     OP-TEE driver isn't loaded, leaving the SMC hole open.
> +
> +   * Mitigation: If there are alternate methods of booting the device, such as a
> +     recovery mode, it should be ensured that the same mitigations are applied
> +     in that mode.
> +
> +3. Attacks prior to SMC invocation.
> +
> +   * Attack vector: Code that is executed prior to issuing the SMC call to load
> +     OP-TEE can be exploited to then load an alternate OS image.
> +
> +   * Mitigation: The OP-TEE driver must be loaded before any potential attack
> +     vectors are opened up. This should include mounting of any modifiable
> +     filesystems, opening of network ports or communicating with external
> +     devices (e.g. USB).
> +
> +4. Blocking SMC call to load OP-TEE.
> +
> +   * Attack vector: Prevent the driver from being probed, so the SMC call to
> +     load OP-TEE isn't executed when desired, leaving it open to being executed
> +     later and loading a modified OS.
> +
> +   * Mitigation: It is recommended to build the OP-TEE driver as builtin driver
> +     rather than as a module to prevent exploits that may cause the module to
> +     not be loaded.
> +
> +References
> +==========
> +
> +[1] https://github.com/OP-TEE/optee_os
> +
> +[2] http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
> +
> +[3] drivers/tee/optee/optee_smc.h
> +
> +[4] drivers/tee/optee/optee_msg.h
> +
> +[5] http://www.globalplatform.org/specificationsdevice.asp look for
> +    "TEE Client API Specification v1.0" and click download.
> +
> +[6] https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_model.html
> diff --git a/Documentation/tee/tee.rst b/Documentation/tee/tee.rst
> new file mode 100644
> index 000000000000..fd9f8c4ff63d
> --- /dev/null
> +++ b/Documentation/tee/tee.rst
> @@ -0,0 +1,22 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================================
> +TEE (Trusted Execution Environment)
> +===================================
> +
> +This document describes the TEE subsystem in Linux.
> +
> +Overview
> +========
> +
> +A TEE is a trusted OS running in some secure environment, for example,
> +TrustZone on ARM CPUs, or a separate secure co-processor etc. A TEE driver
> +handles the details needed to communicate with the TEE.
> +
> +This subsystem deals with:
> +
> +- Registration of TEE drivers
> +
> +- Managing shared memory between Linux and the TEE
> +
> +- Providing a generic API to the TEE
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index 72a65db0c498..24ed39735dd3 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -32,6 +32,7 @@ place where this information is gathered.
>     sysfs-platform_profile
>     vduse
>     futex2
> +   tee
>
>  .. only::  subproject and html
>
> diff --git a/Documentation/userspace-api/tee.rst b/Documentation/userspace-api/tee.rst
> new file mode 100644
> index 000000000000..e2368dbc3451
> --- /dev/null
> +++ b/Documentation/userspace-api/tee.rst
> @@ -0,0 +1,39 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. tee:
> +
> +==================================================
> +TEE (Trusted Execution Environment) Userspace API
> +==================================================
> +
> +include/uapi/linux/tee.h defines the generic interface to a TEE.
> +
> +User space (the client) connects to the driver by opening /dev/tee[0-9]* or
> +/dev/teepriv[0-9]*.
> +
> +- TEE_IOC_SHM_ALLOC allocates shared memory and returns a file descriptor
> +  which user space can mmap. When user space doesn't need the file
> +  descriptor any more, it should be closed. When shared memory isn't needed
> +  any longer it should be unmapped with munmap() to allow the reuse of
> +  memory.
> +
> +- TEE_IOC_VERSION lets user space know which TEE this driver handles and
> +  its capabilities.
> +
> +- TEE_IOC_OPEN_SESSION opens a new session to a Trusted Application.
> +
> +- TEE_IOC_INVOKE invokes a function in a Trusted Application.
> +
> +- TEE_IOC_CANCEL may cancel an ongoing TEE_IOC_OPEN_SESSION or TEE_IOC_INVOKE.
> +
> +- TEE_IOC_CLOSE_SESSION closes a session to a Trusted Application.
> +
> +There are two classes of clients, normal clients and supplicants. The latter is
> +a helper process for the TEE to access resources in Linux, for example file
> +system access. A normal client opens /dev/tee[0-9]* and a supplicant opens
> +/dev/teepriv[0-9].
> +
> +Much of the communication between clients and the TEE is opaque to the
> +driver. The main job for the driver is to receive requests from the
> +clients, forward them to the TEE and send back the results. In the case of
> +supplicants the communication goes in the other direction, the TEE sends
> +requests to the supplicant which then sends back the result.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd5de540ec0b..f20d5fb19ebc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21130,7 +21130,9 @@ M:      Jens Wiklander <jens.wiklander@linaro.org>
>  R:     Sumit Garg <sumit.garg@linaro.org>
>  L:     op-tee@lists.trustedfirmware.org
>  S:     Maintained
> -F:     Documentation/staging/tee.rst
> +F:     Documentation/driver-api/tee.rst
> +F:     Documentation/tee/
> +F:     Documentation/userspace-api/tee.rst
>  F:     drivers/tee/
>  F:     include/linux/tee_drv.h
>  F:     include/uapi/linux/tee.h
> --
> 2.34.1
>
