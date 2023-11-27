Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A437FA190
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjK0Nys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjK0NyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:54:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDE619B2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:54:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195E2C433D9;
        Mon, 27 Nov 2023 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701093263;
        bh=nHcVBOaROmeBm+nheQsNKaXqOlw3ssipp4FWCOkdjNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uh5mO4sHs3WpGxn3J7lrp3czlNz2rm+Yz+2cHNtuXBOE1hHuUx1s37vdz+wTxuF0L
         UBSbhp66tGKIiksBtz7Ag22obvhESD/eebjG69c/50iPd84uQNaBGk4et28IcHOv3R
         EszlK8r2oEDLWd/8lN/+ADEukbz2mvkzp+L9Wuxo=
Date:   Mon, 27 Nov 2023 13:37:53 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc-linus for v6.7-rc3 V2] mei: pxp: fix
 mei_pxp_send_message return value
Message-ID: <2023112733-grapple-freefall-4565@gregkh>
References: <20231126092449.88310-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126092449.88310-1-tomas.winkler@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 11:24:49AM +0200, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> mei_pxp_send_message() should return zero on success and
> cannot propagate number of bytes as returned by internally
> called mei_cldev_send().
> 
> Fixes: ee5cb39348e6 ("mei: pxp: recover from recv fail under memory pressure")
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V2: This is a resent for https://lkml.org/lkml/2023/10/31/636

Nit, please use lore.kernel.org, we have no idea who runs lkml.org and
it really doesn't work well for actual development.

thanks,

greg k-h
