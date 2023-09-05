Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A78792A7C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbjIEQiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354139AbjIEJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:54:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6516D1B4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:54:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1E0EB1F74D;
        Tue,  5 Sep 2023 09:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693907678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OtL84FcEIthPu1azLIEBceBkZW4PPRMQ449CQaLKrj4=;
        b=JqD6PwEqmeOPoAfo53ptle0dBOZ8S3aM7NhtPU+1U6KG/D+7WpPCtr0dcf2yJT8LMdiSpd
        N3rj8nZjuQpQ9qI3Vwc/LQzPAaxfSocdQKj4HvHjAV6exJX2z42UqD52ME9wYX2z+xW675
        w2niBnRam02clQ0651pO/tIK6JGO+4w=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6CAF12C142;
        Tue,  5 Sep 2023 09:54:37 +0000 (UTC)
Date:   Tue, 5 Sep 2023 11:54:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Yunlong Xing <yunlong.xing@unisoc.com>, enlinmu@gmail.com,
        yunlong.xing23@gmail.com
Subject: Re: [PATCH] Revert "printk: export symbols for debug modules"
Message-ID: <ZPb63crhycde0E0Q@alley>
References: <20230905081902.321778-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905081902.321778-1-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added people from the original thread into Cc.

On Tue 2023-09-05 10:19:02, Christoph Hellwig wrote:
> This reverts commit 3e00123a13d824d63072b1824c9da59cd78356d9.
> 
> No, we never export random symbols for out of tree modules.

Yeah, I did not have a good feeling about this patch.

I accepted it because there was an intention to upstream
the module, see
https://lore.kernel.org/all/CAAfh-jM0B2Cn579B0CkCrW44pJGGvjs112K+oMuViib+jDKafg@mail.gmail.com/

I think that it was bad decision. We should not export
symbols when there is no in-tree user.

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
