Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D9679286E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241453AbjIEQKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354661AbjIENU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:20:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426A9A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:20:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5CF6F6732A; Tue,  5 Sep 2023 15:20:22 +0200 (CEST)
Date:   Tue, 5 Sep 2023 15:20:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, rostedt@goodmis.org,
        john.ogness@linutronix.de, senozhatsky@chromium.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Yunlong Xing <yunlong.xing@unisoc.com>, enlinmu@gmail.com,
        yunlong.xing23@gmail.com
Subject: Re: [PATCH] Revert "printk: export symbols for debug modules"
Message-ID: <20230905132022.GA26718@lst.de>
References: <20230905081902.321778-1-hch@lst.de> <ZPb63crhycde0E0Q@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPb63crhycde0E0Q@alley>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 11:54:37AM +0200, Petr Mladek wrote:
> Yeah, I did not have a good feeling about this patch.
> 
> I accepted it because there was an intention to upstream
> the module, see
> https://lore.kernel.org/all/CAAfh-jM0B2Cn579B0CkCrW44pJGGvjs112K+oMuViib+jDKafg@mail.gmail.com/
> 
> I think that it was bad decision. We should not export
> symbols when there is no in-tree user.

I think raw address to the printk buffer is a bad idea even for an
in-tree module.
