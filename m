Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6381D78E534
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbjHaD4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241724AbjHaD4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:56:04 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAAFCF4;
        Wed, 30 Aug 2023 20:55:56 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qbYmd-009Wqh-8x; Thu, 31 Aug 2023 11:55:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 31 Aug 2023 11:55:52 +0800
Date:   Thu, 31 Aug 2023 11:55:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, alx@kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH v2 1/2] crypto: qat - refactor included headers
Message-ID: <ZPAPSOnSTMgYrlV/@gondor.apana.org.au>
References: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
 <20230818102322.142582-2-lucas.segarra.fernandez@intel.com>
 <ZOiEHCsjBCL04Z3x@gondor.apana.org.au>
 <ZOigoVJbjdOx9Wea@smile.fi.intel.com>
 <ZOx1SOBKbmdIvz+b@gondor.apana.org.au>
 <ZOx6+i5HEAY4F4X3@smile.fi.intel.com>
 <ZO3F8AgOS/NnVaeU@gondor.apana.org.au>
 <ZO375Wg0+nTCgCIJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO375Wg0+nTCgCIJ@smile.fi.intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 05:08:37PM +0300, Andy Shevchenko wrote:
>
> Do I understand correctly that you want *ideally* to have THE kernel.h
> as a _single_ header and that's it?

My rule of thumb for a .c file is that if you need more than two
headers directly included by kernel.h then you should just use
kernel.h.

> While I understand your motivation as a maintainer, I hate the idea of current
> kernel.h to be included as a silver bullet to every file because people are not
> capable to understand this C language part of design. The usage of the proper
> headers show that developer _thought_ very well about what they are doing in
> the driver. Neglecting this affects the quality of the code in my opinion.
> That's why I strongly recommend to avoid kernel.h inclusion unless it's indeed
> the one that provides something that is used in the driver. Even though, the
> rest headers also need to be included (as it wasn't done by kernel.h at any
> circumstances).

I have no qualms with fixing header files that include kernel.h
to include whatever it is that they need directly.  That is a
worthy goal and should be enforced for all new header files.

I just don't share your enthusiasm about doing the same for .c
files.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
