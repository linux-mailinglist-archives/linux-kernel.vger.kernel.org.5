Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C217AB416
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjIVOwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjIVOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:52:02 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F38CCF;
        Fri, 22 Sep 2023 07:51:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFAE324000B;
        Fri, 22 Sep 2023 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695394310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qWj4fDfrncvglMKc2oAIEDq1g/mg4BnB8RvFBc7svIE=;
        b=pJxpH0gSZj6K/xGcOkOlfCoRcAO+/IqCCwjw/tpuQQgDqwOTxXRNHuguXNLbQA0q2vqw6u
        yTDeNK5mZFi4GXxuYKCjDZC8rDhijez1IqRU3PflEql5A52IFM7YuF8fOqAWeHdWplm0N4
        4oZEz8fd8K0NH6HihCxPiHMsle2S/ydHbDRP/G9AfRVFddrwZNex0cRAk211HxvUkc6DhQ
        Q8P3yw6mWP32rDqfe/eum3dWZex71urFEov9wNUB7aom01Y6UOPtj08ga47uLGZK+Z/QDb
        MURtRwUfHa1ezm3ZYod9ouNVDWpcXf0IRxYKCGL4G/iaeO9REXlY9GFSKhQYNA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Kees Cook <keescook@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: denali: Annotate struct denali_chip with __counted_by
Date:   Fri, 22 Sep 2023 16:51:48 +0200
Message-Id: <20230922145148.578528-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915201227.never.483-kees@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'48ec74fd8af6d94becf6b53af0c49c888511ec38'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-15 at 20:12:28 UTC, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct denali_chip.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
