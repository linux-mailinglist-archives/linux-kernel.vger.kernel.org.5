Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9651B7C8CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjJMSLv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMSLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:11:49 -0400
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2194891
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:11:48 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 00A2F4046A;
        Fri, 13 Oct 2023 18:11:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 87C551A;
        Fri, 13 Oct 2023 18:11:43 +0000 (UTC)
Message-ID: <00c37fe04a2910345e71afbfc087f7bcdfe0ca80.camel@perches.com>
Subject: Re: [PATCH] checkpatch: avoid warning about Possible repeated word:
 'Google'
From:   Joe Perches <joe@perches.com>
To:     Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com
Date:   Fri, 13 Oct 2023 11:11:42 -0700
In-Reply-To: <20231013172739.1113964-1-kuba@kernel.org>
References: <20231013172739.1113964-1-kuba@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 87C551A
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: jkszg1qij6axn6grepn69m3g1s6r9t74
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19ewI6DaQcHPUjvYOX3U1PnH6KZG/xgAcQ=
X-HE-Tag: 1697220703-11687
X-HE-Meta: U2FsdGVkX19PdlakIHTQy/LKyk02GMKgIKZhpsAE+Q4BYV9CBbYlSHXpy/YAfR1SmVxtJoI2myoJBznJvg/i11rP8Q8C1XtxFz2nG86pw10K/hPgx//wBxcNOOV/RWzXiE8PCedP1nUNdC7YDz9CIYiNzO0atX2+FnEiO3C/EchkIuH+zH7Pq5jFHvBRzHhRUN6VD6zHUEqGieagZruWm1PrExv4VAVJyfunFeEqniEo7qOXfje6pz8GBL9Z61NJB3vpeawYIPi3L1nl3XJbPaSmiG8zxomO1mowJogmnNKXQEBfxzVyw+jHV8jfNj3gdrgjfeVYKHPiDrVKLM2zVaVyqGN4NptZgkEW6j7Wqf+55dfCS45xiehMHW4rd8V2FWTINO8yOdv9ayWGj/eJYwqaHyIFN0QE9YodBm0f7UZwg5lG9+R5b2KRaHn5ZIRdGCWBfmMszD8AsUXqnqdFr9Nszx5lc+nkq+j/5LobOVracNbZ0zZ4r5WDW4egKGfEA6LY8Pw72zA=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-13 at 10:27 -0700, Jakub Kicinski wrote:
> syzbot stack traces often come with the following line:
> 
>  Hardware name: Google Google Compute Engine/Google Compute Engine...

If you must, you must, but I wonder if code to ignore
syzbot blocks might be more sensible.  I don't see
obvious syzbot start/end block markers though.


> This generates the repeated word warning from checkpatch.
> It hit 49 times in the last 6 months in networking
> (false-positive rate of 0.34%). Mute the warning for "Google",
> there's no other word which comes close to being this clear
> cut false-positive in our traffic.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: apw@canonical.com
> CC: joe@perches.com
> CC: dwaipayanray1@gmail.com
> CC: lukas.bulwahn@gmail.com
> ---
>  scripts/checkpatch.pl | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7d16f863edf1..c99f8f93cb4c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3524,6 +3524,8 @@ sub process {
>  
>  				next if (lc($first) ne lc($second));
>  				next if ($first eq 'long');
> +				# syzbot reports contain "Hardware name: Google Google Compute Engine"
> +				next if ($first eq 'Google');
>  
>  				# check for character before and after the word matches
>  				my $start_char = '';

