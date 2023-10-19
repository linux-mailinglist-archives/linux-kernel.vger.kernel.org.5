Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE3A7CF3D1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345026AbjJSJRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjJSJRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:17:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0266B12D;
        Thu, 19 Oct 2023 02:17:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A3DC433C8;
        Thu, 19 Oct 2023 09:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697707024;
        bh=AR8ue59K0EwasDC/WUjeFHRvQRRyS5yf/QPR2pkFuok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AiInQyDJy0Zuzkh7pulkUzzD0u69LsXzBBvIEhMZXlPZqSFWkDGwbtwe7L8xq4PRz
         38e/RedQT6UYdzoK3j5TOD+i8InGzehFClxvlVeDnA2aG8uqQsc5mV7c5TOXrvrKZ6
         b/VowWVssHt7It5Sr5i5D/E8AJI66siQ1aIfUZ2B1u7cHab/QfX4RlLka8Q0CAxyEf
         pZTJZaHr3fGnZuWSkuFYc6dOOkQgl0hkryazaNSzzuoCH8/1amPgrNoh4469Hs2tT1
         djq4K1PjKuQPIeU5BinoNRsopzyK1sBiOGhBK/292TVu1pSZiv6dHTJ6m1/9Z+1lvx
         Xzuz6nIj5S44g==
Date:   Thu, 19 Oct 2023 11:17:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20231019-lahmen-halbjahr-383a5f6dfefe@brauner>
References: <20231019105405.6ed2f53d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019105405.6ed2f53d@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 10:54:05AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vfs-brauner tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> ERROR: modpost: "bdev_mark_dead" [drivers/block/floppy.ko] undefined!
> 
> Caused by commit
> 
>   3b97609801fa ("block: move bdev_mark_dead out of disk_check_media_change")
> 
> I have used the vfs-brauner tree from next-20231018 for today.

Thanks! Fixed now.
