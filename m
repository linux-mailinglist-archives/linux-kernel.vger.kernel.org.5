Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794E97C048E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343970AbjJJT0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbjJJTZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:25:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A617D6C;
        Tue, 10 Oct 2023 12:24:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960DDC433C9;
        Tue, 10 Oct 2023 19:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696965870;
        bh=OaUT113OyEWZGUuz0QanPBBQlM+TNKNCSR8UWh97s4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzH52Z7aff0PLm//rj5X1M7cPqIlNkK7SLMktoACnl6QnQWNaa0dU6ixCQEV0y5oM
         +r6Yl/2FrXGlupfrbBNdkztXv//SemcHc57So/T85eOqDdtEvu2nesyD/PF4T2kKBJ
         6zIDgoLhWG3ilgaPqEsqUCmIvJq5SkCsQef7P0d0=
Date:   Tue, 10 Oct 2023 21:24:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     linux@roeck-us.net, joe@perches.com,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation/process/coding-style.rst: space around
 const
Message-ID: <2023101018-eggnog-unsavory-1ba6@gregkh>
References: <20231010125832.1002941-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010125832.1002941-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 02:58:31PM +0200, Max Kellermann wrote:
> There are currently no rules on the placement of "const", but a recent
> code submission revealed that there is clearly a preference for spaces
> around it.
> 
> checkpatch.pl has no check at all for this; though it does sometimes
> complain, but only because it erroneously thinks that the "*" (on
> local variables) is an unary dereference operator, not a pointer type.
> 
> Current coding style for const pointers-to-pointers:
> 
>  "*const*": 2 occurrences
>  "* const*": 3
>  "*const *": 182
>  "* const *": 681
> 
> Just const pointers:
> 
>  "*const": 2833 occurrences
>  "* const": 16615
> 
> Link: https://lore.kernel.org/r/264fa39d-aed6-4a54-a085-107997078f8d@roeck-us.net/
> Link: https://lore.kernel.org/r/f511170fe61d7e7214a3a062661cf4103980dad6.camel@perches.com/
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> V1 -> V2: removed "volatile" on gregkh's request.
> V2 -> V3: moved patch changelog below the "---" line
> ---
>  Documentation/process/coding-style.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 6db37a46d305..71d62d81e506 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -271,6 +271,17 @@ adjacent to the type name.  Examples:
>  	unsigned long long memparse(char *ptr, char **retptr);
>  	char *match_strdup(substring_t *s);
>  
> +Use space around the ``const`` keyword (except when adjacent to
> +parentheses).  Example:
> +
> +.. code-block:: c
> +
> +	const void *a;
> +	void * const b;
> +	void ** const c;
> +	void * const * const d;
> +	int strcmp(const char *a, const char *b);
> +
>  Use one space around (on each side of) most binary and ternary operators,
>  such as any of these::
>  
> -- 
> 2.39.2
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
