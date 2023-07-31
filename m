Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C85576A36B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGaVzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjGaVzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:55:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483FAE7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=FIptszZmgcaYmAx7y0JpsujrAUL7Y7YD2A5iHLSUAmc=; b=2XZUYaS1aVtHllSy4I2iUi3TPL
        ZRA4uuv9UawIzO8BqCzXK1O/YMAPo8dIAVAFlx2FOIaNM+za7ZOG+3bDP4UWcRiIELX+HUzF7/vjf
        e9aD6i+LxcGMRdxx9/0GZcfZOBcjESah5j80fIIehCXQeltrSY6DiWLUyQ5VNrSHmwobF3aqbfTvK
        XOZ14owKxIvCEMuAvtKXAnCcXD7AOXaYx9SHmj+RTy61lg7ZQveVUVlS7zsOGfMVfHXvJWMToiJpD
        ECjkDPe/duKF/q6JwYWLevtVuzK1PrfVMKEWXPtMSym8vTlAKb9BkFx7ItCIYJbIZ5L+oYBqslnUC
        BNeMsSxw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQaqz-00HR71-1d;
        Mon, 31 Jul 2023 21:55:03 +0000
Message-ID: <59512f64-6d7c-14d7-579a-a04572b27cff@infradead.org>
Date:   Mon, 31 Jul 2023 14:54:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] mtd: ubi: provide NVMEM layer over UBI volumes
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <cover.1690823629.git.daniel@makrotopia.org>
 <2bd2368ff137dbac2282f366efa9b5d16046f2f1.1690823629.git.daniel@makrotopia.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2bd2368ff137dbac2282f366efa9b5d16046f2f1.1690823629.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/23 12:14, Daniel Golle wrote:
> diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
> index 2ed77b7b3fcb5..45d939bbfa853 100644
> --- a/drivers/mtd/ubi/Kconfig
> +++ b/drivers/mtd/ubi/Kconfig
> @@ -104,4 +104,16 @@ config MTD_UBI_BLOCK
>  
>  	   If in doubt, say "N".
>  
> +config MTD_UBI_NVMEM
> +	tristate "UBI virtual NVMEM"
> +	default n
> +	depends on NVMEM
> +	help
> +	   This option enabled an additional driver exposing UBI volumes as NVMEM

	               enables

> +	   providers, intended for platforms where UBI is part of the firmware
> +	   specification and used to store also e.g. MAC addresses or board-
> +	   specific Wi-Fi calibration data.
> +
> +	   If in doubt, say "N".

and Kconfig help text should be indented with one tab + 2 spaces
according to coding-style.rst.

> +
>  endif # MTD_UBI

-- 
~Randy
