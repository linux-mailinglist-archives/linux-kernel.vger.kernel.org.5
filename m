Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85CD808BEE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443522AbjLGPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443479AbjLGPds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:33:48 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9229310CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:33:54 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 110BF227A87; Thu,  7 Dec 2023 16:33:52 +0100 (CET)
Date:   Thu, 7 Dec 2023 16:33:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 4/4] nvme: repack struct nvme_ns_head
Message-ID: <20231207153351.GC21486@lst.de>
References: <20231207123624.29959-1-dwagner@suse.de> <20231207123624.29959-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123624.29959-5-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 01:36:24PM +0100, Daniel Wagner wrote:
> ns_id, lba_shift and ms are always accessed for every read/write I/O in
> nvme_setup_rw. By grouping these variables into one cacheline we can
> safe some cycles.
> 
> 4k sequential reads:
> 
>            baseline   patched
> Bandwidth: 1620       1634
> IOPs       66345579   66910939

Nice:

Reviewed-by: Christoph Hellwig <hch@lst.de>
