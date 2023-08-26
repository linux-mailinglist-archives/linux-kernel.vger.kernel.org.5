Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D24789397
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 05:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjHZDIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 23:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjHZDIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 23:08:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697EE210A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 20:08:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68bed8de5b9so1215541b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 20:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1693019328; x=1693624128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BNKp8DrWFBefTCanp9uY6NFh+95HSJ2HjvYLMWrxpGU=;
        b=nyQMxN8LTPWlbMpEMk2dSKjZAQhwiNHcPTPWjnhA5HaTH8W/DjYtRz8wfepfK6VFe9
         KA7d3vzEVBaU8KnOg0f0m5RWjpK4lPj+Y3PRadkK6dQpLaoZwYLCYDchGiF2R5UmsjpY
         Zdx4wcf6VWB3nxtBudkvjqT/Kl8T+ioJR6nBYH5hkW8cTU/XO/LFImrWRArZks3tgQm2
         iNeajkF0qvbLUMp5U3xO7orwddIkZmSAAde4Fmjhpky+AbxEQAvn90Z/PotEo/at1aV/
         o01Ma8AAv+nRx9KW8v39MWuIw+n6W/wsgtfrmE/5HzmUSXaYHtKO3lr0aWIonaAFRLpH
         6+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693019328; x=1693624128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNKp8DrWFBefTCanp9uY6NFh+95HSJ2HjvYLMWrxpGU=;
        b=NUXa5nEdXhKxE3GPlZz8tlsBfRXfZ6p8dbUUsq2cA0BZi/hbtIiKys2ZrMUQaPbK+Q
         OuZpKyy3avjcTREynWl88tPt5zjbr9uQx0pyj/1edvfdG/H8ARWpEhTVeNJ3A8tWjGfK
         aiEG7JDSKxTGOcx4ikNlonSDFZQlqgcrJ6Xvp7zvURtJfBXQVEQLmHuYOdh+gCVHaZi6
         1PjZqmtWaHL9uTsmOeFVm57770cupcvLNl7bapfhYQVQ4Id6vBvnTfJC4qPkjUFVEvZY
         uqVNOlx2IncZtrGQlNTrvXRIaJrMDN8hM1SB/Q63qUDCI7R2tcTDgPLpeMAPTQF5JumA
         BbEA==
X-Gm-Message-State: AOJu0Yz+xMy7nIJgmdfm2WEjbRzWcdswc/sEpmxT89+cPNlgUeif+HAJ
        KDKI0QaXKaK7HVjrUqJEKTC3uA==
X-Google-Smtp-Source: AGHT+IF/VvLEuup7cpErA9Kb/Eoc6OxjLLqroSj07r35JzltvMVagdy9UHlyl+D9jPfdGYz1GiT8Jg==
X-Received: by 2002:a05:6300:8089:b0:14c:e528:3dcd with SMTP id ap9-20020a056300808900b0014ce5283dcdmr442722pzc.55.1693019328111;
        Fri, 25 Aug 2023 20:08:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ee8a00b001bb9883714dsm2506156pld.143.2023.08.25.20.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 20:08:47 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qZjfI-006b3x-1y;
        Sat, 26 Aug 2023 13:08:44 +1000
Date:   Sat, 26 Aug 2023 13:08:44 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     cheng.lin130@zte.com.cn, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [PATCH] xfs: introduce protection for drop nlink
Message-ID: <ZOlsvPa2imANAzRu@dread.disaster.area>
References: <ZOfhoLql0TYiD5JW@dread.disaster.area>
 <202308251709208292077@zte.com.cn>
 <20230825175627.GK17912@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825175627.GK17912@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 10:56:27AM -0700, Darrick J. Wong wrote:
> On Fri, Aug 25, 2023 at 05:09:20PM +0800, cheng.lin130@zte.com.cn wrote:
> > > On Thu, Aug 24, 2023 at 03:43:52PM +0800, cheng.lin130@zte.com.cn wrote:
> > >> From: Cheng Lin <cheng.lin130@zte.com.cn>
> > >> An dir nlinks overflow which down form 0 to 0xffffffff, cause the
> > >> directory to become unusable until the next xfs_repair run.
> > > Hmmm.  How does this ever happen?
> > > IMO, if it does happen, we need to fix whatever bug that causes it
> > > to happen, not issue a warning and do nothing about the fact we
> > > just hit a corrupt inode state...
> > Yes, I'm very agree with your opinion. But I don't know how it happened,
> > and how to reproduce it.
> 
> Wait, is this the result of a customer problem?  Or static analysis?
> 
> > >> Introduce protection for drop nlink to reduce the impact of this.
> > >> And produce a warning for directory nlink error during remove.
> > >>
> > >> Signed-off-by: Cheng Lin <cheng.lin130@zte.com.cn>
> > >> ---
> > >>  fs/xfs/xfs_inode.c | 16 +++++++++++++++-
> > >>  1 file changed, 15 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > >> index 9e62cc5..536dbe4 100644
> > >> --- a/fs/xfs/xfs_inode.c
> > >> +++ b/fs/xfs/xfs_inode.c
> > >> @@ -919,6 +919,15 @@ STATIC int xfs_iunlink_remove(struct xfs_trans *tp, struct xfs_perag *pag,
> 
> I'm not sure why your diff program thinks this hunk is from
> xfs_iunlink_remove, seeing as the line numbers of the chunk point to
> xfs_droplink.  Maybe that's what's going on in this part of the thread?

Yes.

I don't expect patches to be mangled like this - I generally
take the hunk prefix to indicate what code is being modified when
reading patches, not expecting that the hunk is modifying code over
a thousand lines prior to the function in the prefix...

So, yeah, something went very wrong with the generation of this
patch...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
