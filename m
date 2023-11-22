Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15A7F54E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjKVXes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbjKVXeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:34:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625281BDD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:34:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FA9C433C8;
        Wed, 22 Nov 2023 23:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700696053;
        bh=y/xDtgcOVaYK+pAvWAT8PxuU8yWjmpI1lOQifmWd/CE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o9IOBouzu/1lqDop7NAkpUIdSGIn9EeWvpVNxuzyv7Jui8Y3aNEdsYCMR/hPj/QrJ
         IOmkS/ATzempErFBw0pfXHdv0XEkz+11PT3xjghNt5Nj4RoLAWQiJxcXeva396xsSr
         RQa8rTiQ/0d2QPS6KfsBGkncXQVKzpH5+uLeRnjAyBjOegiWinazNqJ7I2b+E4XHDl
         QKHbSa3aMmVGsE7vPgjVQwPywyAtIpBIXCuV+N+GXmC3TMgvY8KSSOJDxDMZhiJ8kM
         EXYtgheZsQjR2/uw0rUFLSB5QdzeTgrPtQJh1CNDiIGtfgxnLkyHUnt6FVDO9DXNSK
         7Ql+uyjBgme0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8EB1BCE0BDB; Wed, 22 Nov 2023 15:34:12 -0800 (PST)
Date:   Wed, 22 Nov 2023 15:34:12 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Petr Malat <oss@malat.biz>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org
Subject: Re: [PATCH 0/2] bootconfig: Support early options in embedded config
Message-ID: <1b3bfb7e-87d1-467c-ab4a-37b47254bae9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231121231342.193646-1-oss@malat.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121231342.193646-1-oss@malat.biz>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 12:13:40AM +0100, Petr Malat wrote:
> These 2 patches add a support for specifying early options in embedded
> bootconfig and merging embedded and initrd bootconfig into one.
> 
> To allow handling of early options, it's necessary to eliminate allocations
> from embedded bootconfig handling, which can be done by parsing the config
> data in place and allocating xbc_nodes array statically.
> 
> Later, when initrd is available, it either replaces embedded data or is
> appended to them. To append initrd data, it's necessary to relocate already
> parsed data to a bigger memory chunk, but that's not a problem, because
> xbc_node structure uses offsets and not absolute pointers.
> 
> Also, update the documentation to make users aware early options can't be
> configured in the initrd.

Nice!!!

For the series:

Tested-by: Paul E. McKenney <paulmck@kernel.org>

(My setup isn't friendly with initrd bootconfig, so I tested this only for
the embedded bootconfig parameters.)

							Thanx, Paul
