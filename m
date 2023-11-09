Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79EF7E6BCE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 14:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjKIN5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 08:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjKIN5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 08:57:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F12B30D7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 05:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699538170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GBKXQXdWCQSxpfyjkGdZqTa17OKF2eWiu4DGtcY18AI=;
        b=AFFyytZbGV4vFFjEqjQGzhwf5pIzjp15FbWIy3i9XQfOlKr90NuGbPX9R+hkjt/bD/cEC8
        3hLKSlETSdLKY5DKLo+3e0ddk348UEZnGKYqKVquR5cgOos44I6fMYOqcN8xtHEbbL18Ab
        QuUjoEkYgHxcoy1mYXFKqx+N22rya78=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-OB4whbXaNJujgmgHF6W0AQ-1; Thu, 09 Nov 2023 08:56:06 -0500
X-MC-Unique: OB4whbXaNJujgmgHF6W0AQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CCA982DFA2;
        Thu,  9 Nov 2023 13:56:06 +0000 (UTC)
Received: from bfoster (unknown [10.22.8.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D287492BE7;
        Thu,  9 Nov 2023 13:56:06 +0000 (UTC)
Date:   Thu, 9 Nov 2023 08:56:45 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] bcachefs: clean up some inconsistent indenting
Message-ID: <ZUzlHZazdx2OlGBO@bfoster>
References: <20231109074815.117232-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109074815.117232-1-jiapeng.chong@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 03:48:15PM +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> fs/bcachefs/journal_io.c:1832 bch2_journal_write_pick_flush() warn: inconsistent indenting.
> 

What does inconsistent indenting mean? Is this complaining about the
conditional logic or the w->noflush assignment?

> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7207
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/bcachefs/journal_io.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
> index f4bc2cdbfdd7..72b0f3972170 100644
> --- a/fs/bcachefs/journal_io.c
> +++ b/fs/bcachefs/journal_io.c
> @@ -1823,16 +1823,13 @@ static int bch2_journal_write_pick_flush(struct journal *j, struct journal_buf *
>  	if (error && test_bit(JOURNAL_NEED_FLUSH_WRITE, &j->flags))
>  		return -EIO;
>  
> -	if (error ||
> -	    w->noflush ||
> -	    (!w->must_flush &&
> -	     (jiffies - j->last_flush_write) < msecs_to_jiffies(c->opts.journal_flush_delay) &&
> -	     test_bit(JOURNAL_MAY_SKIP_FLUSH, &j->flags))) {
> -		     w->noflush = true;
> +	if (error || w->noflush || (!w->must_flush &&
> +	    (jiffies - j->last_flush_write) < msecs_to_jiffies(c->opts.journal_flush_delay) &&
> +	    test_bit(JOURNAL_MAY_SKIP_FLUSH, &j->flags))) {
> +		w->noflush = true;

This line does look whitespace damaged (and I prefer the style with the
first two branches of the if statement on the same line (i.e. 'if (error
|| w->noflush ||'), but breaking up the third bit looks wrong to me. The
purpose of the indentation of the third part of the if statement is to
highlight the compound nature of it. I.e., explicitly starting on a
newline with the same indentation level as the previous statements,
followed by further indentation on the subsequent lines that are
sub-components of that statement helps highlight the logic and make the
code more readable at a glance. So IOW, I suspect this could look
something like:

        if (error || w->noflush ||
            (!w->must_flush &&
             (jiffies - j->last_flush_write) < msecs_to_jiffies(c->opts.journal_flush_delay) &&
             test_bit(JOURNAL_MAY_SKIP_FLUSH, &j->flags))) {
                w->noflush = true;
		...
	} else {
		...

Hm?

Brian

>  		SET_JSET_NO_FLUSH(w->data, true);
>  		w->data->last_seq	= 0;
>  		w->last_seq		= 0;
> -
>  		j->nr_noflush_writes++;
>  	} else {
>  		j->last_flush_write = jiffies;
> -- 
> 2.20.1.7.g153144c
> 
> 

