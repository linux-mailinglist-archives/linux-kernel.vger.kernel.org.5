Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EE976197A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjGYNMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjGYNM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:12:29 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A03E3;
        Tue, 25 Jul 2023 06:12:27 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A54BC37A;
        Tue, 25 Jul 2023 13:12:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A54BC37A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690290746; bh=5u4BZFBu868zKlxsIvE0FHvQW39n/7MPPlnFcfZZr2A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=br4OSV3qtwoxq6/FU1iNU//cKIJW7YnDU4n7dXk8AZoE/9dcF1QS5t7Kqr8uiMgXR
         qM9m2NU1SBoQcK0IGnYwL+szGw2EEftG6qrnuD9G+7aXdCiTTLnVntXKDdaXWR9upr
         VhL/nvvUwcp3Da77dWkMEHcJwM38FKxrNLQMAkiWH2i7t2T5i30mDGz/K6ccpC+4ue
         /NdmXXd/6LG9QFVcpuYdcFFMvzLyWqPlfJbGJKAsb5kfBuKvfV1Z1XHcPB0ZSEvHoW
         i+Clx+j2iBCaZiUlRaW0jcfhLk5folSI/pu/4bn8YgQxn4A4dpc16HyHsGNSte86eC
         nIVwlG2woYGsw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/1] Documentation: core-api: Drop :export: for
 int_log.h
In-Reply-To: <20230725104956.47806-1-andriy.shevchenko@linux.intel.com>
References: <20230725104956.47806-1-andriy.shevchenko@linux.intel.com>
Date:   Tue, 25 Jul 2023 07:12:25 -0600
Message-ID: <87a5vkb0ee.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> The :export: keyword makes sense only for C-files, where EXPORT_SYMBOL()
> might appear. Otherwise kernel-doc may not produce anything out of this
> file.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: f97fa3dcb2db ("lib/math: Move dvb_math.c into lib/math/int_log.c")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Jonathan Corbet <corbet@lwn.net>
> ---
> v2: added tags (Randy, Jonathan), assumed to go via ASoC tree
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

So I still can't take this patch for the reasons described before.  It
looks like Mark took the patch that added the problem, so perhaps he
should be a recipient of this one too?  I'll add him to the CC...

jon
