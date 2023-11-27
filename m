Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AEF7F9C22
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjK0IyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjK0Ixz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:53:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5344BCB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:54:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD9EC433C7;
        Mon, 27 Nov 2023 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701075240;
        bh=YsSjMoDjG9d/dtc+Vhmds+9B8Q2fIcClNqcZlZ8pY5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XZO4aOuXMP25TUfZbPx+yFAKcQtLr6eNyPYziWmgX5qhff78Uu3JuCLjHuCuNJ+Xy
         RfEhPzFygaSnA6G35DSp29oMIoXGDRfYPKnT0BgIJr8Ba3QRIJAum7/c+wYVHrzKlx
         CpP1r+v9aLU24TlYw7E5BGUGZBi/HR+wr3+6oj6KAmW7+rJXaUqCFrmXIDjZbABdB4
         FI0UEPG64iSheuHpJGjrrfFPrT4uuGBGnRwjn7uVdR5Le602is29JplScfEwnoKbe3
         Wgt9oOLs3FIJaULAtPgEgqjiRWTBn9Q+SbB+k5/TBs2/Fvv4ZHX/OvmCT5lBlVqH6t
         ENhCRusee4XKQ==
Date:   Mon, 27 Nov 2023 08:53:56 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: Add missing check for
 platform_get_resource
Message-ID: <20231127085356.GD1470173@google.com>
References: <20230609014818.28475-1-jiasheng@iscas.ac.cn>
 <ZWDhpZLCZ5xz1RKR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWDhpZLCZ5xz1RKR@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023, Andy Shevchenko wrote:

> On Fri, Jun 09, 2023 at 09:48:18AM +0800, Jiasheng Jiang wrote:
> > Add the missing check for platform_get_resource and return error
> > if it fails.
> 
> > Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> 
> This does not fix anything and just introduces a duplication code.
> I would like this to be reverted. Should I send one?

Checking this value at the source of obtention and providing and earlier
return with arguably a better return value, all at the cost of an
inexpensive pointer comparison to NULL doesn't sound like a terrible
idea.

If you were committed to the idea of removing it, which I suggest you
reconsider, I would insist that you replace it with at least a comment.

-- 
Lee Jones [李琼斯]
