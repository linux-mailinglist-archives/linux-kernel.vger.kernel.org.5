Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1072A78B699
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjH1RgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjH1Rfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:35:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFB21A1;
        Mon, 28 Aug 2023 10:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E075D64E5A;
        Mon, 28 Aug 2023 17:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65A1C433C7;
        Mon, 28 Aug 2023 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693244121;
        bh=l0URK5+hKXJ+ZT9yLXrM2vwer/pEtGQhRykpFAOPVes=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HSOXtyGAH1FTSAyZfiyKCFBM8xmGZXvN7k9Bs5YjbvDR8Ttz31nuwZimAvS+Oqgr1
         EVoMLyoJTqkrg+ixr2l2NbPT1zjXkoSdcCgMeawsWc7tNhabo6xCtkx7NvOClc+QlT
         trN2lOXZKG5CXrzoa4ImT36+siP9APNSZcEBJ/C31x6rfHlr6InNpMa/BX5DfWM1Nr
         lHjwBbsOVocvJskCBetjxNKRbsNCWsi9/1YfprkAHPvbYlJcFJQ6S5k4msvd0N0rwN
         P2ipqQiZE7s6IKwBkkY4FBf6vBSFKc53S2HeH7/cNkRpyR902jMTQVD74NBqgjFV6E
         oDTagiBdGuXqQ==
Date:   Mon, 28 Aug 2023 18:35:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: accel: kionix-kx022a: Use correct header(s)
 instead of string_helpers.h
Message-ID: <20230828183539.43799693@jic23-huawei>
In-Reply-To: <ZNTmNW1I2aI6ervP@smile.fi.intel.com>
References: <20230808164204.66818-1-andriy.shevchenko@linux.intel.com>
        <d8f84ec0-142d-88d1-c317-acfb8c234bad@gmail.com>
        <ZNTmNW1I2aI6ervP@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 16:29:25 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Aug 09, 2023 at 09:00:39AM +0300, Matti Vaittinen wrote:
> > On 8/8/23 19:42, Andy Shevchenko wrote:  
> > > There is nothing from string_helpers.h used in the driver, correct
> > > the header inclusion block accordingly.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > 
> > Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > 
> > Out of the curiosity - is the goal to get rid of including choices from
> > helpers? (I think) then the header split would be more beneficial.  
> 
> At the end, yes.
> 
> Thank you for acknowledging!
> 

Applied.
