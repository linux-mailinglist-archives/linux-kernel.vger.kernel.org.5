Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD87B57B3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238396AbjJBQJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbjJBQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:09:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D287A8E;
        Mon,  2 Oct 2023 09:09:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE3AC433C8;
        Mon,  2 Oct 2023 16:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696262994;
        bh=m11DmdSjjixEhjIU2Jt2cNdM9jZCNnPXRpX5VPCtbQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nr4+d+CwBOBrvBwKIdeDwXMpVl8hLOn1lHoWh0OYbLe2TWuTiKxfHy1giqz6XNaEB
         3XijP2CpOrB/2e4XM9RQgUQRVi3eQ7IKUPDipNbSaPSDe4VPlFDKNzrnDNAr23tNTV
         /D0YJg8Zu/76EFbJXtFSBVCaLVE0PeHKLB+SCuhk73THr/+tOoGps+y0yTx91fmUw8
         PTtngQynyKwyc3CvAvuwyIn1GRGEihn0I9aNHjM986yHmJRrzboFdwrGOShgCQ7Zit
         JyygvgUlcydXDpZX2wGGQSLVbP7kr77T3PA82E/tL0SqF3KgohM0IZaEgXGCOX7V3p
         pmr9DOtZFcHcQ==
Date:   Mon, 2 Oct 2023 21:39:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the dmaengine tree
Message-ID: <ZRrrToewRnOYGOD3@matsya>
References: <20230929131324.6bb84292@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929131324.6bb84292@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-09-23, 13:13, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the dmaengine tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> ld: warning: discarding dynamic section .glink
> ld: warning: discarding dynamic section .plt
> ld: linkage table error against `ioread64'
> ld: stubs don't match calculated size
> ld: can not build stubs: bad value
> ld: fs/debugfs/file.o: in function `debugfs_print_regs':
> file.c:(.text+0xee8): undefined reference to `ioread64be'
> ld: file.c:(.text+0xf50): undefined reference to `ioread64'
> 
> Caused by commit
> 
>   09289d0ad122 ("debugfs_create_regset32() support 8/16/64 bit width registers")
> 
> I have used the dmaengine tree from next-20230928 for today.

Thanks for report, I have dropped offending commits for now.

BR
-- 
~Vinod
