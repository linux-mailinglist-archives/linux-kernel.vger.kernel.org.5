Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C307EA76C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 01:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjKNAUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 19:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKNAUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 19:20:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2119D55;
        Mon, 13 Nov 2023 16:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=sT5hcw46fMNsT+z3O1A9TP5vnaEjS79bqLJh3DzXQBk=; b=hJyRp+Vzp3wE+jgfkpyeRGq+g4
        OYCI5PuZZwADLKs9D69PGS1ZQMLW9Qd/cH2A5pGVd9got/nxXnK2h0T08Hxhr2VC29mKNRvvc74CX
        pUWej/BW+NrUuQiHn+L4vcniyBZnCZKinzGKpjlllM4NKdnrAV0P9HCis+R1MryLK/kferLzfV+lu
        3FFHciT0L8L0hJwZukbiWpInPcb+vRMgqT4SeXNuHp9V3r7X41W6S3UgYKXlNgMViV5T+qK9nHqG+
        92H+NfMDxVWMdI8hkQt27srP72FqjRWKBhSyhyyAqEzKnER2fj7Yq82XRMf2BTmpfxj2iQ/LnYNUn
        ncvVIy/Q==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r2hA5-00EwlM-0J;
        Tue, 14 Nov 2023 00:20:13 +0000
Message-ID: <06567379-aec8-4376-b9b1-3f719716b5ca@infradead.org>
Date:   Mon, 13 Nov 2023 16:20:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12] platform/x86: Add Silicom Platform Driver
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Henry Shi <henryshi2018@gmail.com>, hbshi69@hotmail.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        hdegoede@redhat.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     hb_shi2003@yahoo.com, henrys@silicom-usa.com, wenw@silicom-usa.com
References: <20231113210216.30237-1-henryshi2018@gmail.com>
 <ed211ca9-9018-4dc9-91c1-f199fd4dcf11@infradead.org>
In-Reply-To: <ed211ca9-9018-4dc9-91c1-f199fd4dcf11@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/23 15:19, Randy Dunlap wrote:
> 
> 
> On 11/13/23 13:02, Henry Shi wrote:
>> platform/x86: Add Silicom Platform Driver
>>
>> Add Silicom platform (silicom-platform) Linux driver for Swisscom
>> Business Box (Swisscom BB) as well as Cordoba family products.
>>
>> This platform driver provides support for various functions via
>> the Linux LED framework, GPIO framework, Hardware Monitoring (HWMON)
>> and device attributes.
>>
>> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
>> ---
> 
> Hi,
> 
> An x86_64 defconfig + this driver enabled gives me:
> 
> 
> ld: vmlinux.o: in function `silicom_gpio_get':
> silicom-platform.c:(.text+0xae6639): undefined reference to `gpiochip_get_data'
> ld: vmlinux.o: in function `silicom_gpio_get_direction':
> silicom-platform.c:(.text+0xae66a8): undefined reference to `gpiochip_get_data'
> ld: vmlinux.o: in function `silicom_gpio_direction_input':
> silicom-platform.c:(.text+0xae6888): undefined reference to `gpiochip_get_data'
> ld: vmlinux.o: in function `silicom_gpio_set':
> silicom-platform.c:(.text+0xae68d3): undefined reference to `gpiochip_get_data'
> ld: silicom-platform.c:(.text+0xae68de): undefined reference to `gpiochip_get_data'
> ld: vmlinux.o:silicom-platform.c:(.text+0xae69a1): more undefined references to `gpiochip_get_data' follow
> ld: vmlinux.o: in function `silicom_platform_probe':
> silicom-platform.c:(.init.text+0x656b7): undefined reference to `devm_gpiochip_add_data_with_key'


so add
	depends on GPIOLIB
for this driver.

-- 
~Randy
