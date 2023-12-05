Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF59A804ADB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbjLEHBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjLEHBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:01:52 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042CE11F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 23:01:58 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b845ba9ba9so3352641b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 23:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701759717; x=1702364517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WHU/5DxAV5pvSXplC2cxt/UjGS3r4Zdun9PgLyN7QY=;
        b=xkuupgjne468/xDrloQG3j70wdp/YRLRTn6Lhl7XN7iec2+FtWsavNmvWimHh34NsS
         0p+1vo1JW4qv5wLLLaW9Eda3phiFM1MxucExFILcs+QnDf1N1JrZgKM16ZRnWTcJVTaw
         h1z6IQpm61yaPALqyhiaCro0HMijsK6M2JbN6Infm9u3Xd64Fg/Vb8lhIyIO4esOH6Xq
         XTSzklRMUcGOCrV0JeKShYcrGVzHQJlqCLVP2cDnXofGiWufgJJVMROGR1VAIbVbSbe3
         hRJJgk6T4likZuD9PWppoLtSsnZWrotkXJoFyINfI4+kwHZdUjGhp5DHayyAsYPuLu3n
         Uypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701759717; x=1702364517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WHU/5DxAV5pvSXplC2cxt/UjGS3r4Zdun9PgLyN7QY=;
        b=d1KFzhbIafFqAWAaT3ZtzUwMAka4Wxp6WaiIjmTO8j/MrCN8Xb84goPVeUhxVAl4sR
         X1DPXozQFeytD7ovnFXZ8A7GhN+kG035QXVAU+EwSzBRpc7NKm1++1OhRcuKhGrfyOud
         S+VwtoDcmubH9Mp5lRuGTVtfYUE+h4oMmmu4efJGAI9uxnwEkysfZIy+f/P6X3rv8ZCd
         MUpmIx0fyHRtlkWAxRXql/lqCBet3is+o0IIpO8x/megrSuiEaRKUU5wIZBlEgOv8FQZ
         PJy9Aq8/Zw8ZFmjUCbciZNbroMl7kFeE+49ytVMwPep8YCu+jRKofNeIQJfUZ6O+zEAS
         VAwQ==
X-Gm-Message-State: AOJu0Yz/s2HhKioRabmAmZ8IoJE93dnYBc+WdWzYqySWnCk/6HiQcKys
        G6/YU2boZYMFrKW1LWfzA3c2hA==
X-Google-Smtp-Source: AGHT+IFgJFUGIFJjewT8kTEELs0n4UFfcQ+u/MO6g5eqAMkbJACtIfGGkXoPdnvg0FEz3dtP8TQpZg==
X-Received: by 2002:a05:6871:4318:b0:1fb:75c:3fea with SMTP id lu24-20020a056871431800b001fb075c3feamr6891719oab.74.1701759715826;
        Mon, 04 Dec 2023 23:01:55 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id v4-20020a634644000000b0058901200bbbsm8671692pgk.40.2023.12.04.23.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 23:01:55 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1rAPRJ-0044q7-0q;
        Tue, 05 Dec 2023 18:01:53 +1100
Date:   Tue, 5 Dec 2023 18:01:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] pstore: inode: Convert mutex usage to guard(mutex)
Message-ID: <ZW7K4Up79Ablsoqc@dread.disaster.area>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202212217.243710-2-keescook@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 01:22:12PM -0800, Kees Cook wrote:
> Replace open-coded mutex handling with cleanup.h guard(mutex) and
> scoped_guard(mutex, ...).
> 
> Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/pstore/inode.c | 76 +++++++++++++++++++----------------------------
>  1 file changed, 31 insertions(+), 45 deletions(-)

This doesn't really feel like an improvement. WE've gone from
clearly defined lock/unlock pairings to macro wrapped code that
hides scoping from the reader.

I'm going to have to to continually remind myself that this weird
looking code doesn't actually leak locks just because it returns
from a function with a lock held. That's 20 years of logic design
and pattern matching practice I'm going to have to break, and I feel
that's going to make it harder for me to maintain and review code
sanely as a result.

> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 20f3452c8196..0d89e0014b6f 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -180,25 +180,21 @@ static int pstore_unlink(struct inode *dir, struct dentry *dentry)
>  {
>  	struct pstore_private *p = d_inode(dentry)->i_private;
>  	struct pstore_record *record = p->record;
> -	int rc = 0;
>  
>  	if (!record->psi->erase)
>  		return -EPERM;
>  
>  	/* Make sure we can't race while removing this file. */
> -	mutex_lock(&records_list_lock);
> -	if (!list_empty(&p->list))
> -		list_del_init(&p->list);
> -	else
> -		rc = -ENOENT;
> -	p->dentry = NULL;
> -	mutex_unlock(&records_list_lock);
> -	if (rc)
> -		return rc;
> -
> -	mutex_lock(&record->psi->read_mutex);
> -	record->psi->erase(record);
> -	mutex_unlock(&record->psi->read_mutex);
> +	scoped_guard(mutex, &records_list_lock) {
> +		if (!list_empty(&p->list))
> +			list_del_init(&p->list);
> +		else
> +			return -ENOENT;
> +		p->dentry = NULL;
> +	}
> +
> +	scoped_guard(mutex, &record->psi->read_mutex)
> +		record->psi->erase(record);

And now we combine the new-fangled shiny with a mechanical change
that lacks critical thinking about the logic of the code.  Why drop
the mutex only to have to pick it back up again when the scoping
handles the error case automatically? i.e.:

	scoped_guard(mutex, &records_list_lock) {
		if (!list_empty(&p->list))
			list_del_init(&p->list);
		else
			return -ENOENT;
		p->dentry = NULL;
		record->psi->erase(record);
	}

Not a fan of the required indenting just for critical sections;
this will be somewhat nasty when multiple locks need to be take.

> @@ -317,19 +310,19 @@ int pstore_put_backend_records(struct pstore_info *psi)
>  	if (!root)
>  		return 0;
>  
> -	mutex_lock(&records_list_lock);
> -	list_for_each_entry_safe(pos, tmp, &records_list, list) {
> -		if (pos->record->psi == psi) {
> -			list_del_init(&pos->list);
> -			rc = simple_unlink(d_inode(root), pos->dentry);
> -			if (WARN_ON(rc))
> -				break;
> -			d_drop(pos->dentry);
> -			dput(pos->dentry);
> -			pos->dentry = NULL;
> +	scoped_guard(mutex, &records_list_lock) {
> +		list_for_each_entry_safe(pos, tmp, &records_list, list) {
> +			if (pos->record->psi == psi) {
> +				list_del_init(&pos->list);
> +				rc = simple_unlink(d_inode(root), pos->dentry);
> +				if (WARN_ON(rc))
> +					break;
> +				d_drop(pos->dentry);
> +				dput(pos->dentry);
> +				pos->dentry = NULL;
> +			}
>  		}
>  	}
> -	mutex_unlock(&records_list_lock);

This doesn't even save a line of code - there's no actual scoping
needed here because there is no return from within the loop. But
with a scoped guard we have to add an extra layer of indentation.
Not a fan of that, either.

> @@ -449,9 +439,8 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
>  	if (!sb->s_root)
>  		return -ENOMEM;
>  
> -	mutex_lock(&pstore_sb_lock);
> -	pstore_sb = sb;
> -	mutex_unlock(&pstore_sb_lock);
> +	scoped_guard(mutex, &pstore_sb_lock)
> +		pstore_sb = sb;
>  
>  	pstore_get_records(0);
>  
> @@ -466,17 +455,14 @@ static struct dentry *pstore_mount(struct file_system_type *fs_type,
>  
>  static void pstore_kill_sb(struct super_block *sb)
>  {
> -	mutex_lock(&pstore_sb_lock);
> +	guard(mutex)(&pstore_sb_lock);
>  	WARN_ON(pstore_sb && pstore_sb != sb);
>  
>  	kill_litter_super(sb);
>  	pstore_sb = NULL;
>  
> -	mutex_lock(&records_list_lock);
> +	guard(mutex)(&records_list_lock);
>  	INIT_LIST_HEAD(&records_list);
> -	mutex_unlock(&records_list_lock);
> -
> -	mutex_unlock(&pstore_sb_lock);
>  }

And this worries me, because guard() makes it harder to see
where locks are nested and the scope they apply to. At least with
lock/unlock pairs the scope of the critical sections and the
nestings are obvious.

So, yeah, i see that there is a bit less code with these fancy new
macros, but I don't think it's made the code is easier to read and
maintain at all.

Just my 2c worth...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
