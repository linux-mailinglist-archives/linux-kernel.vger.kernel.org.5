Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BBD7932ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 02:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjIFAh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 20:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjIFAh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:37:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FB3199
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 17:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=peMNFRppx4JKrYCZehA0f8BNK7zNufc5EpwG6akHcdk=; b=TQUpp7IhwXYdQJjOweUnIOkBpU
        6mT52Ed7GD9MEbwVwuEaD+IZxusqH7ra9OH0ajFjh3O71Mds5teX0bxpZEh+6+VMUbMkCl8wYA804
        PtiXfLPsBRpfEAddq2o4LkpDbDdQecrQRgddEO4kVFJtSrZwgYmAA8LnqUFXyjBIHXleulj2cveUa
        SfuSktsHZ9CfTchdsVwbyLCY1fMavS8Z2Bu5pp2ogRBxIy7FiRrhxq8GNCwR8VGjIJdOT/pY0T7Ie
        diGlbpdaq2vrIRdR2NlFnRJgtk4eDtlVwTLLGfVrZ5BSz4fd7HeneMFtm84FJT07joFtTw0W4M0u1
        ZlbzLiEg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdgYH-006xjZ-0W;
        Wed, 06 Sep 2023 00:37:49 +0000
Message-ID: <927e9f62-f273-fb90-2374-e6de2de795a4@infradead.org>
Date:   Tue, 5 Sep 2023 17:37:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] soc: loongson2_pm: add dependency on INPUT
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, Liu Yun <liuyun@loongson.cn>,
        kernel test robot <lkp@intel.com>
References: <20230905123629.4510-1-zhuyinbo@loongson.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230905123629.4510-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 9/5/23 05:36, Yinbo Zhu wrote:
> This fixes some undefined references to `input_set_capability' and
> `input_register_device` issue when INPUT is not enabled.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202309030751.pDnTZX4E-lkp@intel.com/
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  drivers/soc/loongson/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
> index 314e13bb3e01c..1b57af1e55298 100644
> --- a/drivers/soc/loongson/Kconfig
> +++ b/drivers/soc/loongson/Kconfig
> @@ -20,6 +20,7 @@ config LOONGSON2_GUTS
>  config LOONGSON2_PM
>  	bool "Loongson-2 SoC Power Management Controller Driver"
>  	depends on LOONGARCH && OF
> +	depends on INPUT
>  	help
>  	  The Loongson-2's power management controller was ACPI, supports ACPI
>  	  S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To

The preferred patch has already been posted:

https://lore.kernel.org/all/16a37f6ad3cc9417b6638c2cd532d88c79468eb1.1693623752.git.zhoubinbin@loongson.cn/

-- 
~Randy
