Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A89C7C988A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 12:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjJOKDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 06:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJOKD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 06:03:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68BCDE
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1697364200;
        bh=kOWLjiDpvHE5NpXC9jG7b3FrojOzk472gOHlXk+Q33c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=rBCIV0QeEgpaqeHWTRKOjcXQAoTKonEC1zu+hDBOH9+1Lc2hYuPynU4INIFqkiA/9
         iPUXL+F/5yeB7Nao50xfT0Ax3C08fkIRGM1bMX+GvTCE6/4Nk7MVZkcRLQwLlS6Tmm
         PcnTnaMG8KdcCWiCvQz1bljKwiDjGWj1FieYG/R+TOLyOetUuIeFj4ueNa+RMQIc4Y
         O9I/8i8gSeqqe71JXX0ORfLeL2g34YiGh648nVWMI1y9iZf4G/knP52TDSkFDI0Int
         zXbIUyjxqv2dObj9CC6WDcLmZFRhqEGLmjn+HgkXuh9P5bQ5heu5lEDp5YcQzBRoLV
         ied1zNMhSWtbw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S7bRD5hCvz4wnx;
        Sun, 15 Oct 2023 21:03:20 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1695659959.git.christophe.leroy@csgroup.eu>
References: <cover.1695659959.git.christophe.leroy@csgroup.eu>
Subject: Re: (subset) [PATCH v2 00/37] Implement execute-only protection on powerpc
Message-Id: <169736402375.957740.6017054245951697068.b4-ty@ellerman.id.au>
Date:   Sun, 15 Oct 2023 21:00:23 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 20:31:14 +0200, Christophe Leroy wrote:
> This series reworks _PAGE_FLAGS on all platforms in order
> to implement execute-only protection on all powerpc.
> 
> For all targets except 40x and 604 it will be a real execute-only
> protection as the hardware and/or software allows a distinct protection.
> 
> For 40x and 604 that's a poor's man execute-only protection in the
> way that once the page is in the TLB it can be executed. But it's
> better than nothing and allows to have a similar implementation for
> all sorts of powerpc.
> 
> [...]

Patches 1 and 2 applied to powerpc/fixes.

[01/37] powerpc/8xx: Fix pte_access_permitted() for PAGE_NONE
        https://git.kernel.org/powerpc/c/5d9cea8a552ee122e21fbd5a3c5d4eb85f648e06
[02/37] powerpc/64e: Fix wrong test in __ptep_test_and_clear_young()
        https://git.kernel.org/powerpc/c/5ea0bbaa32e8f54e9a57cfee4a3b8769b80be0d2

cheers
