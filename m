Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E001A77E991
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbjHPTVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345822AbjHPTVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:21:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566ED2712;
        Wed, 16 Aug 2023 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=WOFR2dyMXGgZOwEoo4r/Gt4dkAbaIPtVpYgYz2QKgAs=; b=T+BrsXdRCiFOaTl9HYTjeC7onn
        55EMZM5LqF/qaKh15MGH9e44CrEHqARQgmpTMamSyBJe3tj1CGoNNudd/uSabZNEK1j3ugm3P7lfl
        0861tlANnwZNgkt2D3XOowEKW5KYCykbb1M8ZYQiyR4Wc3ytyW8JtnpR/S8+IfA9ZMnJzzhMzEzKl
        yGSJDJDGw35X6l+0C8VdOmAx2puHY3bZXq6g3SGijsKVX1/UjLF+Acba6JayZSqqT5Q+AlOAklepI
        XajZjtLEZKsl0TvrIwUcld9jtcRNvCYaV0LYS3QEAbW2H0SYne/RCOpD7cqzbdavuK21q0KfUtunO
        GAfne/HA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWM58-004sgL-1j;
        Wed, 16 Aug 2023 19:21:26 +0000
Message-ID: <5c8f7140-2121-2468-9b3f-aa8191b3e63c@infradead.org>
Date:   Wed, 16 Aug 2023 12:21:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] media: ivsc: Add ACPI dependency
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>,
        Zhifeng Wang <zhifeng.wang@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20230816133526.3859456-1-sakari.ailus@linux.intel.com>
 <20230816133526.3859456-3-sakari.ailus@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230816133526.3859456-3-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/23 06:35, Sakari Ailus wrote:
> The IVSC driver only works in ACPI systems so make it depend on ACPI.
> 
> Compiling it elsewhere has little if any value.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 29006e196a56 ("media: pci: intel: ivsc: Add CSI submodule")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/media/pci/intel/ivsc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/intel/ivsc/Kconfig b/drivers/media/pci/intel/ivsc/Kconfig
> index ec4ade92f583..413053175df7 100644
> --- a/drivers/media/pci/intel/ivsc/Kconfig
> +++ b/drivers/media/pci/intel/ivsc/Kconfig
> @@ -3,7 +3,7 @@
>  
>  config INTEL_VSC
>  	tristate "Intel Visual Sensing Controller"
> -	depends on INTEL_MEI
> +	depends on INTEL_MEI && ACPI
>  	help
>  	  This adds support for Intel Visual Sensing Controller (IVSC).
>  

-- 
~Randy
