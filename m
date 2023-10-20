Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987FF7D07EC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbjJTFyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235630AbjJTFyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:54:51 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E20D64;
        Thu, 19 Oct 2023 22:54:48 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qtiT2-0097br-3n; Fri, 20 Oct 2023 13:54:41 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Oct 2023 13:54:45 +0800
Date:   Fri, 20 Oct 2023 13:54:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-crypto@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Do not offer sha224 for built-in module signing
Message-ID: <ZTIWJYNNu5mQlqky@gondor.apana.org.au>
References: <20231010212633.64042-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010212633.64042-1-dimitri.ledkov@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:26:33PM +0100, Dimitri John Ledkov wrote:
> sha224 does not provide enough security against collision attacks
> relative to the default keys used for signing (RSA 4k & P-384). Also
> sha224 never became popular, as sha256 got widely adopter ahead of
> sha224 being introduced.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>  kernel/module/Kconfig | 5 -----
>  1 file changed, 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
