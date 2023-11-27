Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E365E7FA565
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjK0P4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjK0P4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:56:50 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC18CBE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:56:52 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3DA8067373; Mon, 27 Nov 2023 16:56:49 +0100 (CET)
Date:   Mon, 27 Nov 2023 16:56:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <20231127155649.GA1403@lst.de>
References: <20231127103208.25748-1-dwagner@suse.de> <20231127141857.GA25833@lst.de> <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 08:44:52AM -0700, Keith Busch wrote:
> > I'd probably spell out metadata_size, or probably even better
> > metadata_bytes to match the unit postfixes elsewhere in the block code.
> 
> Should this even be an nvme specific attribute? I thought we should have
> blk-integrity.c report its 'tuple_size' attribute instead. That should
> work as long as we're not dealing with extended metadata at least, but
> that's kind of a special format that doesn't have block layer support.

Reporting the tuple size is a good idea.  But is that enough for
the existing nvme-cli use case?
