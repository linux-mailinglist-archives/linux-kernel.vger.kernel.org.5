Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E340281175E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442149AbjLMPic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442041AbjLMPib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:38:31 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36E9B3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:38:37 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AB4D168CFE; Wed, 13 Dec 2023 16:38:34 +0100 (CET)
Date:   Wed, 13 Dec 2023 16:38:34 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5 1/6] nvme: move ns id info to struct nvme_ns_head
Message-ID: <20231213153833.GC7301@lst.de>
References: <20231208105337.23409-1-dwagner@suse.de> <20231208105337.23409-2-dwagner@suse.de> <bf20cb2a-0985-467b-842b-6b5fd752f14b@grimberg.me> <7ldcd6imhzxhn3wsirhxxyhb75x5iay2p67p2i4qi2euyztc5i@nbjtvyixifqm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ldcd6imhzxhn3wsirhxxyhb75x5iay2p67p2i4qi2euyztc5i@nbjtvyixifqm>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 03:54:25PM +0100, Daniel Wagner wrote:
> > I think that the whole PI stuff needs to be taken with a bit more
> > consideration because if not all paths agree on the pi (as we have
> > hbas with fabrics) we can't just override or do a logical or on
> > the capabilities/attributes.
> 
> So should the PI variables stay in nvme_ns at this point? Or should I
> add some checks which avoid an override and warn in this case?

Didn't we merge the patch from max to require uniform PI setups
for all controllers that we're using in a multipath setup?  I'll
check the code after finishing a few more things if no one remembers
offhand.
