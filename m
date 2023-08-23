Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B006C785793
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjHWMJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbjHWMJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:09:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93E0E77
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:09:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4dR1jM0z4x4T;
        Wed, 23 Aug 2023 22:04:26 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, ndesaulniers@google.com
Cc:     Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20230817-ppc_xmon-v1-1-8cc2d51b9995@google.com>
References: <20230817-ppc_xmon-v1-1-8cc2d51b9995@google.com>
Subject: Re: [PATCH] Revert "powerpc/xmon: Relax frame size for clang"
Message-Id: <169279175573.797584.2695589362102577867.b4-ty@ellerman.id.au>
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

On Thu, 17 Aug 2023 11:11:56 -0700, ndesaulniers@google.com wrote:
> This reverts commit 9c87156cce5a63735d1218f0096a65c50a7a32aa.
> 
> I have not been able to reproduce the reported -Wframe-larger-than=
> warning (or disassembly) with clang-11 or clang-18.
> 
> I don't know precisely when this was fixed in llvm, but it may be time
> to revert this.
> 
> [...]

Applied to powerpc/next.

[1/1] Revert "powerpc/xmon: Relax frame size for clang"
      https://git.kernel.org/powerpc/c/7f3c5d099b6f8452dc4dcfe4179ea48e6a13d0eb

cheers
