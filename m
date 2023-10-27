Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581267D94BF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345692AbjJ0KI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345674AbjJ0KI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:08:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51121B3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1698401296;
        bh=30OBHWUfyQHjnBWbrlGeUaI2WXMNAW9Re3MJ+2tSPpc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=i8BMO8t6Y4KHqTx8aUV5Zw4npGWR8icDA0Xv/4pqRaVRUM03VA16MiLOb78fabd3C
         AiKl8545U4Tepu0sA+VFzcWMD+xuN9/a7cZUWexLo2Izbu9sGvj53Ad5n8deRgubs2
         vKE2jyhylRvMPvluSCFHjt/H8z7dNm/MN6U5lA86pmpiWo7ZjYBL6ld9xZwkIgzHzl
         elosUl/zMPN5EfPwD9QLl29qPlMLGuBLfR8+PUSkntuXDhS6xwytpFctYPPNQZoHis
         A+pnoAvAoo5JPFPQiy6HGIYbQGs3MnF0EGFYMI9x4GhbLqcwdg3rzvnuyEu3ODysto
         4XJeiC5kSdKTg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGyzN2hTPz4xVb;
        Fri, 27 Oct 2023 21:08:16 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Hari Bathini <hbathini@linux.ibm.com>,
        "Christopher M . Riedl" <cmr@bluescreens.de>
In-Reply-To: <e88b154eaf2efd9ff177d472d3411dcdec8ff4f5.1696675567.git.christophe.leroy@csgroup.eu>
References: <e88b154eaf2efd9ff177d472d3411dcdec8ff4f5.1696675567.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/code-patching: Perform hwsync in __patch_instruction() in case of failure
Message-Id: <169840079684.2701453.17093858702248932899.b4-ty@ellerman.id.au>
Date:   Fri, 27 Oct 2023 20:59:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Oct 2023 12:46:19 +0200, Christophe Leroy wrote:
> Commit c28c15b6d28a ("powerpc/code-patching: Use temporary mm for
> Radix MMU") added a hwsync for when __patch_instruction() fails,
> we results in a quite odd unbalanced logic.
> 
> Instead of calling mb() when __patch_instruction() returns an error,
> call mb() in the __patch_instruction()'s error path directly.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/code-patching: Perform hwsync in __patch_instruction() in case of failure
      https://git.kernel.org/powerpc/c/74726fda9fe306f848088ef73ec266cae0470d5b

cheers
