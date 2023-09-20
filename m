Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22A47A83E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbjITNvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjITNu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:50:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5225CF;
        Wed, 20 Sep 2023 06:50:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9AAC433C7;
        Wed, 20 Sep 2023 13:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695217853;
        bh=ZYMgDvz7cLiEi48+fLoU5oYwxYC+RNXpuugTwerelA4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WYgV42Q41zYcX7fcsQWLwwrxbrrEfVse9h5Cv+phqauR1/HCAert4KodJzA2HkWy3
         5wb0UyHx1o0VXHcCKUn0jNRzJu6mPirdPh0AkNjOfjEPMcqPrX6Ireg2yoYheIqCBy
         ldUg/NPOhKMcsQgNwz0zG0fd9GnxJnb/ulC14E2LjwHAL95gx65ZV8wVCMjDGBlPh9
         vv+8yLllFz9LnvyNzDaIvrT/CHK8cT2GuvVL2I8zN5MzJy5HdZJRhRpgW/JDNIaD7C
         UUHRvK8FRsxpNZa6IRv3BFf2JudeMvzr4gO5/I7NJindbB8LJ388l971g3oLd9K6NG
         RG/djIE3eg1eA==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Kees Cook <keescook@chromium.org>
Cc:     Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alice Chen <alice_chen@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        kernel test robot <lkp@intel.com>,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
In-Reply-To: <20230915201051.never.429-kees@kernel.org>
References: <20230915201051.never.429-kees@kernel.org>
Subject: Re: (subset) [PATCH] leds: mt6370: Annotate struct mt6370_priv
 with __counted_by
Message-Id: <169521784990.3449392.15396251707007241017.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 14:50:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023 13:10:52 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mt6370_priv.
> 
> [...]

Applied, thanks!

[1/1] leds: mt6370: Annotate struct mt6370_priv with __counted_by
      commit: 799107c1bb9049f9b3f28b5d651e336d09856019

--
Lee Jones [李琼斯]

