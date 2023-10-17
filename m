Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D597CC4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbjJQNfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343794AbjJQNfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:35:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9512DF7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:35:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51D3C433C7;
        Tue, 17 Oct 2023 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697549708;
        bh=k+yqzl+5L7PWirICJ9XzjUlpyk8LvIvWdjeOdYVdKSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uAf4KdNv0qw7PCwM8H8/EQgsDZQXeqpHZeYLUImzFIfGjfxQAS+Y2F6/kxdmNdOQv
         GXLkNA6/n6ISlhu0v5pYKxiNDvif1DQ/uw9TX+z3YBXNyk7CWk25q2JvD1GBCAOaRk
         0hzjITR53t8PQ8gD86WMqfrQfI7xfF9Lv8TQrG6s=
Date:   Tue, 17 Oct 2023 15:35:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] staging: rtl8192u: remove entry from Makefile
Message-ID: <2023101757-defy-spiny-4faa@gregkh>
References: <2023101709-amuck-upward-46f1@gregkh>
 <51fcd05c-cb8e-420f-be62-0c9ade82fbfb@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51fcd05c-cb8e-420f-be62-0c9ade82fbfb@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 12:35:57PM +0200, Thorsten Leemhuis wrote:
> On 17.10.23 10:13, Greg Kroah-Hartman wrote:
> > In commit 697455ce4110 ("staging: rtl8192u: Remove broken driver"), the
> > driver was removed, along with the Kconfig entry, but the Makefile line
> > in drivers/staging/Makefile was not updated, so things like 'make clean'
> > fail to work properly as they will decend into all subdirectories to try
> > to clean things up.
> > 
> > Resolve this by removing the entry in the main staging Makefile.
> > 
> > Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> > Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Fixes: 697455ce4110 ("staging: rtl8192u: Remove broken driver")
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thx Greg, that fixed things for my case. In case anyone cares:

I care, thanks!
