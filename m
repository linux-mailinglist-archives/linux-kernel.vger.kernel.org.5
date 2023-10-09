Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8D27BE7C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377515AbjJIRYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377314AbjJIRYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:24:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE1594
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:24:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC3DC433C8;
        Mon,  9 Oct 2023 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696872244;
        bh=GKFEMN07hNN5E82vN+0pDhAfiO1nUR4XmqjuuROxYI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gaeCO8adurUwxASZD9wB3BP6/8Uz3GUJS7FD6aNiJ2KGWv+chps2D9Eg4pniyWtYO
         MSY0ZivypkGcAdu/Rz5IstpFGurLL4yJ5tf0b7mgo3n02SSLmgB92sbLalLiSXaN8W
         naBQjkpOGBlzZHk2SK5sFsNTdfytbVP5JtxLZZBM=
Date:   Mon, 9 Oct 2023 19:24:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] drivers/rtc/sysfs: move code to
 count_attribute_groups()
Message-ID: <2023100943-anew-choking-5954@gregkh>
References: <20231009165741.746184-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009165741.746184-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:57:34PM +0200, Max Kellermann wrote:
> This avoids overloading the "groups" variable for three different
> purposes

What 3 different purposes?

And you sent a patch series that hit a lot of different subsystems and
maintainers all at once, but you didn't cc: all of us.  Who is supposed
to take these?

But step back, _WHY_ are all of these changes needed?  I don't see a
cover letter explaining the rational, and on their own, they really
don't do anything, so it's really confusing as to what is going on here.

thanks,

greg k-h
