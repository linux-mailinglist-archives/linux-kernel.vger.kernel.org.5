Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A45797B83
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343777AbjIGSTk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Sep 2023 14:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343715AbjIGSTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:19:36 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEE5171C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:19:21 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 760081CA3D9;
        Thu,  7 Sep 2023 18:19:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 64F5A6000D;
        Thu,  7 Sep 2023 18:19:18 +0000 (UTC)
Message-ID: <80524052652a85d2efdd3e2a01e7582baf9e545b.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: reword long-line warning about
 commit-msg
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, apw@canonical.com,
        Kees Cook <keescook@chromium.org>
Date:   Thu, 07 Sep 2023 11:19:17 -0700
In-Reply-To: <20230907174506.593889-1-jim.cromie@gmail.com>
References: <20230907174506.593889-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 64F5A6000D
X-Stat-Signature: 4zzjrfkr75k8m579ao54tqawuq14eb53
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18JZC6zKE/u/Kl+kHU1TO7mg4gAwibi3BM=
X-HE-Tag: 1694110758-500721
X-HE-Meta: U2FsdGVkX1+WXzfEUpCFUAyWUw/pAfu7vt15dXDH37xMLastwvVS6HMuIJ0nRkv5DFgj2mzjdgarCPHKFZYnZrA68ry+2Dcw8nZi8SxhY7J51qTEIUCvAF6mHjRU2irCLBWPKEAzQSeXspNWT3x300yNDTGWWnY8W+UNlU0ipN33AIvD+T4/IZ6kWCT8NEigruNNmV0jCp87rA0ogoTZuTvVYfMpm88hhmoS5R4eGngHjKjTdmDUZzujrIRORDUgS0YUuaS4FZaWKgVV1z/b7aj5eFFiFzusJOfDpuL0nf9BWrlqX9hey/MVNSs9Jett4zpy2HJU2HC3dBfyvGkRtYT0x9lkigwuBhlqmWHvEZRPGVg5H0j9koneDAFCCOfzuiLUg9/KwrxPWVaHDPGypVatmYsN2B3VXMb6MTKqRhEOkZobaJ2T3SJ+cyi6rWiPFC9Tg+/fGphUG13qduhFiZO/gCafQ6kh6wOZ3lJIJxbNYjuEvMUnkRWycgkurIIT3qnPW3EHWZ0=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-09-07 at 11:45 -0600, Jim Cromie wrote:
> The COMMIT_LOG_LONG_LINE warning complains about:
>  1- possible unwrapped commit description
>  2- line too long
> 
> The actual test is #2, so reword it to say that 1st.
> This could reduce potential confusion for newbie users.

I don't see this as valuable.

> 
> Cc: apw@canonical.com
> Cc: joe@perches.com
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 6aabcc1f66c1..6e789dc07420 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3272,7 +3272,7 @@ sub process {
>  					# A Fixes:, link or signature tag line
>  		      $commit_log_possible_stack_dump)) {
>  			WARN("COMMIT_LOG_LONG_LINE",
> -			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
> +			     "Prefer a maximum 75 chars per line (possible unwrapped commit description?)\n" . $herecurr);
>  			$commit_log_long_line = 1;
>  		}
>  

