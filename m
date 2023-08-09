Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0824F77643E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjHIPmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjHIPmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E836B2111;
        Wed,  9 Aug 2023 08:42:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75B6E63F21;
        Wed,  9 Aug 2023 15:42:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4347CC433C7;
        Wed,  9 Aug 2023 15:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691595767;
        bh=tPmCD3hLfEfuWygG5x8Az6XzX5lGDP9qkbyRMrIY9mY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEzcSNNGnjgubucOpEHZfT0qtx6wcxq6bPjiSSPTFYhvT+GY4ORnpgg+BC/vLX1u5
         KQEH6K+CzpitQiFM54CHLCkurgJI4W/BN/2biVuRJaMIYVQQD98TXkDu83jPAwooC4
         znMjKysEhOO5FcTKLY08NQzWYNaKvO5qscfqohp1Y6fPsNgCa66QuDvkygKVsN1x9+
         rZGX+ZYxx6UvmGfh6p1DatA8F4GmP2u0r5/qTbFamOMqBB9X2fzTpO0hUqv4AdcyWO
         AOPiIigMlXIIW7myvelKpsZ5JUPafCs9CmgXtBEhK5afBAXFK3hQUNLYwLii/lPwx2
         BY0v9jubrNsFw==
Date:   Wed, 9 Aug 2023 08:42:45 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2] Makefile.extrawarn: enable
 -Wmissing-variable-declarations for W=1
Message-ID: <20230809154245.GB832145@dev-arch.thelio-3990X>
References: <20230807-missing_proto-v2-1-3ae2e188bb0c@google.com>
 <202308081508.EI3CRzQo-lkp@intel.com>
 <CAKwvOdnDEaZt-mD2PvMDmCY1WyaqtrH+oM3M5JgZaiOOWA_0YQ@mail.gmail.com>
 <20230808161707.GA2171444@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808161707.GA2171444@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:17:07AM -0700, Nathan Chancellor wrote:
> I think the register storage issue should be resolved in at least clang
> before this patch is accepted, as that seems to be where the majority of
> warnings are coming from so far. Like we talked about, I'll take a shot
> at fixing that. Once that is fixed, I'll build mainline with
> -Wmissing-variable-declarations to see how many instances there are and
> if there are any other interesting edge cases that should be fixed in
> the compiler. After that, I think this should be good to go in. Does
> that sound reasonable?

I don't think there are any other edge cases from the brief glance I
gave my build logs but my matrix counts 700+ unique instances of this
(give or take some, due to interleaving issues). Quite a few but I see
several in certain files so it might not actually be too bad.

Cheers,
Nathan
