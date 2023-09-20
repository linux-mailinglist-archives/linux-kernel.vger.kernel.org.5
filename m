Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526F27A771D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjITJVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjITJVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:21:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B02AB9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:21:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE3DC433C9;
        Wed, 20 Sep 2023 09:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695201674;
        bh=HS0kiI6cJ8lDguF5Lx5hG1+ACWYo5jOIzlCPwObYEcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JrQ2raBZvY9P7hnchBd+l+OISrN7OvQKYv0AOiUeOw4FXz5dBPrzlhxIjPCWT8VQi
         +1ry+skVQpd9YUaGetfIHXRQ/1s2wQItoG0FDu58gitd1hTJQhyX3N2tyf9+ET1Rog
         F+ZQrPIvbQxGMNhPmgrW1PV5O7LuSJ214RC20DKM=
Date:   Wed, 20 Sep 2023 11:21:13 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul.grandperrin@gmail.com" <paul.grandperrin@gmail.com>,
        Jade Lovelace <lists@jade.fyi>
Subject: Re: [PATCH] misc: rtsx: Fix some platforms can not boot and move the
 l1ss  judgment to probe
Message-ID: <2023092032-blurred-upload-30bd@gregkh>
References: <37b1afb997f14946a8784c73d1f9a4f5@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37b1afb997f14946a8784c73d1f9a4f5@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:11:19AM +0000, Ricky WU wrote:
> commit 101bd907b424 ("misc: rtsx: judge ASPM Mode to set PETXCFG Reg")
> some readers no longer force #CLKREQ to low
> when the system need to enter ASPM.
> But some platform maybe not implement complete ASPM?
> it causes some platforms can not boot
> 
> Like in the past only the platform support L1ss we release the #CLKREQ.
> Move the judgment (L1ss) to probe,
> we think read config space one time when the driver start is enough
> 
> Fixes: 101bd907b424 ("misc: rtsx: judge ASPM Mode to set PETXCFG Reg")
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

What about all of the people that reported this issue?  Have they been
able to test it?  At least a reported-by line should be added, right?

And I'd like someone to test it to verify it fixes the issue before
applying it...

thanks,

greg k-h
