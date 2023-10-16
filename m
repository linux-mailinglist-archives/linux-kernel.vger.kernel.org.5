Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989E07CB1BC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjJPR67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJPR64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:58:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C89F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:58:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DCCC433C8;
        Mon, 16 Oct 2023 17:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697479135;
        bh=nJdAek3aZycrgMRdKYtUObmKFrKh7KF0eBAThEzF7Ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WLiBB2PeXGi7MHr1L86TAUfGDT3KusatDeMchxwb3O1l72p3IXnbY5RLcp3gZ1rLh
         WS0jHxrmNqgqAG16XmdgHtl3UHsXnswRR1XWE6PeK54gaygsOQCrUkJA7/q3kKMe98
         2Ij+QrDEgkyeDDiyPFmLGwL6f/y2V9R3hBnaamD4=
Date:   Mon, 16 Oct 2023 19:47:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: retimer: Check dev_set_name() return value
Message-ID: <2023101630-tiger-sizable-050f@gregkh>
References: <tencent_A06A37B6A0C0643DEC1524501525866FAC09@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A06A37B6A0C0643DEC1524501525866FAC09@qq.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 05:24:53PM +0800, Zhang Shurong wrote:
> It's possible that dev_set_name() returns -ENOMEM.
> We fix this by catching the error and handling it.
> 
> Fixes: ddaf8d96f93b ("usb: typec: Add support for retimers")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>  drivers/usb/typec/retimer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

How was this found?

How was this tested?
