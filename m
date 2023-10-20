Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EAD7D07EE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbjJTFy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjJTFyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:54:51 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3FED65;
        Thu, 19 Oct 2023 22:54:48 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qtiSm-0097bb-Am; Fri, 20 Oct 2023 13:54:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Oct 2023 13:54:29 +0800
Date:   Fri, 20 Oct 2023 13:54:29 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Luis Chamberlain <mcgrof@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] crypto: pkcs7: remove sha1 support
Message-ID: <ZTIWFcFgpOsaE05N@gondor.apana.org.au>
References: <20231010212240.61637-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010212240.61637-1-dimitri.ledkov@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:22:38PM +0100, Dimitri John Ledkov wrote:
> Removes support for sha1 signed kernel modules, importing sha1 signed
> x.509 certificates.
> 
> rsa-pkcs1pad keeps sha1 padding support, which seems to be used by
> virtio driver.
> 
> sha1 remains available as there are many drivers and subsystems using
> it. Note only hmac(sha1) with secret keys remains cryptographically
> secure.
> 
> In the kernel there are filesystems, IMA, tpm/pcr that appear to be
> using sha1. Maybe they can all start to be slowly upgraded to
> something else i.e. blake3, ParallelHash, SHAKE256 as needed.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>  crypto/asymmetric_keys/mscode_parser.c    |  3 -
>  crypto/asymmetric_keys/pkcs7_parser.c     |  4 --
>  crypto/asymmetric_keys/public_key.c       |  3 +-
>  crypto/asymmetric_keys/signature.c        |  2 +-
>  crypto/asymmetric_keys/x509_cert_parser.c |  8 ---
>  crypto/testmgr.h                          | 80 -----------------------
>  include/linux/oid_registry.h              |  4 --
>  kernel/module/Kconfig                     |  5 --
>  8 files changed, 2 insertions(+), 107 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
