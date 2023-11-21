Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00B17F35A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjKUSF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbjKUSFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:05:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37B110E0;
        Tue, 21 Nov 2023 10:05:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F1AC433BA;
        Tue, 21 Nov 2023 18:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700589901;
        bh=PrYlDSh1KBKY9nagnX9e/CAxyEWyzd/7cpff2wOc4d0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dCWz9bft7GOg0xCs3XqYU93HlqP0iTjUumlFjUIAeORz4ELrJWXdZHIIAyiSUjec9
         MIwykqkrj3utYxnPuOd9txndbD9zUY8q12wOCym2nxYPKCC8SE8cfxIYaXQlNwXQXl
         FvFf841GDAQloRn78ZE7dvVzfo4lJqiD1Bp/LGAE=
Date:   Tue, 21 Nov 2023 19:04:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sanath S <Sanath.S@amd.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        stable@vger.kernel.org
Subject: Re: [Patch] thunderbolt: Add quirk to reset downstream port
Message-ID: <2023112111-shelf-deeply-6a03@gregkh>
References: <20231121174701.3922587-1-Sanath.S@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121174701.3922587-1-Sanath.S@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:17:01PM +0530, Sanath S wrote:
> Boot firmware on AMD's Yellow Carp and Pink Sardine allocates
> very minimal buses for PCIe downstream ports. This results in
> failure to extend the daisy chain.
> 
> Add quirk to reset the downstream port to help reset the topology
> created by boot firmware.
> 
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Sanath S <Sanath.S@amd.com>
> Cc: <stable@vger.kernel.org>

What commit id does this fix?

thanks,

greg k-h
