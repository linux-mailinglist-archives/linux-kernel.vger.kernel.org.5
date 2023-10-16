Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2330C7CA7FD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjJPMaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjJPMag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:30:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F5FEB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:30:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD00FC433C8;
        Mon, 16 Oct 2023 12:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697459431;
        bh=HDa7hBcpXz3cDWrePvISKzWuUpZtggI/pzMpkSCoSK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FPn3Jz9o94fKkoYZpQw1fI5oLRCM3hqZldF9TktcSS3c4Ox77ABydFzWguO3SXDlN
         wVockS6pLFQdGOnC6/Tfb1MmBN0WEeS7xrdA631ImwFmWY1s0Ka9zy5sckKHNmvhaL
         V+Yjw9NZaZVjNLwtS32mKDvGylhdFmyhQfPxNWaPczrt5PcCtJBvoI2xXMWJvfTbPw
         mWEtBN3n+3X3wB9siZuHvMzrWRcNlY2u8wTQ3CicL6NjRZ7qXSCzxBNG7AbBWiQtVD
         h6ctXD3IQcIF/GgAPf3jBptNL/mkk98xag9D2EwtsJo04283l8Ff19uDHIT4atzKjl
         BSxoSncPWVt3A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qsMjq-0003h0-0c;
        Mon, 16 Oct 2023 14:30:26 +0200
Date:   Mon, 16 Oct 2023 14:30:26 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Daniel Danzberger <dd@embedd.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gnss/usb: Add U-blox 8/M8 device id
Message-ID: <ZS0s4m9RTxOpLwSr@hovoldconsulting.com>
References: <20230907064413.1302336-1-dd@embedd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907064413.1302336-1-dd@embedd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:44:13AM +0200, Daniel Danzberger wrote:
> Adds support for U-Blox 8 GNSS devices

I have u-blox 8 device with the same PID here as well and that one
identifies itself as a CDC device and is managed by the cdc-acm driver
currently.

Can you please post the output of lsusb -v for your device?

> +	{ USB_DEVICE(0x1546, 0x01a8) },         /* U-blox 8/M8 GNSS Receiver */

Johan
