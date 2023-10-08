Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5F57BD073
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 23:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344732AbjJHV7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 17:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHV7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 17:59:35 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D1A9D
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 14:59:34 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c644a1845cso2722441a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696802373; x=1697407173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHmdmQkdVjsJr88jt1p+1Se8MuMGD/JR3QvlSJrhIZw=;
        b=MTyTl+4FOUG4ZVl94hjQdCwQGnAEmiHO6M3w733h2Z2cBQWuDXpTz78ioFS+l6u3cV
         05SjfnXjcG1E+yPowIr9zgGRlr/WTd11CC7UOQyiY8vgH8PKGKL7BR1z4I5xWT512HBn
         fGKVzl8GCZvik7fsYq+sXEgjDIC21oKwF8BWCPi01UHljPQg80Mr+5Z547+cHYjOxUHO
         0ixG+9QLG580NrewTaYKcVpjBRJOg2h5lAn50iYuS+lobpX9T/F4ZSui0DBg60Ts14Jg
         whY47ll3jm6yYu6m12zm9J9E8lCIaPQ0J1azEmpFaU+cRHlA3VuwcFGgm5cN/pG8GMLu
         hMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696802373; x=1697407173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHmdmQkdVjsJr88jt1p+1Se8MuMGD/JR3QvlSJrhIZw=;
        b=WK1Rl9zck8KgZwV0IRck8BniQEORuWf+GAN9MAA0MU1FmQtjjK8nqiuHH8RhRj++vg
         d3y3vAE1Cq/davaELMZf398oN597naNr1QNWlqIv62PQHvOV+EHnshnXH707sUAcjsbZ
         Z4olwZ/WeSiTa/USTyN+/dHqIO3RBh3ePsDRzrS2F5vxdp5yRGgDeDnQHpgPigCp0BSv
         b6KVLaFuKW6cpvsTNrdwKFJHu5XWUzR5eGX5ZQ24BpYSbpxi+XJxju848hq5lE1NHoUy
         IIkeIYitxuaPy9OwVJ+majdOwNP65ARRYeeb6gk9sQbXilMMFOvzL6rGXuU6NeSdfoOV
         Mbkg==
X-Gm-Message-State: AOJu0Yyd9VO3pF4Sr852BVEqmnDwkNz9epILeeX6bOTdYIDeEodv5kcJ
        VO8WfNB4kvtjO/ra4+ZgqK3yvw==
X-Google-Smtp-Source: AGHT+IGXKMISVyHxuVm+vG9Pt+kBBJaOZcAMf0U1UZVqmJe4rkXuoORfl4tuGE7G0+IUE8CQxCFomg==
X-Received: by 2002:a05:6358:52c2:b0:143:1063:d1ed with SMTP id z2-20020a05635852c200b001431063d1edmr14645362rwz.26.1696802373402;
        Sun, 08 Oct 2023 14:59:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a5d0f00b00263cca08d95sm8772070pji.55.2023.10.08.14.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 14:59:32 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qpboA-00BGGw-1Q;
        Mon, 09 Oct 2023 08:59:30 +1100
Date:   Mon, 9 Oct 2023 08:59:30 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2 3/5] xfs: Replace xfs_isilocked with xfs_assert_locked
Message-ID: <ZSMmQm/DbJQ0/oH9@dread.disaster.area>
References: <20231007203543.1377452-1-willy@infradead.org>
 <20231007203543.1377452-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007203543.1377452-4-willy@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 09:35:41PM +0100, Matthew Wilcox (Oracle) wrote:
> To use the new rwsem_assert_held()/rwsem_assert_held_write(), we can't
> use the existing ASSERT macro.
> 
> xfs_assert_ilocked(ip,  XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL) checks both the
> IOLOCK and the ILOCK are held for write.  xfs_isilocked() only checked
> that the ILOCK was held for write.
> 
> xfs_assert_ilocked() is always on, even if DEBUG or XFS_WARN aren't
> defined.  It's a cheap check, so I don't think it's worth defining
> it away.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
......

> -bool
> -xfs_isilocked(
> +void
> +xfs_assert_ilocked(
>  	struct xfs_inode	*ip,
>  	uint			lock_flags)
>  {
> -	if (lock_flags & (XFS_ILOCK_EXCL|XFS_ILOCK_SHARED)) {
> -		if (!(lock_flags & XFS_ILOCK_SHARED))
> -			return !!ip->i_lock.mr_writer;
> -		return rwsem_is_locked(&ip->i_lock.mr_lock);
> -	}
> -
> -	if (lock_flags & (XFS_MMAPLOCK_EXCL|XFS_MMAPLOCK_SHARED)) {
> -		return __xfs_rwsem_islocked(&VFS_I(ip)->i_mapping->invalidate_lock,
> -				(lock_flags & XFS_MMAPLOCK_SHARED));
> -	}
> -
> -	if (lock_flags & (XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED)) {
> -		return __xfs_rwsem_islocked(&VFS_I(ip)->i_rwsem,
> -				(lock_flags & XFS_IOLOCK_SHARED));
> -	}
> -
> -	ASSERT(0);
> -	return false;
> +	if (lock_flags & XFS_ILOCK_SHARED)
> +		rwsem_assert_held(&ip->i_lock.mr_lock);
> +	else if (lock_flags & XFS_ILOCK_EXCL)
> +		BUG_ON(!ip->i_lock.mr_writer);

		ASSERT(!ip->i_lock.mr_writer);

Otherwise OK.

-Dave.

-- 
Dave Chinner
david@fromorbit.com
