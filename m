Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17167790DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjHKNfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjHKNfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:35:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FC330CA;
        Fri, 11 Aug 2023 06:35:13 -0700 (PDT)
Received: from [192.168.100.7] (unknown [39.34.188.71])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7DFD36607247;
        Fri, 11 Aug 2023 14:35:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691760911;
        bh=wWTqUHKBvsZnlOKHdHWeuHapPEJsmt6jPNGdT3SHPtI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=orq9x3eg7xN4TyOAgdyS23eCgbHr8uMTJOeU8YN7E6ovljXmTPqKfGT/Jhu0K6Ivc
         wCYKGCciUJaMwbhS7DLTXQV0UeSrZOHJWcyH+12i+UhzaubUneKKxSAIROko1/oQQM
         /xOInSnzhb8nZjQMoJza+Bi9sB8uF9pwdIEQ8xyikNyuHUSRmulxkF2ngmQpdkPnrM
         qAsPmhkMZHlHocR3X0ojsRB9nN4s8pTOkrIBCmdmTcWvA+9ZkWiTyEUpgRdwh6FfSh
         vu9ZMl9o91JGRrkBmq5tx3Df/Z/dUCKJaPpxTvW5eW32MWhmh15bVWhSH8TCWPschm
         MZBrxFyK+8OEw==
Message-ID: <1690b97a-e19a-18fc-7248-b0bae0757cb7@collabora.com>
Date:   Fri, 11 Aug 2023 18:35:06 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/1] platform/x86/amd/pmf: Use str_on_off() helper
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230811131330.71263-1-andriy.shevchenko@linux.intel.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230811131330.71263-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 6:13 PM, Andy Shevchenko wrote:
> We have a common helper to represent a boolean value as "on"/"off"
> string. Use it for the sake of the unified style.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  drivers/platform/x86/amd/pmf/cnqf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/cnqf.c b/drivers/platform/x86/amd/pmf/cnqf.c
> index 539b186e9027..bc8899e15c91 100644
> --- a/drivers/platform/x86/amd/pmf/cnqf.c
> +++ b/drivers/platform/x86/amd/pmf/cnqf.c
> @@ -8,6 +8,7 @@
>   * Author: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>   */
>  
> +#include <linux/string_choices.h>
>  #include <linux/workqueue.h>
>  #include "pmf.h"
>  
> @@ -399,7 +400,7 @@ static ssize_t cnqf_enable_store(struct device *dev,
>  			amd_pmf_set_sps_power_limits(pdev);
>  	}
>  
> -	dev_dbg(pdev->dev, "Received CnQF %s\n", input ? "on" : "off");
> +	dev_dbg(pdev->dev, "Received CnQF %s\n", str_on_off(input));
>  	return count;
>  }
>  
> @@ -409,7 +410,7 @@ static ssize_t cnqf_enable_show(struct device *dev,
>  {
>  	struct amd_pmf_dev *pdev = dev_get_drvdata(dev);
>  
> -	return sysfs_emit(buf, "%s\n", pdev->cnqf_enabled ? "on" : "off");
> +	return sysfs_emit(buf, "%s\n", str_on_off(pdev->cnqf_enabled));
>  }
>  
>  static DEVICE_ATTR_RW(cnqf_enable);

-- 
BR,
Muhammad Usama Anjum
