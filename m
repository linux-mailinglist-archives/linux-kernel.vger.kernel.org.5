Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203987DEC13
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348475AbjKBFA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjKBFA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:00:56 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29A9FB;
        Wed,  1 Nov 2023 22:00:49 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qyPoT-00DSTI-9c; Thu, 02 Nov 2023 13:00:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 02 Nov 2023 13:00:20 +0800
Date:   Thu, 2 Nov 2023 13:00:20 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 0/7] crypto: Proper Initialization of `struct
 skcipher_walk` in x86 Glue Files
Message-ID: <ZUMs5C2FLQL4POO+@gondor.apana.org.au>
References: <DB3PR10MB683562E7BD2DC73A48BEA3C8E8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <20231102042043.GD1498@sol.localdomain>
 <ZUMl9BJcEXta1Spg@gondor.apana.org.au>
 <DB3PR10MB683587925DA82E44BD8D5D6EE8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR10MB683587925DA82E44BD8D5D6EE8A6A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 10:27:41AM +0530, Yuran Pereira wrote:
>
> I noticed that, but since skcipher_walk_first can return with failure, there seems
> to be a chance that those bits are never initialized.

The API is such that if an error is returned by walk_first/next,
then you must not call into the skcipher_walk_* functions again.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
