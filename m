Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6866F7A8397
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbjITNjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbjITNi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:38:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDCDDE;
        Wed, 20 Sep 2023 06:38:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A7FC433C7;
        Wed, 20 Sep 2023 13:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695217129;
        bh=pP1eXibM2XF9AVZiEeducJytLu6b4fRhxtC+s2WLHok=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RUtVhgRUXHgvIAUA6eZisimvx4dHVon1muBzkge8QCpU8ixknMmdqE1dxEWSu2Pf9
         i8NOnu7GTV507B/cVo8FwP/SX9iRm+cw095oWSJkf8l+1cr58qQ4L6/BZy/hV8Do2a
         sT6nM0XSa/2Qf0ODN3rmEc/bBvc9yrduhxxC5IXmcab2RAS/3GYQBvwhZGER9hahi7
         cxRiLWIRnG/LNnKjKv5qowsCAlQmHaiv+sMnK6kPu/kJBQAUrKlWOtECUmLAJyIC6v
         esSofuyHFur3+b11sHaqHkge7eGLul2D/pEo3Oqe/ldsqPmURem+1J/jEIymOcWrDS
         WzKCtuSTTK7mw==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Kees Cook <keescook@chromium.org>
Cc:     Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
In-Reply-To: <20230915201003.never.148-kees@kernel.org>
References: <20230915201003.never.148-kees@kernel.org>
Subject: Re: (subset) [PATCH] leds: gpio: Annotate struct gpio_leds_priv
 with __counted_by
Message-Id: <169521712728.3441672.12465778864045972543.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 14:38:47 +0100
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

On Fri, 15 Sep 2023 13:10:04 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct gpio_leds_priv.
> 
> [...]

Applied, thanks!

[1/1] leds: gpio: Annotate struct gpio_leds_priv with __counted_by
      commit: 00f91ead9c8037d044414ae44a0e75ef3df27e6f

--
Lee Jones [李琼斯]

