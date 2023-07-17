Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D17A7562DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGQMfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGQMfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:35:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29131E56;
        Mon, 17 Jul 2023 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=uI/9G3G7T4f36YRNHmjqAGhqu8fowy7O9r6FIhnzxuA=; b=mo5YxrLeBOo1QV0FDIAUKzpPLZ
        rmSg1KnJOHE0l1uFKy+rgilUqy/Uo5D1FP5CYLWS5tw5LLV8/VJs/xibJvXFMVvRh/pOGIkU76dV8
        A0zBQ8i93aH4clGMMVqOjml0jHT5YLYYcBI7DUBwkJN+P93lMlSGQn7YpGNmXWDRq+oQiVLbTsDUR
        vfIGe5YrsIxbm+lZoawQ1tiXiycRd8Paj784jQrlpgk5i6m3hxtFYLD85qEbZD2PseckDhgoCAiqt
        zRnK4gT/aVAdxYA7WINAB1/yRD4L3A5dh6qOIMr6vScXAT5S140+GzQ19p6FtMJ2rhbM+4mNQB1x1
        EVQidmTQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qLNQG-004059-2o;
        Mon, 17 Jul 2023 12:34:27 +0000
Message-ID: <94068cfc-186a-1cac-0f76-77b3b46a85bd@infradead.org>
Date:   Mon, 17 Jul 2023 05:33:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V1 4/5] ASoC: codecs: aw88261 chip register file, data
 type file and Kconfig Makefile
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
        rf@opensource.cirrus.co, shumingf@realtek.com,
        herve.codina@bootlin.com, flatmax@flatmax.com,
        ckeepax@opensource.cirrus.com, doug@schmorgal.com,
        fido_max@inbox.ru, pierre-louis.bossart@linux.intel.com,
        kiseok.jo@irondevice.com, liweilei@awinic.com,
        colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yijiangtao@awinic.com, zhangjianming@awinic.com
References: <20230717115845.297991-1-wangweidong.a@awinic.com>
 <20230717115845.297991-5-wangweidong.a@awinic.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230717115845.297991-5-wangweidong.a@awinic.com>
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



On 7/17/23 04:58, wangweidong.a@awinic.com wrote:
> +config SND_SOC_AW88261
> +	tristate "Soc Audio for awinic aw88261"

	                        Awininc
(as below)

> +	depends on I2C
> +	select CRC8
> +	select REGMAP_I2C
> +	select GPIOLIB
> +	select SND_SOC_AW88261_LIB
> +	help
> +	  this option enables support for aw88261 Smart PA.

	  This

> +	  The Awinic AW88261 is an I2S/TDM input, high efficiency
> +	  digital Smart K audio amplifier with an integrated 10.25V
> +		smart boost convert.

Less indentation on the last line (align it with the previous line).

-- 
~Randy
