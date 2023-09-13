Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE8E79F5A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjIMXmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjIMXmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:42:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B56CE4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:42:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-271d9823cacso327298a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694648527; x=1695253327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HT6xU4tcW9TDIgRseOglxWcshJSQ3PvzbPijNp+n/YM=;
        b=3BgSZApF8fulkKRzZz5/WiO/dNF//D9ckcHVTAP0DuwzFRxjE+8T5p0uy7KRg675Vd
         /rfD1e9NVXUguk11Wl2qxlRQtq+fWi+tRHZ2FcyiqWMHytRxUasup3yi25TZl2jLV8l6
         rCZdW2B2lPsKPNYMsa+nLf4v2GfKJ8fFoAe/YJAI0nw2kTrZABUYB6cXhvxyChZmwXgo
         yIjQjDw3ACBG/avQzbbUaN0TrhMP1Sq4F3iSUCN02UgmWgP2qQUJ1RMnUN5Zk9UrQGWR
         1vIu85mubDqcVY2pg8XCo6YrJ8o/OmxVL/8OSTIcWduGKMT7hLCtNaNdJlYA9Qx/ph8c
         nXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694648527; x=1695253327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HT6xU4tcW9TDIgRseOglxWcshJSQ3PvzbPijNp+n/YM=;
        b=K4NlMy/MghLKiTT3jXwG05WLusQVl5jkwdr5usXNNmGn2LhpLHDG0KZ4a+cVUR6TTT
         1+5RIdf2mHPB16ICWoNLabRPeLb59t2tucPUcL0dc9ZEPfQWo0I0M9bVQPpl05LnafBB
         K+sRIBcTwdEG7Np96p7mLep0HaxAnViUJXj1ysWPusM45FIGn7zqejoOHVjCiX6us2n+
         pYRAt9au/glstN+mmzJ1P3Wlll+ZkXPL4HOuS7sjL6wEqIYhiQTgZS7wyUTflCGVAce7
         uTuhV4qoTSmN4fRQd3cl9nVrxAwilVvHFufUngeEN7L8QMD1RErQRYHxySWQVscZL9RD
         yqww==
X-Gm-Message-State: AOJu0YwM1HmXzPd7kBj/ZC+IruwJmW9XISzjM48WTmQNfDLPlhl1pdOp
        +KsDEtFWzFt1HNrjul1MRnsleg==
X-Google-Smtp-Source: AGHT+IHz1WCst6sngICBQcPJgsLGPu0AvmTkYv4volpjgPuDZ3LR/WLjbLP+KTjhIC45BB1wiR9xIg==
X-Received: by 2002:a17:90a:ab8d:b0:25f:20f:2f7d with SMTP id n13-20020a17090aab8d00b0025f020f2f7dmr3864635pjq.2.1694648527552;
        Wed, 13 Sep 2023 16:42:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id ne10-20020a17090b374a00b002633fa95ac2sm1984921pjb.13.2023.09.13.16.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 16:42:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qgZUh-000Nj6-0s;
        Thu, 14 Sep 2023 09:42:03 +1000
Date:   Thu, 14 Sep 2023 09:42:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     cheng.lin130@zte.com.cn
Cc:     djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [PATCH v3] xfs: introduce protection for drop nlink
Message-ID: <ZQJIyx419cw24ppF@dread.disaster.area>
References: <202309131744458239465@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309131744458239465@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 05:44:45PM +0800, cheng.lin130@zte.com.cn wrote:
> From: Cheng Lin <cheng.lin130@zte.com.cn>
> 
> When abnormal drop_nlink are detected on the inode,
> shutdown filesystem, to avoid corruption propagation.
> 
> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> ---
>  fs/xfs/xfs_inode.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 9e62cc500..40cc106ae 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -919,6 +919,15 @@ xfs_droplink(
>  	xfs_trans_t *tp,
>  	xfs_inode_t *ip)
>  {
> +
> +	if (VFS_I(ip)->i_nlink == 0) {
> +		xfs_alert(ip->i_mount,
> +			  "%s: Deleting inode %llu with no links.",
> +			  __func__, ip->i_ino);
> +		tp->t_flags |= XFS_TRANS_DIRTY;

Marking the transaction dirty is not necessary.

Otherwise this seems fine.

-Dave.

-- 
Dave Chinner
david@fromorbit.com
