Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE1E7682A0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 00:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjG2Wnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 18:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjG2Wno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 18:43:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D17311C
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rvV9ode9l3fx4t7SOOpeAqr8dSt6p7igHDDNi81ShG8=; b=ikaZ03vIqu7aBgQOWxtF2nZOBT
        0jLCKGeTPO9K6EIUwaCZ2FuxdhPli6vKBQIcg2ZvErtrx6VGR8YXGIG223jSIOz3R/Hzs+oHTBKJM
        tHyfUCzBvgTeo1ljp8zMR9OZ/7VgKT4s7UnieZWfGxeFUB0RLIKx39LpBIKgAs3JrqS0Ta84E0uxL
        ixjprZTn18xdlpOvsZwIg0QkhwCrkOo/iGWtcwbKMCGveAilDwl6Oeytp6j/0c8AfzkDqQtsQ8rMm
        /TRAfJblFxw5s91+H3D3lHADEpJ9NBU/2DjxGN/G/e14ZxChrtANfXWRCnbd8clXLFiltfqkPZTay
        3glH3EIQ==;
Received: from [2601:1c2:980:9ec0:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qPsef-0098AC-30;
        Sat, 29 Jul 2023 22:43:22 +0000
Message-ID: <fcf22ecc-858a-43d2-9b4b-78e3bc02ef68@infradead.org>
Date:   Sat, 29 Jul 2023 15:43:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/2] soc: hisilicon: Support HCCS driver on Kunpeng SoC
Content-Language: en-US
To:     Huisong Li <lihuisong@huawei.com>, xuwei5@hisilicon.com,
        arnd@arndb.de, krzk@kernel.org, sudeep.holla@arm.com
Cc:     linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, wanghuiqiang@huawei.com,
        tanxiaofei@huawei.com, liuyonglong@huawei.com
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230729082632.43224-1-lihuisong@huawei.com>
 <20230729082632.43224-2-lihuisong@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230729082632.43224-2-lihuisong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/29/23 01:26, Huisong Li wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d73c9e97a237..c9e302c3ff48 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9488,6 +9488,12 @@ S:	Maintained
>  F:	Documentation/ABI/testing/debugfs-hisi-zip
>  F:	drivers/crypto/hisilicon/zip/
>  

This new entry should be between
HISILICON I2C CONTROLLER DRIVER
and
HISILICON LPC BUS DRIVER
to keep the MAINTAINERS file in alphabetical order.

> +HISILICON KUNPENG SOC HCCS DRIVER
> +M:	Huisong Li <lihuisong@huawei.com>
> +S:	Maintained
> +F:	drivers/soc/hisilicon/kunpeng_hccs.c
> +F:	drivers/soc/hisilicon/kunpeng_hccs.h
> +
>  HMM - Heterogeneous Memory Management
>  M:	Jérôme Glisse <jglisse@redhat.com>
>  L:	linux-mm@kvack.org

> diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
> new file mode 100644
> index 000000000000..73a99b8156c9
> --- /dev/null
> +++ b/drivers/soc/hisilicon/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +menu "Hisilicon SoC drivers"
> +	depends on ARCH_HISI || COMPILE_TEST
> +
> +config KUNPENG_HCCS
> +	tristate "HCCS driver on Kunpeng SoC"
> +	depends on ACPI
> +	depends on ARM64 || COMPILE_TEST
> +	help
> +	  The Huawei Cache Coherence System (HCCS) is a multi-chip
> +	  interconnection bus protocol.
> +	  The performance of application may be affected if some hccs

s/hccs/HCCS/ for consistency.

> +	  ports are not in full lane status, have a large number of CRC
> +	  errors and so on.
> +
> +	  Say M here if you want to include support for querying the
> +	  health status and port information of HCCS on Kunpeng SoC.

thanks.

-- 
~Randy
