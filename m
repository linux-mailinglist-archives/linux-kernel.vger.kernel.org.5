Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D977FCDF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353919AbjHQRTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353922AbjHQRSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:18:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D39F2;
        Thu, 17 Aug 2023 10:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=yuukEpdHT3w26tjBLZ94ch3+AyossAxkNwlLBMkIeJU=; b=MsECgaX/Dpte+TElnCzmX2K32E
        UEbDie3QMs0Y2M8dnwHC9Za45UwbdWjfrEcF9+XDwPycs21SEYbGwciPXDQmscqvlDFDdvLGAAzZk
        apmZNpwIeLab/wWCibS4x4Aae3wsWv7N3/3Dx9HbsZcbQxfYEF7IA0IxYDjpFLMEt/Ji32SFb4Voe
        LxEZkFHfZY02ikd91s47/inXZg8f6A/MEPFVmRxkS598aIE6aoEfV/JO/NlkvpE7ph/1kOFhju7Il
        wOzTRQikAHqWaShscTPNOjy6sTlMaDzyIoAXpyrKGd6jj2G4yY6+Bd+SGGGACF7oT2JkGIsJ2FPVp
        YFyeR1lQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWgdo-006s89-19;
        Thu, 17 Aug 2023 17:18:36 +0000
Message-ID: <34aadd62-5b02-753f-0865-f8a07906631c@infradead.org>
Date:   Thu, 17 Aug 2023 10:18:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/1] docs: kernel-parameters: Refer to the correct
 bitmap function
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>
References: <20230817140432.507889-1-andriy.shevchenko@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230817140432.507889-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 07:04, Andy Shevchenko wrote:
> The parser of the CPU lists is bitmap_parselist() that supports
> special notations with the plain numbers. bitmap_parse() never
> supported those and will fail in case one will try it.
> 
> Fixes: b18def121f07 ("bitmap_parse: Support 'all' semantics")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/admin-guide/kernel-parameters.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
> index 073f73880edf..102937bc8443 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -80,7 +80,7 @@ The special case-tolerant group name "all" has a meaning of selecting all CPUs,
>  so that "nohz_full=all" is the equivalent of "nohz_full=0-N".
>  
>  The semantics of "N" and "all" is supported on a level of bitmaps and holds for
> -all users of bitmap_parse().
> +all users of bitmap_parselist().
>  
>  This document may not be entirely up to date and comprehensive. The command
>  "modinfo -p ${modulename}" shows a current list of all parameters of a loadable

-- 
~Randy
