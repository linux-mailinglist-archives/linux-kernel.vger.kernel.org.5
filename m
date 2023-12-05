Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AA4805B7B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346840AbjLEPQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346114AbjLEPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:16:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A31BF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:16:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C8FC433C9;
        Tue,  5 Dec 2023 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701789415;
        bh=NGpkt7A/M2PqMKxfJGYVnpL+MI4aS2fZnXELzAe1SI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rS5seCw3/QWhpf4ZOYB4szGb12GPH6nndzPJXXGX/5ochu0jjnHEjSVYXT6vxeEwE
         Lb6CnSiPQ0oEF9iZ2DWfwRkZnd60qw9jcesU6kGfruPkEtMuWr+xnFqk90AytuStSW
         47uJCfOnCceJXME6rh6OQHKBbzlnU/xm3kETxnkE8M6mQjDS8xhPUpHFZUPWi6V8A6
         B3eDwsYQ6FlftbDQThbcLsNk72ehLfD+GfPI3klFfdFyLVLlsYZJoaE00sSAG2fWff
         +qkM92iqYamZfHfjCUUUUsbthLwLcjJMv22X0pI9R2zZ1c6ITcA9bOzWPttNhm3VA3
         zVY4wp0dEhtgg==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: replace <asm-generic/export.h> with <linux/export.h>
Date:   Tue,  5 Dec 2023 15:16:31 +0000
Message-Id: <170178637204.13485.9657121759443285683.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231126151045.1556686-1-masahiroy@kernel.org>
References: <20231126151045.1556686-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 00:10:45 +0900, Masahiro Yamada wrote:
> Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> deprecated <asm-generic/export.h>, which is now a wrapper of
> <linux/export.h>.
> 
> Replace #include <asm-generic/export.h> with #include <linux/export.h>.
> 
> 
> [...]

Applied to arm64 (for-next/kbuild), thanks!

[1/1] arm64: replace <asm-generic/export.h> with <linux/export.h>
      https://git.kernel.org/arm64/c/8fd7588fd4ee

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
