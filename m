Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540E0752A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjGMS6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjGMS6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:58:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC52710;
        Thu, 13 Jul 2023 11:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=0z5EzOwGbQbebqElaiAJrpnzehONedhO55mzOn/vq8Q=; b=eNbc7UPXXi9ObuXrxVvC8/KD2d
        EkMMFHewXrvVisiYvd5+H8YDdjl/x6rccLYO56fGCiYqQtD8oVy2IyOymS4RPL6TcXuuIOQiV+WZf
        DSG+SoINJTYA10bE8hSoSAoWevm2rZ75zwi8p6Mz3d1dyvozUUtf/BcdMHqplKvHWOPTD3aPbrjTq
        d+ZazugfoOqOXrSI/OZivJqWmioHvFmBrO50GzfavG0OW5I6DZRo9QM+XEvUMII9FVTPTjC616JEF
        SUaeFCIGoIjYQjLv9lr4h9oJC02Q8BOOtBtVg9Hv+10gyJ1u53n6nSzM/O6QxxMJapes8jGTWcIUE
        YPrE4qrQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qK1Vy-004BmK-1g;
        Thu, 13 Jul 2023 18:58:10 +0000
Message-ID: <7622fbbf-1c2e-e137-38d3-aea66f3c88b2@infradead.org>
Date:   Thu, 13 Jul 2023 11:58:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/1] Documentation: core-api: Drop :export: for
 int_log.h
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230713165320.14199-1-andriy.shevchenko@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230713165320.14199-1-andriy.shevchenko@linux.intel.com>
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



On 7/13/23 09:53, Andy Shevchenko wrote:
> The :export: keyword makes sense only for C-files, where EXPORT_SYMBOL()
> might appear. Otherwise kernel-doc may not produce anything out of this
> file.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: f97fa3dcb2db ("lib/math: Move dvb_math.c into lib/math/int_log.c")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/core-api/kernel-api.rst | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
> index a526fbe06f86..ae92a2571388 100644
> --- a/Documentation/core-api/kernel-api.rst
> +++ b/Documentation/core-api/kernel-api.rst
> @@ -166,7 +166,6 @@ Integer log and power Functions
>  -------------------------------
>  
>  .. kernel-doc:: include/linux/int_log.h
> -   :export:
>  
>  .. kernel-doc:: lib/math/int_pow.c
>     :export:

-- 
~Randy
