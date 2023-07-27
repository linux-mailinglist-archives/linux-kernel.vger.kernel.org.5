Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B2B765CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 22:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjG0UHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 16:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjG0UHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 16:07:31 -0400
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9601A1BC6;
        Thu, 27 Jul 2023 13:07:27 -0700 (PDT)
Received: from [192.168.1.109] (44.183.202.62.dynamic.cgnat.res.cust.swisscom.ch [62.202.183.44])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 5E01F2AC9;
        Thu, 27 Jul 2023 21:57:20 +0200 (CEST)
Message-ID: <af722fc4-8255-167b-a4a7-3268bb424627@gpxsee.org>
Date:   Thu, 27 Jul 2023 21:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 1/2] Added Digiteq Automotive MGB4 driver
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Martin_T=c5=afma?= <martin.tuma@digiteqautomotive.com>
References: <20230704131339.2177-1-tumic@gpxsee.org>
 <20230704131339.2177-2-tumic@gpxsee.org>
 <fd6517b1-1bb9-d54e-45c6-87765343f112@xs4all.nl>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <fd6517b1-1bb9-d54e-45c6-87765343f112@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 07. 23 11:14, Hans Verkuil wrote:
> Hi Martin,
> 
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
>>   MAINTAINERS                             |   7 +
>>   drivers/media/pci/Kconfig               |   1 +
>>   drivers/media/pci/Makefile              |   1 +
>>   drivers/media/pci/mgb4/Kconfig          |  17 +
>>   drivers/media/pci/mgb4/Makefile         |   6 +
>>   drivers/media/pci/mgb4/mgb4_cmt.c       | 244 +++++++
>>   drivers/media/pci/mgb4/mgb4_cmt.h       |  17 +
>>   drivers/media/pci/mgb4/mgb4_core.c      | 711 ++++++++++++++++++
>>   drivers/media/pci/mgb4/mgb4_core.h      |  72 ++
>>   drivers/media/pci/mgb4/mgb4_dma.c       | 123 ++++
>>   drivers/media/pci/mgb4/mgb4_dma.h       |  18 +
>>   drivers/media/pci/mgb4/mgb4_i2c.c       | 140 ++++
>>   drivers/media/pci/mgb4/mgb4_i2c.h       |  35 +
>>   drivers/media/pci/mgb4/mgb4_io.h        |  33 +
>>   drivers/media/pci/mgb4/mgb4_regs.c      |  30 +
>>   drivers/media/pci/mgb4/mgb4_regs.h      |  35 +
>>   drivers/media/pci/mgb4/mgb4_sysfs.h     |  18 +
>>   drivers/media/pci/mgb4/mgb4_sysfs_in.c  | 757 +++++++++++++++++++
>>   drivers/media/pci/mgb4/mgb4_sysfs_out.c | 700 ++++++++++++++++++
>>   drivers/media/pci/mgb4/mgb4_sysfs_pci.c |  71 ++
>>   drivers/media/pci/mgb4/mgb4_trigger.c   | 208 ++++++
>>   drivers/media/pci/mgb4/mgb4_trigger.h   |   8 +
>>   drivers/media/pci/mgb4/mgb4_vin.c       | 930 ++++++++++++++++++++++++
>>   drivers/media/pci/mgb4/mgb4_vin.h       |  69 ++
>>   drivers/media/pci/mgb4/mgb4_vout.c      | 594 +++++++++++++++
>>   drivers/media/pci/mgb4/mgb4_vout.h      |  65 ++
>>   26 files changed, 4910 insertions(+)
>>   create mode 100644 drivers/media/pci/mgb4/Kconfig
>>   create mode 100644 drivers/media/pci/mgb4/Makefile
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_cmt.c
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_cmt.h
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_core.c
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_core.h
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_dma.c
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_dma.h
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_i2c.c
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_i2c.h
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_io.h
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_regs.c
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_regs.h
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs.h
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_in.c
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_out.c
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_sysfs_pci.c
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_trigger.c
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_trigger.h
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_vin.c
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_vin.h
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_vout.c
>>   create mode 100644 drivers/media/pci/mgb4/mgb4_vout.h
>>
> 
> When I build with: make W=1 KCFLAGS=-Wmaybe-uninitialized
> 
> I get this warning:
> 
> drivers/media/pci/mgb4/mgb4_vout.c: In function 'mgb4_vout_create':
> drivers/media/pci/mgb4/mgb4_vout.c:473:27: warning: variable 'video' set but not used [-Wunused-but-set-variable]
>    473 |         struct mgb4_regs *video;
>        |                           ^~~~~
> 
> Regards,
> 
> 	Hans

Hi,
Thanks for pointing this out. I was making some minor code cleanup when 
creating the v8 patch and probably missed that. I will fix it in v9.

M.
