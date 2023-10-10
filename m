Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D227C4453
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjJJWip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjJJWim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:38:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21768F;
        Tue, 10 Oct 2023 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=90TfTQ0HXtaxpP2N+kX5JJUdpzOu8ILN/U8ZS/CUaG4=; b=lop/4jucpEXHelFQId1crSEMAC
        Gn32k7Bk/APUtM7fo9a1ua/e3qWsB79DoGlaKkj1X6fcyXH+FYcXlag5+sTsEb9OiWTDzl4IaqSr1
        mTD7AILBHYRnAMRuv4Qj9/qKPsSCJzt8cSmPp8I3SBITTp2C3MirJfzvwzUmf6Lk6GR5eQ41WssDi
        V/JCqInkk9bcWRDixVfTwmSuF+ojwsgozE7VuwNg89zcQXzs/isFCVnZs6D4VBuEHqZTnInHlFSPt
        lKK+wixmi7wlv18SQzt8Cocdk7JW7D//xwNTl9dOFYPwVhRsq2hEI6f0uqp6xo/1s6vT6BnTGi6+H
        nC9tuvJQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqLN9-00EHUI-0o;
        Tue, 10 Oct 2023 22:38:39 +0000
Date:   Tue, 10 Oct 2023 15:38:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-modules@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: Limit MODULE_SIG_KEY_TYPE_ECDSA to SHA384 or
 SHA512
Message-ID: <ZSXSb9oQxWukme4d@bombadil.infradead.org>
References: <20231010212755.64744-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010212755.64744-1-dimitri.ledkov@canonical.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:27:55PM +0100, Dimitri John Ledkov wrote:
> NIST FIPS 186-5 states that it is recommended that the security
> strength associated with the bit length of n and the security strength
> of the hash function be the same, or higher upon agreement. Given NIST
> P384 curve is used, force using either SHA384 or SHA512.
> 
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---

I'd imagine this could go through crypto tree, as folks more in tune
with these requirements would be more aligned with what we need.

  Luis
