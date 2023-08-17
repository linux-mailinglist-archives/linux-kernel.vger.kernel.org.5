Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C6377F6C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350984AbjHQMvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350991AbjHQMus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:50:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF272D5F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1692276644;
        bh=5oaoKNipVX6iSVnp72EenoIUu3tPuOJ8sGaIEin3KYY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fLLVkqACp2syBanYmRdMWC0/3PUAgD5PRnAXsBRgSfThdw0GmtniHRUReakEKl7lW
         mMiOdflnsx9uQp37PgaO+XKQKbMkstMXUl7qiEEvaYqbtPa+YVS0a9VJxKelxX0VBA
         gFg2BPfvHjrHmS424o7LlcFhHwV1mJ2qIXhNzHouOorCgVWI5cVOW8PQTxL9WTE9p7
         QCSPahZ4qbmpfIxijy7wslasj0jjI7PIbKV2CD3RFLr1hf21WbDxMvWGjvzAcYK9yc
         Wf9NMNg6Sm/S6xESj4A7N5FQXnZdAdWuph+CjNf+ooInhrDPS2d7WZwJCbyhkOuo7E
         8rg7gcwD7ZYSA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRPxc3Wwtz4wy6;
        Thu, 17 Aug 2023 22:50:44 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/82xx: Remove pq2_init_pci
In-Reply-To: <8b2db7c3c2c346aa8aa49507415c360d441e5bf5.1692259498.git.christophe.leroy@csgroup.eu>
References: <8b2db7c3c2c346aa8aa49507415c360d441e5bf5.1692259498.git.christophe.leroy@csgroup.eu>
Date:   Thu, 17 Aug 2023 22:50:44 +1000
Message-ID: <871qg1est7.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Commit 859b21a008eb ("powerpc: drop PowerQUICC II Family ADS platform
> support") removed last user of pq2_init_pci.
>
> Remove it.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/platforms/82xx/pq2.c | 46 -------------------------------
>  1 file changed, 46 deletions(-)

Haha, from my local tree:

$ show --stat dev/mpe
commit d4268218b50422292cb5e1273cc6829fb3b22b5b
Author:     Michael Ellerman <mpe@ellerman.id.au>
AuthorDate: Wed Aug 16 14:06:50 2023 +1000
Commit:     Michael Ellerman <mpe@ellerman.id.au>
CommitDate: Wed Aug 16 14:08:47 2023 +1000

    powerpc/82xx: Drop unused pq2 PCI code

    The last caller of this code was removed when the pq2fads platform was
    dropped in commit 859b21a008eb ("powerpc: drop PowerQUICC II Family ADS
    platform support").

    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

 arch/powerpc/platforms/82xx/pq2.c | 46 ---------------------------------------
 1 file changed, 46 deletions(-)


But I'll take yours because you sent it first.

cheers
