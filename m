Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747457535D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjGNI51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbjGNI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:57:25 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BE226B2;
        Fri, 14 Jul 2023 01:57:24 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qKEc1-001Rgy-DY; Fri, 14 Jul 2023 18:57:18 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Jul 2023 18:57:10 +1000
Date:   Fri, 14 Jul 2023 18:57:10 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     You Kangren <youkangren@vivo.com>
Cc:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Adam Guerin <adam.guerin@intel.com>,
        Srinivas Kerekare <srinivas.kerekare@intel.com>,
        Damian Muszynski <damian.muszynski@intel.com>,
        "open list:QAT DRIVER" <qat-linux@intel.com>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com, luhongfei@vivo.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6] crypto: qat - replace the if statement with min()
Message-ID: <ZLEN5qmCbcXSQ0G8@gondor.apana.org.au>
References: <20230704124534.1127-1-youkangren@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704124534.1127-1-youkangren@vivo.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 08:45:32PM +0800, You Kangren wrote:
> Mark UWORD_CPYBUF_SIZE with U suffix to make its type the same
> with words_num. Then replace the if statement with min() in
> qat_uclo_wr_uimage_raw_page() to make code shorter.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: You Kangren <youkangren@vivo.com>
> ---
> Changelog:
> v5->v6:
> - Remove the unnecessary Fixes tag of the patch
> - Change the first letter of "replace" in the headline of the commit message to lower case
> 
> v4->v5: 
> - Add the Fixes and Reviewed-by tags of the patch
> - Add the version update information of the patch
> 
> v3->v4:
> - Remove the header file <linux/minmax.h> in v3
> 
> v2->v3:
> - Add a header file <linux/minmax.h>
> - Mark UWORD_CPYBUF_SIZE with U suffix
> - Change min_t() to min() in qat_uclo_wr_uimage_raw_page()
> 
> v1->v2:
> - Change min() to min_t() in qat_uclo_wr_uimage_raw_page()
> 
>  drivers/crypto/intel/qat/qat_common/qat_uclo.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
