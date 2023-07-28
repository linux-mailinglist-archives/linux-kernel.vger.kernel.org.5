Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CC7766D11
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbjG1MVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjG1MVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:21:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FDA5BB2;
        Fri, 28 Jul 2023 05:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=0vGzHPOHRgwV2rrCJY+z+iKt3Xe22jPI5VspopXK2NU=; b=sJRROBhDfmYmeSmTgTGOt8SFY0
        bDZz3f0wR6a2kXM2ns6izfQ2/JejJbk0fBYT8Z0R6CPDfwN7OE5/+qH4GRXY2K/AX9E6e/bnP3XCL
        ykz6XXNDiF/Z8MGhusNxDfsTVmkBajUdMlg/K0p5ULCtiyLdhEDvcnaLmlOtNUmu+4l+nk/Xs3O+J
        nZG1ZSqdpN9S1DAOySNanAlMYexHD/jIDikdenef6iRzHrnECZd/gwrlGnXPlZ6nTwmmOaOIhLaOq
        XwDbogXsLoRfxOg90WxvFvBE41953j+8Whg0BaJSrN5laJi8jBknbO5Vav6YQsem8sM/q4sHLNzh1
        5x0zbOrQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qPMPZ-003JFK-0x;
        Fri, 28 Jul 2023 12:17:37 +0000
Message-ID: <cefa57cf-2ff1-22f1-5cb3-ce0c04a30c57@infradead.org>
Date:   Fri, 28 Jul 2023 05:17:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/2] soc: loongson2_pm: add power management support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Liu Yun <liuyun@loongson.cn>
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
 <20230728074944.26746-3-zhuyinbo@loongson.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230728074944.26746-3-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/28/23 00:49, Yinbo Zhu wrote:
> +config LOONGSON2_PM
> +	bool "Loongson-2 SoC Power Management Controller Driver"
> +	depends on LOONGARCH && OF
> +	help
> +	 The Loongson-2's power management controller was ACPI, supports ACPI
> +	 S2Idle (Suspend To Idle), ACPI S3 (Suspend To RAM), ACPI S4 (Suspend To
> +	 Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
> +	 (USB, GMAC, PWRBTN, etc.). This driver was to add power management
> +	 controller support that base on dts for Loongson-2 series SoCs.

Kconfig help text should be indented with one tab +2 spaces, as documented
in Documentation/process/coding-style.rst.

thanks.
-- 
~Randy
