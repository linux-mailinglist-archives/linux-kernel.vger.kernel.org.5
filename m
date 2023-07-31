Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6924676A486
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjGaXJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGaXJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:09:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB441BDB;
        Mon, 31 Jul 2023 16:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=aPb5lDChIqfPMvwsibTI6iiSscbrWxn/ZOI0E80W52g=; b=t3zStTyTjRAu54dTUV7IgHJULD
        whMKO8pdGNdJNVJKiiZuFAeR+XJUqtjwFS+1W5IKKFkVF0ZxHAPT4camP4YE4GoIyXxiCOZkVf66z
        YV89XyfSzJPKbVczfjOGvZNmHxsWlMztiN9iMqUIzK6NWI4vWbUbxaS6kAt2aqkjL8qoqPKmnLdgg
        C63HPaYGIJwDCYYKVTqVKv9HkVZmbpHt/jDhZH1/cQkWu2w+jzc+VgRgPjDUF5lfpNGpV1Un1639u
        hZ1lU957IFf3i0pHHOrSG+Oc+izDB8GWndZIqCtKfLQUU9fuovAQXxREmec197YUiLv3ce/LZ9ur1
        UKG9m7Yg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQc0p-00HXu0-2W;
        Mon, 31 Jul 2023 23:09:15 +0000
Message-ID: <f07f6326-59cb-d6ee-f327-39bdb3977141@infradead.org>
Date:   Mon, 31 Jul 2023 16:09:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: typec: mux: intel: Add dependency on USB_COMMON
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
References: <20230731131210.43158-1-heikki.krogerus@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230731131210.43158-1-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/23 06:12, Heikki Krogerus wrote:
> This fixes an undefined reference to `usb_debug_root' issue
> when USB_COMMON is not enabled.
> 
> Fixes: 0a453dc9f260 ("usb: typec: intel_pmc_mux: Expose IOM port status to debugfs")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/lkml/c3bb8781-676d-2448-cfbb-62e29f1f570b@infradead.org/
> Cc: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/usb/typec/mux/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
> index 784b9d8107e9b..65da61150ba78 100644
> --- a/drivers/usb/typec/mux/Kconfig
> +++ b/drivers/usb/typec/mux/Kconfig
> @@ -29,6 +29,7 @@ config TYPEC_MUX_INTEL_PMC
>  	tristate "Intel PMC mux control"
>  	depends on ACPI
>  	depends on INTEL_SCU_IPC
> +	select USB_COMMON
>  	select USB_ROLE_SWITCH
>  	help
>  	  Driver for USB muxes controlled by Intel PMC FW. Intel PMC FW can

-- 
~Randy
