Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7880F78576D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbjHWMEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjHWMEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:04:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203F4E77
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cs31yXz4x2n;
        Wed, 23 Aug 2023 22:03:57 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b8d6ae4483fcfd17524e79d803c969694a85cc02.1687428075.git.christophe.leroy@csgroup.eu>
References: <b8d6ae4483fcfd17524e79d803c969694a85cc02.1687428075.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/ptrace: Split gpr32_set_common
Message-Id: <169279175565.797584.14665256369695357987.b4-ty@ellerman.id.au>
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

On Thu, 22 Jun 2023 12:01:23 +0200, Christophe Leroy wrote:
> objtool report the following warning:
> 
>   arch/powerpc/kernel/ptrace/ptrace-view.o: warning: objtool:
>     gpr32_set_common+0x23c (.text+0x860): redundant UACCESS disable
> 
> gpr32_set_common() conditionnaly opens and closes UACCESS based on
> whether kbuf point is NULL or not. This is wackelig.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/ptrace: Split gpr32_set_common
      https://git.kernel.org/powerpc/c/9a32584bc108c8fe4d02fa33b16caf686e4a788a

cheers
