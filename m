Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C202478077D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358778AbjHRIvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358771AbjHRIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:51:13 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0641430E6;
        Fri, 18 Aug 2023 01:51:12 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qWvCD-005EnG-5I; Fri, 18 Aug 2023 16:51:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Aug 2023 16:51:05 +0800
Date:   Fri, 18 Aug 2023 16:51:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, alx.manpages@gmail.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH 4/4] crypto: qat - add pm_status debugfs file
Message-ID: <ZN8w+WVxexzMZXj7@gondor.apana.org.au>
References: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
 <20230817143352.132583-5-lucas.segarra.fernandez@intel.com>
 <ZN8BipaGe6DOwiVS@gondor.apana.org.au>
 <ZN8v/2McQboR3dIu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN8v/2McQboR3dIu@smile.fi.intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 11:46:55AM +0300, Andy Shevchenko wrote:
>
> Splitting ARRAY_SIZE() is very beneficial on its own.
> The static assert is slightly more robust for the big code then defining
> something that at some point can be missed or miscalculated. Yet we can
> survive with a macro if you thinks it's better.

Yes please go ahead with just a macro.

If the ARRYA_SIZE thing turns out to be useful for other people I'm
sure it'll be added.  But I don't see much value in this particular
use.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
