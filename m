Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D0A778486
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjHKA3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjHKA3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:29:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25AC2D54;
        Thu, 10 Aug 2023 17:29:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58BC066118;
        Fri, 11 Aug 2023 00:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A73BC433C7;
        Fri, 11 Aug 2023 00:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691713739;
        bh=+c5/OsEBgDnJX2KvgJ9pc4qBsjp8YGnODvKI3Jus9tw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ij2sVd4uf9Z5r88ZswuOjfOvTEbqxEszS2bGHGgnzp5V80Hu+QMCQHxOOV/yPlPuA
         bCGo81r4IV8MxgBmvJ+SxPtikZ4UpPd2Hji1zvRmDY0P+MhYcz6h9LBn3w1grLQ4jz
         DIBJptSYz+gzImJy8+9r5JYwge7AtLLZjyYzToqKDjLOlkwYyieU2fX9xWgiJP0izI
         TdDMth64J+GDoFV0lDTFYiRQcydxw5NvrvtELqxmPTcxgbJxMRxed6Ymr1hOeACMjj
         el4h+kZrl60foSK/y5vJX9qYPE0ayYo/Z8pBgeOWCtnuZZd1k4Eo+xs20QewJBUeEY
         wdx1SZzgsXP1g==
Date:   Thu, 10 Aug 2023 17:28:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Borislav Petkov (AMD)" <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Daniel Kolesa <daniel@octaforge.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sven Volkinsfeld <thyrc@gmx.net>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        torvalds@linux-foundation.org,
        Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [tip: x86/bugs] x86/srso: Fix build breakage with the LLVM
 linker
Message-ID: <20230810172858.12291fe6@kernel.org>
In-Reply-To: <20230810162524.7c426664@kernel.org>
References: <20230809-gds-v1-1-eaac90b0cbcc@google.com>
        <169165870802.27769.15353947574704602257.tip-bot2@tip-bot2>
        <20230810162524.7c426664@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 16:25:24 -0700 Jakub Kicinski wrote:
> On Thu, 10 Aug 2023 09:11:48 -0000 tip-bot2 for Nick Desaulniers wrote:
> > The following commit has been merged into the x86/bugs branch of tip:  
> 
> Hi folks, is there an ETA on this getting to Linus?
> The breakage has propagated to the networking trees, if the fix reaches
> Linus soon we'll just hold off on applying stuff and fast forward again.

Are the commit IDs stable on x86/bugs? 
Would it be rude if we pulled that in?
