Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757C17A83DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbjITNu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbjITNu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:50:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A0FD8;
        Wed, 20 Sep 2023 06:50:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA712C433C8;
        Wed, 20 Sep 2023 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695217820;
        bh=F0w62KOri4+nv8ORRuidRDPCFETZBxnGyBhVgs19590=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=hg6DG5H3voBk4yi1xt3gVxtpWKQwL7f+Xg1hqn+I02tKlteuaHdIGKPKgtDakRgHe
         fmTD4cXn9KSlneOaoR3WQeicN/z5g2sgz/GofMHLn2z2F/Kyq9qU759Hg/vdrQ9k9+
         5GAsapzYRZKp+opUKaAuXToOADpp6z9wcbbM6BxUWb94RZPxGvjtMtqV6fgzlNvDaP
         U3v9zQOXnETzESzXbZFX9czV0eXkXknpCFGA7j2WDmd664c/xI9KbMJvScvEvEr1MC
         1GqH1UznXTFpO8/Moj4m1AZEMXxI5OA0W+bL79vIF5i6YBaTfWh6tz7tsdp83WBSe1
         j9QypSGog46Kw==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Kees Cook <keescook@chromium.org>
Cc:     Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Gene Chen <gene_chen@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
In-Reply-To: <20230915201020.never.433-kees@kernel.org>
References: <20230915201020.never.433-kees@kernel.org>
Subject: Re: (subset) [PATCH] leds: mt6360: Annotate struct mt6360_priv
 with __counted_by
Message-Id: <169521781759.3448785.6991953068239903845.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 14:50:17 +0100
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

On Fri, 15 Sep 2023 13:10:20 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct mt6360_priv.
> 
> [...]

Applied, thanks!

[1/1] leds: mt6360: Annotate struct mt6360_priv with __counted_by
      commit: cecdfff8f5c82816d8b9ef2f4b3d7f4943dfd360

--
Lee Jones [李琼斯]

