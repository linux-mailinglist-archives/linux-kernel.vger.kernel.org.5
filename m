Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093C875DD86
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 18:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGVQxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 12:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVQxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 12:53:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338B71A1;
        Sat, 22 Jul 2023 09:53:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD0F760B06;
        Sat, 22 Jul 2023 16:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D819CC433C7;
        Sat, 22 Jul 2023 16:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690044815;
        bh=Y29p/fyLP/yVWP0radrZBPnFb3gL4bnZcfdmPVFRRtM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M4QMkDp2kGt5STnfWhJkOy/+l0IUZ0ny7T7N2BPIdexHV9XgsjpqQXPLo2m58Keca
         9hkpGmyJkgPT96sMMBruP8I2zeLXrHOGC1L/u+srkxR86XPHjntWFoew+/r7APg5Mo
         fpsiIgaLgwmIUwfs/s6CzoLH0WkvuiqWURVliwOOvl64/+jVjtUOuv3C4hpXImR38e
         9MdH7QPmxqEgc7KngHMSyd2uX4ctzy+QyInwCcCD9KbGAPCp+VfvN9SG1lPUHhZRmG
         L01VFFTEtGErn65fvkNMg9vYB3/AKdHMRfQ7wx307p9CwzDTjcmkUMXSsOFn7c7PvO
         yTyGMGEvGVfWw==
Date:   Sat, 22 Jul 2023 17:53:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Milan Zamazal <mzamazal@redhat.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v3] iio: core: Prevent invalid memory access when there
 is no parent
Message-ID: <20230722175332.3ac83cc8@jic23-huawei>
In-Reply-To: <ZLgA8QG67QGROzwW@smile.fi.intel.com>
References: <20230719083208.88149-1-mzamazal@redhat.com>
        <ZLgA8QG67QGROzwW@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 18:27:45 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Jul 19, 2023 at 10:32:08AM +0200, Milan Zamazal wrote:
> 
> > Changes in v3:
> >  - The call trace in the commit message reduced to the minimum lines
> >    needed to explain the problem.  
> 
> Precisely, that deserves my tag which I already had given :-)
> Thank you!
> 
Applied to the fixes-togreg branch of iio.git.

In theory every device should have a parent, but this fix is more
minimal than adding one for the dummy device (which we should still do
- even if it's a virtual device of some type that we create just for this
purpose).

That reminds me, I was in process of fixing this for perf drivers and
forgot to finish it off :)

Jonathan


