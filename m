Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780D47FD19D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjK2JEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjK2JEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:04:34 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3F8F5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:04:40 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c1a75a4b6cso3881712a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701248680; x=1701853480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJkUwFni1tyd1Oj/0WIsU7esF/PDsZcmLt4NR+sDyhA=;
        b=1m7GaBJAX/dBoRSQky6TREt+1U8mO1oI0WgxSpNuoJblzBB03cw5l5PT6qDgruRROw
         m8v07aPBQEdJEZeSiukVl4MwJH2ZDL+SlcdDiUJekhCniVJz45y5CMY1Ul61pvwQ3C3q
         ILs9TPFeFTcu8o8D+s+rfYvBsPcZM0LAocIG0qblC7cr6WCLQQSx9cIRxGn/aW5cLHmx
         jl0ZzQfb78/kTspGnb2HtgVPwmQCDYlylKmQTYdUBeKckNs7SZFS/P2iFGwYt7JAWNgG
         x+f/p7Jkq5zvTJ16ce7XqNmMjOIJXjKP/UETFhA6hakkF6g77YsuGKyprpsM+02HsN2K
         Ju2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701248680; x=1701853480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJkUwFni1tyd1Oj/0WIsU7esF/PDsZcmLt4NR+sDyhA=;
        b=Fr6m3pwb6zMlQnSFC6RfJszqUi+JQhJDkLZpFnkFWo/tEL77Mm+QsrZQWLxsAIbBC7
         zSQEwrHbmAC3l8UxwJ+7lgKw+Fv2DYxM+6x8SLhFPpU6F+2RO4ITQVc+rphJHku6D+CA
         TPaQeN2Huz00/97vsb9iMicDq/4bnCxnK3+1XWhqydQ+y32Vpoky3TqNjvYczzcfqi3p
         iXJPUVuaiCeKFNH7TVi37aQ6Lu27G1T3/lwIlEr6ADkshDyl8/jIZ+Is8eJKaV6DiIv+
         cI/zlSXWlmzH+8XMWKfq2KsrkwQ2RZiBvuxJ8xB6DiAtxodR1hZVu9ksNpZjd/YOnh1V
         8vfA==
X-Gm-Message-State: AOJu0YwDwUZFkwXuxRfgS1W1G61/Ru1OoTUlG8BJyigm1QlN2Y6Gx9/Y
        dp1ok7E5onliHMIo01tELzMWYg==
X-Google-Smtp-Source: AGHT+IHQ7A+ROUiPAUUtY1Bc1W2rd4y42lCFAgTt5oxHaM+7IKovLk3TNzT/G4os+71nI+Fk2jOC8Q==
X-Received: by 2002:a05:6a20:728f:b0:18c:4b7:2da5 with SMTP id o15-20020a056a20728f00b0018c04b72da5mr17600536pzk.54.1701248680233;
        Wed, 29 Nov 2023 01:04:40 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902b48a00b001cfb52ebffesm7939595plr.147.2023.11.29.01.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:04:39 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1r8GUn-001Req-1b;
        Wed, 29 Nov 2023 20:04:37 +1100
Date:   Wed, 29 Nov 2023 20:04:37 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, Ben Myers <bpm@sgi.com>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com, me@jcix.top,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/2] xfs: ensure logflagsp is initialized in
 xfs_bmap_del_extent_real
Message-ID: <ZWb+pR7AvTY8VLRR@dread.disaster.area>
References: <20231129075832.73600-1-zhangjiachen.jaycee@bytedance.com>
 <20231129075832.73600-2-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129075832.73600-2-zhangjiachen.jaycee@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:58:31PM +0800, Jiachen Zhang wrote:
> In the case of returning -ENOSPC, ensure logflagsp is initialized by 0.
> Otherwise the caller __xfs_bunmapi will set uninitialized illegal
> tmp_logflags value into xfs log, which might cause unpredictable error
> in the log recovery procedure.
> 
> Also, remove the flags variable and set the *logflagsp directly, so that
> the code should be more robust in the long run.
> 
> Fixes: 1b24b633aafe ("xfs: move some more code into xfs_bmap_del_extent_real")
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/libxfs/xfs_bmap.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index be62acffad6c..9435bd6c950b 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -5010,7 +5010,6 @@ xfs_bmap_del_extent_real(
>  	xfs_fileoff_t		del_endoff;	/* first offset past del */
>  	int			do_fx;	/* free extent at end of routine */
>  	int			error;	/* error return value */
> -	int			flags = 0;/* inode logging flags */
>  	struct xfs_bmbt_irec	got;	/* current extent entry */
>  	xfs_fileoff_t		got_endoff;	/* first offset past got */
>  	int			i;	/* temp state */
> @@ -5023,6 +5022,8 @@ xfs_bmap_del_extent_real(
>  	uint32_t		state = xfs_bmap_fork_to_state(whichfork);
>  	struct xfs_bmbt_irec	old;
>  
> +	*logflagsp = 0;
> +
>  	mp = ip->i_mount;
>  	XFS_STATS_INC(mp, xs_del_exlist);
>  
> @@ -5048,10 +5049,12 @@ xfs_bmap_del_extent_real(
>  	if (tp->t_blk_res == 0 &&
>  	    ifp->if_format == XFS_DINODE_FMT_EXTENTS &&
>  	    ifp->if_nextents >= XFS_IFORK_MAXEXT(ip, whichfork) &&
> -	    del->br_startoff > got.br_startoff && del_endoff < got_endoff)
> -		return -ENOSPC;
> +	    del->br_startoff > got.br_startoff && del_endoff < got_endoff) {
> +		error = -ENOSPC;
> +		goto done;
> +	}

Now that you've added initialisation of logflagsp, the need for the
error stacking goto pattern goes away completely. Anywhere that has
a "goto done" can be converted to a direct 'return error' call and
the done label can be removed.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
