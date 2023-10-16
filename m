Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EACE7CB2A1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjJPSio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjJPSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:38:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F778ED
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:38:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AB8C433CA;
        Mon, 16 Oct 2023 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697481517;
        bh=AFdp8omPmPiBhjxSWDTVQjJWPxG/mPwHxdogni4Y9ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3cs+lvEJlruCKwHIQnoEdwi7Sn6r9wueNkl6xsI6JnweopGjxi83ajur94JRAKQs
         ctj86mg8rT9JCXhueBrHxJx2wyIM6ScI1GlTJgb7UC9f5m8zQRQUjhRJnjaeLtbWxQ
         8PR5Oq7isHHrSW0PwiGBvism99GdqTzQxy4Dt+VU=
Date:   Mon, 16 Oct 2023 20:38:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Seo <james@equiv.tech>, Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>,
        Mark Brown <broonie@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Rae Moar <rmoar@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] lib: unload lib/bitmap.c
Message-ID: <2023101622-footsie-example-6428@gregkh>
References: <20231007233510.2097166-1-yury.norov@gmail.com>
 <ZStPPLG7F9V+E7JA@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZStPPLG7F9V+E7JA@yury-ThinkPad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 07:32:28PM -0700, Yury Norov wrote:
> On Sat, Oct 07, 2023 at 04:35:08PM -0700, Yury Norov wrote:
> > The file is intended to hold functions to operate on bit arrays, but
> > this days, more than 1/3 of bitmap.c is helpers for bitmap-to-string
> > converters, plus some wrappers for device.h.
> > 
> > So move those out of lib/bitmap.c in sake of readability and
> > maintainability.
> > 
> > Functionally, this series is a no-op.
> > 
> > Yury Norov (2):
> >   lib/bitmap: move bitmap allocators for device to linux/device.h
> >   lib/bitmap: split-out string-related operations to a separate files
> 
> OK, then if no objections, I drop #1 as a controversial, and pull #2
> into bitmap-for-next.

That's fine with me, thanks.

greg k-h
