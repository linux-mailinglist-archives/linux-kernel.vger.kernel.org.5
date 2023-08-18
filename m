Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDD2781103
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378800AbjHRQxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378856AbjHRQw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:52:57 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AE64214;
        Fri, 18 Aug 2023 09:52:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 04EFE6A2;
        Fri, 18 Aug 2023 16:52:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 04EFE6A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1692377573; bh=iC77jsiqt9OTMQZLVNAikXJw8ZLCx9rN5WouHOG0bVs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fgxlO1WAR4xsh2plaSfuHLt8BibPezOqq8/nB7WWBiHFJs0tvp9R34Qm4lg3ALCFR
         0YV/mgS0TQ3sHFT1ZXsEFxFFWrZy9EfsCDELTFBOFRoXLT+VepRR53giD46GrcQBYL
         O2j72dDGDjaWuX0OjI0/MDn/I0HklnpZlRrf0r8izmTv2KIMHlYcDJ71NSMeGHgzok
         vGi57g8ut4Gcx7G+jRK6d8oy1NHrN4+Exvao2VlJOnmkLf187/kycRq8SV4a7Wd/mM
         6L8Q6S7bPGzPnKvhwO4JQCIXOosOO0DXKuTvPLbJN4ByZCt31cywxJsij+0KIREfOs
         Z2Pt7GIJi2TdA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] docs: kernel-parameters: Refer to the correct
 bitmap function
In-Reply-To: <20230817140432.507889-1-andriy.shevchenko@linux.intel.com>
References: <20230817140432.507889-1-andriy.shevchenko@linux.intel.com>
Date:   Fri, 18 Aug 2023 10:52:52 -0600
Message-ID: <878ra8mgwr.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> The parser of the CPU lists is bitmap_parselist() that supports
> special notations with the plain numbers. bitmap_parse() never
> supported those and will fail in case one will try it.
>
> Fixes: b18def121f07 ("bitmap_parse: Support 'all' semantics")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Applied, thanks.

jon
