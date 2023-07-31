Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0385769763
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjGaNWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjGaNWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:22:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF7A10DD;
        Mon, 31 Jul 2023 06:22:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2957F61147;
        Mon, 31 Jul 2023 13:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9AAC433C7;
        Mon, 31 Jul 2023 13:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690809750;
        bh=WpJsh3fyEuGUo6PH6fN0EFyznVrVxs5GaJUXkqK1ArM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gcpEgFq/S32d3pUMyuyl/Kot/n40hCWR6RpeLyaKC5hCseKd0FZyXQ6XKJVSPdUYe
         Ry+ctDKz7oRurSz3gR7+R6N4+4gf34rqN7zkBtuVetSuenkuKAltbYa4kkJ26LYITn
         cAG3ZCVRWCfnSAB5MG+KhAtyHTtqYU+s4qBd/qqY=
Date:   Mon, 31 Jul 2023 15:22:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Chengfeng Ye <dg573847474@gmail.com>,
        kernel-janitors@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: synclink_gt: Fix potential deadlock on &info->lock
Message-ID: <2023073123-poser-panhandle-1cb7@gregkh>
References: <20230728123901.64225-1-dg573847474@gmail.com>
 <a95e699c-c507-931e-92b0-7f63a5e3a9e1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a95e699c-c507-931e-92b0-7f63a5e3a9e1@web.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
