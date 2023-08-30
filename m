Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F97D78E018
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244009AbjH3TNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243469AbjH3LIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:08:13 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C9FCC9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:08:09 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c79b:b256:edee:805c])
        by xavier.telenet-ops.be with bizsmtp
        id fn862A00Q27hkyq01n86gf; Wed, 30 Aug 2023 13:08:07 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qbJ3O-0022mT-Lp;
        Wed, 30 Aug 2023 13:08:06 +0200
Date:   Wed, 30 Aug 2023 13:08:06 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
cc:     lee@kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: cs42l43: Use correct macro for new-style PM runtime
 ops
In-Reply-To: <20230822114914.340359-1-ckeepax@opensource.cirrus.com>
Message-ID: <594916d0-5321-717-3117-3135ffdf7f18@linux-m68k.org>
References: <20230822114914.340359-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2023, Charles Keepax wrote:
> The code was accidentally mixing new and old style macros, update the
> macros used to remove an unused function warning whilst building with
> no PM enabled in the config.
>
> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks, this fixes the m68k/allmodconfig build for me.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
