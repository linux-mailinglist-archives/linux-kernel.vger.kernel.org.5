Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4653A7C45D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjJKAHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344204AbjJKAHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:07:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F189D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:07:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-694f3444f94so5195595b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696982821; x=1697587621; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pi+6fuCZ7nV+P3VswapuyLpGimJN9EBPXoRWDqou4vc=;
        b=XKCdBT4xDLdhql/mIXTy0D/GZJwAroDCsmYkeaBpzG8J8bvZDgIY4Kylq9B2KfM6K7
         j9iz/Aip7gxKYAsg+6LLcM0QLoHs2MH0LUyjSdYzClKGRFc6CV3/KtVsNj95oKYwXIDt
         kSmOtJawACxFtedvM6VOe9++eDFqRxFZXq3by6LBCY749IwZSrGmUguKTqX3yI4RpRJt
         T1b8YatNVCHuwpQRMV7Ov7FpFQK/4qrkLZZtskdIZ1AANbVx/FtDVgc/vejiz+GYycIG
         KbCi/hoQbKcxaHFAsjWlyve5f8Lk7o5ACYb5yfiZacfBFjlJLXTTaY6zCZTHnFFW3mgR
         DJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696982821; x=1697587621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pi+6fuCZ7nV+P3VswapuyLpGimJN9EBPXoRWDqou4vc=;
        b=oEKC6yHnE5wqawLtpGyFMf44kJmfyQ4wHKi6QrSZ4eG6i6KYa5eNJa9zq0cTDBbjFW
         z5gtYCOV/j3SQyGCsb86TU5btW8aylcwr0OP/ObIO9oBItffB9ODuBy97oo0rbkvDe5F
         OCHaKiE+hMYb9/jxFxnL41PYOwrKYFqPuFLvl/DZa1A6uFNb6NhiFkLfax78qYcejQ39
         2IyyXFrI7GrdzLNdxxujI1alzkrgG2rpofvqeo/SnaDk+UMlMyG1UJLQtA5Zn595s2Nf
         2bU7GmZ1bqYvPM0H6XFbmYumKEO4ScrjcPRnstVZgB5h5PYZZKk+nKWACaAZPlxIIN+y
         BA7w==
X-Gm-Message-State: AOJu0YzLPVSG2a5X4DNmp7VqLyp9rsq1RFPAJQp88Xt69w9iLBvg2Kb5
        nLtdDlFD9iywjMuJgJjhd5LpJA==
X-Google-Smtp-Source: AGHT+IFaQsl6J0oGbAmpi1RKpoyAS4x5TyIMLa9yejYUMWdd4HdS26Ku+N4gQppaQiaJj/ZVu9D0qw==
X-Received: by 2002:a05:6a21:6d9b:b0:14b:8023:33cb with SMTP id wl27-20020a056a216d9b00b0014b802333cbmr25670485pzb.11.1696982820871;
        Tue, 10 Oct 2023 17:07:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id ji9-20020a170903324900b001c5900c9e8fsm12483875plb.81.2023.10.10.17.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:07:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qqMkb-00CB10-3B;
        Wed, 11 Oct 2023 11:06:58 +1100
Date:   Wed, 11 Oct 2023 11:06:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH v8 5/5] block: Pass unshare intent via REQ_OP_PROVISION
Message-ID: <ZSXnIYejKVo74doY@dread.disaster.area>
References: <20231007012817.3052558-1-sarthakkukreti@chromium.org>
 <20231007012817.3052558-6-sarthakkukreti@chromium.org>
 <ZSM64EOTVyKNkc/X@dread.disaster.area>
 <CAG9=OMP_YbfCyjJGGwoZfgwxO-FmR55F5zv3DO8c2-=YzY8iwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG9=OMP_YbfCyjJGGwoZfgwxO-FmR55F5zv3DO8c2-=YzY8iwA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:42:39PM -0700, Sarthak Kukreti wrote:
> On Sun, Oct 8, 2023 at 4:27 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Oct 06, 2023 at 06:28:17PM -0700, Sarthak Kukreti wrote:
> > > Allow REQ_OP_PROVISION to pass in an extra REQ_UNSHARE bit to
> > > annotate unshare requests to underlying layers. Layers that support
> > > FALLOC_FL_UNSHARE will be able to use this as an indicator of which
> > > fallocate() mode to use.
> > >
> > > Suggested-by: Darrick J. Wong <djwong@kernel.org>
> > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > ---
> > >  block/blk-lib.c           |  6 +++++-
> > >  block/fops.c              |  6 ++++--
> > >  drivers/block/loop.c      | 35 +++++++++++++++++++++++++++++------
> > >  include/linux/blk_types.h |  3 +++
> > >  include/linux/blkdev.h    |  3 ++-
> > >  5 files changed, 43 insertions(+), 10 deletions(-)
> >
> > I have no idea how filesystems (or even userspace applications, for
> > that matter) are supposed to use this - they have no idea if the
> > underlying block device has shared blocks for LBA ranges it already
> > has allocated and provisioned. IOWs, I don't know waht the semantics
> > of this function is, it is not documented anywhere, and there is no
> > use case present that tells me how it might get used.
> >
> > Yes, unshare at the file level means the filesystem tries to break
> > internal data extent sharing, but if the block layers or backing
> > devices are doing deduplication and sharing unknown to the
> > application or filesystem, how do they ever know that this operation
> > might need to be performed? In what cases do we need to be able to
> > unshare block device ranges, and how is that different to the
> > guarantees that REQ_PROVISION is already supposed to give for
> > provisioned ranges that are then subsequently shared by the block
> > device (e.g. by snapshots)?
> >
> > Also, from an API perspective, this is an "unshare" data operation,
> > not a "provision" operation. Hence I'd suggest that the API should
> > be blkdev_issue_unshare() rather than optional behaviour to
> > _provision() which - before this patch - had clear and well defined
> > meaning....
> >
> Fair points, the intent from the conversation with Darrick was the
> addition of support for FALLOC_FL_UNSHARE_RANGE in patch 2 of v4
> (originally suggested by Brian Forster in [1]): if we allow
> fallocate(UNSHARE_RANGE) on a loop device (ex. for creating a
> snapshot, similar in nature to the FICLONE example you mentioned on
> the loop patch), we'd (ideally) want to pass it through to the
> underlying layers and let them figure out what to do with it. But it
> is only for situations where we are explicitly know what the
> underlying layers are and what's the mecha
> 
> I agree though that it clouds the API a bit and I don't think it
> necessarily needs to be a part of the initial patch series: for now, I
> propose keeping just mode zero (and FALLOC_FL_KEEP_SIZE) handling in
> the block series patch and drop this patch for now. WDYT?

Until we have an actual use case for unsharing (which explicitly
breaks extent sharing) as opposed to provisioning (which ensures
overwrites always succeed regardless of extent state) then let's
leave it out of this -provisioning- series.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
