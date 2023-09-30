Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACB27B3FBA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 11:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbjI3Jix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 05:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjI3Jiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 05:38:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8E1DD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 02:38:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27E9C433C7;
        Sat, 30 Sep 2023 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696066728;
        bh=IvpiOG/bGE3T67kaLiqC3a217xhno8NefOjxFtDtAkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WaJVTLBeni9ABYwJGH6p5NdtU/RU11lfOkq4o8gQbfieAj6Xnu0oPttIzCz/pyfLD
         zfTdBg1nNBQgV/qTj+JiGRQfkYtvcqEH6wKhSQRy3qHNAswsL8/wJRZIiqy/KwH3qN
         XJnhdlMtd5WJtvr9+PF0pxAhe4SXcD3e669r7MFw=
Date:   Sat, 30 Sep 2023 11:38:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        llvm@lists.linux.dev, alsa-devel@alsa-project.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] device property: Replace custom implementation of
 COUNT_ARGS()
Message-ID: <2023093029-balmy-shrewdly-3e3d@gregkh>
References: <20230920153819.2069869-1-andriy.shevchenko@linux.intel.com>
 <CAKwvOd=7vk2HKOpgVrRd2RtKSF9tXPqbVmN+5teLTNoBy4BWVg@mail.gmail.com>
 <CAKwvOdkbcUh+tmsNcT4nCzFY37WbAUdjHJ62qNe=p8SetaQNTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdkbcUh+tmsNcT4nCzFY37WbAUdjHJ62qNe=p8SetaQNTQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 09:10:11AM -0700, Nick Desaulniers wrote:
> On Wed, Sep 20, 2023 at 9:50 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Sep 20, 2023 at 8:38 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Replace custom and non-portable implementation of COUNT_ARGS().
> > >
> > > Fixes: e64b674bc9d7 ("software node: implement reference properties")
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Closes: https://lore.kernel.org/r/ZQoILN6QCjzosCOs@google.com
> >
> > Thanks for the patch!
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1935
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Of course Linux would have a macro for this!  I should have known.
> > Trying to wrap my head around it. Awesome
> 
> (resending as text/plain)
> 
> Can someone pick this up for linux-next?
> 
> CI for linux-next has been red for days over this.

Will do, give me a chance to catch up...

greg k-h
