Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDB3785768
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjHWMEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjHWMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:04:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B090F10CB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:03:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cq0Lc3z4x2W;
        Wed, 23 Aug 2023 22:03:55 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <2322dd08217bccab25456fe8b189edf0e6a8b6dd.1692121353.git.christophe.leroy@csgroup.eu>
References: <2322dd08217bccab25456fe8b189edf0e6a8b6dd.1692121353.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/32s: Cleanup the mess in __set_pte_at()
Message-Id: <169279175571.797584.13098002018270735977.b4-ty@ellerman.id.au>
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

On Tue, 15 Aug 2023 19:42:40 +0200, Christophe Leroy wrote:
> __set_pte_at() handles 3 main cases with #ifdefs plus the 'percpu'
> subcase which leads to code duplication.
> 
> Rewrite the function using IS_ENABLED() to minimise the total number
> of cases and remove duplicated code.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Cleanup the mess in __set_pte_at()
      https://git.kernel.org/powerpc/c/7cb0094be4a5dfb3c91d285977f489d334455e19

cheers
