Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3B176334C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjGZKTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjGZKTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABADE7;
        Wed, 26 Jul 2023 03:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B3261230;
        Wed, 26 Jul 2023 10:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7101FC433C7;
        Wed, 26 Jul 2023 10:19:42 +0000 (UTC)
Message-ID: <e4808aa1-ed63-fc8e-e3cc-86fd9dd63ee1@xs4all.nl>
Date:   Wed, 26 Jul 2023 12:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 1/2] Added Digiteq Automotive MGB4 driver
Content-Language: en-US
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     tumic@gpxsee.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Martin_T=c5=afma?= <martin.tuma@digiteqautomotive.com>
References: <20230704131339.2177-1-tumic@gpxsee.org>
 <20230704131339.2177-2-tumic@gpxsee.org>
 <bae5dbf6-0f3d-ff66-b4e3-921ab9e042f2@xs4all.nl>
In-Reply-To: <bae5dbf6-0f3d-ff66-b4e3-921ab9e042f2@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 12:08, Hans Verkuil wrote:
> On 04/07/2023 15:13, tumic@gpxsee.org wrote:
>> From: Martin Tůma <martin.tuma@digiteqautomotive.com>
>>
>> Digiteq Automotive MGB4 is a modular frame grabber PCIe card for automotive
>> video interfaces. As for now, two modules - FPD-Link and GMSL - are
>> available and supported by the driver. The card has two inputs and two
>> outputs (FPD-Link only).
>>
>> In addition to the video interfaces it also provides a trigger signal
>> interface and a MTD interface for FPGA firmware upload.
>>
>> Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
>> ---
>>  MAINTAINERS                             |   7 +
>>  drivers/media/pci/Kconfig               |   1 +
>>  drivers/media/pci/Makefile              |   1 +
>>  drivers/media/pci/mgb4/Kconfig          |  17 +
>>  drivers/media/pci/mgb4/Makefile         |   6 +
>>  drivers/media/pci/mgb4/mgb4_cmt.c       | 244 +++++++
>>  drivers/media/pci/mgb4/mgb4_cmt.h       |  17 +
>>  drivers/media/pci/mgb4/mgb4_core.c      | 711 ++++++++++++++++++
>>  drivers/media/pci/mgb4/mgb4_core.h      |  72 ++
>>  drivers/media/pci/mgb4/mgb4_dma.c       | 123 ++++
>>  drivers/media/pci/mgb4/mgb4_dma.h       |  18 +
>>  drivers/media/pci/mgb4/mgb4_i2c.c       | 140 ++++
>>  drivers/media/pci/mgb4/mgb4_i2c.h       |  35 +
>>  drivers/media/pci/mgb4/mgb4_io.h        |  33 +
>>  drivers/media/pci/mgb4/mgb4_regs.c      |  30 +
>>  drivers/media/pci/mgb4/mgb4_regs.h      |  35 +
>>  drivers/media/pci/mgb4/mgb4_sysfs.h     |  18 +
>>  drivers/media/pci/mgb4/mgb4_sysfs_in.c  | 757 +++++++++++++++++++
>>  drivers/media/pci/mgb4/mgb4_sysfs_out.c | 700 ++++++++++++++++++
>>  drivers/media/pci/mgb4/mgb4_sysfs_pci.c |  71 ++
>>  drivers/media/pci/mgb4/mgb4_trigger.c   | 208 ++++++
>>  drivers/media/pci/mgb4/mgb4_trigger.h   |   8 +
>>  drivers/media/pci/mgb4/mgb4_vin.c       | 930 ++++++++++++++++++++++++
>>  drivers/media/pci/mgb4/mgb4_vin.h       |  69 ++
>>  drivers/media/pci/mgb4/mgb4_vout.c      | 594 +++++++++++++++
>>  drivers/media/pci/mgb4/mgb4_vout.h      |  65 ++
>>  26 files changed, 4910 insertions(+)
>>  create mode 100644 drivers/media/pci/mgb4/Kconfig
>>  create mode 100644 drivers/media/pci/mgb4/Makefile
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_cmt.c
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_cmt.h
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_core.c
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_core.h
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_dma.c
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_dma.h
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_i2c.c
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_i2c.h
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_io.h
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_regs.c
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_regs.h
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs.h
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_in.c
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_out.c
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_pci.c
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_trigger.c
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_trigger.h
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_vin.c
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_vin.h
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_vout.c
>>  create mode 100644 drivers/media/pci/mgb4/mgb4_vout.h
>>

<snip>

>> +
>> +	/* Register the video device */
>> +	rv = video_register_device(&vindev->vdev, VFL_TYPE_VIDEO, -1);
>> +	if (rv) {
>> +		dev_err(dev, "failed to register video device\n");
>> +		goto err_v4l2_dev;
>> +	}
>> +
>> +	/* Module sysfs attributes */
>> +	module_attr = MGB4_IS_GMSL(mgbdev)
>> +	  ? mgb4_gmsl_in_attrs : mgb4_fpdl3_in_attrs;
>> +	for (attr = module_attr; *attr; attr++)
>> +		device_create_file(&vindev->vdev.dev, *attr);
> 
> I believe this can be simplified by using ATTRIBUTE_GROUPS and the
> dev_groups field in the struct pci_driver. This will then be automatically
> created and removed.

While this is true for the global PCI attrs, for the per-video device
attrs there is no dev_groups. However, you can still call device_add_groups
and device_remove_groups instead of device_create_file, AFAICT.

That should be a lot easier. Note that you do need to check the error code:
if it fails, then the probe() should fail as well.

Regards,

	Hans

> 
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +	debugfs_init(vindev);
>> +#endif
>> +
>> +	return vindev;
>> +
>> +err_v4l2_dev:
>> +	v4l2_device_unregister(&vindev->v4l2dev);
>> +err_err_irq:
>> +	free_irq(err_irq, vindev);
>> +err_vin_irq:
>> +	free_irq(vin_irq, vindev);
>> +err_alloc:
>> +	kfree(vindev);
>> +
>> +	return NULL;
>> +}

