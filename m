Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429DE7CFDDE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345977AbjJSPbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345747AbjJSPbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:31:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA0C121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:31:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2B7C433C9;
        Thu, 19 Oct 2023 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697729479;
        bh=eFIqv6PT8zFfTS2Wvhm/KJywp22U/mEaQLbVWOOiAG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmNCDDyUIYcCrJMG7idhPxGRpIvOAwchg9u02JNpbMkQNdDnD6nufLI9vlCbNLYlj
         z02/7uT8fz7vYP97lXebp4v+4yXsr6l9Su54GV1YwZI1zJx3uO+QkSR7zG8EcasXLl
         psLjXbmANIHQBeAa0d2omrSs4pLcVC0h1g6WfwKw=
Date:   Thu, 19 Oct 2023 17:31:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Calvince Otieno <calvncce@gmail.com>
Cc:     gustavo@embeddedor.com, outreachy@lists.linux.dev,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vc04_services: remove empty functions
Message-ID: <2023101938-canopener-evasive-3590@gregkh>
References: <ZTD677iqMkRPxT27@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTD677iqMkRPxT27@lab-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:46:23PM +0300, Calvince Otieno wrote:
> The functions vchiq_debugfs_init(), vchiq_debugfs_deinit(),
> vchiq_debugfs_add_instance(), and vchiq_debugfs_remove_instance()
> are declared and defined but contains no code or statements.
> They do nothing.

On the contrary, they do a lot!  Try building with CONFIG_DEBUG_FS
disabled and see what happens with your patch applied (hint, it breaks
the build badly...)

To be fair, the "empty" functions should be moved to the .h file, not
the .c file, so if you want to do that, it would make more sense
overall.

thanks,

greg k-h
