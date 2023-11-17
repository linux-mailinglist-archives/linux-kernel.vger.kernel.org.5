Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BE07EEAD1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345637AbjKQBq5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Nov 2023 20:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345614AbjKQBqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:46:55 -0500
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696FF195
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 17:46:51 -0800 (PST)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay09.hostedemail.com (Postfix) with ESMTP id 00C28807EB;
        Fri, 17 Nov 2023 01:46:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id A6CC420023;
        Fri, 17 Nov 2023 01:46:47 +0000 (UTC)
Message-ID: <1868fc850a1ea5e51c833b68aacce120ad738ab7.camel@perches.com>
Subject: Re: [PATCH] checkpatch: do not require an empty line before error
 injection
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 16 Nov 2023 17:46:46 -0800
In-Reply-To: <20231109075147.2779461-1-senozhatsky@chromium.org>
References: <20231109075147.2779461-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: d8ko5x4sjjiayy6fdqr88chxrbt81e4x
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: A6CC420023
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/sKizmrO9gKq0Ar8O8bFe56cdGutLrTIc=
X-HE-Tag: 1700185607-602356
X-HE-Meta: U2FsdGVkX19+k6GOXjvd9Krdnir1X07UxM2QE+jzwVqKeEsBjjNxbN9JJAfdOS3gf6MUwC3kqxk87uSfoX97eez7Sl7GpmnFXdn+PR269aoHUB0h3C/yoBNMCjuRN4GMurEHLmWhEX5U4T7dqOWFByRkriqQ8RNIJze+jYcJLB7IW1iMjEGWCfcuAbymml6o+E5Kgk42VJY7nbHjrd2lYDUee03Pk+AGujMt8fNxVEvgAgY30cXytflyQR//HLgTkXUt9ARsMsOZBUfk3l6jTYZLowTYmLwQccDoq/bYpToYNpHAHTawFDD0wIkWaO/qfyWlgFOxUj+CyvtsmzhKXR1tuUzdSsO4BAwDPSBXjc43ZiXfYp+mIEkEjpQyQ5gFcU7Hr0nnupVUKruZ8B67Co2GWgKseCXPn48+vRUJJPFkg//M4RdfZMULS02Uvmyi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-09 at 16:51 +0900, Sergey Senozhatsky wrote:
> ALLOW_ERROR_INJECTION macro (just like EXPORT_SYMBOL) can immediately
> follow a function it annotates.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Joe Perches <joe@perches.com>

> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 25fdb7fda112..a94ed6c46a6d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4054,7 +4054,7 @@ sub process {
>  		if ($prevline =~ /^[\+ ]};?\s*$/ &&
>  		    $line =~ /^\+/ &&
>  		    !($line =~ /^\+\s*$/ ||
> -		      $line =~ /^\+\s*(?:EXPORT_SYMBOL|early_param)/ ||
> +		      $line =~ /^\+\s*(?:EXPORT_SYMBOL|early_param|ALLOW_ERROR_INJECTION)/ ||
>  		      $line =~ /^\+\s*MODULE_/i ||
>  		      $line =~ /^\+\s*\#\s*(?:end|elif|else)/ ||
>  		      $line =~ /^\+[a-z_]*init/ ||

