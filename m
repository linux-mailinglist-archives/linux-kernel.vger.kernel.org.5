Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1CC806C04
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377460AbjLFKew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377418AbjLFKeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:34:50 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E659D120
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:34:52 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-286f22c52c7so1043932a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701858892; x=1702463692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4Z8EdhyaZRP7j5Yaa3EE9onKgRz+Z4MfKus85WrUrY=;
        b=w2M98COFigB8GmX+JPVFQJX+JoktYohW1NTF5APcxmW8HtWDwEcXI4/ejjjv8pnI4Q
         OVTHe4PWqDGQ7hVUxo4NA04B1ACVRFWeVh5UIrgyGv6dJ+v2XTp9RGVYLsbZ0FgkCZaC
         A1GPQSClac7cEK3YY2y2JSell9df5B/Ib+zKrtUWuK+3ySo/rs9TSF/BW95nYAQR70nO
         2abijId72/rE/z0NWfV1quElPlS1QcJlcH41iuG1w0k+p3aqSv8tQCfL2TRx2+ACjREd
         sUq4JvEsImU5lDsjcu6pg7fKVB0BuVVlzCpwX6J30twUB1pF0PYFmP/9qGpTVRNlUzE9
         rdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701858892; x=1702463692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4Z8EdhyaZRP7j5Yaa3EE9onKgRz+Z4MfKus85WrUrY=;
        b=QagJLIZwBnHs9CwFTwzGI963M+Q3LX46/i9+XHJmIH3Lw0DnsnKYasXnMh+2Npl7JG
         w0vqu4re9RoUmS+05k2gCyUXb6sjcWiP/66PUwbWEHjPG1Lcm7pMVuvMVgK3MzVN3MEv
         gmFBMfAv3hISiGSYwm05lOiTcCCC7AkxmPlMAjFJjH9A2uXCET37vb53nqD263nRaLhX
         P1JkCy8vWlajk/jYkS44yc/nBMvSlr5cVghROnvicgUnI9Gk9Ds9Lg0srx4b+BfOgxFf
         jQWjd0HEwSg5eDd0HvgmqLjLwuQt0ynotIXcWq0xQPzmtOJgiOCh0nOMNefkFtoH4Gfy
         Jk5g==
X-Gm-Message-State: AOJu0YxEcqLAbgcmZNcrFw2rK2mMRBK7p5m4tFGZPM1AzKeP0FfzE9Ti
        3pnNGDRLH1G3hJpMUZ4t+puMo9HlQI0dsUr4Sow=
X-Google-Smtp-Source: AGHT+IG+r05DW+YG20wT0zMSUQjc8wthXzTPHXekABeetwsDcjq3ngyrW/IXXGOyDC8eXSbIvaBSMQ==
X-Received: by 2002:a17:90b:1249:b0:286:6cc1:866d with SMTP id gx9-20020a17090b124900b002866cc1866dmr475002pjb.82.1701858892359;
        Wed, 06 Dec 2023 02:34:52 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id z14-20020a1709027e8e00b001cc1dff5b86sm10987117pla.244.2023.12.06.02.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 02:34:51 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1rApEv-004aa5-1z;
        Wed, 06 Dec 2023 21:34:49 +1100
Date:   Wed, 6 Dec 2023 21:34:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, willy@infradead.org,
        akpm@linux-foundation.org, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH -RFC 0/2] mm/ext4: avoid data corruption when extending
 DIO write race with buffered read
Message-ID: <ZXBOSRhm11DtGO+K@dread.disaster.area>
References: <20231202091432.8349-1-libaokun1@huawei.com>
 <20231204121120.mpxntey47rluhcfi@quack3>
 <b524ccf7-e5a0-4a55-db6e-b67989055a05@huawei.com>
 <ZXAyV/rlfvBBuDL1@dread.disaster.area>
 <ZXA4swgzsHbkm/uB@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXA4swgzsHbkm/uB@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 01:02:43AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 06, 2023 at 07:35:35PM +1100, Dave Chinner wrote:
> > Mixing overlapping buffered read with direct writes - especially partial block
> > extending DIO writes - is a recipe for data corruption. It's not a
> > matter of if, it's a matter of when.
> > 
> > Fundamentally, when you have overlapping write IO involving DIO, the
> > result of the overlapping IOs is undefined. One cannot control
> > submission order, the order that the overlapping IO hit the
> > media, or completion ordering that might clear flags like unwritten
> > extents. The only guarantee that we give in this case is that we
> > won't expose stale data from the disk to the user read.
> 
> Btw, one thing we could do to kill these races forever is to track if
> there are any buffered openers for an inode and just fall back to
> buffered I/O for that case.  With that and and inode_dio_wait for
> when opening for buffered I/O we'd avoid the races an various crazy
> workarounds entirely.

That's basically what Solaris did 20-25 years ago. The inode held a
flag that indicated what IO was being done, and if the "buffered"
flag was set (either through mmap() based access or buffered
read/write syscalls) then direct IO would do also do buffered IO
until the flag was cleared and the cache cleaned and invalidated.

That had .... problems.

Largely they were performance problems - unpredictable IO latency
and CPU overhead for IO meant applications would randomly miss SLAs.
The application would see IO suddenly lose all concurrency, go real
slow and/or burn lots more CPU when the inode switched to buffered
mode.

I'm not sure that's a particularly viable model given the raw IO
throughput even cheap modern SSDs largely exceeds the capability of
buffered IO through the page cache. The differences in concurrency,
latency and throughput between buffered and DIO modes will be even
more stark itoday than they were 20 years ago....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
