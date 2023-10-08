Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EEA7BCC35
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 06:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344366AbjJHEyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 00:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344352AbjJHEyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 00:54:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800E4BD
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 21:53:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CE8C433C8;
        Sun,  8 Oct 2023 04:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696740832;
        bh=iHUP7w1yj6B3J67wHuveEb6hh0Uh72axIwrx7bDqPIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehtsUKT1V6Gpejv28as1A34jPVJbPEyGD+ZGm+6GjheNHGiQ4de6LwXqePdRdT/qd
         OKXwMZWAVnA766zElWJ+ekdiimlVAtHX5SbyZpABJqqWErmjCYi6LFKRXAfLI1dvtq
         9a1lk3hjYxvN/QfIm02UbtaG1emNhrcKNXPkYrsM=
Date:   Sun, 8 Oct 2023 06:53:49 +0200
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
Subject: Re: [PATCH 1/2] lib/bitmap: move bitmap allocators for device to
 linux/device.h
Message-ID: <2023100855-railroad-wrecking-25af@gregkh>
References: <20231007233510.2097166-1-yury.norov@gmail.com>
 <20231007233510.2097166-2-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007233510.2097166-2-yury.norov@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 04:35:09PM -0700, Yury Norov wrote:
> The allocators are simple wrappers around bitmap_{alloc,free}().
> So move them from bitmap to device sources.

No, they belong in the bitmap.h file, as they are devm_* versions of the
same functions in this file.  They don't belong in the device.h file.

> Similarly to other device wrappers, turn them to static inlines
> and place in header.

Why do these need to be inline functions?

thanks,

greg k-h
