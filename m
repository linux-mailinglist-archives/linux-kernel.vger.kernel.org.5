Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FA87A8385
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjITNfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjITNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:35:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49508D8;
        Wed, 20 Sep 2023 06:35:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8AFC433C8;
        Wed, 20 Sep 2023 13:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695216927;
        bh=XOJB4ugM+cR3vGS6Flq4w3KzGhy52BGvvhYoUHMdbyM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NfoV8bItEvkFAnHF36MmLxcTVuQ7VSCT0le95ZO6wKefQMHFv21hTn/OMS78IWTW9
         w3I76Et9G7W9nuLdS5+vzeeDvZSZuAOoY5yFUf8hILIHyFA9ycDvFIEWzOiCWQ0dPX
         0VhSikuiP3Vi2PvG0hCRdI5dRWGr+s0oD5boWN5NuRBSF7vlBWxWBKYeqkvbvm1vV4
         wN9ZpTulGECoSzN8S3DEKBWJ1QDDu/z6dvg4xM4b5Ns84Cou+2XXlTT0ecYrpndSCz
         sSEv84NiZuHhWv6W1NAazJ3AfEtH08IawA7UTW7P+MLfyj26CPY18NSt7svJ7frUGC
         7ChsKz5qVI0Hw==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Kees Cook <keescook@chromium.org>
Cc:     Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
In-Reply-To: <20230915200938.never.767-kees@kernel.org>
References: <20230915200938.never.767-kees@kernel.org>
Subject: Re: (subset) [PATCH] leds: aw200xx: Annotate struct aw200xx with
 __counted_by
Message-Id: <169521692572.3439618.17540674957048720159.b4-ty@kernel.org>
Date:   Wed, 20 Sep 2023 14:35:25 +0100
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

On Fri, 15 Sep 2023 13:09:39 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct aw200xx.
> 
> [...]

Applied, thanks!

[1/1] leds: aw200xx: Annotate struct aw200xx with __counted_by
      commit: e43d6b679091d196d9ac7664035155ed4c9637cc

--
Lee Jones [李琼斯]

