Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB15788527
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244496AbjHYKl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHYKlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:41:25 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3DC10C3;
        Fri, 25 Aug 2023 03:41:22 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qZUFh-007iKH-Lu; Fri, 25 Aug 2023 18:41:18 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Aug 2023 18:41:18 +0800
Date:   Fri, 25 Aug 2023 18:41:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, andriy.shevchenko@intel.com, alx@kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 1/2] crypto: qat - refactor included headers
Message-ID: <ZOiFTtsboa2rpSBI@gondor.apana.org.au>
References: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
 <20230818102322.142582-2-lucas.segarra.fernandez@intel.com>
 <ZOiEHCsjBCL04Z3x@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOiEHCsjBCL04Z3x@gondor.apana.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 06:36:12PM +0800, Herbert Xu wrote:
> On Fri, Aug 18, 2023 at 12:23:08PM +0200, Lucas Segarra Fernandez wrote:
> >
> > diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c
> > index 34c6cd8e27c0..3bde8759c2a2 100644
> > --- a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c
> > +++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm.c
> > @@ -2,6 +2,9 @@
> >  /* Copyright(c) 2022 Intel Corporation */
> >  #include <linux/bitfield.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/kstrtox.h>
> > +#include <linux/types.h>
> 
> Please include linux/kernel.h instead of these two.

No need to resubmit.  I will fix this up when I apply these two
patches.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
