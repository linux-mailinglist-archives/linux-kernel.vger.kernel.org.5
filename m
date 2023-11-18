Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8225C7EFF29
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 12:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjKRLHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 06:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKRLHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 06:07:16 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6BFD6A;
        Sat, 18 Nov 2023 03:07:12 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SXWF532Tjz4f3lg2;
        Sat, 18 Nov 2023 19:07:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id 87DF41A0175;
        Sat, 18 Nov 2023 19:07:09 +0800 (CST)
Received: from [10.174.176.83] (unknown [10.174.176.83])
        by APP4 (Coremail) with SMTP id gCh0CgBndUXamlhlYXoxBQ--.553S2;
        Sat, 18 Nov 2023 19:07:09 +0800 (CST)
Message-ID: <bfb801e5-3fa9-8bdf-0a00-23dfe8e41dbe@huaweicloud.com>
Date:   Sat, 18 Nov 2023 19:07:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 -next 1/5] spi: mockup: Add SPI controller testing
 driver
To:     Mark Brown <broonie@kernel.org>
Cc:     zhangxiaoxu5@huawei.com, weiyongjun1@huawei.com,
        rostedt@goodmis.org, mingo@redhat.com, frowand.list@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231104064650.972687-1-zhangxiaoxu@huaweicloud.com>
 <20231104064650.972687-2-zhangxiaoxu@huaweicloud.com>
 <ZUjVBKuviXwM0aiR@finisterre.sirena.org.uk>
From:   huaweicloud <zhangxiaoxu@huaweicloud.com>
In-Reply-To: <ZUjVBKuviXwM0aiR@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBndUXamlhlYXoxBQ--.553S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1DWry8Zr15Zw45Kr4xXrb_yoW8uw1fpF
        WjkF4UtFZ5JF47W3Wq93W8CF13urnIkF4UJw4vga4Skr93uFyfCry3KrWayFyrurWvq34I
        vay2vwn8ZFZ0vrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: x2kd0wp0ld053x6k3tpzhluzxrxghudrp/
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for your review.

Most of the comments have been modified. and the v4 has been sent
to the maillist, as has the KDDV (Kernel Device Driver Verfication)
test framework based on python unittests.

Looking forward for your comments.

Thanks.


在 2023/11/6 19:59, Mark Brown 写道:
> On Sat, Nov 04, 2023 at 02:46:46PM +0800, Zhang Xiaoxu wrote:
> 
>> This is accomplished by executing the following command:
>>
>> $ echo adcxx1s 0 > /sys/class/spi_master/spi0/new_device
> 
> That's not a valid sysfs format, sysfs requires one value per file.
> configfs might be a better fit?
> 
>> +config SPI_MOCKUP
>> +	tristate "SPI controller Testing Driver"
>> +	depends on OF
> 
> Why would this depend on DT?  Given that any test SPI controller is a
> virtual device it should never appear in DT and we probably shouldn't
> require providing DT for the created devices even if we implement
> support for that, only some devices might care.
> `
>> +++ b/drivers/spi/spi-mockup.c
>> @@ -0,0 +1,211 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * SPI controller Testing Driver
>> + *
>> + * Copyright(c) 2022 Huawei Technologies Co., Ltd.
>> + */
> 
> Please keep the entire comment a C++ one so things look more
> intentional.
> 
>> +#define MOCKUP_CHIPSELECT_MAX		8
> 
> Why would we have a hard coded limit here?
When register the spi controller, we need to specify the maximun
number of chips. Modify it to U16_MAX in next version.
> 
>> +	blank = strchr(buf, ' ');
>> +	if (!blank) {
>> +		dev_err(dev, "%s: Extra parameters\n", "new_device");
>> +		return -EINVAL;
>> +	}
> 
> There is no point in using %s to render a constant string.
> 
>> +static const struct of_device_id spi_mockup_match[] = {
>> +	{ .compatible = "spi-mockup", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, spi_mockup_match);
> 
> If we were going to instantiate this via DT we'd need a binding, but as
> I indicated above since this is purely virtual and not even something
> like virtual hardware provided by a VMM but rather just something kernel
> internal we should probably not be using DT at all.  Providing a device
> facing DT interface might be useful, but that's a second stage thing.

