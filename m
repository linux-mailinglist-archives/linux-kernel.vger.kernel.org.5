Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9587BA3BA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbjJEP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjJEP4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2884ED8;
        Thu,  5 Oct 2023 06:52:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1E4C4AF6A;
        Thu,  5 Oct 2023 13:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696512782;
        bh=BGZ37AUUud0e+3inw2fY++6jafQ2Lo1A7FxJ7ZWUW4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b3cGXr1nzW94OjzF9GJSrd+tj7iA+dk3N9vU2mSZ3nZ6hy5iRAIro31mwNe87ghmC
         RWu7hPzf8zrr1BOg15vzlq0qip/k/qWJxO5c9bp48EGc+IVwo09JSU565Gd9aXGSYr
         mC2661YLfXyGxm/osYsLycgUA+Opm2qvhYIq6kyymniScSJXzkTs2sNrmzjHvm5sTX
         zmQtgAa2ke/84PQYj9N0CBih+BSclejJavfVL76HakvznVoxjmYvvUBHrD7+Q8hcqg
         XC4D4XTFpc+lihsAeTC0i8H2UTeVYK5NiKQxrN59J3xS1bDylMLMKVo1pp+4u8V+73
         XN3qxW2LDNkqw==
Date:   Thu, 5 Oct 2023 14:33:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <nuno.sa@analog.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v2 2/2] iio: adc: meson: improve error logging at probe
 stage
Message-ID: <20231005143306.6add05e6@jic23-huawei>
In-Reply-To: <8ef7ff71-08e1-b0af-483d-e7cf3cc5efea@sberdevices.ru>
References: <20230721102413.255726-1-gnstark@sberdevices.ru>
        <20230721102413.255726-3-gnstark@sberdevices.ru>
        <ZLphZzO20QW+t1m/@smile.fi.intel.com>
        <20230722181559.02c8362c@jic23-huawei>
        <8ef7ff71-08e1-b0af-483d-e7cf3cc5efea@sberdevices.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 15:47:23 +0300
George Stark <gnstark@sberdevices.ru> wrote:

> Hello Jonathan
> 
> It seems like you haven't had time for this patch yet. Should I fix it 
> myself or just be more patient?
I've been exceptionally slow on this one.  Was still sitting in patchwork
but I'd failed to notice the dependency was now upstream.

Applied to the togreg branch of iio.git and I'll push that out initially
as testing later today (I have to do a rebase to fix up an issue
0-day caught on previous push before I do).

Thanks for the poke and sorry it was necessary!

Jonathan

> 
> On 7/22/23 20:15, Jonathan Cameron wrote:
> > On Fri, 21 Jul 2023 13:43:51 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> >> On Fri, Jul 21, 2023 at 01:23:09PM +0300, George Stark wrote:  
> >>> Add log messages for errors that may occur at probe stage  
> >>
> >> the probe  
> > 
> > British English - excellent ! :) (I argue this one far too often in
> > specification committees :)
> > 
> >   
> >>
> >> stage.
> >>  
> > 
> > I can tidy this up, but the patch will be a while anyway given the fix
> > needs to work it's way into the upstream for my togreg branch (and I need
> > to have send a pull request for togreg as well).
> > 
> > Jonathan
> >   
> 

