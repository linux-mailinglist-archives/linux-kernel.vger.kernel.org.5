Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6721E7F78F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjKXQ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKXQ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:29:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089C1D41;
        Fri, 24 Nov 2023 08:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:From:References:Cc:To:
        Subject:MIME-Version:Date:Message-ID:Content-Type:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QSIqfD1auH2cah+e2faXX91Hu8FgautqSd/5tPNUaHw=; b=js0vAesiRymC6K6ueOKBq4Z/gp
        IcwqTL06Xw4pfelrACR9E/ERgbjDufH+A7WqvNfVPqSk+6ktYGeHvuEMzBT99FQtx4VEA2okMjvPw
        BtP9Ke+vwHznN+GyNiP0vsR25NIyUbkfPF/MWJnm9iDvp0CqMHi0r9mmoV/CB+VPVZ8zHD2GK4Pou
        iXo8T3e0R8/Vf+Nx7oviIKXKFGQWgicBgdeo2HbXkO80n3r70bCNy7aXziIqEhFlX168fvW6HyM/T
        f5+hwPlHEgx0ex5876BIo8OWacb8xo8eBFNoXpO8NhAG9ZAPIlZO992AYvTi5mg1lVhHxQXlF8jnK
        8ATP3QRg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r6Z3k-007eVc-0I;
        Fri, 24 Nov 2023 16:29:40 +0000
Content-Type: multipart/mixed; boundary="------------AxUXxlxhUf63FLX3XErgSsSc"
Message-ID: <a072ac93-e7ba-4b1b-ab66-8a3a889d4b52@infradead.org>
Date:   Fri, 24 Nov 2023 08:29:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Nov 24 (drivers/mux/mmio.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Rosin <peda@axentia.se>
References: <20231124133536.779ed85a@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231124133536.779ed85a@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AxUXxlxhUf63FLX3XErgSsSc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/23/23 18:35, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20231123:
> 
> Non-merge commits (relative to Linus' tree): 2415
>  3096 files changed, 138691 insertions(+), 92122 deletions(-)
> 
> ----------------------------------------------------------------------------

on S390, when CONFIG_REGMAP and none of its subordinate
configs is set:

../drivers/mux/mmio.c: In function 'mux_mmio_probe':
../drivers/mux/mmio.c:76:34: error: storage size of 'field' isn't known
   76 |                 struct reg_field field;
      |                                  ^~~~~
In file included from ../include/linux/bits.h:21,
                 from ../include/linux/bitops.h:6,
                 from ../drivers/mux/mmio.c:8:
../include/linux/bits.h:23:28: error: first argument to '__builtin_choose_expr' not a constant
   23 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
      |                            ^~~~~~~~~~~~~~~~~~~~~
../include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
../include/linux/bits.h:37:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
../drivers/mux/mmio.c:96:29: note: in expansion of macro 'GENMASK'
   96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
      |                             ^~~~~~~
../include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                   ^
../include/linux/bits.h:23:10: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
   23 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
      |          ^~~~~~~~~~~~~~~~~
../include/linux/bits.h:37:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
../drivers/mux/mmio.c:96:29: note: in expansion of macro 'GENMASK'
   96 |                 if (mask != GENMASK(field.msb, field.lsb)) {
      |                             ^~~~~~~
../drivers/mux/mmio.c:102:29: error: implicit declaration of function 'devm_regmap_field_alloc' [-Werror=implicit-function-declaration]
  102 |                 fields[i] = devm_regmap_field_alloc(dev, regmap, field);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~
../drivers/mux/mmio.c:76:34: warning: unused variable 'field' [-Wunused-variable]
   76 |                 struct reg_field field;
      |                                  ^~~~~
cc1: some warnings being treated as errors


Full randconfig file is attached.

-- 
~Randy
--------------AxUXxlxhUf63FLX3XErgSsSc
Content-Type: application/gzip; name="config-s390-mux-mmio.gz"
Content-Disposition: attachment; filename="config-s390-mux-mmio.gz"
Content-Transfer-Encoding: base64

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

--------------AxUXxlxhUf63FLX3XErgSsSc--
