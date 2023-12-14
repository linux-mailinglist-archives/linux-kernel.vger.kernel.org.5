Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239C88135DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjLNQMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjLNQMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:12:21 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F8310E;
        Thu, 14 Dec 2023 08:12:27 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8F71968AFE; Thu, 14 Dec 2023 17:12:23 +0100 (CET)
Date:   Thu, 14 Dec 2023 17:12:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        jaswin@linux.ibm.com, bvanassche@acm.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v2 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <20231214161223.GA12810@lst.de>
References: <20231212110844.19698-1-john.g.garry@oracle.com> <20231212110844.19698-2-john.g.garry@oracle.com> <ZXkIEnQld577uHqu@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXkIEnQld577uHqu@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 09:25:38AM +0800, Ming Lei wrote:

<full quote deleted, please only quote what is relevant.


> >  	lim->dma_alignment = 511;
> > +	lim->atomic_write_unit_min_sectors = 0;
> > +	lim->atomic_write_unit_max_sectors = 0;
> > +	lim->atomic_write_max_sectors = 0;
> > +	lim->atomic_write_boundary_sectors = 0;
> 
> Can we move the four into single structure and setup them in single
> API? Then cross-validation can be done in this API.

Please don't be arbitrarily different from all the other limits.  What
we really should be doing is an API that updates all limits at the
same time, and I actually have code for that, I'll just need to finish
it.  I do not want to block this series for it, though.

