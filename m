Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E53B7BE88F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377488AbjJIRp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346644AbjJIRpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:45:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1335DE;
        Mon,  9 Oct 2023 10:45:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717A0C433C8;
        Mon,  9 Oct 2023 17:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696873552;
        bh=fxbJuVqFx9iYDqPfoly1t59AvhqiKbjiU1d+oTwit8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QUujoRnsadURvNZwWjfFFv/VQhyuyvANkKnhPclmcaP+EuHXCybHFpHIo11P3lrX3
         nLeAr1xw0kKYMGKXYMlVl7gB8iyZwiDH5yjrlFJuewIZCGb7zosIFHRwLziUi2K4Hu
         FPJd+W8dQ8lHoP7546guJ6n52lh0J0YZbYzUgQBx5Piim5MMQNUfyXQyjwnKgoB9Jl
         hFFV8i9qaq2Bldz7div1u/wjhdC+rd3x8r9jsSA3l7bYWmQNxfNy2StF6Y26ABIa3q
         mxRygdy++roknQgVZR+jk1qOblEEGpVAvBlcRXhG6K9q9Y3hXUEMDO4X1OFJ7g0qVt
         xxK3Q/oBjKoKQ==
Date:   Mon, 9 Oct 2023 10:45:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        martin.petersen@oracle.com, david@fromorbit.com,
        himanshu.madhani@oracle.com
Subject: Re: [PATCH 4/4] io_submit.2: Document RWF_ATOMIC
Message-ID: <20231009174551.GF21283@frogsfrogsfrogs>
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
 <20230929093717.2972367-5-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929093717.2972367-5-john.g.garry@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 09:37:17AM +0000, John Garry wrote:
> Document RWF_ATOMIC for asynchronous I/O.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  man2/io_submit.2 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/man2/io_submit.2 b/man2/io_submit.2
> index 1030bb6cd965..beba8865ac2a 100644
> --- a/man2/io_submit.2
> +++ b/man2/io_submit.2
> @@ -140,6 +140,11 @@ as well the description of
>  .B O_SYNC
>  in
>  .BR open (2).
> +.TP
> +.BR RWF_ATOMIC " (since Linux 6.7)"
> +Write a block of data such that a write will never be
> +torn from power fail or similar. See See the description

Nit: Double 'See' here.

--D

> +of the flag of the same name in pwritev2(2).
>  .RE
>  .TP
>  .I aio_lio_opcode
> -- 
> 2.31.1
> 
