Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19C47BA80B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjJER3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjJER3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:29:24 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C7E36BA;
        Thu,  5 Oct 2023 10:26:54 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qoLaq-003lAQ-S2; Thu, 05 Oct 2023 18:28:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 05 Oct 2023 18:28:37 +0800
Date:   Thu, 5 Oct 2023 18:28:37 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: pkcs7: remove md4 md5 x.509 support
Message-ID: <ZR6P1UXERozcUnKW@gondor.apana.org.au>
References: <20231001235716.588251-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001235716.588251-1-dimitri.ledkov@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 12:57:15AM +0100, Dimitri John Ledkov wrote:
> Remove support for md4 md5 hash and signatures in x.509 certificate
> parsers, pkcs7 signature parser, authenticode parser.
> 
> All of these are insecure or broken, and everyone has long time ago
> migrated to alternative hash implementations.
> 
> Also remove md2 & md3 oids which have already didn't have support.
> 
> This is also likely the last user of md4 in the kernel, and thus
> crypto/md4.c and related tests in tcrypt & testmgr can likely be
> removed. Other users such as cifs smbfs ext modpost sumversions have
> their own internal implementation as needed.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>  crypto/asymmetric_keys/mscode_parser.c    | 6 ------
>  crypto/asymmetric_keys/pkcs7_parser.c     | 6 ------
>  crypto/asymmetric_keys/x509_cert_parser.c | 6 ------
>  include/linux/oid_registry.h              | 8 --------
>  4 files changed, 26 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
