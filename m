Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E7F7BD0CB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 00:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbjJHWR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 18:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHWRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 18:17:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99C3B3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 15:17:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-69101022969so3532623b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696803443; x=1697408243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XuMhaoUrb8fYypPyU1C5/BlvN3yIac9qvvOq3KXUHNo=;
        b=cJ32DtL8rX3jl6OITyioJQ+6lf5YB09hOHqBjIcG8Tys86Iq6TkiA2Av7Nr0NgeKGt
         2q6yIGhSajPNqd4lXoiYgYr8vpElzQZAWuDXnh9hR3aqT8vkxitRZIsvwET6RVQ4xzwW
         7YH+gIECJmciYuNEcZnF08fFuuBwadV2QVAu28iY0UB5QGhV/wd3tkRIqoOUsdmxW2Iq
         tRzzZ59nUx/2ulv9S0T4iVqfRnu8YNTpvz6L4TsD+k124HrenAWufZb2Bd0JzvmdpRH/
         2tMjVY5g3YziG2yE6xK3z53xXNv/mp7wpo3FjpVF341lp6Iqt4OjHZtI7esJAaqUTm6u
         1X/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696803443; x=1697408243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuMhaoUrb8fYypPyU1C5/BlvN3yIac9qvvOq3KXUHNo=;
        b=iH2BRZVsRNeft0H2TkmIpkzD3IXhejsBOJcczElKuDyCRQNEX/DoQgOlDMu6JUkIug
         RSzFfJKWRmPVBBLrsm3i8LOWXB25JLioUEIBF5MrlBcQiT9bBZ74bSv5l+0MJ6OUU19V
         +1uLfM8UFBF+kvI2SntmHCTxSwp3zzk9NdJ41RTkJVTlp8JlyYqUsVxgXU3CNBdv7ikf
         /Dz/ssUc+JyPwLWVIYTglVB1gG0Y+BDVdAeHPUwazUW6ruMD1Pei8A3fi1vQe+gmg935
         qUjUBlNhOXf4HZrKYlHGK0/m77seokUsyG5aMWpjvtNRRdtbMP+OYjcsGSrKPnTumfne
         w/jw==
X-Gm-Message-State: AOJu0Yw27wsprqtxI1Vd2qMsulEay0VsWcTiI3ANpJm1h5TL59n0cRFf
        lAvCpuWHr+UN7lCUbwjQFWkYeA==
X-Google-Smtp-Source: AGHT+IFpYWNNF7lhghKXd89cNbLnO1b3yGGYgoerjmBJ/CE2yCqc6X/QyLT7+/JjVYeScKQF4hFJFw==
X-Received: by 2002:a05:6a20:394a:b0:154:e887:f581 with SMTP id r10-20020a056a20394a00b00154e887f581mr16324879pzg.58.1696803443275;
        Sun, 08 Oct 2023 15:17:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id z5-20020a633305000000b0057cb5a780ebsm6920676pgz.76.2023.10.08.15.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 15:17:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qpc5P-00BGU3-1i;
        Mon, 09 Oct 2023 09:17:19 +1100
Date:   Mon, 9 Oct 2023 09:17:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2 4/5] xfs: Remove mrlock wrapper
Message-ID: <ZSMqb70f8mHCEaNl@dread.disaster.area>
References: <20231007203543.1377452-1-willy@infradead.org>
 <20231007203543.1377452-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007203543.1377452-5-willy@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 09:35:42PM +0100, Matthew Wilcox (Oracle) wrote:
> mrlock was an rwsem wrapper that also recorded whether the lock was
> held for read or write.  Now that we can ask the generic code whether
> the lock is held for read or write, we can remove this wrapper and use
> an rwsem directly.
> 
> As the comment says, we can't use lockdep to assert that the ILOCK is
> held for write, because we might be in a workqueue, and we aren't able
> to tell lockdep that we do in fact own the lock.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

.....

> @@ -338,10 +338,14 @@ xfs_assert_ilocked(
>  	struct xfs_inode	*ip,
>  	uint			lock_flags)
>  {
> +	/*
> +	 * Sometimes we assert the ILOCK is held exclusively, but we're in
> +	 * a workqueue, so lockdep doesn't know we're the owner.
> +	 */
>  	if (lock_flags & XFS_ILOCK_SHARED)
> -		rwsem_assert_held(&ip->i_lock.mr_lock);
> +		rwsem_assert_held(&ip->i_lock);
>  	else if (lock_flags & XFS_ILOCK_EXCL)
> -		BUG_ON(!ip->i_lock.mr_writer);
> +		__rwsem_assert_held_write(&ip->i_lock);

It took me ages to work out that the comment related to the "__"
variant of rwsem_assert_held_write() function. I really dislike the
use of "__" prefixes for a function with slightly different,
non-obvious semantics to the parent - it's way too subtle for it to
be clear that this is what the comment is refering to.

In this case, we effectively have rwsem_assert_held_write() that
does lockdep checks, and __rwsem_assert_held_write() that does not
do lockdep checks. Either the former needs to say "lockdep" or the
latter needs "nolockdep" in the name to indicate to the reader the
intent of the code calling the checking function....

Otherwise the code looks fine.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
