Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CE37A2FC7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbjIPLoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjIPLnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:43:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA088CCB;
        Sat, 16 Sep 2023 04:43:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85E4C433C8;
        Sat, 16 Sep 2023 11:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694864616;
        bh=8iD39Qw3H8JPs5fA6kJHUzCEKJF3ScoApfRvXbC6TiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+wnMs5E22siwT+LTWVhV+sUtZBDfVXYThePCUFM24qcex/nIpCuw+Xj4yqsQwr3R
         3mcfTmViZoTEn9Qan1OirzfFGvpdLL9Z2lg+8GNqOI0qdxxFbag6LgOT35nITGiDIq
         k4p7QKwCnMP+mG7LdCuF5fS7sie0zVQTFBp+BqXY=
Date:   Sat, 16 Sep 2023 13:43:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] vlynq: remove bus support
Message-ID: <2023091624-outthink-griminess-11cd@gregkh>
References: <20230916091125.3221-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916091125.3221-1-wsa@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 11:11:22AM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> I'd like to clean up the 'drivers' directory and Kconfig menu, at least
> a little. One major thing I noticed is that VLYNQ can actually be
> removed. From patch 2:
> 
> ---
> There are no users with a vlynq_driver in the Kernel tree. So, remove
> the bus driver which hardly has seen any activity since 2009. It was
> even marked EXPERIMENTAL as long as that symbol existed. OpenWRT had
> some out-of-tree drivers which they probably intended to upport, but AR7
> devices are not supported anymore because they are "stuck with Kernel
> 3.18" [1]. So, this code can go nowadays.
> 
> [1] https://openwrt.org/docs/techref/targets/ar7
> ---
> 
> Patch 1 removes MIPS specific bus initialization code which is the only
> user of the VLYNQ bus currently.
> 
> Sending out as RFC to gather comments. Patches are based on 6.6-rc1 and
> created with "--irreversible-delete" to save some space. They are
> compile tested only, buildbots were happy.
> 
> I think this mainly goes to Florian Fainelli. Florian, what do you
> think?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
