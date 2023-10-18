Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6157CE72A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjJRSsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRSsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:48:09 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76DF114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:48:05 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4S9fxD6sb1z1r1fc;
        Wed, 18 Oct 2023 20:48:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 4S9fxD5Pq3z1qqlS;
        Wed, 18 Oct 2023 20:48:00 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id yVsnDci_gSYG; Wed, 18 Oct 2023 20:47:59 +0200 (CEST)
X-Auth-Info: z53x+HAGnC5Mr85hNarHhEetogq4Juc1fsSdAKqHPeyff1cH7hkefuC/L5r3bMDv
Received: from igel.home (aftr-62-216-205-223.dynamic.mnet-online.de [62.216.205.223])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 18 Oct 2023 20:47:59 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id C38602C1354; Wed, 18 Oct 2023 20:47:58 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v4 1/2] riscv: Add remaining module relocations
In-Reply-To: <20231017-module_relocations-v4-1-937f5ef316f0@rivosinc.com>
        (Charlie Jenkins's message of "Tue, 17 Oct 2023 22:34:16 -0700")
References: <20231017-module_relocations-v4-0-937f5ef316f0@rivosinc.com>
        <20231017-module_relocations-v4-1-937f5ef316f0@rivosinc.com>
X-Yow:  I am having FUN...  I wonder if it's NET FUN or GROSS FUN?
Date:   Wed, 18 Oct 2023 20:47:58 +0200
Message-ID: <871qdr938h.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Okt 17 2023, Charlie Jenkins wrote:

> +static int apply_r_riscv_sub6_rela(struct module *me, u32 *location, Elf_Addr v)
> +{
> +	*(u8 *)location = (*location - ((u8)v & 0x3F)) & 0x3F;

I think that should use *(u8*) on both sides.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
