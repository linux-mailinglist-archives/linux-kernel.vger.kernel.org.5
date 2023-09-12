Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9375479D642
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbjILQ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbjILQ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:28:04 -0400
Received: from out-228.mta0.migadu.com (out-228.mta0.migadu.com [91.218.175.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B123F1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:28:00 -0700 (PDT)
Date:   Tue, 12 Sep 2023 12:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694536078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xAKCqRDHW+lPEAd+hDQsFbTfpENfjf47jiZ8XYV5zrE=;
        b=KkZIjbyxLo4mrQcQZ+yfNImzrOmyAmeWTxmkeOtqZ6g1y20pydPw8WtEmB941odcOulUf0
        RyXYi7uYbc+PyyaQyKpMukySB5KIrS1WkbbqyUos/M0VoV+ps/e1X+8fce90AhFRqHSqsT
        WYvZk+UostgNdQg1KWcmTHAUFv2TAbs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5][next] bcachefs: clean up some redundant assignments
Message-ID: <20230912162754.jcavjd7ezhsaeycl@moria.home.lan>
References: <20230912123744.3929609-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912123744.3929609-1-colin.i.king@gmail.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 01:37:39PM +0100, Colin Ian King wrote:
> Clean up some redundant assignments and variables based on warnings
> found by clang scan build static analysis.
> 
> Colin Ian King (5):
>   bcachefs: remove redundant initialization of pointer d
>   bcachefs: remove redundant initialization of pointer dst
>   bcachefs: remove redundant initializations of variables start_offset
>     and end_offset
>   bcachefs: remove duplicated assignment to variable offset_into_extent
>   bcachefs: remove redundant pointer q
> 
>  fs/bcachefs/btree_update_interior.c | 2 +-
>  fs/bcachefs/buckets.c               | 2 +-
>  fs/bcachefs/disk_groups.c           | 3 +--
>  fs/bcachefs/fs-io.c                 | 4 ++--
>  fs/bcachefs/io.c                    | 1 -
>  fs/bcachefs/quota.c                 | 3 ---
>  6 files changed, 5 insertions(+), 10 deletions(-)

Applied - thanks
