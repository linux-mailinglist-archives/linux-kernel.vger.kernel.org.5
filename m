Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F55F797761
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjIGQYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbjIGQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:22:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6685255;
        Thu,  7 Sep 2023 09:20:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04096C116A5;
        Thu,  7 Sep 2023 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694081814;
        bh=+yxi0fgZJulF5cIi8DZ0uhXbDieooxm6LIqEiuMrOAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ulexrK4hboftGDRCTT9HPEaBJLr5SRU/v185Bon4qp9+VIWYxWKXEZ1h/wiiZfzD
         IG0vXhtNGLnODmebM5MtXHM3Iigh5Hb+KiAqDRcqH0OyRDV5+gXjrKpxqrgQiDzxuZ
         k3IS8f6aqC+QXRYB0tRiKnXJYBq7j78bBMyeoH4k=
Date:   Thu, 7 Sep 2023 11:16:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Rathore <deeratho@cisco.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v6.1.52][PATCH] Bluetooth: btsdio: fix use after free bug in
 btsdio_remove due to race condition
Message-ID: <2023090738-passive-snowless-3b9d@gregkh>
References: <20230906121525.3946250-1-deeratho@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906121525.3946250-1-deeratho@cisco.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:45:25PM +0530, Deepak Rathore wrote:
> From: Zheng Wang <zyytlz.wz@163.com>
> 
> [ Upstream commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 ]
> 
> In btsdio_probe, the data->work is bound with btsdio_work. It will be
> started in btsdio_send_frame.
> 
> If the btsdio_remove runs with a unfinished work, there may be a race
> condition that hdev is freed but used in btsdio_work. Fix it by
> canceling the work before do cleanup in btsdio_remove.
> 
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Deepak Rathore <deeratho@cisco.com>
> 

What tree(s) are you wanting this applied to?

thanks,

greg k-h
