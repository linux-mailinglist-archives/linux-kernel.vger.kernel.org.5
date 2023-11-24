Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484167F78C5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjKXQS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjKXQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:18:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9EA12B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:19:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD71C433C8;
        Fri, 24 Nov 2023 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700842741;
        bh=CEV7NAR5P1IEKIo7VE/OV4UHEH/9vFQ5XlpsJWnIDAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDt22oQ4NnvkfTOMZwj19/fd/1D3bToLigf3b0JIOQlqPwpexWA/Ctdlzj9xXiQVr
         U4YM5Iv9kdKkdQzNeeHIVdPM/xFpr1G7ls5pDovwGOjQvqV8WuAgAw6j1e2RIGOvFU
         oZylt9SmZRcuo548M/AdQoDWJsdd3GLFv7M8Hubg=
Date:   Fri, 24 Nov 2023 16:18:59 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Tomasz Rostanski <tomasz.rostanski@thalesgroup.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: Fwd: dwc3: regression in USB DWC3 driver in kernel 5.15 branch
Message-ID: <2023112424-escalate-saga-2b01@gregkh>
References: <bfee63a3-16ee-0061-94c0-9c9af5318634@gmail.com>
 <635eb180-0dea-4dc7-a092-be453bf80023@leemhuis.info>
 <f7d315b1-f43d-4573-81f0-a4014f3ac0bb@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7d315b1-f43d-4573-81f0-a4014f3ac0bb@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 04:25:30PM +0100, Thorsten Leemhuis wrote:
> Hi. Top-posting for once, to make this easily accessible to everyone.
> 
> To Greg and everyone that might care: apparently Tomasz lost interest in
> fixing this 5.15.y regression. Kinda sad, as the patches are mostly
> there, but lack a S-o-b tag -- which means we are stuck here, unless
> somebody else attempts a backport.
> 
> https://lore.kernel.org/all/20230904071432.32309-1-tomasz.rostanski@thalesgroup.com/
> 
> I'll thus stop tracking this regression.

Thanks, I'll wait for a working backport for those using the 5.15.y tree
and this driver as it's not anything that I am capable of doing at this
point in time.

greg k-h
