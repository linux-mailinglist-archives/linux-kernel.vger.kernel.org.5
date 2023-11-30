Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29F57FFD46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376823AbjK3VKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376386AbjK3VKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:10:36 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5569110E5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:10:42 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-28652d59505so293717a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701378642; x=1701983442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/sRx+Jqf97+NiQ/oo0AK9REAGsSB677imx6VDbBDBPw=;
        b=Km8JtMfxfwYvu/zeg3TFokOr+llQNUz+H/GxvxsWAjDYt6PU9iTzC3WZJB+Eg6vEIL
         c+cuwZ8N2sWDTlLFDZ0NxE5/6n5bblotEgAAIJnZCVlZgy9UvrLgdJZutICxmSYcfRZE
         /sjNFxIc6pe4opf/Gco5ASXmorfGBnTXgYIplE3q4/CD7H1bUdxHQwOfYi0BXuD6tDWa
         KJccNMN8sC6fF+xJn0nb2Ti9a7GFt4ZgEncVQsRNMu/eNWaYVZ+0OunZcoB+wP3r5ky3
         PmgxZVn4Df9AAEFh5pa/Uhs7QemtKkWTcOzbad4Bi+kjdU9Ntq18I+TqrbL3WYAAIi0v
         xBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701378642; x=1701983442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sRx+Jqf97+NiQ/oo0AK9REAGsSB677imx6VDbBDBPw=;
        b=ECKN4pVw08MvOIpnvlcfuCYF7iKA+F2/ftREzDFSKUwnumQWfjG9cx0EzEsnZdl+MF
         /adYpK0kNHyxvnSIq4WvBHfmvuDfYl2bIdkSYtyBpl4tcRRkWSI++TMSQK544U9hRw1Q
         ZPONkOIA6v4ncM99Vi38pI9CDwOGHCooEqAq8I4y4bRJ9WAeLarqZ0C7x8eEPn19ivDi
         Vz01SXjpj7eenAweT2KxVV4yt9v+VhQi08T7euUQkANHXdW6iq4yDcamaQhUvqi9Zs70
         JmDJJla6hLKnagP0DOi3XINtZ5nCiTqaL1xg8wy/GFwvBIdSvrwa2LGGWmZ05K8O6Dn4
         wp/Q==
X-Gm-Message-State: AOJu0YyogEHaOEd3eixTkPHBpGNmp0jdPwD+wUvXdI4jZ4PCNgpVmjNx
        6Y+jvdISLD0ziY33mNeMKR8X+w==
X-Google-Smtp-Source: AGHT+IGvDV12X2Cf2tSiZBcr9G1HEkwxlH7M0D5faUl77dI7BTBzZ5FwmwUTmMZr0vZ2RffJE7o8oQ==
X-Received: by 2002:a17:90b:4b86:b0:286:3074:c632 with SMTP id lr6-20020a17090b4b8600b002863074c632mr4500797pjb.22.1701378641794;
        Thu, 30 Nov 2023 13:10:41 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id kh14-20020a17090b34ce00b002859a1d9fb7sm1768396pjb.2.2023.11.30.13.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:10:41 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1r8oIw-0027MJ-1v;
        Fri, 01 Dec 2023 08:10:38 +1100
Date:   Fri, 1 Dec 2023 08:10:38 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: Re: [RFC 1/7] iomap: Don't fall back to buffered write if the write
 is atomic
Message-ID: <ZWj6Tt1zKUL4WPGr@dread.disaster.area>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <09ec4c88b565c85dee91eccf6e894a0c047d9e69.1701339358.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ec4c88b565c85dee91eccf6e894a0c047d9e69.1701339358.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 07:23:09PM +0530, Ojaswin Mujoo wrote:
> Currently, iomap only supports atomic writes for direct IOs and there is
> no guarantees that a buffered IO will be atomic. Hence, if the user has
> explicitly requested the direct write to be atomic and there's a
> failure, return -EIO instead of falling back to buffered IO.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/iomap/direct-io.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 6ef25e26f1a1..3e7cd9bc8f4d 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -662,7 +662,13 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  			if (ret != -EAGAIN) {
>  				trace_iomap_dio_invalidate_fail(inode, iomi.pos,
>  								iomi.len);
> -				ret = -ENOTBLK;
> +				/*
> +				 * if this write was supposed to be atomic,
> +				 * return the err rather than trying to fall
> +				 * back to buffered IO.
> +				 */
> +				if (!atomic_write)
> +					ret = -ENOTBLK;

This belongs in the caller when it receives an -ENOTBLK from
iomap_dio_rw(). The iomap code is saying "this IO cannot be done
with direct IO" by returning this value, and then the caller can
make the determination of whether to run a buffered IO or not.

For example, a filesystem might still be able to perform an atomic
IO via a COW-based buffered IO slow path. Sure, ext4 can't do this,
but the above patch would prevent filesystems that could from being
able to implement such a fallback....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
