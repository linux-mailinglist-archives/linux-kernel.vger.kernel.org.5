Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2CD792A10
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353832AbjIEQdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353858AbjIEIWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:22:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BF4CC7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 01:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B499EB810D9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 08:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A81BC433C7;
        Tue,  5 Sep 2023 08:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693902154;
        bh=iBja4CwH2k4XwrAiiDxY/Cy3HKlmgWpTULfMScnG4Qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0quW2KDLJAyTajCSLwST6rTUTItNoYbWItIPCt08ytzmVaXtc1Anxoave/JEF9S0M
         VUzthDfYKVn9piQV+SR9KAMw7cujqdwxaB1s2fKzrFubyFjxYjHeS8lmHKIxrGZbH2
         /whUzPIOXnrLbVZOH4sYkbZKwheYu98xjkxJnE+Q=
Date:   Tue, 5 Sep 2023 09:22:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     pmladek@suse.com, rostedt@goodmis.org, john.ogness@linutronix.de,
        senozhatsky@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "printk: export symbols for debug modules"
Message-ID: <2023090521-refining-alive-73e4@gregkh>
References: <20230905081902.321778-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905081902.321778-1-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 10:19:02AM +0200, Christoph Hellwig wrote:
> This reverts commit 3e00123a13d824d63072b1824c9da59cd78356d9.
> 
> No, we never export random symbols for out of tree modules.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/printk/printk.c | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
