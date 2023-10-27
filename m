Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89ED57D94B8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345663AbjJ0KIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345504AbjJ0KIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:08:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A95192
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1698401297;
        bh=HIiuIblWmUwKBLfr5E+dwEIl0kur8dk5dqSlJMaUuB4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Oydjz4Pnt5L2pyLZ40VdI5wD8BKnUj5VXQPmb4dXk92o+86rvK1Tx/rK4XsttL7Vq
         xWn1EeTS+WHcqpPiXXODUwM8A0DYs0zsAU+tyl3U6L9SAscdj/kpfFFWQpO2ILktlb
         OQBiaq2aWSHs8gYf1f1BF/H4Ei6ozWhS9z2OD+Le3kqe9L+fXh2mRqt2Nrgc+CnTsw
         xNEuzEklqDeoMf4OBPVQP3HVqbdedKjUFZg9t3CcJdXCXTGicasmNC6WhRsjWaKjsn
         t1xUxjPJifDYt5sWGB9j4Cu65G1QipWJsA2VV7A/n6m0v1pSbMR54RjpzkxEnp3FwD
         CK4URafB0W5QA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGyzP1mjmz4xWY;
        Fri, 27 Oct 2023 21:08:17 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <3aaa40bf706afeab8fe9a74b8437704a4269a6a2.1697005615.git.christophe.leroy@csgroup.eu>
References: <3aaa40bf706afeab8fe9a74b8437704a4269a6a2.1697005615.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Remove cpm_dp...() macros
Message-Id: <169840079683.2701453.1626668836711742489.b4-ty@ellerman.id.au>
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

On Wed, 11 Oct 2023 08:27:03 +0200, Christophe Leroy wrote:
> Since commit d3c511ac1d72 ("powerpc/cpm: Remove
> !CONFIG_PPC_CPM_NEW_BINDING code") cpm_dp...() macros have no added
> value anymore.
> 
> Last user of those macros were fixed by commit 5e6cb39a256d ("net:
> fs_enet: Use cpm_muram_xxx() functions instead of cpm_dpxxx() macros")
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Remove cpm_dp...() macros
      https://git.kernel.org/powerpc/c/ad496f8f83960c211b00fdbd8ae4ac1e55e4f3d5

cheers
