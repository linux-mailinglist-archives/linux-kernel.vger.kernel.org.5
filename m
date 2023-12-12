Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F111880E8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjLLKQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLKQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:16:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B09A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 02:16:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14397C433C8;
        Tue, 12 Dec 2023 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702376193;
        bh=QNcLcqvo2jYrSjQ/cTdC3kektegzfqa7FvSTeFHo/l4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BEopNWgCWiBewoT41V5fXjtJugYtBLvX1JVPMStxjPpXbBsNZ88/6rgT+f6UaxNTN
         pNmbw3i13OgeeqS0tSa1nB3HnUw37tpaQFVyoPsvAwhhUfZ0LSDZLWKngcuVsf9Xzh
         vgCVmIHOyd2gGNhjLFxdi9IJY8fojNMmzfYcmbng=
Date:   Tue, 12 Dec 2023 11:16:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gan, Yi Fang" <yi.fang.gan@intel.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        John Stultz <jstultz@google.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Halaney <ahalaney@redhat.com>, Lobakin@kroah.com,
        Aleksander <aleksander.lobakin@intel.com>, Gan@kroah.com,
        linux-kernel@vger.kernel.org,
        Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>, Lai@kroah.com,
        Peter Jun Ann <peter.jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next 1/1] driver.h: add helper macro for
 module_exit() boilerplate
Message-ID: <2023121245-unspoiled-aging-214d@gregkh>
References: <20231212094352.2263283-1-yi.fang.gan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212094352.2263283-1-yi.fang.gan@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 05:43:52PM +0800, Gan, Yi Fang wrote:
> For the modules need a module_init() but don't need to do
> anything special in module_exit() might need to have an empty
> module_exit(). This patch add a new macro module_exit_stub() to
> replace the empty module_exit(). The macro is useful to remove
> the module_exit() boilerplate.
> 
> Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
> ---
>  include/linux/device/driver.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Why would we take a macro that no one actually uses?

Please submit this with a user, you all know that this is the case, how
did it pass your internal reviews (hint, I don't think it did...)

thanks,

greg k-h
