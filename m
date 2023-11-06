Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F48A7E27A7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjKFOvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjKFOu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:50:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65672BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:50:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B28C433C7;
        Mon,  6 Nov 2023 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699282256;
        bh=PrPL5yxS0XHR88fAG6CPc6WPfIQAznLRMTKPqNE0Xjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rE7oATpe1ZgWfXcIoEEYTKuDO2oyjiZolXVeLIPumiw25dIWXVc3fhdbRCYyTsa1+
         a3qHcvLQ3yPKfm9y4yFqhEYVmpUZMBlBgG8DrbKm/+JkGfs+eG+EClGCKFCl+bY0gt
         2LSz4dlsQrVCCzaQBJXNcxW402GnJMy2GHaJNQX4+Xph7yOyHBVIa3yDcBlCiWhMf0
         ajGM/77GJy0kUF3VP1S068yabBhLX0AG1XWKxx1UHBGLcEVMFEOMZ8DAVrEzb7zKWr
         67LMJ6vwibIagt+HyiOeI+IJh6XgyCkX+emCBddz3rWw/43wTWtOz97ccPJgs19jFV
         wl4j8poomrivA==
Date:   Mon, 6 Nov 2023 15:50:46 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill O'Donnell <bodonnel@redhat.com>
Subject: Re: [GIT PULL for v6.7] autofs updates
Message-ID: <20231106-aufleben-umfeld-25a2cd86e521@brauner>
References: <20231027-vfs-autofs-018bbf11ed67@brauner>
 <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net>
 <ZT+9kixqhgsRKlav@redhat.com>
 <61f26d16-36e9-9a3c-ad08-9ed2c8baa748@themaw.net>
 <83a889bd-3f9e-edce-78ff-0afa01990197@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83a889bd-3f9e-edce-78ff-0afa01990197@themaw.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Christian, David's original conversion patch for devpts looks like it's
> 
> still relevant, it also looks fairly small to the point that I'm wondering
> 
> if it's worth breaking it down into smaller patches.

I vaguely remember that patch and no, for simple fses like devpts
breaking this into smaller chunks is probably not worth it.

These conversions patches often aren't easy to split nicely anyway.

> Would you be ok with me just doing a straight patch apply, detailed review
> 
> and some testing before posting it?

Sure.
