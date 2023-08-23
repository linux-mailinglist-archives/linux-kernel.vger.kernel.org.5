Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAAA785766
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjHWME0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjHWMD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:03:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EE4E68
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cn3m1rz4x2P;
        Wed, 23 Aug 2023 22:03:53 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <f1d4a15da70190f8c2fcddb377bbc1e09827242c.1687343857.git.christophe.leroy@csgroup.eu>
References: <f1d4a15da70190f8c2fcddb377bbc1e09827242c.1687343857.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/step: Mark __copy_mem_out() and __emulate_dcbz() __always_inline
Message-Id: <169279175564.797584.4721586858055546179.b4-ty@ellerman.id.au>
Date:   Wed, 23 Aug 2023 21:55:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 12:38:10 +0200, Christophe Leroy wrote:
> objtool reports two folliwng warnings:
>   arch/powerpc/lib/sstep.o: warning: objtool: copy_mem_out+0x3c
>     (.text+0x30c): call to __copy_mem_out() with UACCESS enabled
>   arch/powerpc/lib/sstep.o: warning: objtool: emulate_dcbz+0x70
>     (.text+0x4dc): call to __emulate_dcbz() with UACCESS enabled
> 
> Mark __copy_mem_out() and __emulate_dcbz() __always_inline
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/step: Mark __copy_mem_out() and __emulate_dcbz() __always_inline
      https://git.kernel.org/powerpc/c/0d5769f9503d9a88661b82fee6a320e711f8b01a

cheers
