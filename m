Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5B78C233
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjH2KSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbjH2KSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:18:35 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD81191;
        Tue, 29 Aug 2023 03:18:29 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qavnj-008qMP-7B; Tue, 29 Aug 2023 18:18:24 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 29 Aug 2023 18:18:24 +0800
Date:   Tue, 29 Aug 2023 18:18:24 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, alx@kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH v2 1/2] crypto: qat - refactor included headers
Message-ID: <ZO3F8AgOS/NnVaeU@gondor.apana.org.au>
References: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
 <20230818102322.142582-2-lucas.segarra.fernandez@intel.com>
 <ZOiEHCsjBCL04Z3x@gondor.apana.org.au>
 <ZOigoVJbjdOx9Wea@smile.fi.intel.com>
 <ZOx1SOBKbmdIvz+b@gondor.apana.org.au>
 <ZOx6+i5HEAY4F4X3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOx6+i5HEAY4F4X3@smile.fi.intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 01:46:18PM +0300, Andy Shevchenko wrote:
>
> kernel.h is misleading here. It includes 98% of something which this file is
> not using or going to use. Can you tell _why_ we need that 98% bulk to be
> included here?

For most drivers in drivers/crypto they will need multiple header
files included by kernel.h.  I'd hate for people to start posting
patches replacing one inclusion of kernel.h with multiple inclusions.

They're bound to get it wrong and we'll be forever dealing with
random build failures because someone changes a random header
elsewhere which then exposes a missed inclusion.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
