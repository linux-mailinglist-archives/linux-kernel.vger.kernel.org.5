Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A82808617
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjLGKNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjLGKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:13:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6AFD57
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:13:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC34C433C8;
        Thu,  7 Dec 2023 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701943992;
        bh=jjIqC4iSn/VFDe+Xa9h9ciWtGqh8N3pSlXrWjTTjMaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=um9XVhMk6ydG46DAOeQvOYixYw3Lvl2SRRiPz7BFVe5hWSWwj/iBaUMibhPo8IHnp
         imwk05eZz98/uY/w6+KOpBNw3Ptesy6eqokQGK4kO+UoE0kWa3EmiwxEm/LoC3aKlG
         zxBuGQS1oGOU7Za1fr5e9R6SulbE6J6q0qaNPOzU=
Date:   Thu, 7 Dec 2023 11:13:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yann Sionneau <ysionneau@kalrayinc.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: regression in 6.1.yy branch: LTP test preadv03 fails
Message-ID: <2023120747-domain-angled-d633@gregkh>
References: <c1f93c13-4865-b5a8-8969-4c2f5cb8f776@kalrayinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1f93c13-4865-b5a8-8969-4c2f5cb8f776@kalrayinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 11:05:15AM +0100, Yann Sionneau wrote:
> Hello,
> 
> I noticed yesterday that LTP test preadv03 now fails since 6.1.64 (it also
> fails on 6.1.65).
> 
> 6.6.4, 6.6.3, 6.5.0 and 6.2.0 seem to be unaffected.
> 
> I tested this on x86_64 and kvx arch (the latter is not upstream).
> 
> I can see some ext4 related commits on 6.1.64 and 6.1.65 changes, maybe it's
> related, therefore I add ext4 mailing list as CC.
> 
> I didn't run git bisect on this so far because I noticed building an x86_64
> ubuntu kernel on my laptop was taking ages. Maybe someone is more used to
> dealing with this and can bisect this way faster than me.

Should be fixed in the latest 6.1.y-rc release, right?  If not, please
let me know.

thanks,

greg k-h
