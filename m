Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB8D7EA6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjKMXUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMXUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:20:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D35099;
        Mon, 13 Nov 2023 15:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/4j86DDfCFRUl31Gseuj9AB7ZukfxQFqBPHzvgr2CKE=; b=es2OXuf1qIGwpTn0rMVYpwoPT6
        BapN0LtveqQJOb5M8mauw2m8LLPvSUv0Ci2hXRaz9cgyfqaFul/il7DFkfuQS2j/K52E4w0zjPR6O
        TSTEVsHn94PgdG8iiDNVU/D44BuuMIc0gN1+F+t3Tx4VLUyE7AYBuiI/qCu+m6yxPEezv9MFmkirl
        /IGPcxgb5o31djmIbVH3PKl6fIlx/O0Au8fWU6YsIeNs4y+IaoKzuQqXUXl59MXX9KiHWYiZuD7It
        erLWHpqodSRlKvfBgbYtUknJPpJdTiE4y6avC9laB8GHDk76zabvt7zTf6TcV6OylwJQuga/RXGIC
        f5e0fuOg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r2gDd-00Ergs-16;
        Mon, 13 Nov 2023 23:19:49 +0000
Message-ID: <ed211ca9-9018-4dc9-91c1-f199fd4dcf11@infradead.org>
Date:   Mon, 13 Nov 2023 15:19:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12] platform/x86: Add Silicom Platform Driver
Content-Language: en-US
To:     Henry Shi <henryshi2018@gmail.com>, hbshi69@hotmail.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        hdegoede@redhat.com, markgross@kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     hb_shi2003@yahoo.com, henrys@silicom-usa.com, wenw@silicom-usa.com
References: <20231113210216.30237-1-henryshi2018@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231113210216.30237-1-henryshi2018@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/13/23 13:02, Henry Shi wrote:
> platform/x86: Add Silicom Platform Driver
> 
> Add Silicom platform (silicom-platform) Linux driver for Swisscom
> Business Box (Swisscom BB) as well as Cordoba family products.
> 
> This platform driver provides support for various functions via
> the Linux LED framework, GPIO framework, Hardware Monitoring (HWMON)
> and device attributes.
> 
> Signed-off-by: Henry Shi <henryshi2018@gmail.com>
> ---

Hi,

An x86_64 defconfig + this driver enabled gives me:


ld: vmlinux.o: in function `silicom_gpio_get':
silicom-platform.c:(.text+0xae6639): undefined reference to `gpiochip_get_data'
ld: vmlinux.o: in function `silicom_gpio_get_direction':
silicom-platform.c:(.text+0xae66a8): undefined reference to `gpiochip_get_data'
ld: vmlinux.o: in function `silicom_gpio_direction_input':
silicom-platform.c:(.text+0xae6888): undefined reference to `gpiochip_get_data'
ld: vmlinux.o: in function `silicom_gpio_set':
silicom-platform.c:(.text+0xae68d3): undefined reference to `gpiochip_get_data'
ld: silicom-platform.c:(.text+0xae68de): undefined reference to `gpiochip_get_data'
ld: vmlinux.o:silicom-platform.c:(.text+0xae69a1): more undefined references to `gpiochip_get_data' follow
ld: vmlinux.o: in function `silicom_platform_probe':
silicom-platform.c:(.init.text+0x656b7): undefined reference to `devm_gpiochip_add_data_with_key'


-- 
~Randy
