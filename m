Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72352798335
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbjIHHWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239017AbjIHHWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:22:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5D31BCB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:22:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 39D711F461;
        Fri,  8 Sep 2023 07:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694157725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yMgosH2V+Vld6J5jBXIJkB3KbdeHiICDvgis7QJxV0A=;
        b=IfwXxUiGCHEs7s52yIjPuK33PsBsr2W6P5xxFnrDtsO0pgoz7DbPk5fUzTv/3Ku/o/piZA
        qukMOP+J+UVZnnmmvXgbB8OXAPdcRRHFTmjWdpW40Q5Dnph2WNTb/1b0sT+4/J3lj61tgU
        0f5ttoi2htW5vyKwtQV0zzIfMWmX/jY=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D3F1C2C142;
        Fri,  8 Sep 2023 07:22:03 +0000 (UTC)
Date:   Fri, 8 Sep 2023 09:22:03 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Yunlong Xing <yunlong.xing@unisoc.com>, enlinmu@gmail.com,
        yunlong.xing23@gmail.com
Subject: Re: [PATCH] Revert "printk: export symbols for debug modules"
Message-ID: <ZPrLm4fuSiv2-Rnm@alley>
References: <20230905081902.321778-1-hch@lst.de>
 <ZPb63crhycde0E0Q@alley>
 <20230905132022.GA26718@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905132022.GA26718@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-09-05 15:20:22, Christoph Hellwig wrote:
> On Tue, Sep 05, 2023 at 11:54:37AM +0200, Petr Mladek wrote:
> > Yeah, I did not have a good feeling about this patch.
> > 
> > I accepted it because there was an intention to upstream
> > the module, see
> > https://lore.kernel.org/all/CAAfh-jM0B2Cn579B0CkCrW44pJGGvjs112K+oMuViib+jDKafg@mail.gmail.com/
> > 
> > I think that it was bad decision. We should not export
> > symbols when there is no in-tree user.
> 
> I think raw address to the printk buffer is a bad idea even for an
> in-tree module.

Yeah, I suggested to use the kmsg_dump() API in the original thread.

Sigh, I made the bad decision in a hurry before vacation. I know
that it is a bad excuse but... Thanks for catching it.

Best Regards,
Petr

PS: I have just sent a pull request with the revert.
