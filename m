Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DEF7EFAF4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346193AbjKQViv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjKQViu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:38:50 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A301EB4;
        Fri, 17 Nov 2023 13:38:46 -0800 (PST)
Received: from localhost (unknown [98.53.138.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 511A72F3;
        Fri, 17 Nov 2023 21:38:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 511A72F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1700257126; bh=W5tY8N48/imd5r1zGRD0zjzk3IIZka96QVIe4cEb5Y4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=S8AMUbZIKQe5sMX6Nl0/3cph3LWhH0DCo0ffGz8eZ12Mp0rm1uNCFhk4g91gnXy+1
         AqkuZySknAANvD1WkXAmTHS/JvcdwqDhHiSWJ8BM7PIs4yf4wBT6aetGbs6sDDZA2d
         82DbZzye7kZgn52xBrR5I52JYpLvY2YBEWzHsJJZe9g+oAA9S0ItnpWG1G0mnBsEWH
         5WJqZHdXu2L/PMJaZkyVCjToH3HCp8XdReAnpUEWw/7DmyJvWvttDs0cTPWI+0oOKW
         GuonAtXayEiMQvn5MBYYwOCrKmSnOdYX15VCmyL6EilYx+3K1u5dTJ9wOK1QN2UhiL
         pLsmd7CsE9gpg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH] Documentation: add tux logo
In-Reply-To: <20231029074207.297663-1-vegard.nossum@oracle.com>
References: <20231029074207.297663-1-vegard.nossum@oracle.com>
Date:   Fri, 17 Nov 2023 14:38:35 -0700
Message-ID: <878r6w83hg.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vegard Nossum <vegard.nossum@oracle.com> writes:

> We already have the logo, let's use it.
>
> Testing: make htmldocs
>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/conf.py                  | 4 ++++
>  Documentation/sphinx-static/custom.css | 6 ++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index d4fdf6a3875a..20bd74edcca9 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -357,6 +357,10 @@ html_sidebars = { '**': ['searchbox.html', 'kernel-toc.html', 'sourcelink.html']
>  if html_theme == 'alabaster':
>      html_sidebars['**'].insert(0, 'about.html')
>  
> +# The name of an image file (relative to this directory) to place at the top
> +# of the sidebar.
> +html_logo = 'images/logo.svg'
> +
>  # Output file base name for HTML help builder.
>  htmlhelp_basename = 'TheLinuxKerneldoc'
>  
> diff --git a/Documentation/sphinx-static/custom.css b/Documentation/sphinx-static/custom.css
> index 084a884f6fb7..56653f73d8f9 100644
> --- a/Documentation/sphinx-static/custom.css
> +++ b/Documentation/sphinx-static/custom.css
> @@ -20,6 +20,12 @@ div.document {
>      width: auto;
>  }
>  
> +/* Size the logo appropriately */
> +img.logo {
> +    width: 104px;
> +    margin-bottom: 20px;
> +}
> +
>  /*
>   * Parameters for the display of function prototypes and such included
>   * from C source files.

Applied, thanks.

jon
