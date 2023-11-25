Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43DB7F88D7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjKYHfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYHe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:34:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2F910F6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 23:35:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C364C433C7;
        Sat, 25 Nov 2023 07:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700897705;
        bh=zPOBzZx43U5hf8TwnbJx30DgsWNOssZV3HiN/UWC8Bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjS3OuNE7NuzkT1dJ0if+kJDQqREjezr/iBO3Tb+3fIOoaMIsk2IOlB9W6HNJFwZ5
         ZcL+tHZZ9O/ysEyktWsUD7zLUCw2fowqqujui8Dqk+5X+fUwM3z5wjHLqxL13gAXCD
         eZM9TvgYEpYkp+sJSlaUR7yr2nKTFJMmRpc5WwdI=
Date:   Sat, 25 Nov 2023 07:22:49 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4 0/6] Cleanup AMBA PL011 driver
Message-ID: <2023112521-variably-snowcap-0861@gregkh>
References: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 02:42:38PM +0100, Théo Lebrun wrote:
> Hi,
> 
> While adding upstream support to a new platform (Mobileye EyeQ5[1]) that
> uses the AMBA PL011 driver, I took some time to look at the PL011
> driver and ended up with a few patches that cleanup parts of it. The
> line-diff is big mostly because of the checkpatch-fixing commits.
> 
> The driver hadn't received any love for quite some time. See commit
> messages for more information.
> 
> We can thank Ilpo Järvinen for the V3 & V4. V4 fixes an inversed if
> expression bug added in [PATCH V3 6/6].

This series causes build errors in linux-next so I'm dropping them from
my tree now.

greg k-h
