Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F9E780F21
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378152AbjHRP0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377972AbjHRPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:25:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8354239;
        Fri, 18 Aug 2023 08:25:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D51C460A5A;
        Fri, 18 Aug 2023 15:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E400C433C8;
        Fri, 18 Aug 2023 15:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692372312;
        bh=oeduCWzfVI0z4XLydrjpM2xcSdjndteqB0ovP2ptb8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G6/2d+zVKovU0Y5x10ABCezIPpq5vCh6tk0Hy8gkNJWkKGXP7eVhvvAcwwdCKLtk+
         P6EVdDjbaukb/Qu/S2ZoJOQYJ6wf4ZIJ7+vAaO2rANi3B24C7FB4bQ0Ul7RPYkFaOG
         TzzOqHAVKoQl9zqr4dtalTbF1jp5UuaOoNPI2tGjsoaqYDss8CYPRYsDlY9Ybrr8cE
         ++uEEIt+Up24XcN5n7oRaCiuY7BDNKiNc/r8YetVxBGv0qMumESkkvzABKz9A02i9U
         lLrTxAzUF813XyFCOD+Pq6q2gqp0yfF6OjoSHL6YDjxrWD8rknTsvybx9tGmqQHep6
         YmWpU6d8xc+BA==
Date:   Fri, 18 Aug 2023 08:25:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jefflexu@linux.alibaba.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] xfs: fix inconsistent indenting of
 xlog_verify_tail_lsn()
Message-ID: <20230818152511.GB1348949@frogsfrogsfrogs>
References: <20230818020250.35427-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818020250.35427-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:02:50AM +0800, Yang Li wrote:
> Fix smatch warning:
> 
> fs/xfs/xfs_log.c:3598 xlog_verify_tail_lsn() warn: inconsistent indenting
> 
> Also fix several style violations mentioned in [1].
> 
> [1] https://lore.kernel.org/linux-xfs/20210902233137.GB1826899@dread.disaster.area/
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Looks ok to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_log.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
> index 79004d193e54..d197534cd3b3 100644
> --- a/fs/xfs/xfs_log.c
> +++ b/fs/xfs/xfs_log.c
> @@ -3593,23 +3593,23 @@ xlog_verify_tail_lsn(
>  	struct xlog_in_core	*iclog)
>  {
>  	xfs_lsn_t	tail_lsn = be64_to_cpu(iclog->ic_header.h_tail_lsn);
> -	int		blocks;
> +	int		blocks, ic_blocks;
>  
> -    if (CYCLE_LSN(tail_lsn) == log->l_prev_cycle) {
> -	blocks =
> -	    log->l_logBBsize - (log->l_prev_block - BLOCK_LSN(tail_lsn));
> -	if (blocks < BTOBB(iclog->ic_offset)+BTOBB(log->l_iclog_hsize))
> -		xfs_emerg(log->l_mp, "%s: ran out of log space", __func__);
> -    } else {
> -	ASSERT(CYCLE_LSN(tail_lsn)+1 == log->l_prev_cycle);
> +	if (CYCLE_LSN(tail_lsn) == log->l_prev_cycle) {
> +		blocks = log->l_logBBsize -
> +			(log->l_prev_block - BLOCK_LSN(tail_lsn));
> +		ic_blocks = BTOBB(iclog->ic_offset) + BTOBB(log->l_iclog_hsize);
> +	} else {
> +		ASSERT(CYCLE_LSN(tail_lsn) + 1 == log->l_prev_cycle);
>  
> -	if (BLOCK_LSN(tail_lsn) == log->l_prev_block)
> -		xfs_emerg(log->l_mp, "%s: tail wrapped", __func__);
> +		if (BLOCK_LSN(tail_lsn) == log->l_prev_block)
> +			xfs_emerg(log->l_mp, "%s: tail wrapped", __func__);
>  
> -	blocks = BLOCK_LSN(tail_lsn) - log->l_prev_block;
> -	if (blocks < BTOBB(iclog->ic_offset) + 1)
> +		blocks = BLOCK_LSN(tail_lsn) - log->l_prev_block;

> +		ic_blocks = BTOBB(iclog->ic_offset) + 1;
> +	}
> +	if (blocks < ic_blocks)
>  		xfs_emerg(log->l_mp, "%s: ran out of log space", __func__);
> -    }
>  }
>  
>  /*
> -- 
> 2.20.1.7.g153144c
> 
