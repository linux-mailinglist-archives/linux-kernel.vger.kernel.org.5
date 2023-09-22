Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB837ABC0B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 00:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjIVWy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 18:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjIVWyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 18:54:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09A91A4;
        Fri, 22 Sep 2023 15:54:46 -0700 (PDT)
Received: from mercury (unknown [185.254.75.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 344E466072EB;
        Fri, 22 Sep 2023 23:54:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695423285;
        bh=HTBinoWAc7YcHkDe6xiWubFR3Ns+WgahTgV+d1FQL1I=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=QKpLcVMlAnPbQStT2wOk2XxQv89ZEFSGt1LHZaJD2TIpV5X2kA3Q6IApDkfpVNH5L
         xffuza+c+2VvuQJpiCOCX8xExO3MUILOVTBXXd2KB9tdqs687pFCoqpZ1uR4wJ9/gR
         SDyvmGeMIWNeOforVYSwxAqkjNqymzjpsql+aaFCa+ELCgynDeVAEuMXvPkq0j9kyA
         diW5Lqcxx2slzknCutMC8xr5BHndGYcVRzfcuQxVSdnYUihkBZ77XHYlxqKHT++aHu
         n7wI6q4iUha8OCiXw0JJMIxHwWKGzJI0krNickOOKThesgezq5IiIqv8UennEzpGE1
         xogz90elNUjMw==
Received: by mercury (Postfix, from userid 1000)
        id 8A5811060B74; Sat, 23 Sep 2023 00:54:42 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
In-Reply-To: <20230922175358.work.774-kees@kernel.org>
References: <20230922175358.work.774-kees@kernel.org>
Subject: Re: [PATCH] power: supply: axp20x_usb_power: Annotate struct
 axp20x_usb_power with __counted_by
Message-Id: <169542328255.1475988.7829886133144641249.b4-ty@collabora.com>
Date:   Sat, 23 Sep 2023 00:54:42 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Sep 2023 10:53:58 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct axp20x_usb_power.
> 
> [...]

Applied, thanks!

[1/1] power: supply: axp20x_usb_power: Annotate struct axp20x_usb_power with __counted_by
      commit: de1ca06bc0364a58ba0889d97a7a094d87dd5477

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

