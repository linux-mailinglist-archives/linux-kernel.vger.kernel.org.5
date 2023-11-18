Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036DF7EFD30
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 03:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjKRC0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 21:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKRC0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 21:26:42 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5014E10CE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 18:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Evcwlcp3d2PQmMX2IVCecA5yyDwuGfCMof13YLW0yBQ=; b=2nZYVNITdww6ahOBiRFvw7ZRqL
        /lW+cK7eJDD0PkR+eqWUi79C2ikO8+Hd4AiZJ6EhEG7qcg0giT/L0Dxzr+rRDJ1/nCoKCOxJ1mtWL
        HaohPpTlLCCb1Xctuwm0HpV5Mfz2PPajftJnkree3KbX6cVg1RWyY7Y1Vl45HhmO4uz9h5EWne4il
        +HnK+gWsh8Fiyc0Z61RKSyHzibXrJaRpgsNo8iTmp4ee/jIzRhZzkYHX8B8+FW5qVhs5yj1kl8pfV
        1fV3tS8vLCHvgymJxOyIHSQUCsBfqDQJTlvL8uqm39NE3xuAHgUtT8I2bi3FXT8g4dzaiwMjTQv9M
        fVV67VeA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r4B2X-007ijt-17;
        Sat, 18 Nov 2023 02:26:33 +0000
Message-ID: <c40ddfd4-5781-4382-a3f1-c18cbfb22b34@infradead.org>
Date:   Fri, 17 Nov 2023 18:26:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] checkpatch: add judgment condition for Kconfig help test
Content-Language: en-US
To:     Cixi Geng <cixi.geng@linux.dev>, apw@canonical.com, joe@perches.co,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20231116153904.15589-1-cixi.geng@linux.dev>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231116153904.15589-1-cixi.geng@linux.dev>
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

Hi--

On 11/16/23 07:39, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> The has_help only counted the  situation which the patch file add
> a help line, when the config was renamed and  modify description,
> the has_help is zero for the "help" line not added.
> 
> here is one case:
>     the modify file: drivers/iio/adc/Kconfig  line(1047)
> 
>     -config SC27XX_ADC
>     +config SPRD_ADC
>      	tristate "Spreadtrum SC27xx series PMICs ADC"
>      	depends on MFD_SC27XX_PMIC || COMPILE_TEST
>     +	depends on ARCH_SPRD
>      	help
>     -	  Say yes here to build support for the integrated ADC inside the
>     -	  Spreadtrum SC27xx series PMICs.
>     +	  Say yes here to build support for the integrated ADC inside of the
>     +	  Spreadtrum SC27xx and UMPxx series PMICs.
> 
>      	  This driver can also be built as a module. If so, the module
>      	  will be called sc27xx_adc.

OK, I made those changes to that Kconfig file and ran checkpatch.
I didn't get any of the following checkpatch results.

Are you using a current version of checkpatch?

> the checkpatch result:
>     WARNING: please write a help paragraph that fully describes the config symbol
>     #23: FILE: drivers/iio/adc/Kconfig:1050:
>     +config SPRD_ADC
>     +	tristate "Spreadtrum's ADC PMICs driver"
>      	depends on MFD_SC27XX_PMIC || COMPILE_TEST
>     +	depends on ARCH_SPRD
>      	help
>     +	  Say yes here to build support for the integrated ADC inside of the
>     +	  Say yes here to build support for the integrated ADC inside of the
>     +	  Say yes here to build support for the integrated ADC inside of the
>     +	  Spreadtrum SC27xx and UMPxx series PMICs.
> 
>      	  This driver can also be built as a module. If so, the module
>      	  will be called sc27xx_adc.
> 
>     total: 0 errors, 1 warnings, 17 lines checked
> 
> Fixes: b8709bce9089 ("checkpatch: improve Kconfig help test")
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 25fdb7fda112..402009d08505 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3616,7 +3616,7 @@ sub process {
>  					$needs_help = 1;
>  					next;
>  				}
> -				if ($f =~ /^\+\s*help\s*$/) {
> +				if ($f =~ /^\+\s*help\s*$/ || $f =~ /^\s*help\s*$/) {
>  					$has_help = 1;
>  					next;
>  				}

-- 
~Randy
