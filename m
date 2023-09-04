Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5104791191
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352390AbjIDGmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349344AbjIDGmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:42:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11776116
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 23:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2F6AB80D97
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 06:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21920C433C7;
        Mon,  4 Sep 2023 06:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693809732;
        bh=Y5tla0TaJ0T+kAb5huPrGgbB8wPRqn73QCw9I2hihmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlzEBlotRxdgidtU/lBfca7xiEah8rZLbD6CetjwwhilWCUfsH/ZgEArDH8HHpx8/
         PKZU5WEFHXXRQLEjd1Vp8PfzYQgE3cq72ezezSTZqJUROpM3WqpsLlYBWuoJ0x/2Xj
         A9rqAwBQlvlfAMHNj4ZtYkhI0JqSKwB2cOwCpkO8=
Date:   Mon, 4 Sep 2023 07:42:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Behme Dirk (CM/ESO2)" <dirk.behme@de.bosch.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.14 03/62] arm64: kprobe: make page to RO mode when
 allocate it
Message-ID: <2023090431-armored-okay-0915@gregkh>
References: <20181126105051.213025360linuxfoundation!org>
 <cad171ca-dc61-21d9-3a88-08fc85af6d73@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cad171ca-dc61-21d9-3a88-08fc85af6d73@de.bosch.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 07:24:19AM +0200, Behme Dirk (CM/ESO2) wrote:
> 
> On 26.11.2018 11:50, Greg Kroah-Hartman wrote:
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> 
> 
> It looks like that this patch which was back ported from v4.20 to v4.14.100
> needs the '__weak' on kernel/kprobes.c alloc_insn_page() from v4.15 commit
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63fef14fc98a8b4fad7
> 
> to make alloc_insn_page() being used properly.
> 
> But that '__weak' from 63fef14fc98a8b4fad7 was not back ported to v4.14.x
> and is missing in v4.14.x ?

Great, can you send the missing patch after testing that it works?

thanks,

greg k-h
