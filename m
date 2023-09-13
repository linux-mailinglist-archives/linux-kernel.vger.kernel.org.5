Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3857079F5AF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjIMXow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjIMXov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:44:51 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D3DE40
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:44:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2685bcd046eso291000a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694648686; x=1695253486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mbBhrEihaU82qofMP72oFh86MVO1MRdEXnN/IMvNciY=;
        b=eeP5pjGfhDSboc+PvSwFvvJI7m97EUv/nubCBjCCeGCDudYEZWbKB1hmhfyxZ/vzQj
         YF0YmTiIXSgUnuwV7pHgCyDAF6PEA17Q2Oga+Y5Sz9DcfZBcAJcDmr3JFJqkkwSpCbVe
         o5y1eEq24yxf851dH5Bwv5SgEi16+w/X792tIDGzBOtlgM0338MCIWspweLarUrKsqs9
         x1Tk7syZJ/a2nfXuPLd9Jga2lSPq7t79Ct+GpvGjXQQLnuezy3hFsRkWxVPFefAXHGkS
         JLdn/suk9Mk0pbBDJzVfIiEg+h2nbd5hryHJC/O0TRDCqCv7kAOIwM0ahl7VdocQahFP
         AlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694648686; x=1695253486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbBhrEihaU82qofMP72oFh86MVO1MRdEXnN/IMvNciY=;
        b=srmqiWKYG6AsOku9bJ/IHi8K4A1YMZYWCeNeeioZOScVH0/SI4swr35rxxJnAmPfWk
         WwPZZqAkziGyv/ZvVlITCgj0WgVWxUpORFXV18Ic3mZ41T2YFLKlxODq99HxdfHcn0Ke
         KA0sjbExXFPQThCrOM6W9JsLSKwi2LSDJFPmuVnF/8FDynkt+U9cGYR1j1DhRLA3UQpc
         ElmFAXIFufunccZJG9zhfINS9LRr4DZs2Q1mcmWw5cTP2/TTYZkxg2TRwu/I8c5+gCYs
         rhd7U81nOcOf6Wi0ElOUj4avLp2jQYUCWWmI3wdWeA1/FaB2ONQSO7eA0glrjJAL8EvW
         aM6g==
X-Gm-Message-State: AOJu0Yz0XceFg7e0wGWyEJZr8W6Wzlm9js5iqFDeA8Tq+K1pASwxLqeG
        s47vbYgYwXeQEU5YrCUGZ8AjUA==
X-Google-Smtp-Source: AGHT+IEND72MFLrMknqTQ26Ysmj35t4SzN5912iiZOSzBWCL5mDCuarLFkvNWCoco4W/f1uTXedYwQ==
X-Received: by 2002:a17:90b:3149:b0:268:3b8b:140d with SMTP id ip9-20020a17090b314900b002683b8b140dmr3243779pjb.35.1694648686549;
        Wed, 13 Sep 2023 16:44:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id ne10-20020a17090b374a00b002609cadc56esm148650pjb.11.2023.09.13.16.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 16:44:46 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qgZXG-000Nkg-2I;
        Thu, 14 Sep 2023 09:44:42 +1000
Date:   Thu, 14 Sep 2023 09:44:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     alexjlzheng@gmail.com
Cc:     alexjlzheng@tencent.com, chandan.babu@oracle.com,
        djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: remove redundant batch variables for
 serialization
Message-ID: <ZQJJasg4eIt99t/0@dread.disaster.area>
References: <ZP45/7KfB0sHuCIk@dread.disaster.area>
 <20230913034115.1238353-1-alexjlzheng@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913034115.1238353-1-alexjlzheng@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 11:41:15AM +0800, alexjlzheng@gmail.com wrote:
> On Mon, 11 Sep 2023 07:49:51 +1000, Dave Chinner <david@fromorbit.com> wrote:
> > On Sat, Sep 09, 2023 at 03:17:51PM +0800, alexjlzheng@gmail.com wrote:
> > > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > > 
> > > Historically, when generic percpu counters were introduced in xfs for
> > > free block counters by commit 0d485ada404b ("xfs: use generic percpu
> > > counters for free block counter"), the counters used a custom batch
> > > size. In xfs_mod_freecounter(), originally named xfs_mod_fdblocks(),
> > > this patch attempted to serialize the program using a smaller batch size
> > > as parameter to the addition function as the counter approaches 0.
> > > 
> > > Commit 8c1903d3081a ("xfs: inode and free block counters need to use
> > > __percpu_counter_compare") pointed out the error in commit 0d485ada404b
> > > ("xfs: use generic percpu counters for free block counter") mentioned
> > > above and said that "Because the counters use a custom batch size, the
> > > comparison functions need to be aware of that batch size otherwise the
> > > comparison does not work correctly". Then percpu_counter_compare() was
> > > replaced with __percpu_counter_compare() with parameter
> > > XFS_FDBLOCKS_BATCH.
> > > 
> > > After commit 8c1903d3081a ("xfs: inode and free block counters need to
> > > use __percpu_counter_compare"), the existence of the batch variable is
> > > no longer necessary, so this patch is proposed to simplify the code by
> > > removing it.
> > 
> > Hmmmm. Fiddling with percpu counter batch thresholds can expose
> > unexpected corner case behaviours.  What testing have you done on
> > this change?
> 
> Hi, Dave,
> 
> Thank you for your reply.
> 
> I have tested the patch using _filebench_ and _fio_.

What about all the ENOSPC and shutdown tests in fstests?

If you haven't exercised ENOSPC conditions in your testing, then you
haven't actually tested whether the new code can accurately and
correctly detect ENOSPC conditions....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
