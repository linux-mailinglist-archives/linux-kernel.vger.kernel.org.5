Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D660475336A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjGNHqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjGNHp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:45:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E37D2D78;
        Fri, 14 Jul 2023 00:45:53 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so3221158a12.1;
        Fri, 14 Jul 2023 00:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689320751; x=1691912751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6vuG3HQkEQ7VNeSQ5xmh1TS6CjzB/10WVd0XG/5aiY=;
        b=gjzet+3EtfmPg0tf8IJHdcqio4lk8hH5r0xGb3jPub9rRkdCMPlN07kjBsFMoNgcUl
         9scbBglIZZafZTLDAVubtwb6YTanXfnEwyUEE3Xu9iU5qB+whYOrbNEf2ssOHEqvKdeG
         KC8Fule84HyTin/rpOsFjWQ2PzioUgoterzvoTE5x15sm5L2Pg0UtE4dkeixAfjLmJmw
         7BUdczbiPnmAM3KnW3ox/dM3xHSlKpcK5eF8Ce6hgLFRp72tDCyneWEOh9w12AX2ZzAp
         RmVGFDyypB4Tt8gw880ZKOmFh5s0a30KiULcXr8YnPHrT3HuFjh3Whv9ZPZhrOLVxlQ6
         DLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689320751; x=1691912751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6vuG3HQkEQ7VNeSQ5xmh1TS6CjzB/10WVd0XG/5aiY=;
        b=kEns4YZnDS85ecoaXpVOe98NnZjd9Fhof63xzf9W2bl6V1+YJxud64IESSWktI0YFZ
         H3qkSTwPU48E6terwVxmlnnZVYkOtD2jR+5uwpEqKm83OLTWtVS3jY/ZAYmTHws3/T1O
         5aOndXgRIE8CY4X203WuvEIiWfYEOfDUxaNp+S6Qu06hVAAWD6AL3e9zJmgjEBuuRyOn
         sOuMhYwjX5slUUg16BIE1h6izLfC9E8yh6AVo+u7+tn8Y063+JnVE+VrgxexQ1HshST5
         0JqlIHZvDycA9yHKfBc4oGKNWG/Wwt9J1z4ac5eAadljqNYabNi+YGNnsjihnjbh0K0X
         SYaA==
X-Gm-Message-State: ABy/qLaYRTGbD9B1ctUoWYlVmCZhFy28NlvSPq0XZt3sWoEWMTQ3kfFZ
        rTqPLxV9sfI8xSyZPGbnv9U=
X-Google-Smtp-Source: APBJJlE9LmJVESEldeBsjKBFMJhkXTV0WWWDsVr7FqxjeFyNg3BVE+QDcTnHHM2SkLqoXFEitTeN4A==
X-Received: by 2002:a05:6402:518f:b0:51e:4218:b91b with SMTP id q15-20020a056402518f00b0051e4218b91bmr2404203edd.1.1689320750718;
        Fri, 14 Jul 2023 00:45:50 -0700 (PDT)
Received: from ?IPV6:2a00:e180:156e:8700:817e:6375:6a13:2da9? ([2a00:e180:156e:8700:817e:6375:6a13:2da9])
        by smtp.gmail.com with ESMTPSA id n1-20020a056402514100b0051e2cde9e3esm5419862edd.75.2023.07.14.00.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 00:45:50 -0700 (PDT)
Message-ID: <942c0138-e264-88c0-ebb1-cce0604d74ff@gmail.com>
Date:   Fri, 14 Jul 2023 09:45:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Linaro-mm-sig] Re: [PATCH v3] misc: sram: Add DMA-BUF Heap
 exporting of SRAM areas
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Davis <afd@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        John Stultz <jstultz@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20230713191316.116019-1-afd@ti.com>
 <2023071308-squeeze-hamster-d02f@gregkh>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <2023071308-squeeze-hamster-d02f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.07.23 um 21:28 schrieb Greg Kroah-Hartman:
> On Thu, Jul 13, 2023 at 02:13:16PM -0500, Andrew Davis wrote:
>> This new export type exposes to userspace the SRAM area as a DMA-BUF Heap,
>> this allows for allocations of DMA-BUFs that can be consumed by various
>> DMA-BUF supporting devices.
> What devices exactly?
>
> And what userspace tools/programs are going to use this api?
>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>
>> Changes from v2:
>>   - Make sram_dma_heap_allocate static (kernel test robot)
>>   - Rebase on v6.5-rc1
>>
>>   drivers/misc/Kconfig         |   7 +
>>   drivers/misc/Makefile        |   1 +
>>   drivers/misc/sram-dma-heap.c | 245 +++++++++++++++++++++++++++++++++++
>>   drivers/misc/sram.c          |   6 +
>>   drivers/misc/sram.h          |  16 +++
>>   5 files changed, 275 insertions(+)
>>   create mode 100644 drivers/misc/sram-dma-heap.c
>>
>> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
>> index 75e427f124b28..ee34dfb61605f 100644
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -448,6 +448,13 @@ config SRAM
>>   config SRAM_EXEC
>>   	bool
>>   
>> +config SRAM_DMA_HEAP
>> +	bool "Export on-chip SRAM pools using DMA-Heaps"
>> +	depends on DMABUF_HEAPS && SRAM
>> +	help
>> +	  This driver allows the export of on-chip SRAM marked as both pool
>> +	  and exportable to userspace using the DMA-Heaps interface.
> Module name?
>
>>   config DW_XDATA_PCIE
>>   	depends on PCI
>>   	tristate "Synopsys DesignWare xData PCIe driver"
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index f2a4d1ff65d46..5e7516bfaa8de 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -47,6 +47,7 @@ obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
>>   obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
>>   obj-$(CONFIG_SRAM)		+= sram.o
>>   obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
>> +obj-$(CONFIG_SRAM_DMA_HEAP)	+= sram-dma-heap.o
>>   obj-$(CONFIG_GENWQE)		+= genwqe/
>>   obj-$(CONFIG_ECHO)		+= echo/
>>   obj-$(CONFIG_CXL_BASE)		+= cxl/
>> diff --git a/drivers/misc/sram-dma-heap.c b/drivers/misc/sram-dma-heap.c
>> new file mode 100644
>> index 0000000000000..c054c04dff33e
>> --- /dev/null
>> +++ b/drivers/misc/sram-dma-heap.c
>> @@ -0,0 +1,245 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * SRAM DMA-Heap userspace exporter
>> + *
>> + * Copyright (C) 2019-2022 Texas Instruments Incorporated - https://www.ti.com/
>> + *	Andrew Davis <afd@ti.com>
> It's 2023 :(
>
> And this needs review from the dma-buf maintainers before I could do
> anything with it.

Yeah, agree. Thanks Greg.

It would be nice if you explicitly CC the maintainers for DMA-buf and 
DMA-buf heaps as well.

Of hand I can only find the version from 2020 in the LKML archives.

Regards,
Christian.

>
> thanks,
>
> greg k-h
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org

